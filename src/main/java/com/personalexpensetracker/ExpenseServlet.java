package com.personalexpensetracker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/expenses")
public class ExpenseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Expense> expenses = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;
        String error = null;
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT id,title,category,amount,transaction_date,notes FROM transactions ORDER BY transaction_date DESC, id DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BigDecimal amount = rs.getBigDecimal("amount");
                total = total.add(amount);
                expenses.add(new Expense(rs.getInt("id"), rs.getString("title"), rs.getString("category"),
                    amount, rs.getDate("transaction_date"), rs.getString("notes")));
            }
        } catch (SQLException e) {
            error = "Could not connect to the database. Check MySQL and the DB settings in README.md.";
            getServletContext().log("Expense list error", e);
        }
        request.setAttribute("expenses", expenses);
        request.setAttribute("total", total);
        request.setAttribute("error", error);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String amountText = request.getParameter("amount");
        String dateText = request.getParameter("transactionDate");
        String notes = request.getParameter("notes");
        try {
            if (title == null || title.isBlank() || category == null || category.isBlank())
                throw new IllegalArgumentException("Title and category are required.");
            BigDecimal amount = new BigDecimal(amountText);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) throw new IllegalArgumentException("Amount must be greater than zero.");
            Date date = Date.valueOf(dateText);
            try (Connection con = DB.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO transactions(title,category,amount,transaction_date,notes) VALUES(?,?,?,?,?)")) {
                ps.setString(1, title.trim()); ps.setString(2, category);
                ps.setBigDecimal(3, amount); ps.setDate(4, date); ps.setString(5, notes);
                ps.executeUpdate();
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("formError", e.getMessage());
            doGetWithError(request, response);
            return;
        } catch (SQLException e) {
            getServletContext().log("Expense save error", e);
            request.setAttribute("formError", "Unable to save. Check database configuration and try again.");
            doGetWithError(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/expenses");
    }

    private void doGetWithError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

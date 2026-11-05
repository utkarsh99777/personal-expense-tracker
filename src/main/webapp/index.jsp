<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.personalexpensetracker.Expense,java.math.BigDecimal" %>
<%!
  String esc(String s) {
    if (s == null) return "";
    return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#x27;");
  }
%>
<%
  List<Expense> expenses = (List<Expense>) request.getAttribute("expenses");
  BigDecimal total = (BigDecimal) request.getAttribute("total");
  String error = (String) request.getAttribute("error");
  String formError = (String) request.getAttribute("formError");
%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Personal Expense Tracker</title>
<style>
*{box-sizing:border-box}body{margin:0;background:#f3f6fb;color:#18243a;font-family:Arial,sans-serif}
header{background:#101d36;color:white;padding:26px max(calc((100% - 1080px)/2),24px)}
header h1{margin:0 0 7px;font-size:27px}header p{margin:0;color:#b9c7df}
main{max-width:1080px;margin:28px auto;padding:0 20px;display:grid;grid-template-columns:340px 1fr;gap:22px}
.card{background:white;border-radius:16px;padding:22px;box-shadow:0 8px 24px #1b315012}
h2{font-size:18px;margin:0 0 18px}.total{font-size:30px;font-weight:700;color:#245edb;margin:5px 0 20px}
label{display:block;font-size:13px;font-weight:700;margin:13px 0 6px}
input,select{width:100%;padding:11px;border:1px solid #d8e0ed;border-radius:8px;font-size:14px}
button{margin-top:17px;width:100%;padding:12px;border:0;border-radius:8px;background:#245edb;color:white;font-weight:700;cursor:pointer}
table{width:100%;border-collapse:collapse;font-size:14px}th,td{text-align:left;padding:12px 8px;border-bottom:1px solid #edf0f5}th{color:#66748a;font-size:12px}
.muted{color:#748198}.notice{background:#fff4e5;color:#875600;padding:11px;border-radius:8px;margin-bottom:14px;font-size:13px}
@media(max-width:760px){main{grid-template-columns:1fr}}
</style></head><body>
<header><h1>Personal Expense Tracker</h1><p>Record your spending. Understand your habits. Stay in control.</p></header>
<main>
<section class="card">
<h2>Add a transaction</h2>
<% if(formError != null){ %><div class="notice"><%= esc(formError) %></div><% } %>
<form method="post" action="<%=request.getContextPath()%>/expenses">
<label>Expense title</label><input name="title" maxlength="120" placeholder="e.g. Groceries" required>
<label>Category</label><select name="category" required><option value="">Choose category</option><option>Food</option><option>Travel</option><option>Shopping</option><option>Education</option><option>Bills</option><option>Health</option><option>Other</option></select>
<label>Amount (₹)</label><input name="amount" type="number" min="0.01" step="0.01" placeholder="500.00" required>
<label>Date</label><input name="transactionDate" type="date" required>
<label>Notes (optional)</label><input name="notes" maxlength="255" placeholder="Short note">
<button type="submit">Save transaction</button></form>
</section>
<section class="card">
<h2>Spending overview</h2>
<div class="muted">Total recorded expenses</div><div class="total">₹ <%= total == null ? "0.00" : total.toPlainString() %></div>
<% if(error != null){ %><div class="notice"><%=esc(error)%></div><% } %>
<h2>Recent transactions</h2>
<table><thead><tr><th>DATE</th><th>TITLE</th><th>CATEGORY</th><th>AMOUNT</th></tr></thead><tbody>
<% if(expenses == null || expenses.isEmpty()){ %><tr><td colspan="4" class="muted">No transactions yet. Add your first expense.</td></tr><% } else { for(Expense e : expenses){ %>
<tr><td><%=e.getTransactionDate()%></td><td><%=esc(e.getTitle())%></td><td><%=esc(e.getCategory())%></td><td>₹ <%=e.getAmount()%></td></tr>
<% }} %>
</tbody></table>
</section></main></body></html>

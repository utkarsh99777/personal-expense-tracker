package com.personalexpensetracker;

import java.math.BigDecimal;
import java.sql.Date;

public class Expense {
    private int id;
    private String title, category, notes;
    private BigDecimal amount;
    private Date transactionDate;

    public Expense(int id, String title, String category, BigDecimal amount, Date transactionDate, String notes) {
        this.id=id; this.title=title; this.category=category; this.amount=amount; this.transactionDate=transactionDate; this.notes=notes;
    }
    public int getId(){ return id; }
    public String getTitle(){ return title; }
    public String getCategory(){ return category; }
    public BigDecimal getAmount(){ return amount; }
    public Date getTransactionDate(){ return transactionDate; }
    public String getNotes(){ return notes; }
}

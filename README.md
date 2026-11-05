# Personal Expense Tracker

A beginner-friendly Java web application for recording personal expenses. This starter project uses Java 17, Jakarta Servlets, JSP, JDBC, MySQL and Apache Tomcat 10.1+.

## Features included in this starter
- Add an expense with title, category, amount, date and optional notes.
- View recorded transactions.
- Display the total of recorded expenses.
- Validate required fields and positive amounts.
- Use JDBC `PreparedStatement` for database inserts.

## Requirements
- Java JDK 17+
- Apache Maven 3.8+
- MySQL 8+
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## 1. Create the database
Open MySQL Workbench or the MySQL command line and run `database/schema.sql`.

## 2. Configure database connection
The app reads these environment variables:
- `DB_URL` (default: `jdbc:mysql://localhost:3306/expense_tracker?useSSL=false&serverTimezone=UTC`)
- `DB_USER` (default: `root`)
- `DB_PASSWORD` (default: empty)

Set `DB_PASSWORD` to your own local MySQL password. Do not commit passwords to GitHub.

## 3. Build the project
Open a terminal in this project folder and run:

```bash
mvn clean package
```

The WAR file will be created at `target/PersonalExpenseTracker.war`.

## 4. Run on Tomcat
Copy `target/PersonalExpenseTracker.war` into Tomcat's `webapps` folder, start Tomcat, then open:

`http://localhost:8080/PersonalExpenseTracker/expenses`

## Project structure
```text
Personal-Expense-Tracker/
├── database/schema.sql
├── src/main/java/com/personalexpensetracker/
│   ├── DB.java
│   ├── Expense.java
│   └── ExpenseServlet.java
├── src/main/webapp/
│   ├── index.html
│   └── index.jsp
├── pom.xml
└── README.md
```

## Current limitations / future improvements
This is a starter implementation, not a production-ready finance product. It currently has no user accounts, authentication, edit/delete actions, income tracking, charts or category reports. Add and test those features before claiming they are implemented. Test the database connection on your own computer before presenting a live demo.

## Academic project note
Update this README with your name, course, section, screenshots and any changes you actually make. Only describe features that work in your submitted version.

package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InsertUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("user_name");
        String department = request.getParameter("department");
        String section = request.getParameter("section");
        String mail = request.getParameter("mail");
        String salary = request.getParameter("salary");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            String dbURL = "jdbc:mysql://localhost:3306/yourDatabaseName";
            String username = "yourUsername";
            String password = "yourPassword";
            conn = DriverManager.getConnection(dbURL, username, password);

            // Create the SQL query
            String sql = "INSERT INTO Users (user_name, department, section, mail, salary) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            stmt.setString(2, department);
            stmt.setString(3, section);
            stmt.setString(4, mail);
            stmt.setDouble(5, Double.parseDouble(salary));

            // Execute the query
            int rows = stmt.executeUpdate();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (rows > 0) {
                out.println("<h1>User inserted successfully!</h1>");
            } else {
                out.println("<h1>Error inserting user.</h1>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1>Error inserting user.</h1>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

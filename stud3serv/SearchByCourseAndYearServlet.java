package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchByCourseAndYearServlet")
public class SearchByCourseAndYearServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String course = request.getParameter("course");
        String year = request.getParameter("year");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            String dbURL = "jdbc:mysql://localhost:3306/yourDatabaseName";
            String username = "yourUsername";
            String password = "yourPassword";
            conn = DriverManager.getConnection(dbURL, username, password);

            // Create the SQL query
            String sql = "SELECT student_name FROM Students WHERE course = ? AND year = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, course);
            stmt.setInt(2, Integer.parseInt(year));

            // Execute the query
            rs = stmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1>Students studying " + course + " in year " + year + ":</h1>");
            out.println("<ul>");

            while (rs.next()) {
                out.println("<li>" + rs.getString("student_name") + "</li>");
            }
            out.println("</ul>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

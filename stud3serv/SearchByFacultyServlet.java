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

@WebServlet("/SearchByFacultyServlet")
public class SearchByFacultyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String facultyName = request.getParameter("faculty_name");

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
            String sql = "SELECT student_name, course, branch, year FROM Faculty WHERE faculty_name = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, facultyName);

            // Execute the query
            rs = stmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1>Students under " + facultyName + ":</h1>");
            out.println("<ul>");

            while (rs.next()) {
                out.println("<li>" + rs.getString("student_name") + " - " + rs.getString("course") + ", " + rs.getString("branch") + ", Year " + rs.getInt("year") + "</li>");
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

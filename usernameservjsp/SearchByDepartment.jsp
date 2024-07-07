<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String department = request.getParameter("department");

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
        String sql = "SELECT user_name FROM Users WHERE department = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, department);

        // Execute the query
        rs = stmt.executeQuery();

        out.println("<h1>Users in " + department + " Department:</h1>");
        out.println("<ul>");

        while (rs.next()) {
            out.println("<li>" + rs.getString("user_name") + "</li>");
        }
        out.println("</ul>");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

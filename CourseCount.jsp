<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String courseName = request.getParameter("course");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    int count = 0;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connect to the database
        String dbURL = "jdbc:mysql://localhost:3306/yourDatabaseName";
        String username = "yourUsername";
        String password = "yourPassword";
        conn = DriverManager.getConnection(dbURL, username, password);

        // Create the SQL query
        String sql = "SELECT COUNT(*) FROM Students WHERE course = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, courseName);

        // Execute the query
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            count = rs.getInt(1);
        }
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

    out.println("<h1>Number of students studying " + courseName + ": " + count + "</h1>");
%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String bookTitle = request.getParameter("booktitle");
    String author = request.getParameter("author");
    String price = request.getParameter("price");

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
        String sql = "INSERT INTO Book (booktitle, author, price) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, bookTitle);
        stmt.setString(2, author);
        stmt.setDouble(3, Double.parseDouble(price));

        // Execute the query
        int rows = stmt.executeUpdate();
        if (rows > 0) {
            out.println("<h1>Book inserted successfully!</h1>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h1>Error inserting book.</h1>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

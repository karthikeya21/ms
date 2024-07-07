<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String author = request.getParameter("author");

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
        String sql = "SELECT * FROM Book WHERE author = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, author);

        // Execute the query
        rs = stmt.executeQuery();
        
        if (!rs.isBeforeFirst()) {
            out.println("<h1>No author found.</h1>");
        } else {
%>
            <table border="1">
                <tr>
                    <th>Book ID</th>
                    <th>Book Title</th>
                    <th>Author</th>
                    <th>Price</th>
                </tr>
<%
            while (rs.next()) {
%>
                <tr>
                    <td><%= rs.getInt("book_id") %></td>
                    <td><%= rs.getString("booktitle") %></td>
                    <td><%= rs.getString("author") %></td>
                    <td><%= rs.getDouble("price") %></td>
                </tr>
<%
            }
%>
            </table>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h1>Error retrieving books.</h1>");
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

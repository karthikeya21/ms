<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String bookTitle = request.getParameter("booktitle");

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
        String sql = "SELECT DISTINCT author FROM Book WHERE booktitle = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, bookTitle);

        // Execute the query
        rs = stmt.executeQuery();
        
        if (!rs.isBeforeFirst()) {
            out.println("<h1>No book found with the given title.</h1>");
        } else {
%>
            <table border="1">
                <tr>
                    <th>Author</th>
                </tr>
<%
            while (rs.next()) {
%>
                <tr>
                    <td><%= rs.getString("author") %></td>
                </tr>
<%
            }
%>
            </table>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h1>Error retrieving authors.</h1>");
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

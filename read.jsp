<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Details</title>
    
</head>
<body>
    <h2>Employee Details</h2>
    <%
        String username = request.getParameter("username");

        if (username == null || username.trim().isEmpty()) {
            out.println("<p>Please provide an employee name.</p>");
        } else {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Karthikeya@2107");

                String query = "SELECT name, salary FROM employee WHERE name = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    String salary = rs.getString("salary");
    %>
    <table>
        <tr>
            <th>Name</th>
            <th>Salary</th>
        </tr>
        <tr>
            <td><%= name %></td>
            <td><%= salary %></td>
        </tr>
    </table>
    <%
                } else {
                    out.println("<p>No employee found with the name " + username + ".</p>");
                }
            } catch (Exception e) {
                e.printStackTrace(new java.io.PrintWriter(out));
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
    
</body>
</html>

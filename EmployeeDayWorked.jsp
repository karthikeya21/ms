<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%
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
        String sql = "SELECT emp_id, emp_name, salary, department, joining_date FROM Employees";
        stmt = conn.prepareStatement(sql);

        // Execute the query
        rs = stmt.executeQuery();
%>
        <table border="1">
            <tr>
                <th>Employee ID</th>
                <th>Employee Name</th>
                <th>Salary</th>
                <th>Department</th>
                <th>Days Worked</th>
            </tr>
<%
        while (rs.next()) {
            int empId = rs.getInt("emp_id");
            String empName = rs.getString("emp_name");
            double salary = rs.getDouble("salary");
            String department = rs.getString("department");
            Date joiningDate = rs.getDate("joining_date");

            // Calculate the number of days worked
            LocalDate joinDate = joiningDate.toLocalDate();
            LocalDate currentDate = LocalDate.now();
            long daysWorked = ChronoUnit.DAYS.between(joinDate, currentDate);
%>
            <tr>
                <td><%= empId %></td>
                <td><%= empName %></td>
                <td><%= salary %></td>
                <td><%= department %></td>
                <td><%= daysWorked %></td>
            </tr>
<%
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
%>
        </table>
<%
%>

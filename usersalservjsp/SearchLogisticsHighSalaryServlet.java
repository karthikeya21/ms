
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

@WebServlet("/SearchLogisticsHighSalaryServlet")
public class SearchLogisticsHighSalaryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            String sql = "SELECT user_name FROM Users WHERE department = 'Logistics' AND salary > 15000";
            stmt = conn.prepareStatement(sql);

            // Execute the query
            rs = stmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1>Users in Logistics Department with Salary > 15000:</h1>");
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

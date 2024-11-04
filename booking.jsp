<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
</head>
<body>
    <h1>Booking Confirmation</h1>

    <%
        String service = request.getParameter("service");

        String url = "jdbc:mysql://localhost:3306/salon";
        String username = "root"; // Change this to your database username
        String password = "password"; // Change this to your database password
        Connection conn = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(url, username, password);

            // Insert booking details into the database (assuming there's a `bookings` table)
            String sql = "INSERT INTO bookings (service_name, booking_date) VALUES (?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, service);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                out.println("<p>Your booking for " + service + " has been confirmed!</p>");
            } else {
                out.println("<p>There was an error confirming your booking.</p>");
            }

            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    %>

    <a href="index.jsp">Back to Services</a>
</body>
</html>

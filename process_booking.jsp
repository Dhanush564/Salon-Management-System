<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String bookingTime = request.getParameter("bookingTime");
    String service = request.getParameter("service");
    String url = "jdbc:mysql://localhost:3306/salon";
    String username = "root"; 
    String password = "password";
    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        String sql = "INSERT INTO bookings (name, email, service, booking_time) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, service);
        stmt.setString(4, bookingTime);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            out.println("<h2>Thank you, " + name + "! Your booking for " + service + " on " + bookingTime + " has been confirmed.</h2>");
        } else {
            out.println("<h2>Sorry, there was a problem with your booking. Please try again.</h2>");
        }

        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
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
<a href="index.html">Back to Home</a>

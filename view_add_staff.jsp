<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View/Add Staff</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fafafa;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <h1>View and Add Staff</h1>
    <h2>Add New Staff</h2>
    <form method="post" action="view_add_staff.jsp">
        <input type="text" name="staff_name" placeholder="Staff Name" required><br>
        <input type="email" name="staff_email" placeholder="Staff Email" required><br>
        <input type="text" name="staff_role" placeholder="Staff Role" required><br>
        <button type="submit">Add Staff</button>
    </form>

    <hr>
    <h2>Current Staff Members</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
            </tr>
        </thead>
        <tbody>
            <%
                String url = "jdbc:mysql://localhost:3306/salon";
                String username = "root";
                String password = "password"; 
                Connection conn = null;
                String staff_name = request.getParameter("staff_name");
                String staff_email = request.getParameter("staff_email");
                String staff_role = request.getParameter("staff_role");

                try {
                
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);
                    if (staff_name != null && staff_email != null && staff_role != null) {
                        String insertSQL = "INSERT INTO staff (name, email, role) VALUES (?, ?, ?)";
                        PreparedStatement stmt = conn.prepareStatement(insertSQL);
                        stmt.setString(1, staff_name);
                        stmt.setString(2, staff_email);
                        stmt.setString(3, staff_role);
                        stmt.executeUpdate();
                        stmt.close();
                    }

                    String query = "SELECT * FROM staff";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("role") %></td>
                        </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <tr>
                        <td colspan="4">Error: <%= e.getMessage() %></td>
                    </tr>
            <%
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
        </tbody>
    </table>

</body>
</html>

<%@page import="java.util.StringTokenizer"%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.text.DecimalFormat"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
         <%
                        String building_name = request.getParameter("building_name");
                        // out.println(bulding_name);
%>			<h2>
                        <font size="4" >
                            Scenario Information of building:<% building_name = building_name.replace("_", " ");
                                out.println(building_name);
                                building_name = building_name.replace(" ", "_");
                            %>
                        </font>
                    </h2>
        <%
            //String building_name = request.getParameter("building_name");
            connectionString cs = new connectionString();
            String url = cs.url;
            String username = cs.username;
            String password = cs.password;
            String method1 = "", method2 = "";
            
            try {
                Class.forName("org.postgresql.Driver");
                //String url = "jdbc:postgresql://localhost:5432/MTP";
                //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                Connection con = DriverManager.getConnection(url, username, password);
                ResultSet rs = null;
                // out.println("connectionnnn stablished");
                Statement s = con.createStatement();
                String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                rs = (s.executeQuery(q1));
                int building_id = 0;
                while (rs.next()) {
                    building_id = rs.getInt("building_id");
                    //out.println("print building iddddd" + building_id);
                }
                
                %>
                <table border="1" cellpadding="5" cellspacing="5" width="10%">    
                        <tr><td>Scenario ID</td><td>Scenario Description</td></tr>  
                         <%
                         String q2 = "Select * from scenario where building_id="+building_id;
                         rs = (s.executeQuery(q2));
                         while(rs.next()) { %>
                             <tr><td><%out.println(rs.getInt(2));%></td><td><%out.println(rs.getString(3));%></td></tr>
                        <% }
                                               }
            catch(Exception e) {
            System.out.println(e.getMessage());
            }
                    
                   
       %>
   </table>
  </body>
    <form method="post" action="View_data.jsp">
            <input type="submit" value="Back"/>
        </form>
</html>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <!-- ------------------------------------------------------------------------------------>
        <br/>    
        <h2>
            <font size="4" >
                Select Building you want to compare for :
            </font>
        </h2>
        <form method="post" action="output_option.jsp">
            <table border="0" cellpadding="5" cellspacing="5" align="center">
                <tr><td>
                        <select name="building_name" id="building_name">
                            <%
                                connectionString cs = new connectionString();
                                String url = cs.url;
                                String username = cs.username;
                                String password = cs.password;

                                try {
                                    Class.forName("org.postgresql.Driver");
                                    //String url = "jdbc:postgresql://localhost:5432/MTP";
                                    //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                                    Connection con = DriverManager.getConnection(url, username, password);

                                    ResultSet rs = null;
                                    // out.println("connectionnnn stablished");
                                    Statement s = con.createStatement();
                                    String q1 = "Select * from buildings";
                                    rs = (s.executeQuery(q1));
                                    while (rs.next()) {%>
                            <option value=<%out.println(rs.getString("building_name"));%>>
                                <%
                                    out.println(rs.getString("building_name"));
                                %>
                            </option>
                            <%
                                }
                            %>
                        </select></td>
                </tr>
                <tr></tr>
                <tr>
                    <td> <b> Method 1 : </b></td> <td>
                        <select name="algo1" id="algo1" >
                            <option value="1">General Evacuation Planning</option>
                            <option value="11">Evacuation Planning with Dynamic Ladder Placement</option>         
                            <option value="21">Priority Based Evacuation Planning</option>
                        </select><br></td>

                    <td> <b> Method 2 : </b></td> <td>
                        <select name="algo2" id="algo2" >
                            <option value="1">General Evacuation Planning</option>
                            <option value="11">Evacuation Planning with Dynamic Ladder Placement</option>         
                            <option value="21">Priority Based Evacuation Planning</option>
                        </select><br></td> </tr>
                <tr></tr><tr>
                    <td> <b> Scenario : </b></td> <td>
                        <select name="scenario_desc" id="scenario_desc" >
                            <%  String q2 = "Select * from scenario";
                                rs = (s.executeQuery(q2));
                                while (rs.next()) {%>
                            <option value="<%out.println(rs.getString("scenario_description"));%>">
                                <%
                                        out.println(rs.getString("scenario_description"));
                                    }%>
                            </option>
                        </select><br></td> </tr>
                <tr>
                    <td><input type="submit" value="Submit"/></td></tr>
            </table>
        </form>
        <%      rs.close();
                s.close();
                con.close();
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
            }

        %>
    </body>
</html>
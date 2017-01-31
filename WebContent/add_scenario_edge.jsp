<%-- 
    Document   : add_scenario_edge
    Created on : May 11, 2013, 5:14:52 PM
    Author     : kabii
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
    <center>
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                    String building_name = session.getAttribute("building_name").toString();
                    String scenario_name = session.getAttribute("scenario_name").toString();
                    String scenario_desc = session.getAttribute("scenario_desc").toString();
                   // String building_id = session.getAttribute("building_id").toString();
                        // System.out.println("build : "+ building_name);
                    %>
                    <center>
                        <p align="center"><b>Editing data for scenario <%
                                    out.println(" " + scenario_desc);%> of building <%
                                 
                                    out.println(building_name);
                                %>  </b>
                        </p>
                    </center>
                    

                    <form method="post" action="added_scenario_edge.jsp">
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <table border="0" cellpadding="1" cellspacing="4">
                            <tr></tr>

                            <tr><td> Scenario ID </td> 
                                <td><input type = "text" name ="scenario_name" value=<%out.println(scenario_name);%>/></td>

                                <td> Scenario Description </td>
                                <td><input type="text" name ="scenario_desc" value=<%out.println(scenario_desc);%>/></td>
                            </tr>

                            <tr><td> Edge Id </td>
                                <td>  
                                <select name="Edge_number" id="Edge_number">
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
                            //   System.out.println("connectionnnn stablished");
                           Statement s = con.createStatement();
                         //  System.out.println("ID "+building_id);
                             String q1 = "Select * from edge where building_name='"+session.getAttribute("building_name").toString()+"'";
                            rs = (s.executeQuery(q1));
                            while (rs.next()) {%>
                    <option value=<%out.println(rs.getString("edge_id"));%>>
                        <%out.println(rs.getString("edge_id"));%>
                    </option>
                    
                    <% }
                            out.println("Add edge information for scenario " + scenario_desc + " of building: " + building_name);
                           
                    %>    
                  				</select></td>
                                <td> Danger Level </td>
                                <td><input type="text"  name ="Edge_danger"></td>
                            </tr> 
                            <tr> 
                               <td> Travel Speed Fit </td>
                                <td><input type="text"  name ="travel_speed_fit"></td>
                                <td> Travel Speed Injured </td>
                                <td><input type="text"  name ="travel_speed_injured"></td>
                            </tr> 
                            <tr>
                                <td><input type="submit" name="B1" value="Submit" />
                                <td><input type="reset" name="B2" value="Reset" /></td>        
                            </tr>    
                        </table>
                    </form>   

                    <b> Edges Present earlier for Scenario: <%out.println(" " + scenario_desc);%></b>
                </td></tr></table>


        <table border="1" cellpadding="5" cellspacing="5" width="10%">    
        
<!-- building_id
scenario_id
edge_id
danger_level
travel_speed_fit
travel_speed_injured -->
        
            <tr><td><td>Edge ID</td><td>Danger Level</td><td>Travel Speed Fit</td><td>Travel Speed Injured</td></tr>     
            <%
            String query1 = "select * from scenario_edge where building_name = '"+building_name+"' and scenario_name= '"+scenario_name+"'";
                rs = s.executeQuery(query1);
                while (rs.next()) {
            %>
            <tr><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
            <%
                }

            %>
        </table>
        <%
                rs.close();
                s.close();
                con.close();
                System.out.println("No");
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
                System.out.println("Nooo");
            }
        %>
        </center>
    </body>
</html>

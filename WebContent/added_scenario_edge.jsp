<%-- 
    Document   : added_scenario_edge
    Created on : May 12, 2013, 5:10:43 AM
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                    String building_name = session.getAttribute("building_name").toString();
                   // String building_id = session.getAttribute("building_id").toString();
                    String scenario_name = session.getAttribute("scenario_name").toString();
                    String scenario_desc = session.getAttribute("scenario_desc").toString();
                        String Edge_id = request.getParameter("Edge_number");
                        String Edge_danger = request.getParameter("Edge_danger");
                        String Travel_s_fit = request.getParameter("travel_speed_fit");
                        String Travel_s_inj = request.getParameter("travel_speed_injured");
                    %>
                    Added edge information for scenario <b> <% out.println(" " + scenario_desc + " ");%> </b> of building <b> <% /* building_name = building_name.replace("_", " "); */
                        out.println(building_name);
                        %> </b><br/><br/>
                    With information :<br/>
                    <%
                        if (Edge_id != null && Edge_danger != null) {
                    %>  <table border="0" cellpadding="1" cellspacing="4" width="100%">
                        <tr><td><% out.println("  Edge ID : " + request.getParameter("Edge_number"));%></td>
                            <td><% out.println("  Edge Danger : " + request.getParameter("Edge_danger"));%></td>   
                        </tr>
                        <tr><td><% out.println(" Travel speed fit : " + request.getParameter("travel_speed_fit"));%></td>
                            <td><% out.println(" Travel speed injured : " + request.getParameter("travel_speed_injured"));%></td>   
                        </tr>
                    </table>
                    <%
                        } else {
                            out.println("<html><font color=red>Please enter proper values.</font></html>");
                        }
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
                            String ins = "update scenario_edge set danger_level = " + Integer.parseInt(Edge_danger) +", travel_speed_fit = "+ Float.parseFloat(Travel_s_fit)+", travel_speed_injured = "+Float.parseFloat(Travel_s_inj)+" where building_name = '"+building_name+"' and  scenario_name = '"+scenario_name+"' and edge_id = '"+ Edge_id+"'";
                            s.executeUpdate(ins);
                           
                    %>

                    <form action ="add_another_scenario_edge.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/> 
                        <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>    
                        <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%>/>
                        <table><tr>
                                <td><input type="submit" name="B1" value="Add another edge information" /></td>
                        </tr></table>
                    </form>
                  
                </td></tr></table>

        <table border="1" cellpadding="5" cellspacing="5" width="10%">    
            <br/><hr/><br/><b>Updated Edge File:</b><br/> 
            <!--Print these details-->
            <tr><td>Edge ID</td><td>Danger Level</td><td>Travel Speed Fit</td><td>Travel Speed Injured</td></tr>     
            <%
                String query1 = "select * from scenario_edge where building_name = '"+building_name+"' and scenario_name= '"+scenario_name+"'";
                rs = s.executeQuery(query1);
                while (rs.next()) {
            %>
            <tr><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
            <%
                            }%>
        </table>
        <%
                rs.close();
                s.close();
                con.close();
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
                //out.println(count2);
            }
        %>
        <form method="post" action="add_scenario_info.jsp">
            <input type="hidden" name="building_name" value = <% out.println(building_name);%>/> 
            <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>    
            <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%>/> 
            <input type="submit" value="Back">
        </form>
    </body>
</html>

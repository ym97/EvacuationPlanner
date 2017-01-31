<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp"%>
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
                        String building_name = request.getParameter("building_name");
                        String flr_num = request.getParameter("flr_num");
                    %>
                    Added node to building -<b> '<% building_name = building_name.replace("_", " ");
                        out.println(building_name);
                        building_name = building_name.replace(" ", "_");
                        %>' </b><br/><br/>
                    With information :<br/>
                    <%
                        if (request.getParameter("Node_number") != null && request.getParameter("Node_name") != null && request.getParameter("Node_floor") != null && request.getParameter("Node_capacity") != null && request.getParameter("Node_initial") != null && request.getParameter("Node_lat") != null && request.getParameter("Node_long") != null) {
                    %>  <table border="0" cellpadding="1" cellspacing="4" width="100%">
                        <tr><td><% out.println("   Node ID :  " + request.getParameter("Node_number"));%></td>
                            <td><% out.println("   Node Name:  " + request.getParameter("Node_name"));%></td>
                            <td><% out.println("   Floor:  " + request.getParameter("Node_floor"));%></td>
                            <td><% out.println("   Actual Capacity :  " + request.getParameter("Node_capacity"));%></td></tr>
                        <tr><td><% out.println("   Initial Capacity :  " + request.getParameter("Node_initial"));%></td>
                            <td><% out.println("   Latitude :  " + request.getParameter("Node_lat"));%></td>
                            <td><% out.println("   Longitude :  " + request.getParameter("Node_long"));%></td><tr>
                        <tr><td><% out.println("   Ladder Point :  " + request.getParameter("Node_ladder"));%></td>
                            <td><% //out.println("\n Details of all the nodes entered");%></td></tr>
                    </table>
                    <%
                        } else {
                            out.println("<html><font color=red>Please enter proper values.</font></html>");
                        }
                        String Node_number = request.getParameter("Node_number");
                        String Node_name = request.getParameter("Node_name");
                        String Node_floor = request.getParameter("Node_floor");
                        String Node_capacity = request.getParameter("Node_capacity");
                        String Node_initial = request.getParameter("Node_initial");
                        String Node_lat = request.getParameter("Node_lat");
                        String Node_long = request.getParameter("Node_long");
                        String Node_ladder = request.getParameter("Node_ladder");
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
                            String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //   System.out.println("print building iddddd" + building_id);
                            }

                            String ins = "INSERT INTO node_" + building_id + "_withoutladder VALUES (" + building_id + " , " + Integer.parseInt(Node_number) + " , '" + Node_name + " ', '" + Node_floor + "' , " + Integer.parseInt(Node_capacity) + " , " + Integer.parseInt(Node_initial) + " , " + Float.parseFloat(Node_lat) + " , " + Float.parseFloat(Node_long) + ")";
                            s.executeUpdate(ins);
                            if (!Node_ladder.isEmpty()) {
                                out.println("ladder not empty");
                                String ins1 = "INSERT INTO node_" + building_id + "_withladder VALUES (" + building_id + " , " + Integer.parseInt(Node_number) + ")";
                                s.executeUpdate(ins1);
                            }
                    %>
                    <form action ="add_node_ref_image.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <input type="hidden" name="flr_num" value = <% out.println(flr_num);%>/>
                        <table><tr>
                                <td><input type="submit" name="B1" value="Add anoter node"/></td>
                            </tr></table>
                    </form>
                </td></tr></table>
        <table><tr><td valign="top">  
                    <br/><hr/><br/><b>Updated Node File:</b><br/> 
                    <table border="1" cellpadding="5%" cellspacing="5%" width="10%">
                        <!--Print these details-->
                        <%
                            //System.out.println("Hello");
                            String query1 = "select * from information_schema.tables where table_name = 'node_" + building_id + "_withladder'";
                            rs = s.executeQuery(query1);
                            if (rs.next()) {%>
                        <tr><td>Node ID</td><td>Node Name</td><td>Floor</td><td>Actual Capacity</td><td>Initial Capacity</td><td>Latitude</td><td>Longitude</td><td>Ladder</td></tr>     
                        <% // out.println("ladder found");
                            String query2 = "SELECT n1.*, n2.node_id FROM node_" + building_id + "_withoutladder as n1 LEFT JOIN node_" + building_id + "_withladder as n2 ON n1.node_id = n2.node_id;";
                            rs = (s.executeQuery(query2));
                            while (rs.next()) {
                                if (rs.getInt(9) != 0) {%>
                        <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td><% out.println(rs.getInt(9));%></td></tr>
                        <%
                        } else {%>
                        <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td></td></tr>
                        <%
                                }
                            }
                        } else {%>
                        <tr><td>Node ID</td><td>Node Name</td><td>Floor</td><td>Actual Capacity</td><td>Initial Capacity</td><td>Latitude</td><td>Longitude</td></tr>     
                        <% // out.println("kuch to print ho");
                            String query = "Select * from node_" + building_id + "_withoutladder";
                            rs = (s.executeQuery(query));
                            while (rs.next()) {
                        %>
                        <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
                        <%
                                }
                            }%>
                    </table>
                </td>
                <td><table border="1">
                        <tr><td align="center">The Uploaded Image for reference:</td></tr>
                        <%
                            String file_name1 = building_name + "_" + flr_num + "_Floor_plan.png";%>
                        <tr><td><img src="<%out.println(file_name1);%>" height="100%" width="100%"/></td></tr>                    
                    </table>
                </td>
            </tr>
        </table>
        <%
                rs.close();
                s.close();
                con.close();
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
                //out.println(count2);
            }%>
        <form method="post" action="edit_data.jsp">
            <input type="submit" value="Back">
        </form>
    </body>
</html>

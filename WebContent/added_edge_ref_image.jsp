<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
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
                        String building_name = request.getParameter("building_name");
                        String flr_num = request.getParameter("flr_num");
                    %>
                    Added edge to building -<b> '<%-- <% building_name = building_name.replace("_", " "); --%>
                        out.println(building_name);
                        <!-- building_name = building_name.replace(" ", "_"); -->
                        %>' </b><br/><br/>
                    With information :<br/>
                    <%
                        if (request.getParameter("Edge_Id") != null && request.getParameter("Edge_name") != null && request.getParameter("From_Node") != null && request.getParameter("To_Node") != null && request.getParameter("Edge_t_time") != null && request.getParameter("Edge_capacity") != null) {
                    %><table border="0" cellpadding="1" cellspacing="4" width="100%">
                        <tr><td><% out.println("Edge_Id:  " + request.getParameter("Edge_Id"));%></td>
                            <td><% out.println("Edge_name:  " + request.getParameter("Edge_name"));%></td>
                            <td><% out.println("From_Node:  " + request.getParameter("From_Node"));%></td>
                            <td><% out.println("To_Node:  " + request.getParameter("To_Node"));%></td>
                            <td><% out.println("Edge_travel_time:  " + request.getParameter("Edge_t_time"));%></td>
                            <td><% out.println("Edge_Capacity:  " + request.getParameter("Edge_capacity"));%></td>
                        </tr></table>
                        <%            } else {
                                out.println("<html><font color=red>Please enter the values.</font></html>");
                            }
                            //out.println("\n Details of all the nodes entered");

                            String Edge_Id = request.getParameter("Edge_Id");
                            String Edge_name = request.getParameter("Edge_name");
                            String From_Node = request.getParameter("From_Node");
                            String To_Node = request.getParameter("To_Node");
                            String Edge_t_time = request.getParameter("Edge_t_time");
                            String Edge_capacity = request.getParameter("Edge_capacity");

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
                                out.println("connectionnnn stablished");
                                Statement s = con.createStatement();
                                /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                                rs = (s.executeQuery(q1));
                                int building_id = 0;
                                while (rs.next()) {
                                    building_id = rs.getInt("building_id");
                                    //   System.out.println("print building iddddd" + building_id);
                                } */
                                String ins = "INSERT INTO edge VALUES (" + building_name + " , " + Integer.parseInt(Edge_Id) + " , '" + Edge_name + "' , " + Integer.parseInt(From_Node) + " , " + Integer.parseInt(To_Node) + " , " + Float.parseFloat(Edge_t_time) + " , " + Integer.parseInt(Edge_capacity) + ")";
                                s.executeUpdate(ins);
                        %>
                    <form action ="add_edge_ref_image.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <input type="hidden" name="flr_num" value = <% out.println(flr_num);%>/>
                        <table><tr>
                                <td><input type="submit" name="B1" value="Add anoter edge" /></td>
                            </tr></table>
                    </form>
                </td></tr></table>
        <table><tr><td valign="top">
                    <br/><hr/><br/><b>Updated Edge File:</b><br/> 
                    <table border="1" cellpadding="5" cellspacing="5" width="10%">   
                        <tr><td>Edge_ID</td><td>Edge_Name</td><td>From_Node</td><td>To_Node</td><td>Edge_travel_time</td><td>Edge_Capacity</td></tr>

                        <%    String query1 = "Select * from edge where building_name = '" + building_name+"'";
                            rs = (s.executeQuery(query1));
                            while (rs.next()) {
                        %>
                         <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getInt(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getString(5));%> </td><td> <% out.println(rs.getString(6));%> </td><td> <% out.println(rs.getInt(7));%> </td></tr>
                        <%
                            }%>
                    </table>
                </td>
                <td><table border="1">
                        <tr><td align="center">The Uploaded Image for reference:</td></tr>
                        <%
                            String file_name1 = building_name + "_" + flr_num + "_Floor_plan.png";%>
                        <tr><td><img src="<%out.println(file_name1);%>" height="100%" width="100%" /></td></tr>                    
                    </table>
                </td>
            </tr></table>            
        <%  
                rs.close();
                s.close();
                con.close();

            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
        %>
        <form method="post" action="edit_data.jsp">
            <input type="submit" value="Back"/>
        </form>
    </body>
</html>

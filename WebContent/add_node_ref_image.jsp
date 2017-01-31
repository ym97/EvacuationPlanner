<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<%int i = 0;
    int node_id = 1;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <table border="0" cellpadding="5" cellspacing="5" width="100%">
        <tr>
            <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white" >
                <center>
                    <%
                        String building_name = request.getParameter("building_name");
                        String flr_num = request.getParameter("flr_num");
                        //String edit_option = request.getParameter("edit_option");
                    %>
                    <p align="center"><b>Editing data for building <%
                       // building_name = building_name.replace("_", " ");
                        out.println(building_name);

                            %>  </b></p>
                </center>
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
                        Statement stm = con.createStatement();
                        /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                        rs = (stm.executeQuery(q1));
                        int building_id = 0;
                        while (rs.next()) {
                            building_id = rs.getInt("building_id");
                            //out.println("print building iddddd" + building_id);
                        } */
                        out.println("Add node for building:" + building_name);
                      //  building_name = building_name.replace(" ", "_");
                %>    
                <form method="post" action="added_node_ref_image.jsp">
                    <input type="hidden" name="flr_num" value = <% out.println(flr_num);%>/>
                    <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                    <table border="0" cellpadding="1" cellspacing="4">
                        <tr></tr>
                        <tr><td>Node Id</td>
                            <td><input type="text" name="Node_number"/></td>
                            <td>Node Name</td> 
                            <td><input type="text" name="Node_name"/></td>
                            <td>Floor</td> 
                            <td><input type="text" name="Node_floor"/></td>
                            <td>Actual Capacity</td> 
                            <td><input type="text" name="Node_capacity"/></td></tr>

                        <tr><!-- <td>Initial Capacity</td> 
                            <td><input type="text" name="Node_initial"/></td> -->
                            <td>Latitude</td> 
                            <td><input type="text" name="Node_lat"/></td>
                            <td>Longitude</td> 
                            <td><input type="text" name="Node_long"/></td>
                        </tr>
                        <tr><td>Ladder Point</td><td><input type="text" name="Node_ladder"></td></tr>
                        <tr>
                            <td><input type="submit" name="B1" value="Submit"/>
                            <td><input type="reset" name="B2" value="Reset"/></td>        
                        </tr>    
                    </table>
                </form>  
                <table><tr><td valign="top">
                            <b> Nodes Present earlier:</b>
				<tr><td>Node ID</td><td>Node Name</td><td>Building Name</td><td>Capacity</td><td>Floor</td><td>Latitude</td><td>Longitude</td></tr>     
            <% // out.println("kuch to print ho");
                String query = "Select * from node where building_name = '"+building_name+"'";
                rs = stm.executeQuery(query);
                while (rs.next()) {
            %>
            <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td></tr>
            <%
                    }
                %>   
                 </table>
    <%
            rs.close();
            stm.close();
            con.close();
        } catch (Exception e) {//Catch exception if any
            System.err.println("Error: " + e.getMessage());
            //out.println(count2);
        }
    %>
</body>
</html>


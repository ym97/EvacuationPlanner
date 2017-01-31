<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="com.sun.org.apache.bcel.internal.generic.TABLESWITCH"%>
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
    <u><a href="edit_data.jsp" target="f2" ><font size="4">Edit data</font></a></u>>
    <u><a href="Edit_options_passed.jsp" target="f2" ><font size="4">Options</font></a></u>>
     <font size="4">Delete node</font>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                        String lineToRemove = request.getParameter("edge_to_be_deleted");
                        String building_name = request.getParameter("building_name");
                        String creator=request.getParameter("uName");
                    %>

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
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
                            rs = (stm.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                            } */

                            String query1 = "Select * from edge as e where e.edge_id = '" + lineToRemove+"' and building_name ='"+building_name+"'";
                            rs = (stm.executeQuery(query1));
                            while (rs.next()) {

                    %>
                    <p>Successfully deleted the edge with information: <br/>
                        {Edge ID, Edge Name, Building Name, Edge Floor , To Node, From Node,  Capacity, Edge Length} <br/>
                        <% //out.println(file); 
                                out.println(rs.getString(1) + " , " +rs.getString(2) + " , " + rs.getString(3) + " , " + rs.getInt(4) + " , " + rs.getString(5) + " , " + rs.getString(6) + " , " + rs.getInt(7) + " , " + rs.getFloat(8));
                            }%>      </p><hr/>

                    <%

                        String query2 = "DELETE FROM edge as e where e.edge_id = '" + lineToRemove+"' and building_name ='"+building_name+"'";
                        stm.executeUpdate(query2);
                    %>

                    <form action ="delete_another_edge.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>
                        <table align="center"><tr>    
                                <td><input type="submit" name="B1" value="Delete another edge" /></td>
                            </tr></table>
                    </form>
                </td>
            </tr>
        </table>

        <b>Updated Edge File:</b><br/> 
        <!--Print these details-->
           <tr><td>Edge ID</td><td>Edge Name</td><td>Building Name</td><td>Edge Floor</td><td>Source Node</td><td>Destination Node</td><td>Edge Capacity</td><td>Edge length</td></tr>
            <%    query1 = "Select * from edge where building_name = '"+building_name+"'";
                rs = (stm.executeQuery(query1));
                while (rs.next()) {
            %>
             <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getString(5));%> </td><td> <% out.println(rs.getString(6));%> </td><td> <% out.println(rs.getInt(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
            <%
                            }%>
        </table>
        <%
                rs.close();
                stm.close();
                con.close();
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
        %>
        <form method="post" action="edit_data.jsp">
            <center><input type="submit" value="Back"/></center>
        </form>
    </body>
</html>
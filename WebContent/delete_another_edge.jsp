<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<%int i = 0;
    int node_id = 0;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                        String building_name = request.getParameter("building_name");
                        //String edit_option = request.getParameter("edit_option");
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
                    %>                              

                    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
            <center>
                <p align="center">Deleting a edge for Building : <% //building_name = building_name.replace("_", " ");
                    out.println(building_name);
                    //building_name = building_name.replace(" ", "_");
                    %> </p>   
                Select edge to be deleted.<br/>

                <form method="post" action ="delete_edge.jsp">
                    <input type="hidden" name="building_name" value = <% out.println(building_name);%>/> 
                    <table border="0" cellpadding="1" cellspacing="4">
                        <tr><td>        
                                <select name="edge_to_be_deleted" id="edge_to_be_deleted">
                                    <%
                                        String query1 = "Select * from edge where building_name ='"+building_name+"'";
                                        rs = (stm.executeQuery(query1));
                                        while (rs.next()) {
                                    %> <option value=<%out.println(rs.getString(1));%>>
                                <%
                                        out.println(rs.getInt(1)+ " | "+rs.getInt(2));// + " | " + rs.getString(3) + " | " + rs.getInt(4) + " | " + rs.getInt(5) + " | " + rs.getFloat(6) + " | " + rs.getInt(7));
                                    }%>
                                    </option>                                
                                </select> 
                            </td></tr>
                        <tr>
                            <td><input type="submit"  value="Submit"/> 
                                <!--<td><input type="reset" name="B2" value="Add an edge" /></td>-->        
                        </tr>  
                    </table>
                </form>
            </center>
            <%
                    rs.close();
                    stm.close();
                    con.close();
                } catch (Exception e) {
                    System.err.println("Error: " + e.getMessage());
                }
            %>
        </td></tr>
</table>
</body>
</html>


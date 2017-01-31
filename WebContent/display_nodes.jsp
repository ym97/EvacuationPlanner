<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file ="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="java.io.File"%>;
<%@page import="java.io.FilenameFilter"%>;
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
     <center><b><%out.println(session.getAttribute("building_name"));%></b></center>
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" valign="top">
                    <% String building_name = session.getAttribute("building_name").toString();
                    	String creator= request.getParameter("creator");
                        final String buildingNameForSearch = building_name;
                    %>
                    
                    <table border="1" cellpadding="5" cellspacing="5" align="center">    
                        <%
                            System.out.println("Hello");
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
                                /* String q1 = "Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
                                rs = (s.executeQuery(q1));
                                int building_id = 0;
                                while (rs.next()) {
                                    building_id = rs.getInt("building_id");
                                    //out.println("print building iddddd" + building_id);
                                } */
                                String query1 = "select * from node where building_name = '"+building_name+"'";
                                rs = s.executeQuery(query1); %>
                              
                              
                              
                              
                             
                     <tr><td>Node ID</td><td>Node Name</td><td>Building Name</td><td>Capacity</td><td>Floor</td><td>Latitude</td><td>Longitude</td></tr>     
                        <% // out.println("kuch to print ho");
                           
                            while (rs.next()) {
                        %>
                        <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td></tr>
                        <%
                                    }
                                
                                rs.close();
                                s.close();
                                con.close();
                            } catch (Exception e) {
                                System.err.println("Error: " + e.getMessage());
                            }
                            /* String s1 = getServletContext().getRealPath("") + "/";
                            File root = new File(s1);
                            //File root = new File("C:/users/kabii/Desktop/HDEEP_1_new_may12_withCSS/build/web/");
                            FilenameFilter beginswith = new FilenameFilter() {
                                public boolean accept(File directory, String filename) {
                                    return filename.startsWith(buildingNameForSearch);
                                }
                            };
                            File[] files = root.listFiles(beginswith); */
                        %>
                    </table></td>
                <td valign="top"><%-- <table>
                        <%
                            for (File f : files) {
                                System.out.println(f);
                                String file_name1 = f.getName();
                                if (file_name1.endsWith("_Floor_plan.png")) {
                        %>
                        <tr><td><%out.println(file_name1);%><img src="<%out.println(file_name1);%>" width="100%" height="100%" /></td></tr>
                                <%}
                                    }
                                %>
                    </table> --%>
                    <form method="post" action="View_data.jsp">
                        <input type="submit" value="Back">
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>

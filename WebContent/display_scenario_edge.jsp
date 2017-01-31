<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white" valign="top">
                <% String building_name = request.getParameter("building_name");
                    String scenario_name = request.getParameter("scenario_name");
                    final String buildingNameForSearch = building_name;

                %>
                <h2>
                    <font size="4">
                        Edge Information of building <% 
                            out.println(building_name);
                          
                        %> for Scenario <%out.println(scenario_name);%> </b>
                    </font> 
                </h2>

                <table border="1" cellpadding="5" cellspacing="5" align="center">    
                    <%
                        //System.out.println("Hello");
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
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //out.println("print building iddddd" + building_id);
                            } */%>
                            
                            <tr><td>Edge ID</td><td>Danger Level</td><td>Travel Speed Fit</td><td>Travel Speed Injured</td></tr>
                            <%
                            String q1 = "Select * from edge where building_name='"+session.getAttribute("building_name").toString()+"'";
                            rs = (s.executeQuery(q1));
                            while (rs.next()) {
                                %>
                                <tr><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
                                <%
                                    }

                            rs.close();
                            s.close();
                            con.close();
                        } catch (Exception e) {
                            System.err.println("Error: " + e.getMessage());
                        }

                        String s1 = getServletContext().getRealPath("") + "/";
                        File root = new File(s1);
                        //File root = new File("C:/users/kabii/Desktop/HDEEP_1_new_may12_withCSS/build/web/");
                        FilenameFilter beginswith = new FilenameFilter() {

                            public boolean accept(File directory, String filename) {
                                return filename.startsWith(buildingNameForSearch);
                            }
                        };

                        File[] files = root.listFiles(beginswith);

                    %>
                </table>

            <TD valign="top"><table>
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
                </table>

                </tr>
        </table>

        <form method="post" action="view_scenario_option.jsp">

            <input type="hidden" name="building_name" value = <% out.println(building_name);%> >    
            <input type="hidden" name="scenario_desc" value = <% out.println(scenario_name);%> >    
            <input type="submit" value="Back">
        </form>
    </body>
</html>

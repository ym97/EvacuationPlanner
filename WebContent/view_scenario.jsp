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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
    <u><a href="building_created.jsp" target="f2" >Home</a></u> > 
     <u><a href="View_data.jsp" target="f2" >View data</a></u> > 
     View scenario
        <table border="0" cellpadding="5" cellspacing="5" width="50%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                   <p align="center"><b>Select the building name and Scenario ID to view data of the building</b></p>
                    <center>
                        <form action="view_scenario_option.jsp"  method="post" >
                           
                                <%
                                String buildingName = request.getParameter("param1");
                         		if(buildingName==null)
                        				buildingName = session.getAttribute("building_name").toString();
                                 session.setAttribute("building_name", buildingName);
                                 
                                 
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
                                       
%>
                             
                           
                            <select name="scenario_name" id="scenario_name" >
                                <% String q3 = "Select distinct scenario_name from scenario_node where building_name ='"+buildingName+"'";
                                rs = s.executeQuery(q3);
                                while(rs.next()) { %>
                                 <option value=<%out.println(rs.getString("scenario_name"));%>>
                                    <%
                                        out.println(rs.getString("scenario_name"));
                                    %>
                                </option>
                                <%
                                    }
%>
                            </select>                
                            <input type="submit" value="Submit"/>
                        </form>
                        <br/><br/><br><br/><br/><br/>                
                    </center> 
                </td>
            </tr>
        </table>
      <%
            s.close();
            con.close();
        } catch (Exception e) {//Catch exception if any
            System.err.println("Error: " + e.getMessage());
            //out.println(count2);
        }
    %>
        <form method="post" action="View_data.jsp">
            <input type="submit" value="Back"/>
            </form>
          </body>
</html>

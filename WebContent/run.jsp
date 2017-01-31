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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <%System.out.println("inside run.jsp");
        String building_name = session.getAttribute("building_name").toString();
        
        String scenario_name = request.getParameter("scenario_name");
        session.setAttribute("scenario_name", scenario_name);   

      //  System.out.println("inside run.jsp"+scenario_name);

        %>
        <center><b><%out.println(session.getAttribute("building_name"));%></b></center>
        <center><b><%out.println(session.getAttribute("scenario_name"));%></b></center>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
            <td bgcolor="white"><br/>
              <!--   <form action="edit_node_before_run.jsp" method="post"> -->
              <form action="temp.jsp" method="post">
                   
                        <% connectionString cs = new connectionString();
                            String url = cs.url;
                            String username = cs.username;
                            String password = cs.password;
                            String evac=null;
                            try {
                                Class.forName("org.postgresql.Driver");
                                //String url = "jdbc:postgresql://localhost:5432/MTP";
                                //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                                Connection con = DriverManager.getConnection(url, username, password);
                                ResultSet rs = null;
                                // out.println("connectionnnn stablished");
                                Statement s = con.createStatement();
                             //   Statement s = con.createStatement();
                                System.out.println("uname: " +session.getAttribute("uName").toString());
                                String q1 = "Select evacuation_type from scenario_node where building_name='"+building_name+"' and scenario_name ='"+scenario_name+"'"; //where creator='"+session.getAttribute("uName").toString()+"'";
                                rs = (s.executeQuery(q1));
                                while (rs.next()) {
                       				evac=rs.getString("evacuation_type");
                       				System.out.println("evac "+evac);
                                }
                                rs.close();
                                s.close();
                                con.close();
                            } catch (Exception e) {//Catch exception if any
                                System.err.println("Error1: " + e.getMessage());
                            }
                               
                 		%>
                    <br/><!--input type="checkbox" onclick="changeVisibility(this)"><label id="ladder" style="visibility: hidden">&nbsp;&nbsp;Number of ladders <input type="text" size="10" id="ladderNum" name="ladderNum"  value="0"></label-->
                    
                    
                    
                    <br/><br/>Select Method for Evacuation Plan:<br/>   
                    
                    <select name="algo" id="algo" >
                    <% try {
                                Class.forName("org.postgresql.Driver");
                                //String url = "jdbc:postgresql://localhost:5432/MTP";
                                //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                                Connection con = DriverManager.getConnection(url, username, password);
                                ResultSet rs = null;
                                // out.println("connectionnnn stablished");
                                Statement s = con.createStatement();
                              
                               
                                String q1 = "Select algo from algorithm where evacuation_type ='"+evac+"'"; //where creator='"+session.getAttribute("uName").toString()+"'";
                                rs = (s.executeQuery(q1));
                                while (rs.next()) {%>
                                <option value=<%out.println(rs.getString("algo"));%>>
                                    <%out.println(rs.getString("algo"));%>
                                </option>
                                
                                <%
                                }
                                System.out.println("algo: ");
                                rs.close();
                                s.close();
                                con.close();
                            } catch (Exception e) {//Catch exception if any
                                System.err.println("Error2: " + e.getMessage());
                            }%>
                        
                    </select><br>

                   
                    <input type="submit" value="Submit"/>
                </form>
            </td>
        </tr>
    </table>
   
</body>
</html>

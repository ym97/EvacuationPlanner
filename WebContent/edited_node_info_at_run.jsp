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
<%@page import="java.text.SimpleDateFormat"%>
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
    <script>
        function changeVisibility(id){
            if(id.checked)
                document.getElementById("ladder").style.visibility="visible";
            else{
                document.getElementById("ladder").style.visibility="hidden";
                document.getElementById("ladderNum").value="0";        
            }
        }
    
    </script>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <%
                    Calendar currentDate = Calendar.getInstance();
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MMM/dd HH:mm:ss");
                    String dateNow = formatter.format(currentDate.getTime());
                    String building_name = request.getParameter("building_name");
                    String scenario_desc = request.getParameter("scenario_desc");
                    String ladderNum = request.getParameter("ladderNum");
                    String algo = request.getParameter("algo");
                    dateNow = dateNow.replace(" ", "_time_");
                    dateNow = dateNow.replace(":", "_");
                    dateNow = dateNow.replace("/", "_");
                    dateNow = "Day_" + dateNow;  //System.out.println("Hello");

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
                        String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                        rs = (stm.executeQuery(q1));
                        int building_id = 0;
                        while (rs.next()) {
                            building_id = rs.getInt("building_id");
                            //out.println("print building iddddd" + building_id);
                        }

                        String q2 = "Select * from scenario where building_id = " + building_id + " and scenario_description='" + scenario_desc + " '";
                        //out.println(q2);
                        rs = (stm.executeQuery(q2));
                        int scenario_id = 0;
                        while (rs.next()) {
                            scenario_id = rs.getInt("scenario_id");
                            //out.println("print scenario iddddd " + scenario_id);
                        }
                %>
            <form action="BuildingEvacuationPlanner" method="post">
                <input type="hidden" name="building_name" value=<%out.println(request.getParameter("building_name"));%> >
                <input type="hidden" name="scenario_desc" value=<%out.println(request.getParameter("scenario_desc"));%> >
                <input type="hidden" name="j" value=<% out.println(request.getParameter("j"));%> />
                <input type="hidden" name="token_number" value=<% out.println(request.getParameter("token_number"));%> />
                <input type="hidden" name="algo" value=<% out.println(request.getParameter("algo"));%> />
                <input type="hidden" name="dateNow" value=<% out.println(dateNow);%>/>

                <%
                    if (algo.equals("1")) {
                        String file1 = building_name + "_Node_file_on_" + dateNow;
                %>
                <input type="hidden" name="node_file" value=<% out.println(file1);%> />
                <input type="hidden" name="ladderNum" value="0" />
                <%
                    }
                %>    
                <%
                    if (algo.equals("11")) {
                        String file2 = building_name + "_Node_data_with_ladder_on_" + dateNow;
                %>
                <input type="hidden" name="node_file_ladder" value=<% out.println(file2);%> />
                <input type="hidden" name="ladderNum" value=<% out.println(request.getParameter("ladderNum"));%> />
                <%
                    }

                    if (algo.equals("21")) {
                        String file5 = building_name + "_Node_file_on_" + dateNow;
                %>
                <input type="hidden" name="node_file" value=<% out.println(file5);%> />
                <input type="hidden" name="ladderNum" value=<%out.println(request.getParameter("ladderNum"));%> />
                <%
                    }
                %>
                <input type="submit" value="Run">
            </form>
            <td bgcolor="white">
                <h2>
                    <font size="4" >
                        Node Information of building:<% out.println(request.getParameter("building_name"));%>
                    </font>
                </h2>



                <%
                    if (algo.equals("1")) {
                        System.out.println("inside edited node at run.jsp");
                %>
                <table border="1" cellpadding="5" cellspacing="5" width="10%">    
                    <tr><td>Node ID</td><td>Node Name</td><td>Floor</td><td>Actual Capacity</td><td>Initial Capacity</td><td>Latitude</td><td>Longitude</td></tr>     
                    <%


                        String query = "Select * from node_" + building_id + "_withoutladder";
                        rs = (stm.executeQuery(query));
                        while (rs.next()) {
                    %>
                    <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
                    <% }
                        }
                        
                        if (algo.equals("11")) {%>
                    <table border="1" cellpadding="5" cellspacing="5" width="10%"> 
                        <%    String query1 = "select * from information_schema.tables where table_name = 'node_" + building_id + "_withladder'";
                             rs = stm.executeQuery(query1);

                             if (rs.next()) {%>

                        <tr><td>Node ID</td><td>Node Name</td><td>Floor</td><td>Actual Capacity</td><td>Initial Capacity</td><td>Latitude</td><td>Longitude</td><td>Ladder</td><td>No of Ladder</td><td>Ladder Load</td><td>Ladder Travel Time</td><td>Ladder Capacity</td><td>Ladder St Node</td><td>Ladder End Node</td></tr>     
                        <% // out.println("ladder found");
                            String query2 = "SELECT n1.*, n2.* FROM node_" + building_id + "_withoutladder as n1 LEFT JOIN node_" + building_id + "_withladder as n2 ON n1.node_id = n2.node_id";
                            rs = (stm.executeQuery(query2));
                            while (rs.next()) {
                                if (rs.getInt(9) != 0) {%>
                        <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td><% out.println(Integer.parseInt("1"));%></td><td><% out.println(rs.getInt(11));%></td><td><% out.println(rs.getInt(12));%></td><td> <% out.println(rs.getFloat(13));%> </td><td><% out.println(rs.getInt(14));%></td><td><% out.println(rs.getInt(15));%></td><td><% out.println(rs.getInt(16));%></td></tr>
                        <%
                        } else {%>
                        <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td><% out.println(Integer.parseInt("0"));%></td></tr>

                        <%
                                }
                            }
                        } else {%>
                        <tr><td>Node ID</td><td>Node Name</td><td>Floor</td><td>Actual Capacity</td><td>Initial Capacity</td><td>Latitude</td><td>Longitude</td></tr>     

                        <% // out.println("kuch to print ho");
                            String query = "Select * from node_" + building_id + "_withoutladder";
                            rs = (stm.executeQuery(query));
                            while (rs.next()) {
                        %>
                        <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
                        <%
                                }
                            }
                        %>
                        <table border="1" cellpadding="5" cellspacing="5" width="10%">    
                            <%          }

                                if (algo.equals("21")) {
                            %>
                            <table border="1" cellpadding="5" cellspacing="5" width="10%">    
                                <tr><tr><td>Node ID</td><td>Node name</td><td>Floor</td><td>Actual Capacity</td><td>Initial Capacity</td><td>Ladder</td><td>Latitude</td><td>Longitude</td><td>Danger Level</td><td>Waiting Time</td></tr>

                                <%
                                    String query1 = "select * from information_schema.tables where table_name = 'node_" + building_id + "_withladder'";
                                    rs = stm.executeQuery(query1);
                                    if (rs.next()) {  //out.println("ladder found");
                                        String q = "SELECT x.*, y.node_id FROM (SELECT n1.*, n2.danger_level, n2.waiting_time from node_" + building_id + "_withoutladder as n1, node_" + building_id + "_scenario_" + scenario_id + " as n2 where n1.node_id = n2.node_id) as x LEFT JOIN node_" + building_id + "_withladder as y ON x.node_id = y.node_id";
                                        //out.println(q);
                                        rs = stm.executeQuery(q);
                                        //out.println("query executed");
                                        while (rs.next()) {
                                    if (rs.getInt(11) != 0) {%>
                                <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td><% out.println(Integer.parseInt("1"));%></td><td><% out.println(rs.getFloat(9));%></td><td><% out.println(rs.getFloat(10));%></td></tr>
                                <%
                        } else {%>
                                <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td><% out.println(Integer.parseInt("0"));%></td><td><% out.println(rs.getFloat(9));%></td><td><% out.println(rs.getFloat(10));%></td></tr> <%
                                        }
                                    }
                                } else {
                                    String query = "SELECT n1.*, n2.danger_level, n2.waiting_time from node_" + building_id + "_withoutladder as n1, node_" + building_id + "scenario_" + scenario_id + " as n2 where n1.node_id = n2.node_id";
                                    rs = stm.executeQuery(query);
                                    while (rs.next()) {
                                %>
                                <tr><td> <% out.println(rs.getInt(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getInt(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td><td><% out.println(Integer.parseInt("0"));%></td><td><% out.println(rs.getFloat(9));%></td><td><% out.println(rs.getFloat(10));%></td></tr>
                                <%
                                        }
                                    }%>
                            </table>
                            </td>
                            </tr>
                        </table>
                        <% }    rs.close();
                                stm.close();
                                con.close();

                            } catch (Exception e) {//Catch exception if any
                                System.err.println("Error: " + e.getMessage());
                            }%>
                        </body>
                        </html>

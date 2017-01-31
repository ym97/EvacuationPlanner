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
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" valign="top">
                    <% String building_name = request.getParameter("building_name");
                        String scenario_desc = request.getParameter("scenario_desc");
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
                            //out.println("connectionnnn stablished");
                            Statement s = con.createStatement();
                            String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //out.println("print building iddddd" + building_id);
                            }

                            String q2 = "Select * from scenario where building_id = " + building_id + " and scenario_description='" + scenario_desc + " '";
                            //out.println(q2);
                            rs = (s.executeQuery(q2));
                            int scenario_id = 0;
                            while (rs.next()) {
                                scenario_id = rs.getInt("scenario_id");
                                //out.println("print scenario iddddd " + scenario_id);
                            }

                            String s1 = getServletContext().getRealPath("") + "/Evacuation/nodeFile.csv";
                            System.out.println("s1 :" + s1);
                            FileWriter fw = new FileWriter(s1);
                            PrintWriter out1 = new PrintWriter(fw);
                            out1.write("Node_ID,Node_Name,Floor,Actual_Capacity,Initial_Capacity,Latitude,Longitude,Ladder_Placement,Danger_Level,Waiting_Time");
                            out1.flush();
                            out1.println();

                            String query1 = "select * from information_schema.tables where table_name = 'node_" + building_id + "_withladder'";
                            rs = s.executeQuery(query1);
                            if (rs.next()) {  //out.println("ladder found");
                                String q = "SELECT x.*, y.node_id FROM (SELECT n1.*, n2.danger_level, n2.waiting_time from node_" + building_id + "_withoutladder as n1, node_" + building_id + "_scenario_" + scenario_id + " as n2 where n1.node_id = n2.node_id) as x LEFT JOIN node_" + building_id + "_withladder as y ON x.node_id = y.node_id";
                                //out.println(q);
                                rs = s.executeQuery(q);
                                //out.println("query executed");
                                while (rs.next()) {
                                    if (rs.getInt(11) != 0) {
                                        out1.print(rs.getInt(2) + "," + rs.getString(3).trim() + "," + rs.getString(4) + "," + rs.getInt(5) + "," + rs.getInt(6) + "," + rs.getFloat(7) + "," + rs.getFloat(8) + "," + Integer.parseInt("1") + "," + rs.getFloat(9) + "," + rs.getFloat(10));
                                        out1.flush();
                                        out1.println();

                                    } else {
                                        out1.print(rs.getInt(2) + "," + rs.getString(3).trim() + "," + rs.getString(4) + "," + rs.getInt(5) + "," + rs.getInt(6) + "," + rs.getFloat(7) + "," + rs.getFloat(8) + "," + Integer.parseInt("0") + "," + rs.getFloat(9) + "," + rs.getFloat(10));
                                        out1.flush();
                                        out1.println();
                                    }
                                }
                            } else {
                                String query = "SELECT n1.*, n2.danger_level, n2.waiting_time from node_" + building_id + "_withoutladder as n1, node_" + building_id + "scenario_" + scenario_id + " as n2 where n1.node_id = n2.node_id";
                                rs = s.executeQuery(query);
                                while (rs.next()) {
                                    out1.print(rs.getInt(2) + "," + rs.getString(3).trim() + "," + rs.getString(4) + "," + rs.getInt(5) + "," + rs.getInt(6) + "," + rs.getFloat(7) + "," + rs.getFloat(8) + "," + Integer.parseInt("0") + "," + rs.getFloat(9) + "," + rs.getFloat(10));
                                    out1.flush();
                                    out1.println();
                                }
                            }

                            String s2 = getServletContext().getRealPath("") + "/Evacuation/edgeFile.csv";
                            FileWriter fw2 = new FileWriter(s2);
                            System.out.println(s2);
                            PrintWriter out2 = new PrintWriter(fw2);
                            out2.write("Edge_ID,Edge_Name,Start_Node,End_Node,Travel_Time,Edge_Capacity,Danger_Level");
                            out2.flush();
                            out2.println();

                            String q = "SELECT e1.*, e2.danger_level from edge_" + building_id + " as e1 LEFT JOIN edge_" + building_id + "_scenario_" + scenario_id + " as e2 ON e1.edge_id = e2.edge_id";
                            //out.println(q);
                            rs = s.executeQuery(q);
                            //out.println("query executed");
                            while (rs.next()) {
                                out2.print(rs.getInt(2) + "," + rs.getString(3) + "," + rs.getInt(4) + "," + rs.getInt(5) + "," + rs.getFloat(6) + "," + rs.getInt(7) + "," + rs.getFloat(9));
                                out2.flush();
                                out2.println();
                            }

                            String s3 = getServletContext().getRealPath("") + "/Evacuation/result1.csv";
                            FileWriter fw3 = new FileWriter(s3);
                            System.out.println(s3);
                            PrintWriter out3 = new PrintWriter(fw3);
                            out3.write("GroupID,Size,Path,Time");
                            out3.flush();
                            out3.println();

                            String query = "SELECT * FROM result_" + building_id + "_algo_21_scenario_" + scenario_id;
                            rs = s.executeQuery(query);
                            while (rs.next()) {
                                out3.print(rs.getString(1) + "," + rs.getString(2) + "," + rs.getString(3) + "," + rs.getString(4));
                                out3.flush();
                                out3.println();
                            }
                            rs.close();
                            s.close();
                            con.close();
                        } catch (Exception e) {
                            System.err.println("Error: " + e.getMessage());
                        }

                    %>
                    <a href="Evacuation/index.html" target="f3"> <font color="blue">Click Here</font></a>  for visualization of building <b><% out.println(" "+ building_name);%></b> for scenario <b><% out.println(" " + scenario_desc);%></b>    
                    <form method="post" action="Animation.jsp">
                    <input type="submit" value="Back">
                    </form>
                    </body>
                    </html>

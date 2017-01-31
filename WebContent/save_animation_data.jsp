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
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //out.println("print building iddddd" + building_id);
                            } */

                            String s1 = getServletContext().getRealPath("") + "/Evacuation/nodeFile.csv";
                            System.out.println("s1 :" + s1);
                            FileWriter fw = new FileWriter(s1);
                            PrintWriter out1 = new PrintWriter(fw);
                           /*  out1.write("Node_ID,Node_Name,Floor,Actual_Capacity,Initial_Capacity,Latitude,Longitude,Ladder_Placement,Danger_Level,Waiting_Time"); */
                           /*
node_ladder
no_of_ladder
ladder_load
travel_time
ladder_capacity
start_node
end_node
  */
 						    out1.write("Node_ID,Node_Name,Building_Name,Capacity,Floor,Latitude,Longitude");
                            out1.flush();
                            out1.println();

                           /*  String query1 = "select * from information_schema.tables where table_name = 'node_" + building_id + "_withladder'";
                            rs = s.executeQuery(query1); */
                            /* if (rs.next()) {  //out.println("ladder found");
                                String q = "SELECT n1.*, n2.node_id FROM node_" + building_id + "_withoutladder as n1 LEFT JOIN node_" + building_id + "_withladder as n2 ON n1.node_id = n2.node_id;";
                                //out.println(q);
                                rs = s.executeQuery(q);
                                //out.println("query executed");
                                while (rs.next()) {
                                    if (rs.getInt(9) != 0) {
                                        out1.print(rs.getInt(2) + "," + rs.getString(3).trim() + "," + rs.getString(4) + "," + rs.getInt(5) + "," + rs.getInt(6) + "," + rs.getFloat(7) + "," + rs.getFloat(8) + "," + Integer.parseInt("1") + "," + Double.parseDouble("0") + "," + Double.parseDouble("-1"));
                                        out1.flush();
                                        out1.println();

                                    } else {
                                        out1.print(rs.getInt(2) + "," + rs.getString(3).trim() + "," + rs.getString(4) + "," + rs.getInt(5) + "," + rs.getInt(6) + "," + rs.getFloat(7) + "," + rs.getFloat(8) + "," + Integer.parseInt("0") + "," + Double.parseDouble("0") + "," + Double.parseDouble("-1"));
                                        out1.flush();
                                        out1.println();
                                    }
                                }
                            } else { */
                                String query = "Select * from node where building_name ='"+building_name+"'";
                                rs = s.executeQuery(query);
                                while (rs.next()) {
                                	
                                    out1.print(rs.getString(1)+ "," + rs.getString(2) + "," + rs.getString(3) + "," + rs.getInt(4) + "," + rs.getInt(5) + "," + rs.getFloat(6) + "," + rs.getFloat(7) + "," + Integer.parseInt("0") + "," + Double.parseDouble("0") + "," + Double.parseDouble("-1"));
                                    out1.flush();
                                    out1.println();
                                }
                            /* } */

                            String s2 = getServletContext().getRealPath("") + "/Evacuation/edgeFile.csv";
                            FileWriter fw2 = new FileWriter(s2);
                            System.out.println(s2);
                            PrintWriter out2 = new PrintWriter(fw2);
                           
                            out2.write("Edge_ID,Edge_Name,Building Name,Edge Floor,Start_Node,Destination_Node,Edge_Capacity,Edge_Length");
                            out2.flush();
                            out2.println();

                            String q = "Select * from edge where building_name= '" + building_name+"'";
                            //out.println(q);
                            rs = s.executeQuery(q);
                            //out.println("query executed");
                            while (rs.next()) {
                                out2.print(rs.getInt(2) + "," + rs.getString(3) + "," + rs.getInt(4) + "," + rs.getInt(5) + "," + rs.getFloat(6) + "," + rs.getInt(7) + "," + Double.parseDouble("0"));
                                out2.flush();
                                out2.println();
                            }

                            String s3 = getServletContext().getRealPath("") + "/Evacuation/result1.csv";
                            FileWriter fw3 = new FileWriter(s3);
                            System.out.println(s3);
                            PrintWriter out3 = new PrintWriter(fw3);
                           // out3.write("GroupID,Size,Path,Time");
                            out3.write("path_id,groupsize,path,arrival_time,departure_time");
                            out3.flush();
                            out3.println();

                            query = "SELECT * FROM evacrun_time";
                            rs = s.executeQuery(query);
                            while (rs.next()) {
                                out3.print(rs.getInt(1) + "," + rs.getInt(2) + "," + rs.getString(3) + "," + rs.getString(4) + "," + rs.getString(5));
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
                    <a href="Evacuation/index.html" target="f3"><font color="blue">Click Here</font></a>  for visualization of building <b><% out.println(" "+ building_name);%></b>   

                    <form method="post" action="Animation.jsp">
                        <input type="submit" value="Back">
                    </form>
                    </body>
                    </html>

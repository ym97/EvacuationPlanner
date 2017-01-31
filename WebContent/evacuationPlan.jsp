<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.*"%> 

<jsp:useBean id="DijBean" scope="page" class="in.ac.iitb.Dijkstra"></jsp:useBean>
<jsp:useBean id="HDEEP_1" scope="page" class="HDEEP1.Dijkstra"></jsp:useBean>
<jsp:useBean id="HDEEP_2" scope="request" class="HDEEP11.Dijkstra"></jsp:useBean>
<jsp:useBean id="PriorityBased" scope="request" class="PriorityBased.Evacuate1"></jsp:useBean>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" valign="top">
                    <%
                        connectionString cs = new connectionString();
                        String url = cs.url;
                        String username = cs.username;
                        String password = cs.password;
                        DecimalFormat df = new DecimalFormat("0.0");
                        try {
                            boolean uploadSuccess = false;
                            String filePath = getServletContext().getRealPath("") + "/";
                            String ladderNum2 = "0";
                            ladderNum2 = request.getParameter("ladderNum");
                            int ladderNum1 = Integer.parseInt(ladderNum2);
                            out.println("Number of ladders available are : " + ladderNum1);
                            int method = 1;
                            String buildingName = request.getParameter("building_name");
                            String scenario_desc = request.getParameter("scenario_desc");
                            String dateNow = request.getParameter("dateNow");
                            Class.forName("org.postgresql.Driver");
                            //String url = "jdbc:postgresql://localhost:5432/MTP";
                            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                            Connection con = DriverManager.getConnection(url, username, password);
                            ResultSet rs = null;
                            // out.println("connectionnnn stablished");
                            Statement stm = con.createStatement();
                            String q1 = "Select * from buildings where building_name = '" + buildingName + "'";
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
                            String nodeFile = "node_" + building_id + "_withoutladder";
                            String edgeFile = "edge_" + building_id;
                            String nodeFileWithLadder = "node_" + building_id + "_withladder";
                            String nodeScenarioFile = "node_" + building_id + "_scenario_" + scenario_id;
                            String edgeScenarioFile = "edge_" + building_id + "_scenario_" + scenario_id;
                            ladderNum2 = "0";
                            ladderNum2 = request.getParameter("ladderNum");
                            ladderNum1 = Integer.parseInt(ladderNum2);
                            buildingName = request.getParameter("building_name");
                            String method1 = request.getParameter("algo");
                            method = Integer.parseInt(method1);
                            String methodname = "Method Name";
                            if (method1.equals("1")) {
                                methodname = "General_Plan";
                            }
                            if (method1.equals("11")) {
                                methodname = "Plan_with_Dynamic_ladder";
                            }
                            if (method1.equals("21")) {
                                methodname = "Plan_with_Danger_Level";
                            }

                            String node_file_ladder = request.getParameter("node_file_ladder");
                            String node_file_for_two_way = request.getParameter("node_file_for_two_way");
                            String rescures_file = request.getParameter("rescures_file");

                            buildingName = request.getParameter("building_name");
                            out.println("<center><h3>For Building:" + buildingName + ", The Evacuation Plan is:</h3></center>");
                            String result = null;
                            boolean flag21 = false;
                            switch (method) {
                                case 1:
                                    result = DijBean.startEvacuationPlanner(nodeFile, edgeFile, url, username, password);
                                    //result = DijBean.startEvacuationPlanner(uploadSuccess, filePathArray[0], filePathArray[1]);
                                    System.out.println("print result : " + result);
                                    break;
                                case 11:
                                    result = HDEEP_1.dynamicLadder(nodeFile, nodeFileWithLadder, edgeFile, ladderNum1, url, username, password);
                                    //out.println("\n Putting  2 ladders");//+ladderNum1+"  ladders");
                                    break;
                                case 12:
                                    //result = HDEEP_2.startEvacuationPlanner();//( true ,"C:/Users/abc/Desktop/newnode.csv","C:/Users/abc/Desktop/newedge.csv","C:/Users/abc/Desktop/emergency.csv");
                                    result = HDEEP_2.startEvacuationPlanner(true, nodeFile, edgeFile, nodeFileWithLadder, url, username, password);
                                    //out.println("\n Putting   "+ladderNum1+"  ladders");
                                    break;

                                case 21:
                                    //out.println("\n Putting   "+ladderNum1+"  ladders" + result);

                                    //result = HDEEP_2.startEvacuationPlanner();//( true ,"C:/Users/abc/Desktop/newnode.csv","C:/Users/abc/Desktop/newedge.csv","C:/Users/abc/Desktop/emergency.csv");
                                    result = PriorityBased.startEvacuationPlanner(nodeFile, nodeFileWithLadder, nodeScenarioFile, edgeFile, edgeScenarioFile, ladderNum1, url, username, password);
                                    //out.println("\n Putting   "+ladderNum1+"  ladders" + result);
                                    flag21 = true;
                                    break;
                            }
                            if (!flag21) {
                                System.out.println("before create");
                                //String query = "CREATE TABLE IF NOT EXISTS result_" + building_id + "_algo_" + method + "(group_id integer, size integer, node_sequence varchar[], time_sequence real[])";
                                String query = "DROP TABLE IF EXISTS result_" + building_id + "_algo_" + method;
                                stm.executeUpdate(query);

                                String renameQuery = "ALTER TABLE result_temp RENAME TO result_" + building_id + "_algo_" + method;
                                stm.executeUpdate(renameQuery);
                            } else {
                                System.out.println("before create");
                                //String query = "CREATE TABLE IF NOT EXISTS result_" + building_id + "_algo_" + method + "_scenario_" + scenario_id + "(group_id integer, size integer, node_sequence varchar[], time_sequence real[])";
                                String query = "DROP TABLE IF EXISTS result_" + building_id + "_algo_" + method + "_scenario_" + scenario_id;
                                stm.executeUpdate(query);

                                String renameQuery = "ALTER TABLE result_temp RENAME TO result_" + building_id + "_algo_" + method + "_scenario_" + scenario_id;
                                stm.executeUpdate(renameQuery);
                            }
                    %>
                    <table border=1 align="center">
                        <tr align="center">
                            <td>Group ID</td>
                            <td>Size</td>
                            <td>Route</td>
                            <td>Time Stamps</td>
                        </tr>
                        <%-- System.out.println("line.length " + line.length);%>
                        <% // int last_time = 0;
                            for (int i = 0; i < line.length; i++) {
                                System.out.println(line[i]);
                        %><tr align="center"><%
                            String groupid = "";
                            String size = "";
                            String route = "";
                            String routeForDB = "{\"";
                            String tsForDB = "{";
                            String ts = "";
                            System.out.println(line[i]);
                            StringTokenizer st1 = new StringTokenizer(line[i], "***");
                            groupid = st1.nextToken();

                            String f = st1.nextToken();
                            String rou;
                            StringTokenizer stf = new StringTokenizer(f, "%%%[");
                            size = stf.nextToken();
                            f = stf.nextToken();
                            StringTokenizer routeTs1 = new StringTokenizer(f, ",");
                            rou = routeTs1.nextToken();
                            StringTokenizer routeTs2 = new StringTokenizer(rou, "-");
                            route = routeTs2.nextToken().trim();
                            routeForDB = routeForDB + route;
                            // routeForDB = routeForDB.trim();
                            ts = df.format(Double.parseDouble(routeTs2.nextToken()));
                            tsForDB = tsForDB + ts;
                            //System.out.println("test1 : " + groupid + size + route + ts);
                            while (routeTs1.hasMoreTokens()) {
                                rou = routeTs1.nextToken();
                                routeTs2 = new StringTokenizer(rou, "-");
                                String routeForDBrouteTs2 = routeTs2.nextToken().trim();
                                String tsForDBrouteTs2 = df.format(Double.parseDouble(routeTs2.nextToken().trim()));
                                routeForDB = routeForDB + "\",\"" + routeForDBrouteTs2;
                                route = route + "-->" + routeForDBrouteTs2;
                                tsForDB = tsForDB + "," + tsForDBrouteTs2;
                                ts = ts + "-" + tsForDBrouteTs2;
                                //System.out.println("test : " +route+ " : " + routeForDB);

                            }
                            routeForDB = routeForDB + "\"}";
                            tsForDB = tsForDB + "}";
                            //System.out.println("testinggggggg : " +routeForDB + " : "+ tsForDB);
%>
                            <td><%= groupid%></td> <%//out12.write("Group ID:" + groupid + ",");%>
                            <td><%= size%></td> <%//out12.write("Size:" + size + ",");%>
                            <td><%= route%></td> <%//out12.write("Route:" + route + ",");%>
                            <td><%= ts%></td> <%//out12.write("Time Stamps:" + ts + "\n");</tr>--%> 
                        <%--
                                if (!flag21) {
                                    String query1 = "INSERT INTO result_" + building_id + "_algo_" + method + " VALUES (" + groupid + ", " + size + ", '" + routeForDB + "', '" + tsForDB + "')";
                                    stm.executeUpdate(query1);
                                } else {
                                    String query1 = "INSERT INTO result_" + building_id + "_algo_" + method + "_scenario_" + scenario_id + " VALUES (" + groupid + ", " + size + ", '" + routeForDB + "', '" + tsForDB + "')";
                                    stm.executeUpdate(query1);

                                }
                            }--%>

                        <% if (!flag21) {
                                String query = "SELECT * FROM result_" + building_id + "_algo_" + method;
                                rs = stm.executeQuery(query);
                               while (rs.next()) {%>
                        <tr><td><%out.print(rs.getString(1));%></td><td><%out.print(rs.getString(2));%></td><td><%out.print(rs.getString(3));%></td><td><%out.print(rs.getString(4));%></td></tr>
                        <%     }
                        } else {
                            String query = "SELECT * FROM result_" + building_id + "_algo_" + method + "_scenario_" + scenario_id;
                            rs = stm.executeQuery(query);
                          while (rs.next()) {%>
                        <tr><td><%out.print(rs.getString(1));%></td><td><%out.print(rs.getString(2));%></td><td><%out.print(rs.getString(3));%></td><td><%out.print(rs.getString(4));%></td></tr>
                        <%     }
                            }
                        %>
                    </table>
                </td>
            </tr>
        </table>
        <%
                rs.close();
                stm.close();
                con.close();
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }%>
    
    <form method="post" action="run.jsp">
        <input type="submit" value="Back"/>
    </form>
  </body>
</html>


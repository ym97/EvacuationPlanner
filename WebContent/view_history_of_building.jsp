<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.text.DecimalFormat"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <%
            String building_name = request.getParameter("building_name");
            int algo = Integer.parseInt(request.getParameter("algo"));
            String scenario_desc = request.getParameter("scenario_desc");
            connectionString cs = new connectionString();
            String url = cs.url;
            String username = cs.username;
            String password = cs.password;
            String method = "";
            boolean flag_algo = false;
            DecimalFormat df = new DecimalFormat("0.0");

            try {
                Class.forName("org.postgresql.Driver");
                //String url = "jdbc:postgresql://localhost:5432/MTP";
                //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                Connection con = DriverManager.getConnection(url, username, password);
                ResultSet rs = null;
                // out.println("connectionnnn stablished");
                Statement s = con.createStatement();
                String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                rs = (s.executeQuery(q1));
                int building_id = 0;
                while (rs.next()) {
                    building_id = rs.getInt("building_id");
                    //out.println("print building iddddd" + building_id);
                }
                int scenario_id = 0;
                String q2 = "Select * from scenario where building_id = " + building_id + " and scenario_description='" + scenario_desc + " '";
                //out.println(q2);
                rs = (s.executeQuery(q2));
                scenario_id = 0;
                while (rs.next()) {
                    scenario_id = rs.getInt("scenario_id");
                    //out.println("print scenario iddddd " + scenario_id);
                }


                if (algo == 1) {
                    method = "General Evacuation Planning";
                }
                if (algo == 11) {
                    method = "Evacuation Planning with Dynamic Ladder Placement";
                }
                if (algo == 21) {
                    method = "Priority Based Evacuation Planning";
                    flag_algo = true;
                }
        %>
        <center> 
            <h2> 
                <font size="4" >
                    <% if (flag_algo) {%>
                    History of past run for scenario <%out.println(scenario_desc);%> of building <%out.println(building_name);%>  using method <%out.println(method);%> 
                    <% } else {%> History of past run for building <%out.println(building_name);%> using method <%out.println(method);
                }%></font>
            </h2> </center>

        <table border="1" cellpadding="5" cellspacing="5" width="10%">
            <tr><th>Group ID</th><th>Size</th><th>Route</th><th>Time Sequence</th></tr>
            <!-- ------------------------------------------------------------------------------------>

            <% String q3 = "";
                if (!flag_algo) {
                    q3 = "select * from result_" + building_id + "_algo_" + algo;
                } else {
                    q3 = "select * from result_" + building_id + "_algo_" + algo + "_scenario_" + scenario_id;
                }
                System.out.println("for first table : " + q3);
                        rs = s.executeQuery(q3);
                        while (rs.next()) {%>
            <tr><td><% out.println(rs.getInt("group_id"));%> </td><td><% out.println(rs.getInt("size"));%> </td><td><% out.println(rs.getString("node_sequence"));%> </td><td><% out.println(rs.getString("time_sequence"));%> </td></tr>
            <%   }
            %>             
        </table>
        <%      rs.close();
                s.close();
                con.close();
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
            }

        %>

        <form method="post" action="View_data.jsp">
            <input type="submit" value="Back"/>
        </form>
    </body>

</html>
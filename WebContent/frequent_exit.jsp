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
        int algo1 = Integer.parseInt(request.getParameter("algo1"));
        int algo2 = Integer.parseInt(request.getParameter("algo2"));
        String scenario_desc = request.getParameter("scenario_desc");
        connectionString cs = new connectionString();
        String url = cs.url;
        String username = cs.username;
        String password = cs.password;
        String method1 = "", method2 = "";
        DecimalFormat df = new DecimalFormat("0.0");
        boolean flag_algo1 = false, flag_algo2 = false;

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

            if (algo1 == 21) {
                flag_algo1 = true;
            }
            if (algo2 == 21) {
                flag_algo2 = true;
            }
            int scenario_id = 0;
            if (flag_algo1 | flag_algo2) {
                String q2 = "Select * from scenario where building_id = " + building_id + " and scenario_description='" + scenario_desc + " '";
                //out.println(q2);
                rs = (s.executeQuery(q2));
                scenario_id = 0;
                while (rs.next()) {
                    scenario_id = rs.getInt("scenario_id");
                    //out.println("print scenario iddddd " + scenario_id);
                }
            }

            if (algo1 == 1) {
                method1 = "General Evacuation Planning";
            }
            if (algo1 == 11) {
                method1 = "Evacuation Planning with Dynamic Ladder Placement";
            }
            if (algo1 == 12) {
                method1 = "Evacuation Planning with Path for Rescuers";
            }
            if (algo1 == 21) {
                method1 = "Priority Based Evacuation Planning";
            }
            if (algo2 == 1) {
                method2 = "General Evacuation Planning";
            }
            if (algo2 == 11) {
                method2 = "Evacuation Planning with Dynamic Ladder Placement";
            }
            if (algo2 == 12) {
                method2 = "Evacuation Planning with Path for Rescuers";
            }
            if (algo2 == 21) {
                method2 = "Priority Based Evacuation Planning";
            }
    %>
    <center>
        <h2> 
            <font size="4" >
                Compare Exit points used in Building <%out.println(building_name);%> :
            </font>
        </h2> </center>

        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">
                    <table border="1" cellpadding="5" cellspacing="5" width="50%">
                        <tr><b> <%out.println(method1);%></b></tr>
            <tr><th>Count</th><th>Exit Point</th></tr>    
            <% String q3 = "";
                if (!flag_algo1) {
                    q3 = "select count(group_id) as temp_count, node_sequence[array_length(node_sequence,1)] as exit_point from result_" + building_id + "_algo_" + algo1 + " group by node_sequence[array_length(node_sequence,1)] having node_sequence[array_length(node_sequence,1)] like 'E%' or node_sequence[array_length(node_sequence,1)] like 'D_%'";
                } else {
                    q3 = "select count(group_id) as temp_count, node_sequence[array_length(node_sequence,1)] as exit_point from result_" + building_id + "_algo_" + algo1 + "_scenario_" + scenario_id + " group by node_sequence[array_length(node_sequence,1)] having node_sequence[array_length(node_sequence,1)] like 'E%' or node_sequence[array_length(node_sequence,1)] like 'D_%'";
                }
                System.out.println("for first table : " + q3);
                        rs = s.executeQuery(q3);
                        while (rs.next()) {%>
            <tr><td><% out.println(rs.getInt("temp_count"));%> </td>
                <td><% out.println(rs.getString("exit_point"));%></td></tr>

            <%   }
            %>              

        </table>
    </td>
<td bgcolor="white">
    <table border="1" cellpadding="5" cellspacing="5" width="50%">
        <tr><b> <%out.println(method2);%></b></tr>
    <tr><th>Count</th><th>Exit Point</th></tr>
    <% String q4 = "";
        if (!flag_algo2) {
            q4 = "select count(group_id) as temp_count, node_sequence[array_length(node_sequence,1)] as exit_point from result_" + building_id + "_algo_" + algo2 + " group by node_sequence[array_length(node_sequence,1)] having node_sequence[array_length(node_sequence,1)] like 'E%' or node_sequence[array_length(node_sequence,1)] like 'D_%'";
        } else {
            q4 = "select count(group_id) as temp_count, node_sequence[array_length(node_sequence,1)] as exit_point from result_" + building_id + "_algo_" + algo2 + "_scenario_" + scenario_id + " group by node_sequence[array_length(node_sequence,1)] having node_sequence[array_length(node_sequence,1)] like 'E%' or node_sequence[array_length(node_sequence,1)] like 'D_%'";
        }
        System.out.println("for first table : " + q4);
                            rs = s.executeQuery(q4);
                            while (rs.next()) {%>
    <tr><td><% out.println(rs.getInt("temp_count"));%> </td>
        <td><% out.println(rs.getString("exit_point"));%></td></tr>
        <%   }
        %>              
</table>
</td>
</tr>
</table>
<%
        s.close();
        con.close();
    } catch (Exception e) {//Catch exception if any
        System.err.println("Error: " + e.getMessage());
    }
%>
<form method="post" action="output_option.jsp">
    <input type="hidden" name="building_name" value = <% out.println(building_name);%>>
    <input type="hidden" name="algo1" value = <% out.println(algo1);%>>
    <input type="hidden" name="algo2" value = <% out.println(algo2);%>>
    <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%>>
    <input type="submit" value="Back">
</form>
</body>
</html>
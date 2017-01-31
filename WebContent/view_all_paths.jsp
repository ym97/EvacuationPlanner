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
    <center>
    <%
     String building_name = session.getAttribute("building_name").toString();
    	int run_id = Integer.parseInt(session.getAttribute("run_id").toString());
        String scenario_name = session.getAttribute("scenario_name").toString();
    %>
    <% out.println("Building : "+building_name);%>
    <% out.println("Scenario : "+scenario_name);%>
    </center>
     <table border="0" cellpadding="5" cellspacing="5" align="center" >
     
    <%
       
        connectionString cs = new connectionString();
        String url = cs.url;
        String username = cs.username;
        String password = cs.password;
       /*  String method1 = "", method2 = "";
        DecimalFormat df = new DecimalFormat("0.0");
        boolean flag_algo1 = false, flag_algo2 = false;
 */
        try {
            Class.forName("org.postgresql.Driver");
            //String url = "jdbc:postgresql://localhost:5432/MTP";
            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
            Connection con = DriverManager.getConnection(url, username, password);
            ResultSet rs = null, rs1 = null, temp_rs = null, temp_rs1 = null;
            // out.println("connectionnnn stablished");
            Statement s = con.createStatement();
            String q1 = "Select * from EvacRun_Path where run_id ="+run_id; // building_name = '" + building_name + "' and scenario_name = '"+scenario_name+"' ";
            rs = (s.executeQuery(q1));%>
            <tr>
            <td>Source</td>
				<td>Destination</td>
				<td>Group Size</td>
				<!-- <td>Building Name</td> -->
				<td>Path</td>
				<td>Arrival Time</td>
				<td>Departure Time</td>
				<td>Travel_type</td>
            </tr>
            <%
            while (rs.next()) {
              /*
source
destination
groupsize
path
arrival_time
departure_time
path_type
  */
  				String source = rs.getString("source");
  				String destination = rs.getString("destination");
  				int groupsize = rs.getInt("groupsize");
  				String path = rs.getString("path");
  				String arrival_time = rs.getString("arrival_time");
  				String departure_time = rs.getString("departure_time");
  				String travel_type = rs.getString("travel_type");%>
  				<tr>
  				<td><% out.println(source);%></td>
				<td><% out.println(destination);%></td>
				<td><% out.println(groupsize);%></td>
				<%-- <td><% out.println(building_name);%></td> --%>
				<td><% out.println(path);%></td>
				<td><% out.println(arrival_time);%></td>
				<td><% out.println(departure_time);%></td>
				<td><% out.println(travel_type);%></td>
				</tr>
  				<%
                //out.println("print building iddddd" + building_id);
            }

           
            

    %>
    </table>
    <%
        rs.close();
        s.close();
       
        con.close();
    } catch (Exception e) {//Catch exception if any
        System.err.println("Error: " + e.getMessage());
    }
%>

</body>
 <form method="post" action="output_option.jsp">
    <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>
    <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>
    <input type="submit" value="Back"/>
</form>

</html>
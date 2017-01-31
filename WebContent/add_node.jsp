<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2013, 2:24:51 AM
    Author     : kabii
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
    <!-- <u><a href="edit_data.jsp" target="f2" ><font size="4">Edit data</font></a></u>> -->
    <!-- <u><a href="Edit_options_passed.jsp" target="f2" ><font size="4">Add</font></a></u>> -->
     <!-- <font size="4">Add node</font></a> -->
     <center><b><%out.println(session.getAttribute("building_name"));%></b></center>		
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                        String building_name = session.getAttribute("building_name").toString();
                   	    String creator = session.getAttribute("uName").toString();
                    %>
                    Added node to building -<b> '<% 
                        out.println(building_name);
                      
                        %>' </b><br/><br/>
                    With information :<br/>
                    <%
                        if (request.getParameter("Node_number") != "" && request.getParameter("Node_name") != "" && request.getParameter("Node_floor") != "" && request.getParameter("Node_capacity") != "" &&/*  request.getParameter("Node_initial") != ""  &&*/ request.getParameter("Node_lat") != "" && request.getParameter("Node_long") != "") {
                    %>  <table border="0" cellpadding="1" cellspacing="4" width="100%">
                        <tr><td><% out.println("   Node ID :  " + request.getParameter("Node_number"));%></td>
                            <td><% out.println("   Node Name:  " + request.getParameter("Node_name"));%></td>
                            <td><% out.println("   Floor:  " + request.getParameter("Node_floor"));%></td>
                            
                        <tr><td><% out.println("   Actual Capacity :  " + request.getParameter("Node_capacity"));%></td></tr>
                        	<%-- <td><% out.println("   Initial Capacity :  " + request.getParameter("Node_initial"));%></td> --%>
                            <td><% out.println("   Latitude :  " + request.getParameter("Node_lat"));%></td>
                            <td><% out.println("   Longitude :  " + request.getParameter("Node_long"));%></td><tr>
                       <%--  <tr><td><% out.println("   Ladder Point :  " + request.getParameter("Node_ladder"));%></td></tr>
                        <tr><td><% out.println("   Number of Ladder :  " + request.getParameter("No_of_ladder"));%></td>
                            <td><% out.println("   Ladder Load :  " + request.getParameter("Ladder_load"));%></td>
                            <td><% out.println("   Travel Time :  " + request.getParameter("Travel_time"));%></td></tr>
                         <tr><td><% out.println("   Ladder Capacity :  " + request.getParameter("Ladder_capacity"));%></td>
                            <td><% out.println("   Ladder St Node :  " + request.getParameter("Ladder_st_node"));%></td>
                            <td><% out.println("   Ladder End Node :  " + request.getParameter("Ladder_end_node"));%></td><tr> --%>
                    </table>
                    <%
                        } else {
                            out.println("<html><font color=red>Please Enter Proper Values !! </font></html>");
                        }
                        String Node_number = request.getParameter("Node_number");
                        String Node_name = request.getParameter("Node_name");
                        String Node_floor = request.getParameter("Node_floor");
                        String Node_capacity = request.getParameter("Node_capacity");
                       // String Node_initial = request.getParameter("Node_initial");
                        String Node_lat = request.getParameter("Node_lat");
                        String Node_long = request.getParameter("Node_long");
                        /* String Node_type = request.getParameter("Node_Type");
                        int Node_fit=0; 
                        if(Node_type.equals("Source") && request.getParameter("Node_fit")!=null)
                        	Node_fit= Integer.parseInt(request.getParameter("Node_fit"));
                        int Node_inj=0;
                        if(Node_type.equals("Source") && request.getParameter("Node_inj")!=null)
                        	Node_inj= Integer.parseInt(request.getParameter("Node_inj"));
                        int Node_resc; 
                        if(Node_type.equals("Rescuer Center") && request.getParameter("Node_resc")!=null)
                        	Node_resc= Integer.parseInt(request.getParameter("Node_resc")); */
                        
                         String Node_ladder = request.getParameter("Node_ladder");
                        String No_of_ladder = request.getParameter("No_of_ladder");
                        String Ladder_load = request.getParameter("Ladder_load");
                        String Travel_time = request.getParameter("Ladder_travel_time");
                        String Ladder_capacity = request.getParameter("Ladder_capacity");
                        String Ladder_st_node = request.getParameter("Ladder_st_node");
                        String Ladder_end_node = request.getParameter("Ladder_end_node"); 
                        String Ladder_placement_time = request.getParameter("Ladder_placement_time");
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
                            //   System.out.println("connectionnnn stablished");
                            Statement s = con.createStatement();
                            System.out.println("building_name "+building_name+" creator "+creator);
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //   System.out.println("print building iddddd" + building_id);
                            } */
                            String q3 = "CREATE TABLE IF NOT EXISTS node(node_id varchar(225) NOT NULL, node_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE, capacity integer NOT NULL, floor integer NOT NULL, latitude float NOT NULL, longitude float NOT NULL, node_ladder varchar(5) NOT NULL default 'no', Primary key(node_id, building_name))";
                            s.executeUpdate(q3);
                            String ins = "INSERT INTO node VALUES ('" +Node_number +"', '" + Node_name + "', '" + building_name + "' , "+ Integer.parseInt(Node_capacity) + " , "  + Integer.parseInt(Node_floor) + " , "  + Float.parseFloat(Node_lat) + " , " + Float.parseFloat(Node_long) + ")";
                            s.executeUpdate(ins);
                            
                             if (!Node_ladder.isEmpty()) {
                                q3 = "CREATE TABLE IF NOT EXISTS node_ladder(node_id varchar(225) NOT NULL, node_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE, no_of_ladder integer NOT NULL default 0, ladder_load integer NOT NULL default 0, ladder_travel_time numeric NOT NULL default 0, ladder_capacity integer NOT NULL default 0, ladder_start_node varchar(225) NOT NULL, ladder_end_node varchar(225) NOT NULL, placement_time int NOT NULL, Primary key(node_id, building_name))";
                                s.executeUpdate(q3);
                                out.println("ladder not empty");
                                //String ins1 = "INSERT INTO node_" + building_id + "_withladder VALUES (" + building_id + " , " + Integer.parseInt(Node_number) + ")";
                                String ins1 = "INSERT INTO node_ladder VALUES ('"+Node_number +"', '" + Node_name + "', '" + building_name + "' , "+ Integer.parseInt(No_of_ladder) + " , " + Integer.parseInt(Ladder_load) + " , " + Integer.parseInt(Travel_time) + " , " + Integer.parseInt(Ladder_capacity) + " , '" + Ladder_st_node + "' , '" + Ladder_end_node + "', "+Ladder_placement_time+")";
                                s.executeUpdate(ins1);
                            } 
                    %>
                    <form action ="add_another_node.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <table align="center"><tr>
                                <td><input type="submit" name="B1" value="Add anoter node" /></td>
                            </tr></table>
                    </form>
                </td></tr></table>

        <table border="1" cellpadding="5%" cellspacing="5%" align="center">
            <!--<a href="add_another_node">Add another node.</a> -->
            <br/><hr/><br/><b>Updated Node File:</b><br/> 
            <!--Print these details-->
            
             <tr><td>Node ID</td><td>Node Name</td><td>Building Name</td><td>Capacity</td><td>Floor</td><td>Latitude</td><td>Longitude</td></tr>     
            <% // out.println("kuch to print ho");
                String query = "Select * from node where building_name = '"+building_name+"'";
                rs = s.executeQuery(query);
                while (rs.next()) {
                	if(rs.getString(8).equalsIgnoreCase("no")){
                        %>
                        <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td></tr>
                        <%
                            	}
                            	else{
                            
                            %>
                             <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getString(8));%> </td><td> <% out.println(rs.getInt(9));%> </td><td> <% out.println(rs.getInt(10));%> </td><td> <% out.println(rs.getInt(11));%> </td><td> <% out.println(rs.getInt(12));%> </td><td> <% out.println(rs.getString(13));%> </td><td> <% out.println(rs.getString(14));%> </td><td> <% out.println(rs.getInt(15));%> </td></tr>
                          <%} 
                           }%>   
                    </table>
                    <%
                            
                            rs.close();
                            s.close();
                            con.close();
                            } catch (Exception e) {//Catch exception if any
                            System.err.println("Error: " + e.getMessage());
                            //out.println(count2);
                        }
        %>
         <form method="post" action="edit_data.jsp">
            <center><input type="submit" value="Back"/></center>
        </form>
    </body>
</html>

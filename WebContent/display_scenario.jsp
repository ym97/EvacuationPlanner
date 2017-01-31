<%-- 
    Document   : Running_Module
    Created on : Feb 18, 2012, 9:26:52 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <script>
    </script>
    <body>
        
      
                <!-- ------------------------------------------------------------------------------------>
        
                    
                        <%
                            String scenario_desc = null;
                            connectionString cs = new connectionString();
                            String url = cs.url;
                            String username = cs.username;
                            String password = cs.password;
                            try {
                                String building_name = request.getParameter("building_name");
                                session.setAttribute("building_name", building_name);
                                
                                String creator = session.getAttribute("uName").toString();
                             //   int scenario_id;// = request.getParameter("scenarioId");

                                Class.forName("org.postgresql.Driver");
                                //String url = "jdbc:postgresql://localhost:5432/MTP";
                                //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                                Connection con = DriverManager.getConnection(url, username, password);
                                ResultSet rs = null;
                                //out.println("connection stablished");
                                Statement s = con.createStatement();
                                /* String q1 ="Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
                                rs = (s.executeQuery(q1));
                                int building_id = 0;
                                while (rs.next()) {
                                    building_id = rs.getInt("building_id");
                                    //out.println("print building iddddd" + building_id);
                                } */
								//session.setAttribute("building_id", building_id);
								String check="select exists (select 1 from pg_type where typname = 'node_type');";
								boolean b=s.execute(check);
								if(!b){
									String type_create="CREATE TYPE node_type AS ENUM ('source', 'destination', 'rescueCenter', 'normal');";
									s.executeUpdate(type_create);
								}
								
								String q2 = "CREATE TABLE IF NOT EXISTS scenario_node(snode_id serial primary key, building_name varchar(225) not null references buildings(building_name) ON DELETE CASCADE, scenario_name varchar(225) not null, node_id varchar(225) not null, scenario_description varchar(255), node_type node_type default 'source', fit_people integer default 0, injured_people integer default 0, rescuer integer default 0, danger_level integer default 1, priority integer default 1, evacuation_type varchar(225) not null, UNIQUE(building_name, scenario_name, node_id))";
                                s.executeUpdate(q2);

                                 /* String query = "SELECT s1.scenario_name FROM scenario_node s1 WHERE NOT EXISTS(SELECT s2.scenario_name FROM scenario_node s2 WHERE s2.scenario_name > s1.scenario_id AND s2.building_name=s1.building_name) and s1.building_name = '" + building_name+"'";
                                rs = (s.executeQuery(query));
                                if (rs.next()) {
                                    scenario_id = rs.getInt("scenario_id") + 1;
                                } else {
                                    scenario_id = 1;
                                }*/
                                String q3 = "CREATE TABLE IF NOT EXISTS scenario_edge (sedge_id serial primary key, building_name varchar(225) not null references buildings(building_name) ON DELETE CASCADE, scenario_name varchar(225) not null, edge_id varchar(225) not null, scenario_description varchar(255), danger_level integer not null default 1, travel_speed_fit float not null default 1, travel_speed_injured float not null default 1, UNIQUE(building_name, scenario_name, edge_id))";
                                s.executeUpdate(q3);
                               
                        %>

                            
                           <center> <%  out.println("Describe scenario of building: " + building_name);%></center>
                           
                        

        <form method="post" action="add_scenario_info.jsp"> 
            <table border="0" cellpadding="1" cellspacing="1" align="center">

                <tr></tr>
                <tr></tr>
                <tr></tr>
                
                    <%-- <td color="white">
                        <font size="4" >
                            Building Name
                        </font>
                    </td><td><input type = "text" name ="building_name" value =<%out.println(building_name);%>> </td>       
 --%>
 					
 					<tr>
                    <td bgcolor="white">
                        <font size="4" >
                            Scenario Name
                        </font>
                    </td> <td><input type = "text" name ="scenario_name" ></td>
					</tr>
					<tr>
                    <td bgcolor="white">
                        <font size="4" >
                            Scenario Description
                        </font>
                    </td><td><input type="text"  name="scenario_desc" ></td>
                    </tr>
					<tr>
                    <td bgcolor="white">
                        <font size="4" >
                            Evacuation type
                        </font>
                    </td><td>
                    <select name="evacuation_type" id="evacuation_type">
                    <option value="with rescuers">with rescuers</option>
                    <option value="without rescuers">without rescuers</option>
                    
                    </select>
                    </td></tr>
                <tr></tr><tr></tr><tr></tr>
                <tr></tr><tr></tr><tr></tr>
                <tr>
                	<td></td>
                	<td></td>
                    <td><input type="submit" name="B1" value="Submit" /></td>
                    <td><input type="reset" name="B2" value="Reset" /></td>        
                </tr>   
            </table>
            			
        </form>
        <%
                rs.close();
                s.close();
                con.close();
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
            }
        %>
        
        </center>
    </body>
</html>

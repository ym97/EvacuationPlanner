<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<%int i = 0;
    int node_id = 0;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
      
    </head>
    <script type="text/javascript">
    function changetextbox()
	{
		 
    	if ((document.getElementById("Node_ladder").value == "yes")){
			
		    document.getElementById("No_of_ladder").disabled="";
		    document.getElementById("Ladder_load").disabled="";
		    document.getElementById("Ladder_travel_time").disabled="";
		    document.getElementById("Ladder_capacity").disabled="";
		    document.getElementById("Ladder_st_node").disabled="";
		    document.getElementById("Ladder_end_node").disabled="";
		    document.getElementById("Ladder_placement_time").disabled="";

		  } 
		if ((document.getElementById("Node_ladder").value == "no")){
			
		    document.getElementById("No_of_ladder").disabled='true';
		    document.getElementById("Ladder_load").disabled='true';
		    document.getElementById("Ladder_travel_time").disabled='true';
		    document.getElementById("Ladder_capacity").disabled='true';
		    document.getElementById("Ladder_st_node").disabled='true';
		    document.getElementById("Ladder_end_node").disabled='true';
		    document.getElementById("Ladder_placement_time").disabled='true';

		  } 
	} 
</script>  
    <body vlink="black" alink="black" link="black">
    
<!-- node_id
node_name
building_id(given)
capacity
floor
latitude
longitude -->
    
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!--------------------------------------------------------------------------------------->
                <td bgcolor="white" >
                    <center>
                        <%
                            String building_name = session.getAttribute("building_name").toString();
                        	String creator = session.getAttribute("uName").toString();
                            System.out.println("building_name "+building_name+" creator "+creator);

                        %>
                        <p align="center"><b>Editing data for building <%
                           // building_name = building_name.replace("_", " ");
                            out.println(building_name);
                                %>  </b></p>
                    </center>
                    <%
                        out.println("Add node for building:" + building_name);
                      //  building_name = building_name.replace(" ", "_");
                    %>    
                    <form method="post" action="add_node.jsp">
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <table border="0" cellpadding="1" cellspacing="4">
                            <tr></tr>
                            <tr><td>Node Id</td>
                                <td><input type="text" name="Node_number"/></td>
                                <td>Node Name</td> 
                                <td><input type="text" name="Node_name"/></td>
                                <td>Floor</td> 
                                <td><input type="text" name="Node_floor"/></td>
                                </tr>
							<tr>
                            <!-- <td>Initial Capacity</td> 
                                <td><input type="text" name="Node_initial"/></td> -->
                                 <td>Actual Capacity</td> 
                                <td><input type="text" name="Node_capacity"/></td>
                                <td>Latitude</td> 
                                <td><input type="text" name="Node_lat"/></td>
                                <td>Longitude</td> 
                                <td><input type="text" name="Node_long"/></td>
                                 <td>Node Ladder</td> 
                                <td><select name="Node_ladder" id="Node_ladder" onChange="changetextbox();">
                                	 <option value="no">no</option>
 								  	 <option value="yes">yes</option>
 							    </select>
 							    </td>
                            </tr>
                            <tr>
                                
                                <td>No of ladder</td> 
                                <td><input type="text" id="No_of_ladder" name="No_of_ladder" disabled="disabled"/></td>
                                <td>Ladder load</td> 
                                <td><input type="text" id="Ladder_load" name="Ladder_load" disabled="disabled"/></td>
                                 <td>Ladder travel time</td> 
                                <td><input type="text" id="Ladder_travel_time" name="Ladder_travel_time" disabled="disabled"/></td>
                            </tr>
                            <tr>
                                <td>Ladder capacity</td> 
                                <td><input type="text" id="Ladder_capacity" name="Ladder_capacity" disabled="disabled"/></td>
                                <td>Start node</td> 
                                
                                <td>
                                
                                <%try {
                                	
                                    Class.forName("org.postgresql.Driver");
                                    connectionString cs = new connectionString();
                                    String url = cs.url;
                                    String username = cs.username;
                                    String password = cs.password;
                                    Connection con = DriverManager.getConnection(url, username, password);

                                    ResultSet rs = null;
                                    // out.println("connectionnnn stablished");
                                    Statement s = con.createStatement();
                                   
                                    	%>
                                    	<select name="Ladder_st_node" id="Ladder_st_node">
                                    	<%
                                        
                                    	String q3 = "CREATE TABLE IF NOT EXISTS node(node_id varchar(225) NOT NULL, node_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE, capacity integer NOT NULL, floor integer NOT NULL, latitude float NOT NULL, longitude float NOT NULL, node_ladder varchar(5) NOT NULL default 'no', Primary key(node_id, building_name))";
                                        s.executeUpdate(q3);
                                    String q1 = "Select node_id from node where building_name = '"+building_name+"'";
                                    rs = (s.executeQuery(q1));
                                    while (rs.next()) {%>
                         			   <option value=<%out.println(rs.getString("node_id"));%>>
                           		    	  <%out.println(rs.getString("node_id"));%>
                          			  </option>
                          		  <%
                                    }
                                 
                                %>
                                </select>
                                </td>
                                <td>End node</td> 
                                <td> 
                                <select name="Ladder_end_node" id="Ladder_end_node">
                                <%
                                String q2 = "Select node_id from node where building_name = '"+building_name+"'";
                                rs = (s.executeQuery(q2));
                                while (rs.next()) {%>
                     			   <option value=<%out.println(rs.getString("node_id"));%>>
                       		    	  <%out.println(rs.getString("node_id"));%>
                      			  </option>
                      		  <%
                                }
                                
                                rs.close();
                                s.close();
                                con.close();
                            } catch (Exception e) {//Catch exception if any
                                System.err.println("Error: " + e.getMessage());
                            }
                                %>
                                </select>
                                </td>
                                <td>ladder Placement Time</td> 
                                 <td><input type="text" id="Ladder_placement_time" name="Ladder_placement_time" disabled="disabled"/></td>
                            </tr>
                            
                            <tr>
                                <td><input type="submit" name="B1" value="Submit"/>
                                <td><input type="reset" name="B2" value="Reset"/></td>        
                            </tr>    
                        </table>
                    </form>    
                    <b> Nodes Present earlier:</b>
                    <table border="1" cellpadding="5" cellspacing="5" align="center"> 
                        <%
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
                                /* String q1 = "Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
                                rs = (s.executeQuery(q1));
                                int building_id = 0;
                                while (rs.next()) {
                                    building_id = rs.getInt("building_id");
                                    //   System.out.println("print building iddddd" + building_id);
                                } */
                               // String query1 = "select * from information_schema.tables where table_name = node";
                               // rs = s.executeQuery(query1);%>
              <tr><td>Node ID</td><td>Node Name</td><td>Building Name</td><td>Capacity</td><td>Floor</td><td>Latitude</td><td>Longitude</td></tr>     
            <% // out.println("kuch to print ho");
            
                String query = "Select * from node where building_name = '"+building_name+"'";
                rs = (s.executeQuery(query));
                while (rs.next()) {
                	if(rs.getString(8).equalsIgnoreCase("no")){
            %>
            <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td></tr>
            <%
                	}
                	else{
                
                %>
                 <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td><td> <% out.println(rs.getString(8));%> </td><td> <% out.println(rs.getInt(9));%> </td><td> <% out.println(rs.getInt(10));%> </td><td> <% out.println(rs.getInt(11));%> </td><td> <% out.println(rs.getInt(12));%> </td><td> <% out.println(rs.getString(13));%> </td><td> <% out.println(rs.getString(14));%> </td></tr>
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
                        </table>
                </td>
            </tr>
        </table>
    </body>
</html>


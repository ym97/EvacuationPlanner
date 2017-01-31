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
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<%int i = 0;
    int node_id = 0, edge_id = 1;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    	<u><a href="edit_data.jsp" target="f2" ><font size="4">Edit data</font></a></u>>
     	<font size="4">Add</font></a>
     <center><b><%out.println(session.getAttribute("building_name"));%></b></center>		
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <td bgcolor="white" >
                    <center>
                        <%
                        	
                            String building_name = request.getParameter("building_name").toString();
                            String edit_option = request.getParameter("edit_option").toString();
                            if(building_name==null)
                            building_name = session.getAttribute("building_name").toString();
                            if(edit_option==null)
                            edit_option = session.getAttribute("edit_option").toString();
                            
                            session.setAttribute("building_name", building_name);
                            session.setAttribute("edit_option", edit_option);
                        %>
                        
                    </center>
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
                            // out.println("connectionnnn stablished");
                            Statement stm = con.createStatement();
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (stm.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //out.println("print building iddddd" + building_id);
                            } */
                            if (edit_option.equalsIgnoreCase("1")) {
                                out.println("Add node for building: " + building_name);
                               /*  building_name = building_name.replace(" ", "_"); */
                    %>    
                    <form method="post" action="add_node.jsp">
                        <input type="hidden" name="building_name" value=<%out.println(building_name);%>/>    
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
                                
                                <%
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
                           // String query1 = "select * from information_schema.tables where table_name = 'node_" + building_id + "_withladder'";
                        String query1 = "select * from node where building_name = '"+building_name+"'";
                            rs = stm.executeQuery(query1);
                            %>
                        <tr><td>Node ID</td><td>Node Name</td><td>Building Name</td><td>Capacity</td><td>Floor</td><td>Latitude</td><td>Longitude</td><td>Ladder</td><td>No of Ladder</td><td>Ladder Load</td><td>Ladder Travel Time</td><td>Ladder Capacity</td><td>Ladder Start Node</td><td>Ladder End Node</td><td>Ladder Placement time</td></tr>     
                         <%  //System.out.println("ladder found");
                         /*    String query2 = "SELECT n1.*, n2.* FROM node_" + building_id + "_withoutladder as n1 LEFT JOIN node_" + building_id + "_withladder as n2 ON n1.node_id = n2.node_id;";
                            rs = (stm.executeQuery(query2)); */
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
                    } else if (edit_option.equalsIgnoreCase("2")) {
                        //out.println("You have selected add edge");
                       /*  building_name = building_name.replace("_", " "); */
                        out.println("Add edge for building : " + building_name);
                       /*  building_name = building_name.replace(" ", "_"); */
                        //out.println(building_name);     
%>
                    <form method="post" action="add_edge.jsp">
                                  
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <table border="0" cellpadding="1" cellspacing="4">
                            <tr>
                                <td>Edge Id</td> 
                                <td><input type="text" name="Edge_Id"/></td>
                                <td>Edge Name</td>
                                <td><input type="text" name="Edge_name"/></td>  
                                 <td>Edge Floor</td> 
                                <td><input type="text" name="Edge_floor"/></td>            
                               </tr>
                            <tr> <td>Start Node</td>
                                <td><input type="text" name="From_Node"/></td>
                            	<td>End Node</td> 
                                <td><input type="text" name="To_Node"/></td>
                                <td>Edge Length</td> 
                                <td><input type="text" name="Edge_length"/></td>
                                <td>Edge Capacity</td> 
                                <td><input type="text" name="Edge_capacity"/></td> 
                               
                            </tr>
                            <tr>
                                <td><input type="submit" name="B1" value="Submit" />
                                <td><input type="reset" name="B2" value="Reset" /></td>        
                            </tr>    
                        </table>
                    </form>    
                    <b> Edges Present earlier:</b>
                    
<!-- edge_id
edge_name
building_id
floor
start_node
end_node
capacity
edge_length -->
                    
                    <table border="1" cellpadding="5" cellspacing="5" align="center">   
                        <tr><td>Edge ID</td><td>Edge Name</td><td>Building Name</td><td>Edge Floor</td><td>Source Node</td><td>Destination Node</td><td>Edge Capacity</td><td>Edge length</td></tr>                         
                        <%
                            String query1 = "Select * from edge where building_name='"+building_name+"'";
                            rs = (stm.executeQuery(query1));
                            while (rs.next()) {
                        %>
                       <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getString(5));%> </td><td> <% out.println(rs.getString(6));%> </td><td> <% out.println(rs.getInt(7));%> </td><td> <% out.println(rs.getFloat(8));%> </td></tr>
                        <%
                            }%>
                    </table> <tr>
                    <%
                    } else if (edit_option.equalsIgnoreCase("3")) {
                        //out.println("You have selected delete node"); 
%>
                <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
            <p align="center">Deleting a node for Building : <% //building_name = building_name.replace("_", " ");
                 out.println(building_name);
               // building_name = building_name.replace(" ", "_"); 
                %> </p>  
            <center>
                Select node to be deleted <br/>
                <table border="0" cellpadding="1" cellspacing="4">
                    <form action ="delete_node.jsp" method="post" >
                        <select name="node_to_be_deleted" id="node_to_be_deleted">
                            <%
                            System.out.println("building_name "+building_name);
                                String query1 = "Select * from node where building_name = '"+building_name+"'";
                                rs = (stm.executeQuery(query1));
                                while (rs.next()) {
                                    System.out.println("building_name "+rs.getString(2));

                            %> <option value=<%out.println(rs.getString(1));%>>
                                <%
                                    out.println(rs.getString(1)+ " | " + rs.getString(2));// + " | " + rs.getInt(4) + " | " + rs.getInt(5) + " | " + rs.getInt(6) + " | " + rs.getFloat(7) + " | " + rs.getFloat(8));
                                %>
                            </option>
                            <%
                                }
                            %>
                        </select> 
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/> 
                        <tr>
                            <td><input type="submit"  value="Submit"/></td> 
                            <!--<td><input type="reset" name="B2" value="Add an edge" /></td>-->        
                        </tr>  
                    </form>
                </table>
            </center>
            <%
            } else if (edit_option.equalsIgnoreCase("4")) {
                //out.println("You have selected delete node"); 
            %>

            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
            <p align="center">Deleting a edge for Building : 
                <%
                /*     building_name = building_name.replace("_", " "); */
                    out.println(building_name);
                    /* building_name = building_name.replace(" ", "_"); */
                %> </p>   

            <center>
                <table border="0" cellpadding="0" cellspacing="0" align="center">
                    <form action ="delete_edge.jsp" method="post" >
                        <select name="edge_to_be_deleted" id="edge_to_be_deleted">
                            <%
                                String query1 = "Select * from edge where building_name = '"+building_name+"'";
                                rs = (stm.executeQuery(query1));
                                while (rs.next()) {
                            %> <option value=<%out.println(rs.getString(1));%>>
                                <%
                                        out.println(rs.getString(1)+ " | "+rs.getString(2));// + " | " + rs.getString(3) + " | " + rs.getInt(4) + " | " + rs.getInt(5) + " | " + rs.getFloat(6) + " | " + rs.getInt(7));
                                    }%>
                            </option>                                
                        </select> 
                        <input type="hidden" name="building_name" value = <%out.println(building_name);%>/> 
                        <tr>
                            <td><input type="submit"  value="Submit"/> 
                        </tr>   
                    </form>
                </table>
            </center>
            <%
                    } else
                        out.println("Select proper option.");
                    rs.close();
                    stm.close();
                    con.close();
                } catch (Exception e) {
                    System.err.println("Error: " + e.getMessage());
                }%>
        </tr>
    </table>
</body>
</html>


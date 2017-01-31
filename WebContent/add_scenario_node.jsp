<%-- 
    Document   : view_arcs
    Created on : Apr 4, 201, 2:24:51 AM
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <script type="text/javascript">
						 function changetextbox()
						{
							 
/* 							 if(document.getElementById("evac_type").value== "without rescuers"){
								
								 document.getElementById("Node_inj").style.display='none';
								 document.getElementById("Node_resc").style.display='none';

							 }
							 else */ 
							 if ((document.getElementById("Node_Type").value == "destination" || document.getElementById("Node_Type").value == "normal") && document.getElementById("evac_type").value== "with rescuers"  ){
								
    							    document.getElementById("Node_fit").disabled='true';
    							    document.getElementById("Node_inj").disabled='true';
    							    document.getElementById("Node_resc").disabled='true';
  							  } 
  							  else if ((document.getElementById("Node_Type").value == "rescueCenter") && document.getElementById("evac_type").value== "with rescuers") {
  								
  								document.getElementById("Node_fit").disabled='true';
							    document.getElementById("Node_inj").disabled='true';
							    document.getElementById("Node_resc").disabled="";
 						      }
  							else if ((document.getElementById("Node_Type").value == "source") && document.getElementById("evac_type").value== "with rescuers") {
  								
  								document.getElementById("Node_fit").disabled="";
							    document.getElementById("Node_inj").disabled="";
							    document.getElementById("Node_resc").disabled='true';
 						      }
  							  
  							  else if( document.getElementById("evac_type").value== "without rescuers" && (document.getElementById("Node_Type").value == "source") ){
  								document.getElementById("Node_fit").disabled="";
							    document.getElementById("Node_inj").disabled='true';
							    document.getElementById("Node_resc").disabled='true';
  							  }
  							  else if( document.getElementById("evac_type").value== "without rescuers" && ((document.getElementById("Node_Type").value == "destination") || (document.getElementById("Node_Type").value == "rescueCenter") || (document.getElementById("Node_Type").value == "normal"))){
  								document.getElementById("Node_fit").disabled='true';
							    document.getElementById("Node_inj").disabled='true';
							    document.getElementById("Node_resc").disabled='true';

  							  }
						} 
	 </script>
    <body vlink="black" alink="black" link="black" onload="changetextbox();">
   
    <center>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                        String building_name = session.getAttribute("building_name").toString();
                 		   System.out.println("building_name : " + building_name);
                        String scenario_name = session.getAttribute("scenario_name").toString();
                        System.out.println("scenario_name : " + scenario_name);
                        String scenario_desc = session.getAttribute("scenario_desc").toString();
                        System.out.println("scenario_desc : " + scenario_desc);
                        String evacuation_type = session.getAttribute("evacuation_type").toString();
                        System.out.println("evacuation_type : " + evacuation_type);
                        System.out.println("in node scenario_name "+scenario_name);
                        //String building_id = session.getAttribute("building_id").toString();
                      //  System.out.println("build : " + building_name);
                    %>
                    <%-- <center>
                                <p align="center"><b>Editing data for scenario <%
                                    out.println(" " + scenario_desc);%> of building <%
                                    building_name = building_name.replace("_", " ");
                                    out.println(building_name);
                                %>  </b>
                        </p>
                    </center> --%>
                    
                    
                    
                    
                      <form method="post" action="added_scenario_node.jsp">
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                        <table border="0" cellpadding="1" cellspacing="4">
                            <tr></tr>

                            <tr><td> Scenario ID </td> 
                                <td><input type = "text" name ="scenario_name" value=<%out.println(scenario_name);%>/></td>

                                <td> Scenario Description </td>
                                <td><input type="text"  name ="scenario_desc" value=<%out.println(scenario_desc);%>/></td>
                            </tr>
                    		 <tr><td> Node Id </td>
                                <td>
                    				<select name="Node_number" id="Node_number">
                    
                    
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
                             String q1 = "Select * from node where building_name='"+session.getAttribute("building_name").toString()+"'";
                            rs = (s.executeQuery(q1));
                            while (rs.next()) {%>
                    <option value=<%out.println(rs.getString("node_id"));%>>
                        <%out.println(rs.getString("node_id"));%>
                    </option>
                    <%
                            }
                            /* rs.close();
                            s.close();
                            con.close();
                        } catch (Exception e) {//Catch exception if any
                            System.err.println("Error: " + e.getMessage());
                        } */
                    %>                       
                  
                           		</select></td>
                                <td> Danger Level </td>
                                <td><input type="text"  name ="Node_danger" value="0"/></td>
                                <td> Waiting Time </td>
                                <td><input type="text"  name ="Node_waiting_time" value="0"/></td>
                                <td> Priority </td>
                                <td><input type="text"  name ="Node_priority" value="1"/></td>
                            </tr>   
                            <tr><td>Node Type</td> 
                                <td>
                                   <select name="Node_Type" id="Node_Type" onChange="changetextbox();">
 								  	 <option value="source">source</option>
 								   	 <option value="destination">destination</option>
  								     <option value="normal">normal</option>
  								     
  								     <option value="rescueCenter">rescueCenter</option>
  								     
 							       </select>
                                </td>
                                
                                <td>Fit People</td> 
                                <td><input type="text" id="Node_fit" name="Node_fit" value="0"/></td>
                                <td>Injured People</td> 
                                
                                <td><input type="text" id="Node_inj" name="Node_inj" value="0"/></td>
                                <td>Rescuers</td> 
                                <td><input type="text" id="Node_resc" name="Node_resc" value="0" disabled="disabled"/>
                               	<input type="hidden" id="evac_type" name="evac_type" value="<%= session.getAttribute("evacuation_type") %>" />
                                </td>
                            </tr> 
                            <tr>
                                <td><input type="submit" name="B1" value="Submit" />
                                <td><input type="reset" name="B2" value="Reset" /></td>        
                            </tr>    
                        </table>
                    </form>   

                    <b> Nodes Present earlier for Scenario: <%out.println(" " + scenario_name);%></b>
                </td></tr></table>


<!-- scenario_id
node_id
scenario_description
node_type
fit_people
injured_people 

rescuer
danger_level
priority
-->

        <table border="1" cellpadding="5" cellspacing="5" width="10%">    
            <tr><td>Node Id</td><td>Node Type</td><td>Fit People</td><td>Injured people</td><td>Rescuers</td><td>Danger level</td><td>Priority</td></tr>     
            <%
                String query1 = "select * from scenario_node where building_name = '"+building_name+"' and scenario_name ='"+scenario_name+"'";
                rs = s.executeQuery(query1);
                while (rs.next()) {
            %>
            <tr><td> <% out.println(rs.getString(4));%> </td><td> <% out.println(rs.getString(6));%> </td><td> <% out.println(rs.getInt(7));%> </td><td> <% out.println(rs.getInt(8));%> </td><td> <% out.println(rs.getInt(9));%> </td><td> <% out.println(rs.getInt(10));%> </td><td> <% out.println(rs.getInt(11));%> </td></tr>
            <%
                }

            %>
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
        </center>
    </body>
</html>

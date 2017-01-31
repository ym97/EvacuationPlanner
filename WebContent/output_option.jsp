<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@include file="connectionString.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
    
    <center><font size="4" >
    	<% 
	  	String building_name = session.getAttribute("building_name").toString();
        String scenario_name = session.getAttribute("scenario_name").toString();
        out.println("Building : "+building_name);
	 	out.println("Scenario : "+scenario_name);
        %>
   </font></center>     
        <table border="0" cellpadding="5" cellspacing="5" align="center" >
            <tr>
                
                    <%	float egress_time_fit=0;
                    	float egress_time_injured=0;
                    	float run_time=0;
                    	float avg_evac_time_fit=0;
                    	float avg_evac_time_injured=0;
                    	float avg_waiting_time_fit=0;
                    	float avg_waiting_time_injured=0;
                    	int run_id = Integer.parseInt(session.getAttribute("run_id").toString());
                       
                       /*  int algo1 = Integer.parseInt(request.getParameter("algo1"));
                        int algo2 = Integer.parseInt(request.getParameter("algo2")); */
                       
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
                           
                            Statement s = con.createStatement();
                            String q1 = "Select egress_time_fit, egress_time_injured, run_time, avg_evac_time_fit, avg_evac_time_injured, avg_waiting_time_fit, avg_waiting_time_injured from EvacRun_Time where building_name= '" + building_name + "' and scenario_name = '"+scenario_name+"' and run_id = "+run_id;
                            rs = (s.executeQuery(q1));
                          //  int building_id = 0;
                            while (rs.next()) {
                            	egress_time_fit=Float.parseFloat(rs.getString("egress_time_fit"));
                            	 egress_time_injured=Float.parseFloat(rs.getString("egress_time_injured"));
                            	 run_time=Float.parseFloat(rs.getString("run_time"));
                            	 avg_evac_time_fit=Float.parseFloat(rs.getString("avg_evac_time_fit"));
                            	 avg_evac_time_injured=Float.parseFloat(rs.getString("avg_evac_time_injured"));
                            	 avg_waiting_time_fit=Float.parseFloat(rs.getString("avg_waiting_time_fit"));
                            	 avg_waiting_time_injured=Float.parseFloat(rs.getString("avg_waiting_time_injured"));
                               
                                //out.println("print building iddddd" + building_id);
                            } 
                    %>
                   
                      
                          <td >	  Egress time for Fit :
                          </td>
                           <td >	 <%out.println(egress_time_fit);%>
                          </td> 

                    
            </tr>
             <tr>
                  		  <td >	  Egress time for Injured :
                          </td>
                           <td >	 <%out.println(egress_time_injured);%>
                          </td> 

                    
            </tr>
            <tr>
                  		  <td >	  Run time :
                          </td>
                           <td >	 <%out.println(run_time);%>
                          </td> 

                    
            </tr>
            <tr>
             			  <td>	  Average evacuation time Fit :
                          </td>
                           <td >	 <%out.println(avg_evac_time_fit);%>
                          </td> 

                    
            </tr>
            <tr>
             			  <td>	  Average evacuation time Injured :
                          </td>
                           <td >	 <%out.println(avg_evac_time_injured);%>
                          </td> 

                    
            </tr>
            <tr>
             			  <td >	  Average waiting time Fit :
                          </td>
                           <td >	 <%out.println(avg_waiting_time_fit);%>
                          </td> 

                    
            </tr>  
             <tr>
             			  <td >	  Average waiting time Injured :
                          </td>
                           <td >	 <%out.println(avg_waiting_time_injured);%>
                          </td> 

                    
            </tr>  
            <tr>
            		<td>
                    <h2>
                        <font size="4" >
                        	  
                            Click on options you want to perform on Results of building <%out.println(building_name);%> 
                        </font>
                    </h2>
                    </td>
            </tr>
            <tr>
          		  <td>
                    <%-- <a href="evacuation_time.jsp?building_name=<%=building_name%>&algo1=<%=algo1%>&algo2=<%=algo2%>&scenario_desc=<%=scenario_desc%>"><font color="black"><b>1. Total evacuation time </b></font></a><br/><br/> --%>
                    <a href="view_all_paths.jsp?building_name=<%=building_name%>&scenario_name=<%=scenario_name%>"><font color="black"><b>1. View all Paths </b></font></a><br/><br>
                   
                </td>
            <tr>
                <td> <b>2. All paths going from source node</b> 
                    <form method="post" action="path_from_source.jsp">
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>
                        <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>
                        <table><tr><td>
                                    <select name="source_name" id="source_name">
                                        <%
                                            String q2 = "Select node_id from scenario_node where building_name ='"+building_name+"' and scenario_name ='"+scenario_name+"' and node_type ='source'";
                                            rs = (s.executeQuery(q2));
                                            while (rs.next()) {%>
                                        <option value=<%out.println(rs.getString("node_id"));%>>
                                            <%
                                                out.println(rs.getString("node_id"));
                                            %>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select></td>
                                <td><input type="submit" value="Submit" id="B1"></td></tr>
                        </table>
                    </form>
            <tr><td>
                    <b>3. All paths coming to destination node</b> 
                    <form method="post" action="path_to_desti.jsp">
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>
                        
                        <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>
                        <table><tr><td>
                                    <select name="desti_name" id="desti_name">
                                        <%
                                            String q3 = "Select node_id from scenario_node where building_name ='"+building_name+"' and scenario_name ='"+scenario_name+"' and node_type ='destination'";
                                            rs = (s.executeQuery(q3));
                                            while (rs.next()) {%>
                                        <option value=<%out.println(rs.getString("node_id"));%>/>
                                        <%
                                            out.println(rs.getString("node_id"));
                                        %>
                                        </option>
                                        <%
                                                }
                                                rs.close();
                                                s.close();
                                                con.close();
                                            } catch (Exception e) {
                                                System.out.println(e.getMessage());
                                            }
                                        %>
                                    </select></td>
                                <td><input type="submit" value="Submit" id="B2"/></td></tr>
                        </table>
                    </form>
                </td></tr>
        </table>
       <!--  <form method="post" action="Output.jsp">
            <input type="submit" value="submit"/>
        </form> -->
    </body>
</html>
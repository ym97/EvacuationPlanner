<%@page import="javax.xml.crypto.Data"%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <table border="0" cellpadding="5" cellspacing="5" width="100%">
        <tr>
            <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white">
                <center>
                <%
                			String building_name = session.getAttribute("building_name").toString();
                			//String building_id = session.getAttribute("building_id").toString();
                			String scenario_desc = request.getParameter("scenario_desc");
                			String scenario_name = request.getParameter("scenario_name");
                            String creator = session.getAttribute("uName").toString();
                            String evacuation_type = request.getParameter("evacuation_type");
                            if(evacuation_type==null)
                            	evacuation_type = session.getAttribute("evacuation_type").toString();
                            session.setAttribute("building_name", building_name);
                            session.setAttribute("scenario_desc", scenario_desc);
                            session.setAttribute("scenario_name", scenario_name);
                            session.setAttribute("evacuation_type", evacuation_type);
                            System.out.println("in info scenario_name "+scenario_name);
                           /*  String redirectURL = "index.jsp";
                         	 response.sendRedirect(redirectURL); */
                %>
                        <%
                         connectionString cs = new connectionString();
                        String url = cs.url;
                        String username = cs.username;
                        String password = cs.password;
                        try {
                           
                           // System.out.println("building name in add : " + building_name + scenario_id);

                            Class.forName("org.postgresql.Driver");
                            //String url = "jdbc:postgresql://localhost:5432/MTP";
                            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                            Connection con = DriverManager.getConnection(url, username, password);
                            ResultSet rs = null;
                            //   System.out.println("connectionnnn stablished");
                            Statement s = con.createStatement();
                            int fl=1;
                            //   System.out.println("connectionnnn stablished");
                             
                             String  q1 ="Select building_name, scenario_name from scenario_node where building_name = '"+ building_name+"' and  scenario_name = '"+scenario_name+"'" ;
                             rs = (s.executeQuery(q1));
                             while (rs.next()) {
                           	  System.out.println("in while "+rs.getString("building_name")+" "+building_name+" "+rs.getString("scenario_name")+" "+scenario_name);
                           	  if(rs.getString("building_name").equalsIgnoreCase(building_name)  && rs.getString("scenario_name").equalsIgnoreCase(scenario_name)){
                           		  fl=0;
                           		  break;
                           	  }
                             }
                             if(fl==1){
                            System.out.println("here");
                            
                            
                            q1 ="Select * from node where building_name = '"+ building_name+"'" ;
                            System.out.println("building_name "+ building_name);
                            rs = (s.executeQuery(q1));
                            while (rs.next()) {
                            	
                            	String node_id =rs.getString("node_id");
                            	System.out.println(node_id);
                            	 System.out.println(building_name + " , " + scenario_name + " ,  '" + node_id + "' , '" + scenario_desc);
                            	 Statement s1 = con.createStatement();
                            	 String ins = "INSERT INTO scenario_node(building_name, scenario_name, node_id, scenario_description, evacuation_type) VALUES ('" + building_name + "' , '" + scenario_name + "' ,  '" + node_id + "' , '" + scenario_desc + "', '"+evacuation_type+"' )";
                                 s1.executeUpdate(ins);
                                 s1.close();
                                 //  System.out.println("print building id" + building_id);
                            } 
							
                            
                            
                             String q2 ="Select * from edge where building_name = '" + building_name+"'";
                            rs = (s.executeQuery(q2));
                            //System.out.println("here");
                            while (rs.next()) {
                            //	System.out.println("here1");
                            	String edge_id =rs.getString("edge_id");
                            	 //System.out.println(building_id + " , " + scenario_id + " ,  '" + edge_id + "' , '" + scenario_desc);
                            	 Statement s1 = con.createStatement();
                            	 String ins = "INSERT INTO scenario_edge(building_name, scenario_name, edge_id, scenario_description) VALUES ('" + building_name + "' , '" + scenario_name + "' ,  '" + edge_id + "' , '" + scenario_desc + "' )";
                                 s1.executeUpdate(ins);
                                 s1.close();
                                   //System.out.println("print building id" + building_id);
                            } 
                          }
                           
                     %> 
                </center>
                <font size="4"><b>
                        Click on options you want to perform on scenario <%out.println(request.getParameter("scenario_desc"));%>  of building <%=building_name%>
                    </b></font>
                <br/><br/>

                <table><tr>
                        <td><font color=#105690><b>1.</b> </td>
                        <td><font color=#105690><b>Add Data from Files </b></font> </td>
                    </tr>            
                    <tr><td></td><td>            
                            <font color="black"> Enter scenario data files of Nodes and Edges. 
                            </font>
                            <br>Enter Node Scenario file.<br/>
                            <form action="RegisterBuilding4" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
                                <!--input type="hidden" name="building_name" value = <% out.println(building_name);%> />
                                <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%> />
                                <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%> /-->
                                <table>    
                                    <%
                                        session.setAttribute("building_name", building_name);
                                    %>
                                    <tr>
                                        <td>Node Scenario File </td>
                                        <td><input type="file" name="file4"><!-- Here You Can Add more numbers of Files For Uploading --></td>
                                    </tr>
                                    <tr><td>
                                            <input type="submit" value="Submit">
                                        </td></tr>
                                </table>
                            </form>                     
                        </td></tr>
                    <tr></tr><tr><td></td><td bgcolor=#105690></td></tr>
                    <tr>
                        <td><font color=#105690><b>2.</b></td>
                        <td><font color=#105690><b>Add data as nodes and edges one by one.</b></font></td>
                    </tr>
                    <tr><td></td><td>
                            If there is no scenario data file, enter the data of nodes and edges one by one<!--<a href="edit_data.jsp"><font color="red">option</font></a>-->.</font>
                            <br/>
                            <a href="add_scenario_edge.jsp?building_name=<%=building_name%>&scenario_desc=<%=scenario_desc%>&scenario_name=<%=scenario_name%>"><font color="black"><b>1. Add Arcs' information of a scenario </b></font></a><br/><br>
                            <a href="add_scenario_node.jsp?building_name=<%=building_name%>&scenario_desc=<%=scenario_desc%>&scenario_name=<%=scenario_name%>"><font color="black"><b>2. Add Nodes' information of a scenario </b></font></a><br/><br/>                        
                        </td>
                    </tr>
                </table>
                   <%
                         rs.close();
                        s.close();
                    
                        con.close();
                    } catch (Exception e) {//Catch exception if any
                        System.err.println("Error: " + e.getMessage());
                       // out.println("count2");
                    } 
                %> 
                <!-- <form method="post" action="Create_Scenario.jsp">
                    <input type="submit" value="Back"/>
                </form> -->
            </td></tr>
    </table>
</body>
</html>

               
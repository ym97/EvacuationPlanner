<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
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
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                  //  System.out.println("print bbbbb");
                    String building_name = session.getAttribute("building_name").toString();
                   // String building_id = session.getAttribute("building_id").toString();
                    String scenario_name = session.getAttribute("scenario_name").toString();
                    System.out.println("scenario_name "+scenario_name);
                    String scenario_desc = session.getAttribute("scenario_desc").toString();
                        String Node_id = request.getParameter("Node_number");
                        String Node_danger = request.getParameter("Node_danger");
                        String Node_waiting_time = request.getParameter("Node_waiting_time");
                        String Node_Type = request.getParameter("Node_Type");
                        String Node_fit="0";
                        if(request.getParameter("Node_fit")!=null)
                        	Node_fit = request.getParameter("Node_fit");
                        String Node_inj = "0"; 
                        if(request.getParameter("Node_inj")!=null)
                        	Node_inj = request.getParameter("Node_inj");
                        String Node_resc = "0";
                        if(request.getParameter("Node_resc")!=null)
                        	Node_resc = request.getParameter("Node_resc");
                        System.out.println("Node_resc "+Node_resc);
                        String Node_priority="1";
                        if(request.getParameter("Node_priority")!=null)
                        	Node_priority = request.getParameter("Node_priority");

                    %>
                    Added node information for scenario <b> <% out.println(" " + scenario_desc + " ");%> </b> of building <b> <% /* building_name = building_name.replace("_", " "); */
                        out.println(building_name);
                       /*  building_name = building_name.replace(" ", "_"); */
                        %> </b><br/><br/>
                    With information :<br/>
                    <%
                        if (Node_id != null && Node_danger != null && Node_waiting_time != null ) {
                    %>  <table border="0" cellpadding="1" cellspacing="4" align="center">
                        <tr><td>
							
                            <%-- <%
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
                                   /*  Statement s = con.createStatement();
                                    String q1 = "Select * from scenario_node where building_id='"+session.getAttribute("building_id").toString()+"' and scenario_id="+scenario_id;
                                    rs = (s.executeQuery(q1));
                                    while (rs.next()) {
                                    } 
                                    rs.close();
                                    s.close();
                                    con.close();
                                } catch (Exception e) {//Catch exception if any
                                    System.err.println("Error: " + e.getMessage());
                                }
                            %> --%>
                       
                        </td>
                            <td><% out.println("  Node Danger : " + request.getParameter("Node_danger"));%></td>   
                            <td><% out.println("  Node_waiting_time : " + request.getParameter("Node_waiting_time"));%></td>
                            <td><% out.println("  Node_priority : " + request.getParameter("Node_priority"));%></td>
                            <td><% out.println("  Node Type : " + request.getParameter("Node_Type"));%></td>
                            <td><% out.println("  Node Fit : " + Node_fit);%></td>   
                            <td><% out.println(" Node_injured : " + Node_inj);%></td>
                            <td><% out.println(" Node_rescuer : " + Node_resc);%></td>
                        </tr>
                    </table>
                    <%
                        } else {
                            out.println("<html><font color=red>Please enter proper values.</font></html>");
//                            out.println(Node_id +" "+ Node_danger +" "+ Node_waiting_time +" "+ Node_Type +" "+ Node_fit +" "+ Node_inj +" "+ Node_resc);
                        }
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
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //  
                            } 
                            System.out.println("print hhhhhhhh");*/
                            System.out.println("print hhhhhhhh");
                            String ins = "update scenario_node set node_type = '" + Node_Type +"', fit_people = "+ Node_fit+", injured_people = "+Node_inj+", rescuer = "+ Node_resc+", danger_level = "+Node_danger+", priority = "+Node_priority+" where building_name = '"+building_name+"' and  scenario_name = '"+scenario_name+"' and node_id = '"+ Node_id+"'";
                            s.executeUpdate(ins);
                            System.out.println("print hhhhhhhh2");
                    %>

                    <!-- <form action ="add_another_scenario_node.jsp" method="post" > -->
                    <form action ="add_scenario_node.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/> 
                            <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>    
                            <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%>/>    
                        <table><tr>
                            <td><input type="submit" name="B1" value="Add another node information"/></td>
                            </tr></table>
                    </form>
                    <br/><hr/><br/><b>Updated Node File:</b><br/>
                </td></tr></table>

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
        <form method="post" action="add_scenario_info.jsp">
            <input type="hidden" name="building_name" value = <% out.println(building_name);%>/> 
            <input type="hidden" name="scenario_name" value = <% out.println(scenario_name);%>/>    
            <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%>/> 
            <input type="submit" value="Back">
        </form>
    </body>
</html>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include file="connectionString.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
    <body vlink="black" alink="black" link="black">
    <u><a href="building_created.jsp" target="f2" >Home</a></u> > 
     <u><a href="View_data.jsp" target="f2" >View data</a></u> > 
     View history
        <center><h2>
                <font size="4" >
                    View History of The Runs.
                </font>
            </h2>
        </center>
        <br/><br/>
        <table border="0" cellpadding="5" cellspacing="5" width="50%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td> <b>Select the Building name : </b></td>
                <td>  <form action="view_history_of_building.jsp"  method="post" >
                        <select name="building_name" id="building_name">
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
                                    Statement s = con.createStatement();
                                    String q1 = "Select * from buildings";
                                           rs = (s.executeQuery(q1));
                                           while (rs.next()) {%>
                            <option value=<%out.println(rs.getString("building_name"));%>>
                                <%
                                    out.println(rs.getString("building_name"));
                                %>
                            </option>
                            <%
                                }
                            %>
                        </select>
                </td></tr><tr></tr><tr>
                <td> <b> Method : </b></td> <td>
                    <select name="algo" id="algo" >
                        <option value="1">General Evacuation Planning</option>
                        <option value="11">Evacuation Planning with Dynamic Ladder Placement</option>         
                        <option value="21">Priority Based Evacuation Planning</option>
                    </select><br></td></tr>

            <tr></tr><tr>
                <td> <b> Scenario : </b></td> <td>
                    <select name="scenario_desc" id="scenario_desc" >
                        <%  String q2 = "Select * from scenario";
                            rs = (s.executeQuery(q2));
                            while (rs.next()) {%>
                        <option value=<%out.println(rs.getString("scenario_description"));%>>
                            <%
                                        out.println(rs.getString("scenario_description"));
                                    }
                                    rs.close();
                                    s.close();
                                    con.close();
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                            %>
                        </option>
                    </select><br></td> </tr>
            <tr></tr><tr><td>
                    <input type="submit" value="Submit"/></td>
                </form>
            </tr>
        </table>
    </body>
</html>
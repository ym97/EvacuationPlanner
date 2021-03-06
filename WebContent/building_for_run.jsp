<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
    <center>
        <!--table border="0" cellpadding="5" cellspacing="5" width="50%">
            <tr>
                <td bgcolor="white"-->
        <h2> 
             <font size="4">
                Select Building for Scenario
            </font>
        </h2>
        </center>
        <form method="post" action="scenario_for_run.jsp">
            <table align="center"><tr><td>
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
                                   
                                    String q1 = "Select * from buildings"; //where creator='"+session.getAttribute("uName").toString()+"'";
                                    rs = (s.executeQuery(q1));
                                    while (rs.next()) {%>
                            <option value=<%out.println(rs.getString("building_name"));%>>
                                <%out.println(rs.getString("building_name"));%>
                            </option>
                            <%
                                    }
                                    
                                    String check="select exists (select 1 from pg_type where typname = 'evacuation_type');";
    								boolean b=s.execute(check);
    								if(!b){
    									String type_create="CREATE TYPE evacuation_type AS ENUM ('with rescuers', 'without rescuers');";
    									s.executeUpdate(type_create);
    								}
    								
    								
                                    String create_algorithm_table = "CREATE TABLE IF NOT EXISTS algorithm(algo varchar(225) NOT NULL PRIMARY KEY, evacuation_type evacuation_type) ";
                                    s.executeUpdate(create_algorithm_table);
                                    
                                    rs.close();
                                    s.close();
                                    con.close();
                                } catch (Exception e) {//Catch exception if any
                                    System.err.println("Error: " + e.getMessage());
                                }
                            %>
                        </select></td>
                    <td><input type="submit" value="Submit"/></td></tr>
            </table>
        </form>
        <!--/td>
    </tr>
</table-->
    </body>
</html>
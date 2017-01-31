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
        <%System.out.println("inside run.jsp");
        String building_name = request.getParameter("building_name");
        if(building_name==null)
        	building_name=session.getAttribute("building_name").toString();
        session.setAttribute("building_name", building_name);
        
        %>
        <center><b><%out.println(session.getAttribute("building_name"));%></b></center>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
            <td bgcolor="white"><br/>
                <form action="run.jsp" method="post">
                   
                        <% connectionString cs = new connectionString();
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
                               
                 		%>
                    <br/><!--input type="checkbox" onclick="changeVisibility(this)"><label id="ladder" style="visibility: hidden">&nbsp;&nbsp;Number of ladders <input type="text" size="10" id="ladderNum" name="ladderNum"  value="0"></label-->
                    
                    <br/><br/>
                    Select Scenario For Building:<br/> 
                    <select name="scenario_name" id="scenario_name" >
                        <% String q3 = "Select distinct scenario_name from scenario_node where building_name ='"+building_name+"'";
                                rs = s.executeQuery(q3);
                                while (rs.next()) {%>
                        <option value=<%out.println(rs.getString("scenario_name"));%>>
                            <%
                                out.println(rs.getString("scenario_name"));
                            %>
                        </option>
                        <%
                            }
                        %>
                    </select><br/><br/>
                    
                    <input type="submit" value="Submit"/>
                </form>
            </td>
        </tr>
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
</body>
</html>
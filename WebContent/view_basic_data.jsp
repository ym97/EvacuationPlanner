<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
     <u><a href="building_created.jsp" target="f2" ><font size="4">Home</font></a></u>>
     <u><a href="View_data.jsp" target="f2" ><font size="4">View data</font></a></u>>
     <center><b><%out.println(session.getAttribute("building_name"));%></b></center>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">
                    <h2>
                        <font size="4" >
                            Click on data you want to view
                        </font>
                    </h2></td>
                    <%
//String building_name = (String)session.getAttribute("building_name");

                        String building_name = (String) request.getAttribute("building_name");
                        // int view_opt = (Integer) session.getAttribute("view_opt");
                       // out.println("building name : " + building_name);

                    %>
                    <tr><td><a href="display_arcs.jsp"><font color="black"><b>1. View Arcs' data of a building </b></font></a></td></tr>
                    <tr><td><a href="display_nodes.jsp"><font color="black"><b>2. View Nodes' data of a building </b></font></a><br/></td></tr>                        
                
            
        </table>
        <form method="post" action="View_data.jsp">
            <input type="submit" value="Back">
        </form>
    </body>
</html>
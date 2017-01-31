<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>

    <%
        String building_name = session.getAttribute("building_name").toString();
        String scenario_name = request.getParameter("scenario_name").toString();
        session.setAttribute("scenario_name", scenario_name);
    %>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white">
                <h2>
                    <font size="4" >
                        Click on data you want to view
                    </font>
                </h2>
                <a href="display_scenario_edge.jsp?building_name=<%=building_name%>&scenario_name=<%=scenario_name%>"><font color="black"><b>1. View Arcs' scenario data of a building </b></font></a><br/><br>
                <a href="display_scenario_node.jsp?building_name=<%=building_name%>&scenario_name=<%=scenario_name%>"><font color="black"><b>2. View Nodes'scenario data of a building </b></font></a><br/><br/>                        
            </td>
        </tr>
    </table>


    <form method="post" action="view_scenario.jsp">
        <input type="submit" value="Back"/>
    </form>
</body>
</html>
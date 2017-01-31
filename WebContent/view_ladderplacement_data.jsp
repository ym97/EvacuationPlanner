<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
<body vlink="black" alink="black" link="black">
<body vlink="black" alink="black" link="black">
    <u><a href="building_created.jsp" target="f2" >Home</a></u> > 
     <u><a href="View_data.jsp" target="f2" >View data</a></u> > 
     View ladderplacement data
<table border="0" cellpadding="5" cellspacing="5" width="100%">
<tr>
<!-- ------------------------------------------------------------------------------------>
<td bgcolor="white">
			<h2>
                        <font size="4" >
                            Click on data you want to view
                        </font>
                        </h2>
                         <a href="view_ladderplacement_arcs.jsp"><font color="black"><b>1. View Arcs' data of a building </b></font></a><br/><br>
                        <a href="view_ladderplacement_nodes.jsp"><font color="black"><b>2. View Nodes' data of a building </b></font></a><br/><br/>                        
</td>
</tr>
</table>
     <form method="post" action="View_data.jsp">
            <input type="submit" value="Back"/>
            </form>
</body>
</html>
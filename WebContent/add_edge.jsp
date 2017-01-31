<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp"%>
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
	<!-- <u><a href="edit_data.jsp" target="f2" ><font size="4">Edit data</font></a></u>> -->
	<!-- <u><a href="Edit_options_passed.jsp" target="f2" ><font size="4">Add</font></a></u>> -->
	<!-- <font size="4">Add edge</font> -->
	<table border="0" cellpadding="5" cellspacing="5" width="100%">
		<tr>
			<!-- ------------------------------------------------------------------------------------>
			<td bgcolor="white">
				<%
					String building_name = "Kresit";
					// building_name = building_name.replace("_", " ");
					String creator = "YM";
				%> Added Edge to building -<b> '<%
					out.println(building_name);
				%>'
			</b><br /> <br /> With information :<br /> <%
 	if (request.getParameter("Edge_Id") != "" && request.getParameter("Edge_name") != ""
 			&& request.getParameter("From_Node") != "" && request.getParameter("To_Node") != ""
 			&& request.getParameter("Edge_t_time") != "" && request.getParameter("Edge_capacity") != "") {
 %><table border="0" cellpadding="1" cellspacing="4" width="100%">
					<tr>
						<td>
							<%
								out.println("Edge_Id:  " + request.getParameter("Edge_Id"));
							%>
						</td>
						<td>
							<%
								out.println("Edge_name:  " + request.getParameter("Edge_name"));
							%>
						</td>
						<td>
							<%
								out.println("From_Node:  " + request.getParameter("From_Node"));
							%>
						</td>
						<td>
							<%
								out.println("To_Node:  " + request.getParameter("To_Node"));
							%>
						</td>
					</tr>
					<tr>
						<td>
							<%
								out.println("Edge_capacity:  " + request.getParameter("Edge_capacity"));
							%>
						</td>
						<td>
							<%
								out.println("Edge_Length:  " + request.getParameter("Edge_length"));
							%>
						</td>
						<td>
							<%
								out.println("Edge_Floor:  " + request.getParameter("Edge_floor"));
							%>
						</td>
					</tr>
				</table> <%
 	} else {
 		out.println("<html><font color=red>Please Enter Proper Values !!</font></html>");
 	}
 	//out.println("\n Details of all the nodes entered");
 	String Edge_Id = request.getParameter("Edge_Id");
 	String Edge_name = request.getParameter("Edge_name");
 	String From_Node = request.getParameter("From_Node");
 	String To_Node = request.getParameter("To_Node");
 	String Edge_capacity = request.getParameter("Edge_capacity");
 	String Edge_length = request.getParameter("Edge_length");
 	String Edge_floor = request.getParameter("Edge_floor");
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
 		//out.println("connectionnnn stablished");
 		Statement s = con.createStatement();
 		/* String q1 ="Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
 		rs = (s.executeQuery(q1));
 		int building_id = 0;
 		while (rs.next()) {
 		    building_id = rs.getInt("building_id");
 		    //  
 		} */
 		String q3 = "CREATE TABLE IF NOT EXISTS edge (edge_id varchar(225) NOT NULL, edge_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE, floor integer NOT NULL, start_node varchar(225) NOT NULL, end_node varchar(225) NOT NULL, capacity integer NOT NULL, edge_length integer NOT NULL, Primary key(edge_id, building_name))";
 		s.executeUpdate(q3);
 		System.out.println(
 				"print " + "Edge_Id " + Edge_Id + "Edge_name " + Edge_name + "building_name " + building_name);
 		String ins = "INSERT INTO edge VALUES('" + Edge_Id + "', '" + Edge_name + "', '" + building_name
 				+ "' , " + Integer.parseInt(Edge_floor) + " , '" + From_Node + "' , '" + To_Node + "' , "
 				+ Integer.parseInt(Edge_capacity) + ", " + Integer.parseInt(Edge_length) + ")";
 		System.out.println("edge added");
 		s.executeUpdate(ins);
 %>
				<form action="add_another_edge.jsp" method="post">
					<input type="hidden" name="building_name"
						value=<%out.println(building_name);%> />
					<table align="center">
						<tr>
							<td><input type="submit" name="B1" value="Add anoter edge" /></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
	<table border="1" cellpadding="5" cellspacing="5" align="center">
		<br />
		<hr />
		<br />
		<b>Updated Edge File:</b>
		<br />
		<!--Print these details-->
		<tr>
			<td>Edge ID</td>
			<td>Edge Name</td>
			<td>Building Name</td>
			<td>Edge Floor</td>
			<td>Source Node</td>
			<td>Destination Node</td>
			<td>Edge Capacity</td>
			<td>Edge length</td>
		</tr>
		<%
			String query1 = "Select * from edge where building_name = '" + building_name + "'";
				rs = (s.executeQuery(query1));
				while (rs.next()) {
		%>
		<tr>
			<td>
				<%
					out.println(rs.getString(1));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(2));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(3));
				%>
			</td>
			<td>
				<%
					out.println(rs.getInt(4));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(5));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(6));
				%>
			</td>
			<td>
				<%
					out.println(rs.getInt(7));
				%>
			</td>
			<td>
				<%
					out.println(rs.getInt(8));
				%>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		rs.close();
			s.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	%>
	<form method="post" action="edit_data.jsp">
		<input type="submit" value="Back" />
	</form>
</body>
</html>

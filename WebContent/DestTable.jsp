<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="connectionString.jsp"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<style>
body {
	background: #fafafa
		url(http://jackrugile.com/images/misc/noise-diagonal.png);
	color: #444;
	font: 100%/30px 'Helvetica Neue', helvetica, arial, sans-serif;
	text-shadow: 0 1px 0 #fff;
}

strong {
	font-weight: bold;
}

em {
	font-style: italic;
}

table {
	background: #f5f5f5;
	border-collapse: separate;
	box-shadow: inset 0 1px 0 #fff;
	font-size: 12px;
	line-height: 24px;
	margin: 30px auto;
	text-align: left;
	width: 800px;
}

th {
	background: url(http://jackrugile.com/images/misc/noise-diagonal.png),
		linear-gradient(#777, #444);
	border-left: 1px solid #555;
	border-right: 1px solid #777;
	border-top: 1px solid #555;
	border-bottom: 1px solid #333;
	box-shadow: inset 0 1px 0 #999;
	color: #fff;
	font-weight: bold;
	padding: 10px 15px;
	position: relative;
	text-shadow: 0 1px 0 #000;
}

th:after {
	background: linear-gradient(rgba(255, 255, 255, 0),
		rgba(255, 255, 255, .08));
	content: '';
	display: block;
	height: 25%;
	left: 0;
	margin: 1px 0 0 0;
	position: absolute;
	top: 25%;
	width: 100%;
}

th:first-child {
	border-left: 1px solid #777;
	box-shadow: inset 1px 1px 0 #999;
}

th:last-child {
	box-shadow: inset -1px 1px 0 #999;
}

td {
	border-right: 1px solid #fff;
	border-left: 1px solid #e8e8e8;
	border-top: 1px solid #fff;
	border-bottom: 1px solid #e8e8e8;
	padding: 10px 15px;
	position: relative;
	transition: all 300ms;
}

td:first-child {
	box-shadow: inset 1px 0 0 #fff;
}

td:last-child {
	border-right: 1px solid #e8e8e8;
	box-shadow: inset -1px 0 0 #fff;
}

tr {
	background: url(http://jackrugile.com/images/misc/noise-diagonal.png);
}

tr:nth-child(odd) td {
	background: #f1f1f1
		url(http://jackrugile.com/images/misc/noise-diagonal.png);
}

tr:last-of-type td {
	box-shadow: inset 0 -1px 0 #fff;
}

tr:last-of-type td:first-child {
	box-shadow: inset 1px -1px 0 #fff;
}

tr:last-of-type td:last-child {
	box-shadow: inset -1px -1px 0 #fff;
}

tbody:hover td {
	color: transparent;
	text-shadow: 0 0 3px #aaa;
}

tbody:hover tr:hover td {
	color: #444;
	text-shadow: 0 1px 0 #fff;
}
</style>

</head>
<body>

	<%
		String dest = request.getParameter("param");
	System.out.println(dest+" hhahaha");
	// String dest = "node_1_0";	
	connectionString cs = new connectionString();
		String url = cs.url;
		String username = cs.username;
		String password = cs.password;
		try {

			Class.forName("org.postgresql.Driver");

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
			e.printStackTrace();
			return;

		}

		System.out.println("PostgreSQL JDBC Driver Registered!");

		java.sql.Connection connection = null;

		try {

			connection = DriverManager.getConnection(url, username, password);

		} catch (Exception e) {

			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;

		}

		if (connection != null) {

			String sourceList = new String("");
			Statement s = connection.createStatement();
			ResultSet rs = null, ry = null;
			String q1 = "Select * from evacrun_path where building_name = 'lib' and scenario_name= 'scene1' and algorithm ='CCRP_extended' and destination='"
					+ dest + "'";/* session.getAttribute("building_name") */
					System.out.println(q1);
			rs = (s.executeQuery(q1));

			while (rs.next()) {

				String tp = rs.getString("source");
				sourceList += "," + tp;

			}
			
			if(sourceList.compareTo("")!=0){ String sources[] = sourceList.substring(1).split(",");
			//System.out.println(sourceList);
			String q2 = "Select * from node where building_name = 'lib'";/* session.getAttribute("building_name") */
			ry = s.executeQuery(q2);
			int max = -1;
			while (ry.next()) {
				int i = Integer.parseInt(ry.getString("floor"));
				if (i > max)
					max = i;
			}
			//System.out.println(" max "+max);
	%>
	<table>
		<thead>
			<tr>
				<th>Floor</th>
				<th>List of Sources</th>
			</tr>
		</thead>
		<tbody>

			<%
				for (int i = 0; i <= max; i++) {
		
				ResultSet rp = null;    
				String q5 = "Select * from node where building_name='lib' and floor="+i;
				rp = s.executeQuery(q5);
				String p ="";
				while(rp.next()){
					p+=","+rp.getString("node_id");
				}
				//System.out.println("p : "+p);
				p = p.substring(1);
				//System.out.println("p substr : "+p);
				String po[] = p.split(",");
				p="";
				for(int j=0;j<po.length;j++){
					for(int k=0;k<sources.length;k++){
						if(sources[k].compareTo(po[j])==0){
							p+=","+sources[k];
							break;
						}
					}}
					if(p.compareTo("")!=0) p= p.substring(1);
					else p="none";
					
					String href = "FloorSources.jsp?param1="+p+"__"+i;
				    %>
				  
			<tr >
<td> <strong><a href=<% out.println (href);%> ; 
  target="_self"
  onclick="'<% out.println (href);%>','_self','width=800,height=800"><% out.println("   Floor " + i);%>	</a></strong></td>
		
				<td><% out.println(p);%></td>
			
			</tr>
			
			<%
				
				}}}
			%>

		</tbody>
	</table>

</body>
</html>
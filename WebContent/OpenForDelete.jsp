
<!DOCTYPE HTML>
<%@include file="connectionString.jsp"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>Graph</title>
<script type="text/javascript">

</script>

<style>
body {
	margin: 0;
	padding: 0;
	overflow: hidden;
}

p {
	text-align: center;
	overflow: overlay;
	position: relative;
}

body {
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: url('bodyBG.jpg');
	background-repeat: no-repeat;
}
</style>
<script type="text/javascript">


</script>
</head>

<body>


	<script>
 
		<%
		String var = request.getParameter("param");
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
				System.out.println("Entered fro query");
				ResultSet rs = null;
				Statement s = connection.createStatement();
				String q3 = "SELECT node_id FROM node WHERE building_name='lib'";
				rs = s.executeQuery(q3);

				while (rs.next()) {
				//	System.out.println("Entered while");

					String k = rs.getString("node_id");
					//System.out.println(k);
						 if(k.compareTo(var)==0){
														 Statement sw = connection.createStatement();
									String q1 = "DELETE FROM node WHERE building_name='lib' AND node_id='"+var+"'";
								String q2 = "DELETE FROM edge WHERE start_node='"+var+"' OR end_node='"+var+"'";
								String q4 = "DELETE FROM node_ladder WHERE building_name='lib' AND node_id='"+var+"'";
								sw.executeUpdate(q1);
								sw.executeUpdate(q2);
								sw.executeUpdate(q4);
						 }
				}

			} else {

				System.out.println("Failed to make connection!");

			}%>
	
	</script>

</body>

</html>

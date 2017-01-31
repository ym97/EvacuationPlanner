
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
window.onload = function() {

	 window.opener.sourcePath = null;
	
	 window.opener.destPath = null;
}
</script>
</head>

<body>


	<script>
		
	<% System.out.println("entered");
			String var = request.getParameter("param");
			System.out.println(var);
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
				String q3 = "SELECT * FROM edge WHERE building_name='lib' and edge_id='" + var ;
				rs = s.executeQuery(q3);
				
				if(rs.next()){%>
					window.opener.check = true;
			<%	}
				else{%>
					window.opener.check = false;
			<%	}
			}
				else {

				System.out.println("Failed to make connection!");

			}
			
	 %> 
		
			
	</script>
</body>

</html>

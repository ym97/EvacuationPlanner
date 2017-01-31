
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

window.onload = function() {

	window.opener.NodeList = null;
	window.opener.EdgeList = null;
	
};
	
</script>
</head>

<body>


	<script>
		
	<%System.out.println("entered");
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
				String q3 = "SELECT * FROM scenario_node WHERE building_name='lib' and node_id='" + var + "' AND node_type='source'";
				rs = s.executeQuery(q3);
				ArrayList<String> aa = new ArrayList<String>();
				ArrayList<String> ab = new ArrayList<String>();

				while (rs.next()) {
                    
					System.out.println("Yes it is a source");
					ResultSet rsw = null;
					Statement sw = connection.createStatement();
					String q3w = "SELECT * FROM evacrun_path WHERE building_name='lib' and algorithm='CCRP_extended' and scenario_name='scene1' and source='"
							+ var + "'";
					rsw = sw.executeQuery(q3w);

					while (rsw.next()) {
						//System.out.println("path edgelisht kosam vacha");
						String p = rsw.getString("path");
						String q = rsw.getString("edgelist");
						System.out.println(p);
						System.out.println(q);

						String po[] = p.split("---");
						for (int i = 0; i < po.length; i++) {
							if (!aa.contains(po[i])) {
								aa.add(po[i]);
							}
						}

						q = q.substring(1, q.length()-1);
						System.out.println(q);

						String pi[] = q.split(",");
						for (int i = 0; i < pi.length; i++) {
							if (!ab.contains(pi[i])) {
								ab.add(pi[i]);
							}
						}
					}

				}
				System.out.println(aa + " --- " + ab);
				String as=new String("");
				String ad=new String("");
				
				for(int i=0;i<aa.size();i++) as += aa.get(i)+",";
				for(int i=0;i<ab.size();i++) ad += ab.get(i)+",";
				as=as.substring(0, as.length()-1);
				ad=ad.substring(0, ad.length()-1);
				System.out.println(as+"         "+ad);
                    %>
                    
                        window.opener.NodeList = "<%=as%>";
                        window.opener.EdgeList   = "<%=ad%>";
               	var pass = window.opener.NodeList+"__"+window.opener.EdgeList+"__"+"4";
					 var popupStoD = window.open("StoD.jsp?param1="+pass,
								"_self",
						"visible=none,directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1100,height=700,left=100,top=0");
	
					 <%
			} else {

				System.out.println("Failed to make connection!");

			}
			
	 %> 
		
			
	</script>
</body>

</html>

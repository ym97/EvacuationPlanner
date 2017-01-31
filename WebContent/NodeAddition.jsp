<!DOCTYPE html>
<%@include file="connectionString.jsp"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Node Details</title>
<script type="text/javascript">
	window.onload = function() {

		document.getElementById('param_id').value = window.opener.idd;
		document.getElementById('param_x').value = window.opener.xx;
		document.getElementById('param_y').value = window.opener.yy;
	}
</script>
<!-- CSS -->
<style>
body {
	background-image: url("formbg.jpg");
	background-repeat: no-repeat;
}

.myForm {
	background-opacity: 0.2;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size: 0.8em;
	padding: 1em;
	border: 1px solid #ccc;
	border-radius: 3px;
}

.myForm * {
	box-sizing: border-box;
}

.myForm label {
	font-size: 0.9em;
}

.myForm .audioOnly {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.myForm input {
	border-color: brown;
	border: 1px solid /* #ccc */;
	border-radius: 3px;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size: 0.9em;
	padding: 0.5em;
}

div {
	align: centre;
	padding: 5px;
}

.myForm input {
	width: 12em;
}

h6 {
	font-size: 10px;
	color: white;
	font-family: Verdana;
}

.myForm button {
	padding: 0.7em;
	border-radius: 0.5em;
	background: #eee;
	border: none;
	font-weight: bold;
	margin-left: 1.5em;
}

.myForm button:hover {
	background: #ccc;
	cursor: pointer;
}
</style>

</head>
<body>
	<form role="form" name="nodeform" class="myForm" method="get"
		enctype="application/x-www-form-urlencoded" action="NodeAddition.jsp">
		<!-- action="/html/codes/html_form_handler.cfm"  -->
		<!-- <div ><h6>NODE DETAILS</h6> </div> -->
		<div class="form-group">
			<label class="audioOnly" for="node_id">Node ID</label> <input
				id="param_id" type="text" name="node_id" readonly>
			<!-- "Node ID" -->
		</div>

		<div class="form-group">
			<label class="audioOnly" for="node_name">Node Name</label> <input
				type="text" name="node_name" required placeholder="Node Name">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="building_name">Building Name</label> <input
				type="text" name="building_name" value ="lib" required placeholder="lib"
				<%-- <%=session.getAttribute("building_name")%> --%> readonly>
		</div>

		<div class="form-group">
			<label class="audioOnly" for="capacity">Capacity</label> <input
				type="number" name="capacity" required placeholder="Capacity">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="floor">Floor Number</label> <input
				type="number" name="floor" required placeholder="Floor Number">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="latitude">Latitude</label> <input
				id="param_x" type="number" step="0.01" name="latitude" readonly>
		</div>
		
		<div class="form-group">
			<label class="audioOnly" for="longitude">Longitude</label> <input
				id="param_y" type="number" step="0.01" name="longitude" readonly>
		</div>


		<div class="form-group">
			<label class="audioOnly" for="node_ladder">Node Ladder</label> <input
				type="number" name="node_ladder" required placeholder="Node Ladder">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="no_of_ladder">No of Ladder</label> <input
				type="number" name="no_of_ladder" required
				placeholder="No of Ladder">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="ladder_load">Ladder Load</label> <input
				type="number" name="ladder_load" required placeholder="Ladder Load">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="travel_time">Travel Time</label> <input
				type="number" name="travel_time" required placeholder="Travel Time">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="ladder_capacity">Ladder
				Capacity</label> <input type="number" name="ladder_capacity" required
				placeholder="Ladder Capacity">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="start_node">Start Node</label> <input
				type="text" name="start_node" required placeholder="Start Node">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="end_node">End Node</label> <input
				type="text" name="end_node" required placeholder="End Node">
		</div>
		<div class="form-group">
			<label class="audioOnly" for="placement_time">Placement Time</label>
			<input type="text" name="placement_time" required
				placeholder="Placement Time">
		</div>
		<button onclick="saveNode();">Save</button>

	</form>
	<%
		boolean canStore = false;
	%>
	<script type="text/javascript">
		function saveNode() {

			var nodeid = document.nodeform.node_id.value;
			var nodename = document.nodeform.node_name.value;
			var building = document.nodeform.building_name.value;
			var cap = document.nodeform.capacity.value;
			var floor = document.nodeform.floor.value;
			var latitude = document.nodeform.latitude.value;
			var longitude = document.nodeform.longitude.value;
			var node_ladder = document.nodeform.node_ladder.value;
			var no_of_ladder = document.nodeform.no_of_ladder.value;
			var ladder_load = document.nodeform.ladder_load.value;
			var travel_time = document.nodeform.travel_time.value;
			var ladder_capacity = document.nodeform.ladder_capacity.value;
			var start_node = document.nodeform.start_node.value;
			var end_node = document.nodeform.end_node.value;
			var placement_time = document.nodeform.placement_time.value;
			
			// nodeid
			//building name
			//floor
			//lat
			//long
			// pre taken 

			if (nodename == "") {
				alert("Please provide name!");
				document.nodeform.name.focus();
			} else if (cap == "") {
				alert("Please provide capacity!");
				document.nodeform.capacity.focus();
			} else if (node_ladder == "") {
				alert("Please provide node ladder!");
				document.nodeform.node_ladder.focus();
			} else if (no_of_ladder == "") {
				alert("Please provide number of ladder!");
				document.nodeform.no_of_ladder.focus();
			} else if (travel_time == "") {
				alert("Please provide travel time!");
				document.nodeform.travel_time.focus();
			} else if (ladder_capacity == "") {
				alert("Please provide ladder capacity!");
				document.nodeform.ladder_capacity.focus();
			} else if (start_node == "") {
				alert("Please provide start node !");
				document.nodeform.start_node.focus();
			} else if (end_node == "") {
				alert("Please provide end node !");
				document.nodeform.end_node.focus();
			} else if (placement_time == "") {
				alert("Please provide the ladder placement time !");
				document.nodeform.placement_time.focus();
			} else {

				alert("storing...");
	<%canStore = true;

			String Node_number = request.getParameter("node_id");
			String Node_name = request.getParameter("node_name");
			String Node_floor = request.getParameter("floor");
			String Building_Name = request.getParameter("building_name");
			String Node_capacity = request.getParameter("capacity");
			String Node_ladder = request.getParameter("node_ladder");
			String Node_lat = request.getParameter("latitude");
			String Node_long = request.getParameter("longitude");
			String No_of_ladder = request.getParameter("no_of_ladder");
			String Ladder_load = request.getParameter("ladder_load");
			String Travel_time = request.getParameter("travel_time");
			String Ladder_capacity = request.getParameter("ladder_capacity");
			String Ladder_st_node = request.getParameter("start_node");
			String Ladder_end_node = request.getParameter("end_node");
			String Ladder_Placement_Time = request.getParameter("placement_time");
			connectionString cs = new connectionString();
			String url = cs.url;
			String username = cs.username;
			String password = cs.password;%>
		}

		}
	</script>
	<%
		if (canStore) {

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

			//	System.out.println("Before table");
				Statement s = connection.createStatement();

				String q3 = "CREATE TABLE IF NOT EXISTS node(node_id varchar(225) NOT NULL, node_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE , capacity integer NOT NULL, floor integer NOT NULL, latitude float NOT NULL, longitude float NOT NULL, node_ladder varchar(5) NOT NULL default 'no', Primary key(node_id, building_name))";
				/* references buildings(building_name) ON DELETE CASCADE*/
				s.executeUpdate(q3);
				String ins = "INSERT INTO node VALUES ('" + Node_number + "', '" + Node_name + "', '"
						+ Building_Name + "' , '" + Integer.parseInt(Node_capacity) + " ', '"
						+ Integer.parseInt(Node_floor) + "' ,' " + Float.parseFloat(Node_lat) + "' , '"
						+ Float.parseFloat(Node_long) + "')";
				s.executeUpdate(ins);
				if (!Node_ladder.isEmpty()) {
					q3 = "CREATE TABLE IF NOT EXISTS node_ladder(node_id varchar(225) NOT NULL, node_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE ,node_ladder varchar(5) NOT NULL, no_of_ladder integer NOT NULL default 0, ladder_load integer NOT NULL default 0, ladder_travel_time numeric NOT NULL default 0, ladder_capacity integer NOT NULL default 0, ladder_start_node varchar(225) NOT NULL, ladder_end_node varchar(225) NOT NULL, ladder_placement_time int NOT NULL, Primary key(node_id, building_name))";
					/* references buildings(building_name) ON DELETE CASCADE*/
					s.executeUpdate(q3);
					//out.println("ladder not empty");
					//String ins1 = "INSERT INTO node_" + building_id + "_withladder VALUES (" + building_id + " , " + Integer.parseInt(Node_number) + ")";
					String ins1 = "INSERT INTO node_ladder VALUES ('" + Node_number + "', '" + Node_name + "', '"
							+ Building_Name + "' ,' " + Node_ladder + "','" + Integer.parseInt(No_of_ladder)
							+ " ',' " + Integer.parseInt(Ladder_load) + "' ,' " + Integer.parseInt(Travel_time)
							+ "' ,' " + Integer.parseInt(Ladder_capacity) + "' , '" + Ladder_st_node + "' , '"
							+ Ladder_end_node + "',' " + Ladder_Placement_Time + "')";
					s.executeUpdate(ins1);
connection.commit();
				}

				System.out.println("done done ");
			} else {

				System.out.println("Failed to make connection!");

			}
		}
	%>

</body>
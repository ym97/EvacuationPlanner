<! DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Node Details</title>

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
<script type="text/javascript">
	window.onload = function() {

		document.getElementById('param_id').value = window.opener.idd;
		document.getElementById('param_x').value = window.opener.xx;
		document.getElementById('param_y').value = window.opener.yy;
	}
</script>
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
			alert(nodeid + " " + nodename + " " + building + " " + cap + " "
					+ floor + " " + latitude + " " + longitude + " "
					+ node_ladder + " " + no_of_ladder + " " + ladder_load
					+ " " + travel_time + " " + ladder_capacity + " "
					+ start_node + " " + end_node + " " + placement_time);
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
			}

		}
	</script>

</body>
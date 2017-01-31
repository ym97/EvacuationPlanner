<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Edge Details</title>

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

		document.getElementById('param_eid').value = window.opener.eid;
		document.getElementById('param_s').value = window.opener.ex;
		document.getElementById('param_t').value = window.opener.ey;
	}
</script>
</head>
<body>

	<form role="form" class="myForm" name="edgeform" method="get"
		enctype="application/x-www-form-urlencoded" action="EdgeAddition.jsp">
		<!-- <div ><h6>EDGE DETAILS</h6> </div> -->
		<div class="form-group">
			<label class="audioOnly" for="edge_id">Edge ID</label> <input
				type="text" name="edge_id" id="param_eid" readonly>
		</div>

		<div class="form-group">
			<label class="audioOnly" for="edge_name">Edge Name</label> <input
				type="text" name="edge_name" required placeholder="Edge Name">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="building_name">Building Name</label> <input
				type="text" name="building_name" required
				placeholder="lib" value ="lib" readonly > <!-- "Building Name" -->
		<!--  < %session.getAttribute("building_name" );%>-->
		</div>

		<div class="form-group">
			<label class="audioOnly" for="floor">Floor Number</label> <input
				type="number" name="floor" required placeholder="Floor Number">
		</div>

		<div class="form-group">
			<label class="audioOnly" for="start_node">Start Node</label> <input
				type="text" name="start_node" id="param_s" readonly>
		</div>

		<div class="form-group">
			<label class="audioOnly" for="end_node">End Node</label> <input
				type="text" name="end_node" id="param_t" readonly>
		</div>


		<div class="form-group">
			<label class="audioOnly" for="capacity">Capacity</label> <input
				type="number" name="capacity" required placeholder="Capacity">
		</div>


		<div class="form-group">
			<label class="audioOnly" for="edge_length">Edge Length</label> <input
				type="number" name="edge_length" required placeholder="Edge Length">
		</div>

		<button>Save</button>

	</form>


</body>
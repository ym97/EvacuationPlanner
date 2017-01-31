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
  var my_id,check;
  var maxNode=0;
  var maxEdge=0;var idd, xx, yy , eid, ex, ey;
  var staircases =[] ;
  var stairXPositions=[];
  var stairYPositions=[];
  var floorNum=[];  
  var color=["green","blue","magenta","gray","orange","pink"];
  var k=0;
	function changeBackground(url_of_pic) {
		document.body.style.backgroundImage = url("'" + url_of_pic + "'");
	}
	var popupnodeWindow = null , popupdelWindow=null;

	

	function nodeparent_disable() {
		if (popupnodeWindow && !popupbnodeWindow.closed)
			popupnodeWindow.focus();
	}
	
	var popupedgeWindow = null;
function nodeopen(id,x,y) {
	
	//if the node id is already existing then
	//i need to open that form with preloaded details
	//else with the nodeid and others
	idd =id ;xx=x ; yy=y;
	popupnodeWindow = window
				.open(
						'Check.jsp?param='+id,
						"_blank",
						"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0");
    setTimeout(function () { popupnodeWindow.close();
       if(check){
    	   window
			.open(
					'NodeDetails.jsp?param='+id,
					"_blank",
					"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0");
 
       }
       else{
    	   window
			.open(
					'NodeForm.jsp',
					"_blank",
					"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0");

       }
    }, 1);  
	
	}
	
	function edgeopen(id,x,y) {
		
		//if the edge id is already existing then
		//i need to open that form with preloaded details
		//else with the edgeid and others
		eid=id; ex=x; ey=y;
		popupedgeWindow = window
		.open(
				'CheckE.jsp?param='+id,
				"_blank",
				"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0");
setTimeout(function () { popupedgeWindow.close();
if(check){
   window
	.open(
			'EdgeDetails.jsp?param='+id,
			"_blank",
			"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0");

}
else{
   window
	.open(
			'EdgeForm.jsp',
			"_blank",
			"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0");

}
}, 1);  	}

	function edgeparent_disable() {
		if (popupedgeWindow && !popupedgeWindow.closed)
			popupedgeWindow.focus();
	}

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
	overflow-y: scroll;
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: url('bodyBG.jpg');
	background-repeat: no-repeat;
}

#plan0 {
	scrollbar: yes;
	width: 700px;
	height: 600px;
	align: center;
	/* background-image: url('kresit_1_Floor_plan.png'); */
	background-repeat: no-repeat;
	background-position: center;
	border-size: 3px;
	border-style: solid;
	border-color: brown;
	align: center;
	width: 700px;
}

#plan1 {
	scrollbar: yes;
	width: 700px;
	height: 600px;
	align: center;
	/* background-image: url('kresit_1_Floor_plan.png'); */
	background-repeat: no-repeat;
	background-position: center;
	border-size: 3px;
	border-style: solid;
	border-color: brown;
	align: center;
	width: 700px;
}

#plan2 {
	scrollbar: yes;
	width: 700px;
	height: 600px;
	align: center;
	/* background-image: url('kresit_1_Floor_plan.png'); */
	background-repeat: no-repeat;
	background-position: center;
	border-size: 3px;
	border-style: solid;
	border-color: brown;
	align: center;
	width: 700px;
}

#plan3 {
	scrollbar: yes;
	width: 700px;
	height: 600px;
	align: center;
	/* background-image: url('kresit_1_Floor_plan.png'); */
	background-repeat: no-repeat;
	background-position: center;
	border-size: 3px;
	border-style: solid;
	border-color: brown;
	align: center;
	width: 700px;
}

#plan4 {
	scrollbar: yes;
	width: 700px;
	height: 600px;
	align: center;
	/* background-image: url('kresit_1_Floor_plan.png'); */
	background-repeat: no-repeat;
	background-position: center;
	border-size: 3px;
	border-style: solid;
	border-color: brown;
	align: center;
	width: 700px;
}

#toolbox {
	position: absolute;
	bottom: 0;
	left: 0;
	margin-bottom: 0.5em;
	margin-left: 1em;
	border: 2px solid #EEEEEE;
	border-radius: 5px;
	padding: 1em;
	z-index: 5;
}

#toolbox input {
	width: 30px;
	opacity: 0.4;
}

#toolbox input:hover {
	opacity: 1;
	cursor: pointer;
}

#hidden-file-upload {
	display: none;
}

.conceptG text {
	pointer-events: none;
}

marker {
	fill: #333;
}

g.conceptG circle {
	fill: red;
}

g.conceptG:hover circle {
	stroke-width: 8px;
	stroke: red;
	stroke-opacity: 0.2;
}

g.selected circle {
	fill: magenta;
}

g.selected:hover circle {
	stroke: magenta;
	stroke-width: 8px;
	stroke-opacity: 0.2;
}

#narrow {
	float: right;
	width: 200px;
	background: lightblue;
}
div. stair{
pointer-events:none;
}
#slider {
    display: block;
    left: 178px;
    position: absolute;
    top: 370px;
    width: 445px;
    z-index: 50;
}
#wide {
	float: left;
	width: calc(100% - 200px);
	background: lightgreen;
}

path.link {
	fill: pink;
	stroke: #333;
	stroke-width: 6px;
	cursor: default;
}

path.link:hover {
	stroke: black;
}

g.connect-node circle {
	fill: #BEFFFF;
}

path.link.hidden {
	stroke-width: 0;
}

#parent_div_2 {
	width: 100px;
	height: 100px;
	border: 1px solid red;
	margin-right: 10px;
	float: left;
}
div.hidden {
    display: none;
}
path.link.selected {
	stroke: rgb(229, 172, 247);
}
</style>
<script type="text/javascript">
    
 
	var imageArray = [ "kresit_0_Floor_plan.png", "kresit_1_Floor_plan.png",
			"kresit_2_Floor_plan.png", "kresit_3_Floor_plan.png",
			"kresit_4_Floor_plan.png" ];
	document.getEleentById('plan0').style.backgroundImage = 'url(' + imageArray[0] + ')';
	plan1.style.backgroundImage = 'url(' + imageArray[1] + ')';
	plan2.style.backgroundImage = 'url(' + imageArray[2] + ')';
	plan3.style.backgroundImage = 'url(' + imageArray[3] + ')';
	plan4.style.backgroundImage = 'url(' + imageArray[4] + ')';
	
</script>

</head>

<body onFocus="parent_disable();" onclick="parent_disable();">
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"
		type="text/javascript"></script>
	<div id="wide">
		<input type="button" id="upload-input0"> <input type="button"
			id="upload-input1"> <input type="button" id="upload-input2">
		<input type="button" id="upload-input3"> <input type="button"
			id="upload-input4"> <input type="button" id="drawStairs"
			onclick="obtainStairData()"> <input type="button" id="bfb"
			onclick="please()"><input type="button" id="wfb"
			onclick="hi()">
	</div>
<script>
function hi(){
var c = document.getElementById("HI");
var ctx = c.getContext("2d");
ctx.beginPath();
ctx.moveTo(20, 30);
ctx.lineTo(300, 150);
ctx.stroke();
}
</script>
    <script>
    
    function please(){
    	$("div").remove(".stair");
    }
    
    function connect(div1, div2, color, thickness,a,b,c,d) {
    	var off1 = getOffset(div1,a,b);
        var off2 = getOffset(div2,c,d);
        // bottom right
        var x1 = off1.left ;//+ a;
        var y1 = off1.top ;//+b ;
        // top right
        var x2 = off2.left ;//+ c;
        var y2 = off2.top ;//+d ;
        // distance
        var length = Math.sqrt(((x2-x1) * (x2-x1)) + ((y2-y1) * (y2-y1)));
        // center
        var cx = ((x1 + x2) / 2) - (length / 2);
        var cy = ((y1 + y2) / 2) - (thickness / 2);
        // angle
        var angle = Math.atan2((y1-y2),(x1-x2))*(180/Math.PI);
        // make hr
        var htmlLine = "<div  class='stair' style=' z-index: -10;  padding:0px; margin:0px; height:" + thickness + "px; background-color:" + color + "; line-height:1px; position:absolute; left:" + cx + "px; top:" + cy + "px; width:" + length + "px; -moz-transform:rotate(" + angle + "deg); -webkit-transform:rotate(" + angle + "deg); -o-transform:rotate(" + angle + "deg); -ms-transform:rotate(" + angle + "deg); transform:rotate(" + angle + "deg);' />";
        //
       // alert(htmlLine);
        document.body.innerHTML += htmlLine; 
    }

    function getOffset( el,a,b ) {
        var rect = el.getBoundingClientRect();
        return {
            left: rect.left + window.pageXOffset+a,
            top: rect.top + window.pageYOffset+b,
            width: rect.width || el.offsetWidth,
            height: rect.height || el.offsetHeight
        };
    }

    </script>
    
   
    
	<script>
    
      function obtainStairData(){
    	  <%connectionString cs = new connectionString();
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

			java.sql.Connection con = null;

			try {

				con = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}  
			
			if (con != null) {

				Statement s = con.createStatement();
				ResultSet rs = null, ry = null;
				String q1 = "SELECT DISTINCT node_name from node where node_name like 'staircase%' and building_name='lib'";/* session.getAttribute("building_name") */
				rs = (s.executeQuery(q1));
				// add floorr number also in the query

				while (rs.next()) {
					//the distinct staircases of the building are obtained from here
					String p = rs.getString("node_name");
					Statement st = con.createStatement();%>
	var pp = "<%=p%>";
//	alert(pp);
	staircases.push(pp);
	stairXPositions = [];
	stairYPositions = [];
	floorNum = [];
	ry = null;
	<%
	     String q2 = "Select * from node where building_name = 'lib' and node_name='" + p+ "' order by floor";/* session.getAttribute("building_name") */
					System.out.println(q2);
							ry = st.executeQuery(q2);

					while (ry.next()) {
                            
						   int flr = ry.getInt("floor");
						   double x = ry.getDouble("latitude");
						   double y = ry.getDouble("longitude");
						   System.out.println(flr+" "+x+" "+y);
						  %> 
						     floorNum.push(<%=flr%>);
						     stairXPositions.push(<%=x%>);
						     stairYPositions.push(<%=y%>);
						     
						  <%
					}
					
					%>
					var i=0,j=1;
			//		alert("Main Connect Loop")
			    for(i=floorNum[0],j=floorNum[1];i<floorNum.length-1;i++,j++){
			    	//alert("Floor "+ i +" to Floor "+j);
			    	//alert(stairXPositions[i]+" "+stairYPositions[i]+" "+stairXPositions[j]+" "+stairYPositions[j]);
		        var div1 = document.getElementById('plan'+i);
		        var div2 = document.getElementById('plan'+j);
		        connect(div1, div2, color[k], 3 , stairXPositions[i],stairYPositions[i],stairXPositions[j],stairYPositions[j]);
		        }k++;
		    <%
				}

			}

			else { 

				System.out.println("Failed to make connection!");

			}


		%>
			
      }
    </script>
  
	<div id="plan0" style="width: 700px; margin: 0 auto;">
		<script src="//d3js.org/d3.v3.js" charset="utf-8"></script>
		<script src="//cdn.jsdelivr.net/filesaver.js/0.1/FileSaver.min.js"></script>
		<script>
			document.onload = (function(d3, saveAs, Blob, undefined) {
				"use strict";

				// define graphcreator object
				var GraphCreator = function(svg, nodes, edges) {
					var thisGraph = this;
					thisGraph.idct = 0;thisGraph.cdct = 0;

					thisGraph.nodes = nodes || [];
					thisGraph.edges = edges || [];

					thisGraph.state = {
						selectedNode : null,
						selectedEdge : null,
						mouseDownNode : null,
						mouseDownLink : null,
						justDragged : false,
						justScaleTransGraph : false,
						lastKeyDown : -1,
						shiftNodeDrag : false,
						selectedText : null
					};

					// define arrow markers for graph links
					var defs = svg.append('svg:defs');
					defs.append('svg:marker').attr('id', 'end-arrow').attr(
							'viewBox', '0 0 0 0').attr('refX', "0").attr(
							'markerWidth', 0).attr('markerHeight', 0).attr(
							'orient', 'auto').append('svg:path').attr('d',
							'M0,0');

					// define arrow markers for leading arrow
					defs.append('svg:marker').attr('id', 'mark-end-arrow')
							.attr('viewBox', '0 0 00 00').attr('refX', 0).attr(
									'markerWidth', 0).attr('markerHeight', 0)
							.attr('orient', 'auto').append('svg:path').attr(
									'd', 'M0,00');

					thisGraph.svg = svg;
					thisGraph.svgG = svg.append("g").classed(
							thisGraph.consts.graphClass, true);
					var svgG = thisGraph.svgG;

					// displayed when dragging between nodes
					thisGraph.dragLine = svgG.append('svg:path').attr('class',
							'link dragline hidden').attr('d', 'M0,0L0,0')
							.style('marker-end', 'url(#mark-end-arrow)');

					// svg nodes and edges 
					thisGraph.paths = svgG.append("g").selectAll("g");
					thisGraph.circles = svgG.append("g").selectAll("g");

					thisGraph.drag = d3.behavior.drag().origin(function(d) {
						return {
							x : d.x,
							y : d.y
						};
					}).on("drag", function(args) {
						thisGraph.state.justDragged = true;
						thisGraph.dragmove.call(thisGraph, args);
					}).on("dragend",
	function() {
						// todo check if edge-mode is selected
					});

	// listen for key events
	d3.select(window).on("keydown",
	function() {
						thisGraph.svgKeyDown.call(thisGraph);
					}).on("keyup",
	function() {
						thisGraph.svgKeyUp.call(thisGraph);
					});svg.on("mousedown",
	function(d) {
						thisGraph.svgMouseDown.call(thisGraph, d);
					});
					svg.on("mouseup", function(d) {
						thisGraph.svgMouseUp.call(thisGraph, d);
					});

					// listen for dragging
					var dragSvg = d3.behavior.zoom().on("zoom", function() {
						if (d3.event.sourceEvent.shiftKey) {
							// TODO  the internal d3 state is still changing
							return false;
						} else {
							thisGraph.zoomed.call(thisGraph);
						}
						return true;
					}).on(
							"zoomstart",
	function() {
								var ael = d3.select(
										"#" + thisGraph.consts.activeEditId)
										.node();
								if (ael) {
									ael.blur();
								}
								if (!d3.event.sourceEvent.shiftKey)
									d3.select('body').style("cursor", "move");
							}).on("zoomend",
	function() {
						d3.select('body').style("cursor", "auto");
					});

	svg.call(dragSvg).on("dblclick.zoom",null);

	// listen for resize
	window.onresize=
	function() {
						thisGraph.updateWindow(svg);
					};

	// handle uploaded data

	d3.select("#upload-input0").on("click",
	function() {
										
										thisGraph.deleteGraph(true);
										
		<%try {

				Class.forName("org.postgresql.Driver");

			} catch (ClassNotFoundException e) {

				System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
				e.printStackTrace();
				return;

			}

			System.out.println("PostgreSQL JDBC Driver Registered!");

			java.sql.Connection connection0 = null;

			try {

				connection0 = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}

			if (connection0 != null) {

				Statement s0 = connection0.createStatement();
				ResultSet rs0 = null, ry0 = null;
				String q1 = "Select * from node where building_name = 'lib' and floor = 0";/* session.getAttribute("building_name") */

				// add floor number also in the query

				rs0 = (s0.executeQuery(q1));
				String q2 = "Select * from edge where building_name = 'lib' and floor = 0";/* session.getAttribute("building_name") */

				// add floorr number also in the query

				while (rs0.next()) {
					String id = rs0.getString("node_id");
					String x = rs0.getString("latitude");
					String y = rs0.getString("longitude");
					String z = rs0.getString("node_name");
					System.out.println(id + " " + x + " " + y);%>
					
				
			                           var idd =		"<%=id%>";
										var xx =		"<%=x%>";
										var yy =		"<%=y%>";
var ut  = idd.substr(idd.lastIndexOf("_")+1);
							//	alert(ut);
								if(ut > maxNode) maxNode = ut ;
								
								//		alert(idd + " " + xx + " " + yy);

										thisGraph.setIdCt(thisGraph.idct++);
										thisGraph.nodes.push({
											"id" : idd,
											"title" : "",
											"x" : xx,
											"y" : yy
										});
										thisGraph.updateGraph();
						
				
		<%}%>
				    
				   d3.selectAll('circle').attr("id",function(d){return d.id;});
				
					var newEdges = [];
				<%ry0 = (s0.executeQuery(q2));

				while (ry0.next()) {
					String eid = ry0.getString("edge_id");
					String ex = ry0.getString("start_node");
					String ey = ry0.getString("end_node");

					//System.out.println(eid + " " + ex + " " + ey);%>
					
				
			                           var iidd =		"<%=eid%>";
										var exx =		"<%=ex%>";
										var eyy =		"<%=ey%>";

										//alert(iidd + " " + exx + " " + eyy);
										var ut = iidd.substr(iidd
												.lastIndexOf("_") + 1);
										//alert(ut);
										if (ut > maxEdge)
											maxEdge = ut;

										newEdges.push({
											"id" : iidd,
											"source" : exx,
											"target" : eyy
										});
		<%}%>
			newEdges
												.forEach(function(e, i) {
													newEdges[i] = {
														id : e.id,
														source : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.source;
																})[0],
														target : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.target;
																})[0]
													};

												});
										thisGraph.edges = newEdges;
										thisGraph.updateGraph();
										maxNode++;
										maxEdge++; // for the new ids to be unique
		<%}

			else {

				System.out.println("Failed to make connection!");

			}%>
			});

					// handle delete graph
					d3.select("#delete-graph").on("click", function() {
						thisGraph.deleteGraph(false);
					});
				};

				GraphCreator.prototype.setIdCt = function(idct) {
					this.idct = idct;
				};
				GraphCreator.prototype.setCdCt = function(cdct) {
					this.cdct = cdct;
				};
				GraphCreator.prototype.consts = {
					selectedClass : "selected",
					connectClass : "connect-node",
					circleGClass : "conceptG",
					graphClass : "graph",
					activeEditId : "active-editing",
					BACKSPACE_KEY : 8,
					DELETE_KEY : 46,
					ENTER_KEY : 13,
					nodeRadius : 10
				};

					GraphCreator.prototype.deleteGraph = function(skipPrompt) {
					var thisGraph = this, doDelete = true;
					if (!skipPrompt) {
						doDelete = window
								.confirm("Press OK to delete this graph");
					}
					if (doDelete) {
						thisGraph.nodes = [];
						thisGraph.edges = [];
						thisGraph.updateGraph();
					}
				};

				/* select all text in element: taken from http://stackoverflow.com/questions/6139107/programatically-select-text-in-a-contenteditable-html-element */
				GraphCreator.prototype.selectElementContents = function(el) {
					var range = document.createRange();
					range.selectNodeContents(el);
					var sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange(range);
				};

				/* insert svg line breaks: taken from http://stackoverflow.com/questions/13241475/how-do-i-include-newlines-in-labels-in-d3-charts */
				GraphCreator.prototype.insertTitleLinebreaks = function(gEl,
						title) {
					var words = title.split(/\s+/g), nwords = words.length;
					var el = gEl.append("text").attr("text-anchor", "middle")
							.attr("dy", "-" + (nwords - 1) * 7.5);

					for (var i = 0; i < words.length; i++) {
						var tspan = el.append('tspan').text(words[i]);
						if (i > 0)
							tspan.attr('x', 0).attr('dy', '15');
					}
				};

				// remove edges associated with a node
				GraphCreator.prototype.spliceLinksForNode = function(node) {
					var thisGraph = this, toSplice = thisGraph.edges
							.filter(function(l) {
								return (l.source === node || l.target === node);
							});
					toSplice.map(function(l) {
						thisGraph.edges.splice(thisGraph.edges.indexOf(l), 1);
					});
				};

				GraphCreator.prototype.replaceSelectEdge = function(d3Path,
						edgeData) {
					var thisGraph = this;
					d3Path.classed(thisGraph.consts.selectedClass, true);
					if (thisGraph.state.selectedEdge) {
						thisGraph.removeSelectFromEdge();
					}
					thisGraph.state.selectedEdge = edgeData;
				};

				GraphCreator.prototype.replaceSelectNode = function(d3Node,
						nodeData) {
					var thisGraph = this;
					d3Node.classed(this.consts.selectedClass, true);
					if (thisGraph.state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}
					thisGraph.state.selectedNode = nodeData;
				};

				GraphCreator.prototype.removeSelectFromNode = function() {
					var thisGraph = this;
					thisGraph.circles.filter(function(cd) {
						return cd.id === thisGraph.state.selectedNode.id;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedNode = null;
				};

				GraphCreator.prototype.removeSelectFromEdge = function() {
					var thisGraph = this;
					thisGraph.paths.filter(function(cd) {
						return cd === thisGraph.state.selectedEdge;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedEdge = null;
				};

				GraphCreator.prototype.pathMouseDown = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;

					if (state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}

					var prevEdge = state.selectedEdge;
					if (!prevEdge || prevEdge !== d) {
						thisGraph.replaceSelectEdge(d3path, d);
					} else {
						thisGraph.removeSelectFromEdge();
					}
				};

				// mousedoubleclick on edge
				GraphCreator.prototype.pathMouseClick = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;
					alert("hi")
					edgeopen(d.id,d.source.id,d.target.id);
				};
				// mousedown on node
				GraphCreator.prototype.circleMouseDown = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownNode = d;
					if (d3.event.shiftKey) {
						state.shiftNodeDrag = d3.event.shiftKey;
						// reposition dragged directed edge
						thisGraph.dragLine.classed('hidden', false).attr('d',
								'M' + d.x + ',' + d.y + 'L' + d.x + ',' + d.y);
						return;
					}
				};

				// mousedoubleclick on node
				GraphCreator.prototype.circleMouseClick = function(d3node, d) {

					var thisGraph = this, state = thisGraph.state;

					d3.event.stopPropagation();
					state.mouseDownNode = d;
					nodeopen(d.id,d.x,d.y);

				};
				/* place editable text on node in place of svg text */
				GraphCreator.prototype.changeTextOfNode = function(d3node, d) {
					var thisGraph = this, consts = thisGraph.consts, htmlEl = d3node
							.node();
					d3node.selectAll("text").remove();
					var nodeBCR = htmlEl.getBoundingClientRect(), curScale = nodeBCR.width
							/ consts.nodeRadius, placePad = 5 * curScale, useHW = curScale > 1 ? nodeBCR.width * 0.71
							: consts.nodeRadius * 1.42;
					// replace with editableconent text
					var d3txt = thisGraph.svg
							.selectAll("foreignObject")
							.data([ d ])
							.enter()
							.append("foreignObject")
							.attr("x", nodeBCR.left + placePad)
							.attr("y", nodeBCR.top + placePad)
							.attr("height", 2 * useHW)
							.attr("width", useHW)
							.append("xhtml:p")
							.attr("id", consts.activeEditId)
							.attr("contentEditable", "true")
							.text(d.title)
							.on("mousedown", function(d) {
								
								d3.event.stopPropagation();
							})
							.on(
									"keydown",
									function(d) {
										d3.event.stopPropagation();
										if (d3.event.keyCode == consts.ENTER_KEY
												&& !d3.event.shiftKey) {
											this.blur();
										}
									}).on(
									"blur",
									function(d) {
										d.title = this.textContent;
										thisGraph.insertTitleLinebreaks(d3node,
												d.title);
										d3.select(this.parentElement).remove();
									});
					return d3txt;
				};

				// mouseup on nodes
				GraphCreator.prototype.circleMouseUp = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// reset the states
					state.shiftNodeDrag = false;
					d3node.classed(consts.connectClass, false);

					var mouseDownNode = state.mouseDownNode;

					if (!mouseDownNode)
						return;

					thisGraph.dragLine.classed("hidden", true);

					if (mouseDownNode !== d) {
						// we're in a different node: create new edge for mousedown edge and add to graph
						var newEdge = {
							id : "path_0" + "_"
									+ ( maxEdge +thisGraph.cdct++ ),
							source : mouseDownNode,
							target : d
						};
						var filtRes = thisGraph.paths.filter(function(d) {
							if (d.source === newEdge.target
									&& d.target === newEdge.source) {
								thisGraph.edges.splice(thisGraph.edges
										.indexOf(d), 1);
							}
							return d.source === newEdge.source
									&& d.target === newEdge.target;
						});
						if (!filtRes[0].length) {
							thisGraph.edges.push(newEdge);
							thisGraph.updateGraph();
						}
					} else {
						// we're in the same node
						if (state.justDragged) {
							// dragged, not clicked
							state.justDragged = false;
						} else {
							// clicked, not dragged
							if (d3.event.shiftKey) {
								// shift-clicked node: edit text content
								var d3txt = thisGraph.changeTextOfNode(d3node,
										d);
								var txtNode = d3txt.node();
								thisGraph.selectElementContents(txtNode);
								txtNode.focus();
							} else {
								if (state.selectedEdge) {
									thisGraph.removeSelectFromEdge();
								}
								var prevNode = state.selectedNode;

								if (!prevNode || prevNode.id !== d.id) {
									thisGraph.replaceSelectNode(d3node, d);
								} else {
									thisGraph.removeSelectFromNode();
								}
							}
						}
					}
					state.mouseDownNode = null;
					return;

				}; // end of circles mouseup

				// mousedown on main svg
				GraphCreator.prototype.svgMouseDown = function() {
					this.state.graphMouseDown = true;
				};

				// mouseup on main svg
				GraphCreator.prototype.svgMouseUp = function() {
					var thisGraph = this, state = thisGraph.state;
					if (state.justScaleTransGraph) {
						// dragged not clicked
						state.justScaleTransGraph = false;
					} else if (state.graphMouseDown && d3.event.shiftKey) {
						// clicked not dragged from svg
						alert("hihi")
						var xycoords = d3.mouse(thisGraph.svgG.node()), d = {
							id : "node_0"
								
								+ "_" + (maxNode +thisGraph.idct++),
							title : "",
							x : xycoords[0],
							y : xycoords[1]
						};
						thisGraph.nodes.push(d);
						thisGraph.updateGraph();
						// make title of text immediently editable
						var d3txt = thisGraph.changeTextOfNode(
								thisGraph.circles.filter(function(dval) {
									return dval.id === d.id;
								}), d), txtNode = d3txt.node();
						thisGraph.selectElementContents(txtNode);
						txtNode.focus();
					} else if (state.shiftNodeDrag) {
						// dragged from node
						state.shiftNodeDrag = false;
						thisGraph.dragLine.classed("hidden", true);
					}
					state.graphMouseDown = false;
				};

				// keydown on main svg
				GraphCreator.prototype.svgKeyDown = function() {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// make sure repeated key presses don't register for each keydown
					if (state.lastKeyDown !== -1)
						return;

					state.lastKeyDown = d3.event.keyCode;
					var selectedNode = state.selectedNode, selectedEdge = state.selectedEdge;

					switch (d3.event.keyCode) {
					case consts.BACKSPACE_KEY:
					case consts.DELETE_KEY:
						d3.event.preventDefault();
						if (selectedNode) {
							my_id = thisGraph.nodes[thisGraph.nodes
									.indexOf(selectedNode)].id;
							delOpen();
							thisGraph.nodes.splice(thisGraph.nodes
									.indexOf(selectedNode), 1);
							thisGraph.spliceLinksForNode(selectedNode);
							state.selectedNode = null;
							thisGraph.updateGraph();
						} else if (selectedEdge) {
							my_id = thisGraph.edges[thisGraph.edges
									.indexOf(selectedEdge)].id;
							dellOpen();
							thisGraph.edges.splice(thisGraph.edges
									.indexOf(selectedEdge), 1);
							state.selectedEdge = null;
							thisGraph.updateGraph();
						}
						break;
					}
				};

				GraphCreator.prototype.svgKeyUp = function() {
					this.state.lastKeyDown = -1;
				};

				// call to propagate changes to graph
				GraphCreator.prototype.updateGraph = function() {

					var thisGraph = this, consts = thisGraph.consts, state = thisGraph.state;

					thisGraph.paths = thisGraph.paths.data(thisGraph.edges,
							function(d) {
								return String(d.source.id) + "+"
										+ String(d.target.id);
							});
					var paths = thisGraph.paths;
					// update existing paths
					paths.style('marker-end', 'url(#end-arrow)').classed(
							consts.selectedClass, function(d) {
								return d === state.selectedEdge;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							});

					// add new paths
					paths.enter().append("path").style('marker-end',
							'url(#end-arrow)').classed("link", true).attr("id",
							function(d, i) {
								return d.id;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							}).on(
							"mousedown",
							function(d) {
								thisGraph.pathMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {
								thisGraph.pathMouseClick.call(thisGraph, d3
										.select(this), d);

								;
							}).on("mouseup", function(d) {
						state.mouseDownLink = null;
					});

					// remove old links
					paths.exit().remove();

					// update existing nodes
					thisGraph.circles = thisGraph.circles.data(thisGraph.nodes,
							function(d) {
								return d.id;
							});
					thisGraph.circles.attr("transform", function(d) {
						return "translate(" + d.x + "," + d.y + ")";
					});

					// add new nodes
					var newGs = thisGraph.circles.enter().append("g");

					newGs.classed(consts.circleGClass, true).attr("transform",
							function(d) {
								return "translate(" + d.x + "," + d.y + ")";
							}).on("mouseover", function(d) {
						if (state.shiftNodeDrag) {
							d3.select(this).classed(consts.connectClass, true);
						}
					}).on("mouseout", function(d) {
						d3.select(this).classed(consts.connectClass, false);
					}).on(
							"mousedown",
							function(d) {
								
								thisGraph.circleMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"mouseup",
							function(d) {
								thisGraph.circleMouseUp.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {

								thisGraph.circleMouseClick.call(thisGraph, d3
										.select(this), d);

							}).call(thisGraph.drag);

					newGs
							.append("circle")
							.attr("r", String(consts.nodeRadius))
							.attr(
									"id",
									function(d, i) {
										return "node_0"
												
												+ "_" + (maxNode++);
									});

					newGs.each(function(d) {
						thisGraph.insertTitleLinebreaks(d3.select(this),
								d.title);
					});

					// remove old nodes
					thisGraph.circles.exit().remove();
				};

				/* GraphCreator.prototype.zoomed = function() {
				this.state.justScaleTransGraph = true;
				d3.select("." + this.consts.graphClass).attr(
						"transform",
						"translate(" + d3.event.translate + ") scale("
								+ d3.event.scale + ")");
				}; */

				GraphCreator.prototype.updateWindow = function(svg) {
					var docEl = document.documentElement, bodyEl = document
							.getElementsByTagName('body')[0];
					var x = window.innerWidth || docEl.clientWidth
							|| bodyEl.clientWidth;
					var y = window.innerHeight || docEl.clientHeight
							|| bodyEl.clientHeight;
					svg.attr("width", x).attr("height", y);
				};

				/**** MAIN ****/

				// warn the user when leaving
				window.onbeforeunload = function() {
					return "Make sure to save your graph locally before leaving :-)";
				};

				var docEl = document.documentElement, bodyEl = document
						.getElementsByTagName('body')[0];

				var width = window.innerWidth || docEl.clientWidth
						|| bodyEl.clientWidth, height = window.innerHeight
						|| docEl.clientHeight || bodyEl.clientHeight;

				var xLoc = width / 2 - 25, yLoc = 100;

				// initial node data
				var nodes = [];
				var edges = [];

				/** MAIN SVG **/
				var svg = d3.select("#plan0").append("svg").attr("width", width)
						.attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
		</script>
	</div>


	<div id="plan1" style="width: 700px; margin: 0 auto;">
		<script src="//d3js.org/d3.v3.js" charset="utf-8"></script>
		<script src="//cdn.jsdelivr.net/filesaver.js/0.1/FileSaver.min.js"></script>
		<script>
			document.onload = (function(d3, saveAs, Blob, undefined) {
				"use strict";

				// define graphcreator object
				var GraphCreator = function(svg, nodes, edges) {
					var thisGraph = this;
					thisGraph.idct = 0;thisGraph.cdct = 0;

					thisGraph.nodes = nodes || [];
					thisGraph.edges = edges || [];

					thisGraph.state = {
						selectedNode : null,
						selectedEdge : null,
						mouseDownNode : null,
						mouseDownLink : null,
						justDragged : false,
						justScaleTransGraph : false,
						lastKeyDown : -1,
						shiftNodeDrag : false,
						selectedText : null
					};

					// define arrow markers for graph links
					var defs = svg.append('svg:defs');
					defs.append('svg:marker').attr('id', 'end-arrow').attr(
							'viewBox', '0 0 0 0').attr('refX', "0").attr(
							'markerWidth', 0).attr('markerHeight', 0).attr(
							'orient', 'auto').append('svg:path').attr('d',
							'M0,0');

					// define arrow markers for leading arrow
					defs.append('svg:marker').attr('id', 'mark-end-arrow')
							.attr('viewBox', '0 0 00 00').attr('refX', 0).attr(
									'markerWidth', 0).attr('markerHeight', 0)
							.attr('orient', 'auto').append('svg:path').attr(
									'd', 'M0,00');

					thisGraph.svg = svg;
					thisGraph.svgG = svg.append("g").classed(
							thisGraph.consts.graphClass, true);
					var svgG = thisGraph.svgG;

					// displayed when dragging between nodes
					thisGraph.dragLine = svgG.append('svg:path').attr('class',
							'link dragline hidden').attr('d', 'M0,0L0,0')
							.style('marker-end', 'url(#mark-end-arrow)');

					// svg nodes and edges 
					thisGraph.paths = svgG.append("g").selectAll("g");
					thisGraph.circles = svgG.append("g").selectAll("g");

					thisGraph.drag = d3.behavior.drag().origin(function(d) {
						return {
							x : d.x,
							y : d.y
						};
					}).on("drag", function(args) {
						thisGraph.state.justDragged = true;
						thisGraph.dragmove.call(thisGraph, args);
					}).on("dragend", function() {
						// todo check if edge-mode is selected
					});

					// listen for key events
					d3.select(window).on("keydown", function() {
						thisGraph.svgKeyDown.call(thisGraph);
					}).on("keyup", function() {
						thisGraph.svgKeyUp.call(thisGraph);
					});
					svg.on("mousedown", function(d) {
						thisGraph.svgMouseDown.call(thisGraph, d);
					});
					svg.on("mouseup", function(d) {
						thisGraph.svgMouseUp.call(thisGraph, d);
					});

					// listen for dragging
					var dragSvg = d3.behavior.zoom().on("zoom", function() {
						if (d3.event.sourceEvent.shiftKey) {
							// TODO  the internal d3 state is still changing
							return false;
						} else {
							thisGraph.zoomed.call(thisGraph);
						}
						return true;
					}).on(
							"zoomstart",
							function() {
								var ael = d3.select(
										"#" + thisGraph.consts.activeEditId)
										.node();
								if (ael) {
									ael.blur();
								}
								if (!d3.event.sourceEvent.shiftKey)
									d3.select('body').style("cursor", "move");
							}).on("zoomend", function() {
						d3.select('body').style("cursor", "auto");
					});

					svg.call(dragSvg).on("dblclick.zoom", null);

					// listen for resize
					window.onresize = function() {
						thisGraph.updateWindow(svg);
					};

					

					
															// handle uploaded data

					d3
							.select("#upload-input1")
							.on(
									"click",
									function() {
										
										thisGraph.deleteGraph(true);
										
		<%try {

				Class.forName("org.postgresql.Driver");

			} catch (ClassNotFoundException e) {

				System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
				e.printStackTrace();
				return;

			}

			System.out.println("PostgreSQL JDBC Driver Registered!");

			java.sql.Connection connection1 = null;

			try {

				connection1 = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}

			if (connection1 != null) {

				Statement s1 = connection1.createStatement();
				ResultSet rs1 = null, ry1 = null;
				String q1 = "Select * from node where building_name = 'lib' and floor = 1";/* session.getAttribute("building_name") */

				// add floor number also in the query

				rs1 = (s1.executeQuery(q1));
				String q2 = "Select * from edge where building_name = 'lib' and floor = 1";/* session.getAttribute("building_name") */

				// add floorr number also in the query

				while (rs1.next()) {
					String id = rs1.getString("node_id");
					String x = rs1.getString("latitude");
					String y = rs1.getString("longitude");
					System.out.println(id + " " + x + " " + y);%>
					
				
			                           var idd =		"<%=id%>";
										var xx =		"<%=x%>";
										var yy =		"<%=y%>";
var ut  = idd.substr(idd.lastIndexOf("_")+1);
							//	alert(ut);
								if(ut > maxNode) maxNode = ut ;
								
								//	alert(idd + " " + xx + " " + yy);

										thisGraph.setIdCt(thisGraph.idct++);
										thisGraph.nodes.push({
											"id" : idd,
											"title" : "",
											"x" : xx,
											"y" : yy
										});
										thisGraph.updateGraph();
		<%}%>
				    
				   d3.selectAll('circle').attr("id",function(d){return d.id;});
				
					var newEdges = [];
				<%ry1 = (s1.executeQuery(q2));

				while (ry1.next()) {
					String eid = ry1.getString("edge_id");
					String ex = ry1.getString("start_node");
					String ey = ry1.getString("end_node");
					//System.out.println(eid + " " + ex + " " + ey);%>
					
				
			                           var iidd =		"<%=eid%>";
										var exx =		"<%=ex%>";
										var eyy =		"<%=ey%>";

									//	alert(iidd + " " + exx + " " + eyy);
										var ut = iidd.substr(iidd
												.lastIndexOf("_") + 1);
										//alert(ut);
										if (ut > maxEdge)
											maxEdge = ut;

										newEdges.push({
											"id" : iidd,
											"source" : exx,
											"target" : eyy
										});
		<%}%>
			newEdges
												.forEach(function(e, i) {
													newEdges[i] = {
														id : e.id,
														source : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.source;
																})[0],
														target : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.target;
																})[0]
													};

												});
										thisGraph.edges = newEdges;
										thisGraph.updateGraph();
										maxNode++;
										maxEdge++; // for the new ids to be unique
		<%}

			else {

				System.out.println("Failed to make connection!");

			}%>
			});

					// handle delete graph
					d3.select("#delete-graph").on("click", function() {
						thisGraph.deleteGraph(false);
					});
				};

				GraphCreator.prototype.setIdCt = function(idct) {
					this.idct = idct;
				};
				GraphCreator.prototype.setCdCt = function(cdct) {
					this.cdct = cdct;
				};
				GraphCreator.prototype.consts = {
					selectedClass : "selected",
					connectClass : "connect-node",
					circleGClass : "conceptG",
					graphClass : "graph",
					activeEditId : "active-editing",
					BACKSPACE_KEY : 8,
					DELETE_KEY : 46,
					ENTER_KEY : 13,
					nodeRadius : 10
				};

				/* PROTOTYPE FUNCTIONS */

				/*  GraphCreator.prototyragmove = function(d) {
					var thisGraph = this;
					if (thisGraph.state.shiftNodeDrag) {
						thisGraph.dragLine.attr('d', 'M' + d.x + ',' + d.y
								+ 'L' + d3.mouse(thisGraph.svgG.node())[0]
								+ ',' + d3.mouse(this.svgG.node())[1]);
					} else {
						d.x += d3.event.dx;
						d.y += d3.event.dy;
						thisGraph.updateGraph();
					}
				}; */

				GraphCreator.prototype.deleteGraph = function(skipPrompt) {
					var thisGraph = this, doDelete = true;
					if (!skipPrompt) {
						doDelete = window
								.confirm("Press OK to delete this graph");
					}
					if (doDelete) {
						thisGraph.nodes = [];
						thisGraph.edges = [];
						thisGraph.updateGraph();
					}
				};

				/* select all text in element: taken from http://stackoverflow.com/questions/6139107/programatically-select-text-in-a-contenteditable-html-element */
				GraphCreator.prototype.selectElementContents = function(el) {
					var range = document.createRange();
					range.selectNodeContents(el);
					var sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange(range);
				};

				/* insert svg line breaks: taken from http://stackoverflow.com/questions/13241475/how-do-i-include-newlines-in-labels-in-d3-charts */
				GraphCreator.prototype.insertTitleLinebreaks = function(gEl,
						title) {
					var words = title.split(/\s+/g), nwords = words.length;
					var el = gEl.append("text").attr("text-anchor", "middle")
							.attr("dy", "-" + (nwords - 1) * 7.5);

					for (var i = 0; i < words.length; i++) {
						var tspan = el.append('tspan').text(words[i]);
						if (i > 0)
							tspan.attr('x', 0).attr('dy', '15');
					}
				};

				// remove edges associated with a node
				GraphCreator.prototype.spliceLinksForNode = function(node) {
					var thisGraph = this, toSplice = thisGraph.edges
							.filter(function(l) {
								return (l.source === node || l.target === node);
							});
					toSplice.map(function(l) {
						thisGraph.edges.splice(thisGraph.edges.indexOf(l), 1);
					});
				};

				GraphCreator.prototype.replaceSelectEdge = function(d3Path,
						edgeData) {
					var thisGraph = this;
					d3Path.classed(thisGraph.consts.selectedClass, true);
					if (thisGraph.state.selectedEdge) {
						thisGraph.removeSelectFromEdge();
					}
					thisGraph.state.selectedEdge = edgeData;
				};

				GraphCreator.prototype.replaceSelectNode = function(d3Node,
						nodeData) {
					var thisGraph = this;
					d3Node.classed(this.consts.selectedClass, true);
					if (thisGraph.state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}
					thisGraph.state.selectedNode = nodeData;
				};

				GraphCreator.prototype.removeSelectFromNode = function() {
					var thisGraph = this;
					thisGraph.circles.filter(function(cd) {
						return cd.id === thisGraph.state.selectedNode.id;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedNode = null;
				};

				GraphCreator.prototype.removeSelectFromEdge = function() {
					var thisGraph = this;
					thisGraph.paths.filter(function(cd) {
						return cd === thisGraph.state.selectedEdge;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedEdge = null;
				};

				GraphCreator.prototype.pathMouseDown = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;

					if (state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}

					var prevEdge = state.selectedEdge;
					if (!prevEdge || prevEdge !== d) {
						thisGraph.replaceSelectEdge(d3path, d);
					} else {
						thisGraph.removeSelectFromEdge();
					}
				};

				// mousedoubleclick on edge
				GraphCreator.prototype.pathMouseClick = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;
					alert(d.id);
					edgeopen(d.id,d.source.id,d.target.id);
				};
				// mousedown on node
				GraphCreator.prototype.circleMouseDown = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownNode = d;
					if (d3.event.shiftKey) {
						state.shiftNodeDrag = d3.event.shiftKey;
						// reposition dragged directed edge
						thisGraph.dragLine.classed('hidden', false).attr('d',
								'M' + d.x + ',' + d.y + 'L' + d.x + ',' + d.y);
						return;
					}
				};

				// mousedoubleclick on node
				GraphCreator.prototype.circleMouseClick = function(d3node, d) {

					var thisGraph = this, state = thisGraph.state;

					d3.event.stopPropagation();
					state.mouseDownNode = d;
					nodeopen(d.id,d.x,d.y);

				};
				/* place editable text on node in place of svg text */
				GraphCreator.prototype.changeTextOfNode = function(d3node, d) {
					var thisGraph = this, consts = thisGraph.consts, htmlEl = d3node
							.node();
					d3node.selectAll("text").remove();
					var nodeBCR = htmlEl.getBoundingClientRect(), curScale = nodeBCR.width
							/ consts.nodeRadius, placePad = 5 * curScale, useHW = curScale > 1 ? nodeBCR.width * 0.71
							: consts.nodeRadius * 1.42;
					// replace with editableconent text
					var d3txt = thisGraph.svg
							.selectAll("foreignObject")
							.data([ d ])
							.enter()
							.append("foreignObject")
							.attr("x", nodeBCR.left + placePad)
							.attr("y", nodeBCR.top + placePad)
							.attr("height", 2 * useHW)
							.attr("width", useHW)
							.append("xhtml:p")
							.attr("id", consts.activeEditId)
							.attr("contentEditable", "true")
							.text(d.title)
							.on("mousedown", function(d) {
								d3.event.stopPropagation();
							})
							.on(
									"keydown",
									function(d) {
										d3.event.stopPropagation();
										if (d3.event.keyCode == consts.ENTER_KEY
												&& !d3.event.shiftKey) {
											this.blur();
										}
									}).on(
									"blur",
									function(d) {
										d.title = this.textContent;
										thisGraph.insertTitleLinebreaks(d3node,
												d.title);
										d3.select(this.parentElement).remove();
									});
					return d3txt;
				};

				// mouseup on nodes
				GraphCreator.prototype.circleMouseUp = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// reset the states
					state.shiftNodeDrag = false;
					d3node.classed(consts.connectClass, false);

					var mouseDownNode = state.mouseDownNode;

					if (!mouseDownNode)
						return;

					thisGraph.dragLine.classed("hidden", true);

					if (mouseDownNode !== d) {
						// we're in a different node: create new edge for mousedown edge and add to graph
						var newEdge = {
							id : "path_1" + "_"
									+ ( maxEdge +thisGraph.cdct++),
							source : mouseDownNode,
							target : d
						};
						var filtRes = thisGraph.paths.filter(function(d) {
							if (d.source === newEdge.target
									&& d.target === newEdge.source) {
								thisGraph.edges.splice(thisGraph.edges
										.indexOf(d), 1);
							}
							return d.source === newEdge.source
									&& d.target === newEdge.target;
						});
						if (!filtRes[0].length) {
							thisGraph.edges.push(newEdge);
							thisGraph.updateGraph();
						}
					} else {
						// we're in the same node
						if (state.justDragged) {
							// dragged, not clicked
							state.justDragged = false;
						} else {
							// clicked, not dragged
							if (d3.event.shiftKey) {
								// shift-clicked node: edit text content
								var d3txt = thisGraph.changeTextOfNode(d3node,
										d);
								var txtNode = d3txt.node();
								thisGraph.selectElementContents(txtNode);
								txtNode.focus();
							} else {
								if (state.selectedEdge) {
									thisGraph.removeSelectFromEdge();
								}
								var prevNode = state.selectedNode;

								if (!prevNode || prevNode.id !== d.id) {
									thisGraph.replaceSelectNode(d3node, d);
								} else {
									thisGraph.removeSelectFromNode();
								}
							}
						}
					}
					state.mouseDownNode = null;
					return;

				}; // end of circles mouseup

				// mousedown on main svg
				GraphCreator.prototype.svgMouseDown = function() {
					this.state.graphMouseDown = true;
				};

				// mouseup on main svg
				GraphCreator.prototype.svgMouseUp = function() {
					var thisGraph = this, state = thisGraph.state;
					if (state.justScaleTransGraph) {
						// dragged not clicked
						state.justScaleTransGraph = false;
					} else if (state.graphMouseDown && d3.event.shiftKey) {
						// clicked not dragged from svg
						alert("hihi")
						var xycoords = d3.mouse(thisGraph.svgG.node()), d = {
							id : "node_1"
								
								+ "_" + (maxNode +thisGraph.idct++),
							title : "",
							x : xycoords[0],
							y : xycoords[1]
						};
						thisGraph.nodes.push(d);
						thisGraph.updateGraph();
						// make title of text immediently editable
						var d3txt = thisGraph.changeTextOfNode(
								thisGraph.circles.filter(function(dval) {
									return dval.id === d.id;
								}), d), txtNode = d3txt.node();
						thisGraph.selectElementContents(txtNode);
						txtNode.focus();
					} else if (state.shiftNodeDrag) {
						// dragged from node
						state.shiftNodeDrag = false;
						thisGraph.dragLine.classed("hidden", true);
					}
					state.graphMouseDown = false;
				};

				// keydown on main svg
				GraphCreator.prototype.svgKeyDown = function() {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// make sure repeated key presses don't register for each keydown
					if (state.lastKeyDown !== -1)
						return;

					state.lastKeyDown = d3.event.keyCode;
					var selectedNode = state.selectedNode, selectedEdge = state.selectedEdge;

					switch (d3.event.keyCode) {
					case consts.BACKSPACE_KEY:
					case consts.DELETE_KEY:
						d3.event.preventDefault();
						if (selectedNode) {
							my_id = thisGraph.nodes[thisGraph.nodes
									.indexOf(selectedNode)].id;
							delOpen();
							thisGraph.nodes.splice(thisGraph.nodes
									.indexOf(selectedNode), 1);
							thisGraph.spliceLinksForNode(selectedNode);
							state.selectedNode = null;
							thisGraph.updateGraph();
						} else if (selectedEdge) {
							my_id = thisGraph.edges[thisGraph.edges
									.indexOf(selectedEdge)].id;
							dellOpen();
							thisGraph.edges.splice(thisGraph.edges
									.indexOf(selectedEdge), 1);
							state.selectedEdge = null;
							thisGraph.updateGraph();
						}
						break;
					}
				};

				GraphCreator.prototype.svgKeyUp = function() {
					this.state.lastKeyDown = -1;
				};

				// call to propagate changes to graph
				GraphCreator.prototype.updateGraph = function() {

					var thisGraph = this, consts = thisGraph.consts, state = thisGraph.state;

					thisGraph.paths = thisGraph.paths.data(thisGraph.edges,
							function(d) {
								return String(d.source.id) + "+"
										+ String(d.target.id);
							});
					var paths = thisGraph.paths;
					// update existing paths
					paths.style('marker-end', 'url(#end-arrow)').classed(
							consts.selectedClass, function(d) {
								return d === state.selectedEdge;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							});

					// add new paths
					paths.enter().append("path").style('marker-end',
							'url(#end-arrow)').classed("link", true).attr("id",
							function(d, i) {
								return d.id;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							}).on(
							"mousedown",
							function(d) {
								thisGraph.pathMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {
								thisGraph.pathMouseClick.call(thisGraph, d3
										.select(this), d);

								;
							}).on("mouseup", function(d) {
						state.mouseDownLink = null;
					});

					// remove old links
					paths.exit().remove();

					// update existing nodes
					thisGraph.circles = thisGraph.circles.data(thisGraph.nodes,
							function(d) {
								return d.id;
							});
					thisGraph.circles.attr("transform", function(d) {
						return "translate(" + d.x + "," + d.y + ")";
					});

					// add new nodes
					var newGs = thisGraph.circles.enter().append("g");

					newGs.classed(consts.circleGClass, true).attr("transform",
							function(d) {
								return "translate(" + d.x + "," + d.y + ")";
							}).on("mouseover", function(d) {
						if (state.shiftNodeDrag) {
							d3.select(this).classed(consts.connectClass, true);
						}
					}).on("mouseout", function(d) {
						d3.select(this).classed(consts.connectClass, false);
					}).on(
							"mousedown",
							function(d) {
								
								thisGraph.circleMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"mouseup",
							function(d) {
								thisGraph.circleMouseUp.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {

								thisGraph.circleMouseClick.call(thisGraph, d3
										.select(this), d);

							}).call(thisGraph.drag);

					newGs
							.append("circle")
							.attr("r", String(consts.nodeRadius))
							.attr(
									"id",
									function(d, i) {
										return "node_1"
												
												+ "_" + (maxNode++);
									});

					newGs.each(function(d) {
						thisGraph.insertTitleLinebreaks(d3.select(this),
								d.title);
					});

					// remove old nodes
					thisGraph.circles.exit().remove();
				};

				/* GraphCreator.prototype.zoomed = function() {
				this.state.justScaleTransGraph = true;
				d3.select("." + this.consts.graphClass).attr(
						"transform",
						"translate(" + d3.event.translate + ") scale("
								+ d3.event.scale + ")");
				}; */

				GraphCreator.prototype.updateWindow = function(svg) {
					var docEl = document.documentElement, bodyEl = document
							.getElementsByTagName('body')[0];
					var x = window.innerWidth || docEl.clientWidth
							|| bodyEl.clientWidth;
					var y = window.innerHeight || docEl.clientHeight
							|| bodyEl.clientHeight;
					svg.attr("width", x).attr("height", y);
				};

				/**** MAIN ****/

				// warn the user when leaving
				window.onbeforeunload = function() {
					return "Make sure to save your graph locally before leaving :-)";
				};

				var docEl = document.documentElement, bodyEl = document
						.getElementsByTagName('body')[0];

				var width = window.innerWidth || docEl.clientWidth
						|| bodyEl.clientWidth, height = window.innerHeight
						|| docEl.clientHeight || bodyEl.clientHeight;

				var xLoc = width / 2 - 25, yLoc = 100;

				// initial node data
				var nodes = [];
				var edges = [];

				/** MAIN SVG **/
				var svg = d3.select("#plan1").append("svg").attr("width", width)
						.attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
		</script>
	</div>


	<div id="plan2" style="width: 700px; margin: 0 auto;">
		<script src="//d3js.org/d3.v3.js" charset="utf-8"></script>
		<script src="//cdn.jsdelivr.net/filesaver.js/0.1/FileSaver.min.js"></script>
		<script>
			document.onload = (function(d3, saveAs, Blob, undefined) {
				"use strict";

				// define graphcreator object
				var GraphCreator = function(svg, nodes, edges) {
					var thisGraph = this;
					thisGraph.idct = 0;thisGraph.cdct = 0;

					thisGraph.nodes = nodes || [];
					thisGraph.edges = edges || [];

					thisGraph.state = {
						selectedNode : null,
						selectedEdge : null,
						mouseDownNode : null,
						mouseDownLink : null,
						justDragged : false,
						justScaleTransGraph : false,
						lastKeyDown : -1,
						shiftNodeDrag : false,
						selectedText : null
					};

					// define arrow markers for graph links
					var defs = svg.append('svg:defs');
					defs.append('svg:marker').attr('id', 'end-arrow').attr(
							'viewBox', '0 0 0 0').attr('refX', "0").attr(
							'markerWidth', 0).attr('markerHeight', 0).attr(
							'orient', 'auto').append('svg:path').attr('d',
							'M0,0');

					// define arrow markers for leading arrow
					defs.append('svg:marker').attr('id', 'mark-end-arrow')
							.attr('viewBox', '0 0 00 00').attr('refX', 0).attr(
									'markerWidth', 0).attr('markerHeight', 0)
							.attr('orient', 'auto').append('svg:path').attr(
									'd', 'M0,00');

					thisGraph.svg = svg;
					thisGraph.svgG = svg.append("g").classed(
							thisGraph.consts.graphClass, true);
					var svgG = thisGraph.svgG;

					// displayed when dragging between nodes
					thisGraph.dragLine = svgG.append('svg:path').attr('class',
							'link dragline hidden').attr('d', 'M0,0L0,0')
							.style('marker-end', 'url(#mark-end-arrow)');

					// svg nodes and edges 
					thisGraph.paths = svgG.append("g").selectAll("g");
					thisGraph.circles = svgG.append("g").selectAll("g");

					thisGraph.drag = d3.behavior.drag().origin(function(d) {
						return {
							x : d.x,
							y : d.y
						};
					}).on("drag", function(args) {
						thisGraph.state.justDragged = true;
						thisGraph.dragmove.call(thisGraph, args);
					}).on("dragend", function() {
						// todo check if edge-mode is selected
					});

					// listen for key events
					d3.select(window).on("keydown", function() {
						thisGraph.svgKeyDown.call(thisGraph);
					}).on("keyup", function() {
						thisGraph.svgKeyUp.call(thisGraph);
					});
					svg.on("mousedown", function(d) {
						thisGraph.svgMouseDown.call(thisGraph, d);
					});
					svg.on("mouseup", function(d) {
						thisGraph.svgMouseUp.call(thisGraph, d);
					});

					// listen for dragging
					var dragSvg = d3.behavior.zoom().on("zoom", function() {
						if (d3.event.sourceEvent.shiftKey) {
							// TODO  the internal d3 state is still changing
							return false;
						} else {
							thisGraph.zoomed.call(thisGraph);
						}
						return true;
					}).on(
							"zoomstart",
							function() {
								var ael = d3.select(
										"#" + thisGraph.consts.activeEditId)
										.node();
								if (ael) {
									ael.blur();
								}
								if (!d3.event.sourceEvent.shiftKey)
									d3.select('body').style("cursor", "move");
							}).on("zoomend", function() {
						d3.select('body').style("cursor", "auto");
					});

					svg.call(dragSvg).on("dblclick.zoom", null);

					// listen for resize
					window.onresize = function() {
						thisGraph.updateWindow(svg);
					};

					

					
															// handle uploaded data

					d3
							.select("#upload-input2")
							.on(
									"click",
									function() {
										
										thisGraph.deleteGraph(true);
										
		<%try {

				Class.forName("org.postgresql.Driver");

			} catch (ClassNotFoundException e) {

				System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
				e.printStackTrace();
				return;

			}

			System.out.println("PostgreSQL JDBC Driver Registered!");

			java.sql.Connection connection2 = null;

			try {

				connection2 = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}

			if (connection2 != null) {

				Statement s2 = connection2.createStatement();
				ResultSet rs2 = null, ry2 = null;
				String q1 = "Select * from node where building_name = 'lib' and floor = 2";/* session.getAttribute("building_name") */

				// add floor number also in the query

				rs2 = (s2.executeQuery(q1));
				String q2 = "Select * from edge where building_name = 'lib' and floor = 2";/* session.getAttribute("building_name") */

				// add floorr number also in the query

				while (rs2.next()) {
					String id = rs2.getString("node_id");
					String x = rs2.getString("latitude");
					String y = rs2.getString("longitude");
					System.out.println(id + " " + x + " " + y);%>
					
				
			                           var idd =		"<%=id%>";
										var xx =		"<%=x%>";
										var yy =		"<%=y%>";
var ut  = idd.substr(idd.lastIndexOf("_")+1);
							//	alert(ut);
								if(ut > maxNode) maxNode = ut ;
								
									//	alert(idd + " " + xx + " " + yy);

										thisGraph.setIdCt(thisGraph.idct++);
										thisGraph.nodes.push({
											"id" : idd,
											"title" : "",
											"x" : xx,
											"y" : yy
										});
										thisGraph.updateGraph();
		<%}%>
				    
				   d3.selectAll('circle').attr("id",function(d){return d.id;});
				
					var newEdges = [];
				<%ry2 = (s2.executeQuery(q2));

				while (ry2.next()) {
					String eid = ry2.getString("edge_id");
					String ex = ry2.getString("start_node");
					String ey = ry2.getString("end_node");
					//System.out.println(eid + " " + ex + " " + ey);%>
					
				
			                           var iidd =		"<%=eid%>";
										var exx =		"<%=ex%>";
										var eyy =		"<%=ey%>";

										//	alert(iidd + " " + exx + " " + eyy);
										var ut = iidd.substr(iidd
												.lastIndexOf("_") + 1);
										//alert(ut);
										if (ut > maxEdge)
											maxEdge = ut;

										newEdges.push({
											"id" : iidd,
											"source" : exx,
											"target" : eyy
										});
		<%}%>
			newEdges
												.forEach(function(e, i) {
													newEdges[i] = {
														id : e.id,
														source : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.source;
																})[0],
														target : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.target;
																})[0]
													};

												});
										thisGraph.edges = newEdges;
										thisGraph.updateGraph();
										maxNode++;
										maxEdge++; // for the new ids to be unique
		<%}

			else {

				System.out.println("Failed to make connection!");

			}%>
			});

					// handle delete graph
					d3.select("#delete-graph").on("click", function() {
						thisGraph.deleteGraph(false);
					});
				};

				GraphCreator.prototype.setIdCt = function(idct) {
					this.idct = idct;
				};
				GraphCreator.prototype.setCdCt = function(cdct) {
					this.cdct = cdct;
				};
				GraphCreator.prototype.consts = {
					selectedClass : "selected",
					connectClass : "connect-node",
					circleGClass : "conceptG",
					graphClass : "graph",
					activeEditId : "active-editing",
					BACKSPACE_KEY : 8,
					DELETE_KEY : 46,
					ENTER_KEY : 13,
					nodeRadius : 10
				};

				/* PROTOTYPE FUNCTIONS */

				/*  GraphCreator.prototyragmove = function(d) {
					var thisGraph = this;
					if (thisGraph.state.shiftNodeDrag) {
						thisGraph.dragLine.attr('d', 'M' + d.x + ',' + d.y
								+ 'L' + d3.mouse(thisGraph.svgG.node())[0]
								+ ',' + d3.mouse(this.svgG.node())[1]);
					} else {
						d.x += d3.event.dx;
						d.y += d3.event.dy;
						thisGraph.updateGraph();
					}
				}; */

				GraphCreator.prototype.deleteGraph = function(skipPrompt) {
					var thisGraph = this, doDelete = true;
					if (!skipPrompt) {
						doDelete = window
								.confirm("Press OK to delete this graph");
					}
					if (doDelete) {
						thisGraph.nodes = [];
						thisGraph.edges = [];
						thisGraph.updateGraph();
					}
				};

				/* select all text in element: taken from http://stackoverflow.com/questions/6139107/programatically-select-text-in-a-contenteditable-html-element */
				GraphCreator.prototype.selectElementContents = function(el) {
					var range = document.createRange();
					range.selectNodeContents(el);
					var sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange(range);
				};

				/* insert svg line breaks: taken from http://stackoverflow.com/questions/13241475/how-do-i-include-newlines-in-labels-in-d3-charts */
				GraphCreator.prototype.insertTitleLinebreaks = function(gEl,
						title) {
					var words = title.split(/\s+/g), nwords = words.length;
					var el = gEl.append("text").attr("text-anchor", "middle")
							.attr("dy", "-" + (nwords - 1) * 7.5);

					for (var i = 0; i < words.length; i++) {
						var tspan = el.append('tspan').text(words[i]);
						if (i > 0)
							tspan.attr('x', 0).attr('dy', '15');
					}
				};

				// remove edges associated with a node
				GraphCreator.prototype.spliceLinksForNode = function(node) {
					var thisGraph = this, toSplice = thisGraph.edges
							.filter(function(l) {
								return (l.source === node || l.target === node);
							});
					toSplice.map(function(l) {
						thisGraph.edges.splice(thisGraph.edges.indexOf(l), 1);
					});
				};

				GraphCreator.prototype.replaceSelectEdge = function(d3Path,
						edgeData) {
					var thisGraph = this;
					d3Path.classed(thisGraph.consts.selectedClass, true);
					if (thisGraph.state.selectedEdge) {
						thisGraph.removeSelectFromEdge();
					}
					thisGraph.state.selectedEdge = edgeData;
				};

				GraphCreator.prototype.replaceSelectNode = function(d3Node,
						nodeData) {
					var thisGraph = this;
					d3Node.classed(this.consts.selectedClass, true);
					if (thisGraph.state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}
					thisGraph.state.selectedNode = nodeData;
				};

				GraphCreator.prototype.removeSelectFromNode = function() {
					var thisGraph = this;
					thisGraph.circles.filter(function(cd) {
						return cd.id === thisGraph.state.selectedNode.id;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedNode = null;
				};

				GraphCreator.prototype.removeSelectFromEdge = function() {
					var thisGraph = this;
					thisGraph.paths.filter(function(cd) {
						return cd === thisGraph.state.selectedEdge;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedEdge = null;
				};

				GraphCreator.prototype.pathMouseDown = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;

					if (state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}

					var prevEdge = state.selectedEdge;
					if (!prevEdge || prevEdge !== d) {
						thisGraph.replaceSelectEdge(d3path, d);
					} else {
						thisGraph.removeSelectFromEdge();
					}
				};

				// mousedoubleclick on edge
				GraphCreator.prototype.pathMouseClick = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;
					edgeopen(d.id,d.source.id,d.target.id);
				};
				// mousedown on node
				GraphCreator.prototype.circleMouseDown = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownNode = d;
					if (d3.event.shiftKey) {
						state.shiftNodeDrag = d3.event.shiftKey;
						// reposition dragged directed edge
						thisGraph.dragLine.classed('hidden', false).attr('d',
								'M' + d.x + ',' + d.y + 'L' + d.x + ',' + d.y);
						return;
					}
				};

				// mousedoubleclick on node
				GraphCreator.prototype.circleMouseClick = function(d3node, d) {

					var thisGraph = this, state = thisGraph.state;

					d3.event.stopPropagation();
					state.mouseDownNode = d;
					nodeopen(d.id,d.x,d.y);

				};
				/* place editable text on node in place of svg text */
				GraphCreator.prototype.changeTextOfNode = function(d3node, d) {
					var thisGraph = this, consts = thisGraph.consts, htmlEl = d3node
							.node();
					d3node.selectAll("text").remove();
					var nodeBCR = htmlEl.getBoundingClientRect(), curScale = nodeBCR.width
							/ consts.nodeRadius, placePad = 5 * curScale, useHW = curScale > 1 ? nodeBCR.width * 0.71
							: consts.nodeRadius * 1.42;
					// replace with editableconent text
					var d3txt = thisGraph.svg
							.selectAll("foreignObject")
							.data([ d ])
							.enter()
							.append("foreignObject")
							.attr("x", nodeBCR.left + placePad)
							.attr("y", nodeBCR.top + placePad)
							.attr("height", 2 * useHW)
							.attr("width", useHW)
							.append("xhtml:p")
							.attr("id", consts.activeEditId)
							.attr("contentEditable", "true")
							.text(d.title)
							.on("mousedown", function(d) {
								d3.event.stopPropagation();
							})
							.on(
									"keydown",
									function(d) {
										d3.event.stopPropagation();
										if (d3.event.keyCode == consts.ENTER_KEY
												&& !d3.event.shiftKey) {
											this.blur();
										}
									}).on(
									"blur",
									function(d) {
										d.title = this.textContent;
										thisGraph.insertTitleLinebreaks(d3node,
												d.title);
										d3.select(this.parentElement).remove();
									});
					return d3txt;
				};

				// mouseup on nodes
				GraphCreator.prototype.circleMouseUp = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// reset the states
					state.shiftNodeDrag = false;
					d3node.classed(consts.connectClass, false);

					var mouseDownNode = state.mouseDownNode;

					if (!mouseDownNode)
						return;

					thisGraph.dragLine.classed("hidden", true);

					if (mouseDownNode !== d) {
						// we're in a different node: create new edge for mousedown edge and add to graph
						var newEdge = {
							id : "path_2"+ "_"
									+ ( maxEdge +thisGraph.cdct++),
							source : mouseDownNode,
							target : d
						};
						var filtRes = thisGraph.paths.filter(function(d) {
							if (d.source === newEdge.target
									&& d.target === newEdge.source) {
								thisGraph.edges.splice(thisGraph.edges
										.indexOf(d), 1);
							}
							return d.source === newEdge.source
									&& d.target === newEdge.target;
						});
						if (!filtRes[0].length) {
							thisGraph.edges.push(newEdge);
							thisGraph.updateGraph();
						}
					} else {
						// we're in the same node
						if (state.justDragged) {
							// dragged, not clicked
							state.justDragged = false;
						} else {
							// clicked, not dragged
							if (d3.event.shiftKey) {
								// shift-clicked node: edit text content
								var d3txt = thisGraph.changeTextOfNode(d3node,
										d);
								var txtNode = d3txt.node();
								thisGraph.selectElementContents(txtNode);
								txtNode.focus();
							} else {
								if (state.selectedEdge) {
									thisGraph.removeSelectFromEdge();
								}
								var prevNode = state.selectedNode;

								if (!prevNode || prevNode.id !== d.id) {
									thisGraph.replaceSelectNode(d3node, d);
								} else {
									thisGraph.removeSelectFromNode();
								}
							}
						}
					}
					state.mouseDownNode = null;
					return;

				}; // end of circles mouseup

				// mousedown on main svg
				GraphCreator.prototype.svgMouseDown = function() {
					this.state.graphMouseDown = true;
				};

				// mouseup on main svg
				GraphCreator.prototype.svgMouseUp = function() {
					var thisGraph = this, state = thisGraph.state;
					if (state.justScaleTransGraph) {
						// dragged not clicked
						state.justScaleTransGraph = false;
					} else if (state.graphMouseDown && d3.event.shiftKey) {
						// clicked not dragged from svg
						alert("hihi")
						var xycoords = d3.mouse(thisGraph.svgG.node()), d = {
							id : "node_2"
								
								+ "_" + (maxNode +thisGraph.idct++),
							title : "",
							x : xycoords[0],
							y : xycoords[1]
						};
						thisGraph.nodes.push(d);
						thisGraph.updateGraph();
						// make title of text immediently editable
						var d3txt = thisGraph.changeTextOfNode(
								thisGraph.circles.filter(function(dval) {
									return dval.id === d.id;
								}), d), txtNode = d3txt.node();
						thisGraph.selectElementContents(txtNode);
						txtNode.focus();
					} else if (state.shiftNodeDrag) {
						// dragged from node
						state.shiftNodeDrag = false;
						thisGraph.dragLine.classed("hidden", true);
					}
					state.graphMouseDown = false;
				};

				// keydown on main svg
				GraphCreator.prototype.svgKeyDown = function() {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// make sure repeated key presses don't register for each keydown
					if (state.lastKeyDown !== -1)
						return;

					state.lastKeyDown = d3.event.keyCode;
					var selectedNode = state.selectedNode, selectedEdge = state.selectedEdge;

					switch (d3.event.keyCode) {
					case consts.BACKSPACE_KEY:
					case consts.DELETE_KEY:
						d3.event.preventDefault();
						if (selectedNode) {
							my_id = thisGraph.nodes[thisGraph.nodes
									.indexOf(selectedNode)].id;
							delOpen();
							thisGraph.nodes.splice(thisGraph.nodes
									.indexOf(selectedNode), 1);
							thisGraph.spliceLinksForNode(selectedNode);
							state.selectedNode = null;
							thisGraph.updateGraph();
						} else if (selectedEdge) {
							my_id = thisGraph.edges[thisGraph.edges
									.indexOf(selectedEdge)].id;
							dellOpen();
							thisGraph.edges.splice(thisGraph.edges
									.indexOf(selectedEdge), 1);
							state.selectedEdge = null;
							thisGraph.updateGraph();
						}
						break;
					}
				};

				GraphCreator.prototype.svgKeyUp = function() {
					this.state.lastKeyDown = -1;
				};

				// call to propagate changes to graph
				GraphCreator.prototype.updateGraph = function() {

					var thisGraph = this, consts = thisGraph.consts, state = thisGraph.state;

					thisGraph.paths = thisGraph.paths.data(thisGraph.edges,
							function(d) {
								return String(d.source.id) + "+"
										+ String(d.target.id);
							});
					var paths = thisGraph.paths;
					// update existing paths
					paths.style('marker-end', 'url(#end-arrow)').classed(
							consts.selectedClass, function(d) {
								return d === state.selectedEdge;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							});

					// add new paths
					paths.enter().append("path").style('marker-end',
							'url(#end-arrow)').classed("link", true).attr("id",
							function(d, i) {
								return d.id;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							}).on(
							"mousedown",
							function(d) {
								thisGraph.pathMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {
								thisGraph.pathMouseClick.call(thisGraph, d3
										.select(this), d);

								;
							}).on("mouseup", function(d) {
						state.mouseDownLink = null;
					});

					// remove old links
					paths.exit().remove();

					// update existing nodes
					thisGraph.circles = thisGraph.circles.data(thisGraph.nodes,
							function(d) {
								return d.id;
							});
					thisGraph.circles.attr("transform", function(d) {
						return "translate(" + d.x + "," + d.y + ")";
					});

					// add new nodes
					var newGs = thisGraph.circles.enter().append("g");

					newGs.classed(consts.circleGClass, true).attr("transform",
							function(d) {
								return "translate(" + d.x + "," + d.y + ")";
							}).on("mouseover", function(d) {
						if (state.shiftNodeDrag) {
							d3.select(this).classed(consts.connectClass, true);
						}
					}).on("mouseout", function(d) {
						d3.select(this).classed(consts.connectClass, false);
					}).on(
							"mousedown",
							function(d) {
								
								thisGraph.circleMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"mouseup",
							function(d) {
								thisGraph.circleMouseUp.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {

								thisGraph.circleMouseClick.call(thisGraph, d3
										.select(this), d);

							}).call(thisGraph.drag);

					newGs
							.append("circle")
							.attr("r", String(consts.nodeRadius))
							.attr(
									"id",
									function(d, i) {
										return "node_2"
												
												+ "_" + (maxNode++);
									});

					newGs.each(function(d) {
						thisGraph.insertTitleLinebreaks(d3.select(this),
								d.title);
					});

					// remove old nodes
					thisGraph.circles.exit().remove();
				};

				/* GraphCreator.prototype.zoomed = function() {
				this.state.justScaleTransGraph = true;
				d3.select("." + this.consts.graphClass).attr(
						"transform",
						"translate(" + d3.event.translate + ") scale("
								+ d3.event.scale + ")");
				}; */

				GraphCreator.prototype.updateWindow = function(svg) {
					var docEl = document.documentElement, bodyEl = document
							.getElementsByTagName('body')[0];
					var x = window.innerWidth || docEl.clientWidth
							|| bodyEl.clientWidth;
					var y = window.innerHeight || docEl.clientHeight
							|| bodyEl.clientHeight;
					svg.attr("width", x).attr("height", y);
				};

				/**** MAIN ****/

				// warn the user when leaving
				window.onbeforeunload = function() {
					return "Make sure to save your graph locally before leaving :-)";
				};

				var docEl = document.documentElement, bodyEl = document
						.getElementsByTagName('body')[0];

				var width = window.innerWidth || docEl.clientWidth
						|| bodyEl.clientWidth, height = window.innerHeight
						|| docEl.clientHeight || bodyEl.clientHeight;

				var xLoc = width / 2 - 25, yLoc = 100;

				// initial node data
				var nodes = [];
				var edges = [];

				/** MAIN SVG **/
				var svg = d3.select("#plan2").append("svg").attr("width", width)
						.attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
		</script>
	</div>


	<div id="plan3" style="width: 700px; margin: 0 auto;">
		<script src="//d3js.org/d3.v3.js" charset="utf-8"></script>
		<script src="//cdn.jsdelivr.net/filesaver.js/0.1/FileSaver.min.js"></script>
		<script>
			document.onload = (function(d3, saveAs, Blob, undefined) {
				"use strict";

				// define graphcreator object
				var GraphCreator = function(svg, nodes, edges) {
					var thisGraph = this;
					thisGraph.idct = 0;thisGraph.cdct = 0;

					thisGraph.nodes = nodes || [];
					thisGraph.edges = edges || [];

					thisGraph.state = {
						selectedNode : null,
						selectedEdge : null,
						mouseDownNode : null,
						mouseDownLink : null,
						justDragged : false,
						justScaleTransGraph : false,
						lastKeyDown : -1,
						shiftNodeDrag : false,
						selectedText : null
					};

					// define arrow markers for graph links
					var defs = svg.append('svg:defs');
					defs.append('svg:marker').attr('id', 'end-arrow').attr(
							'viewBox', '0 0 0 0').attr('refX', "0").attr(
							'markerWidth', 0).attr('markerHeight', 0).attr(
							'orient', 'auto').append('svg:path').attr('d',
							'M0,0');

					// define arrow markers for leading arrow
					defs.append('svg:marker').attr('id', 'mark-end-arrow')
							.attr('viewBox', '0 0 00 00').attr('refX', 0).attr(
									'markerWidth', 0).attr('markerHeight', 0)
							.attr('orient', 'auto').append('svg:path').attr(
									'd', 'M0,00');

					thisGraph.svg = svg;
					thisGraph.svgG = svg.append("g").classed(
							thisGraph.consts.graphClass, true);
					var svgG = thisGraph.svgG;

					// displayed when dragging between nodes
					thisGraph.dragLine = svgG.append('svg:path').attr('class',
							'link dragline hidden').attr('d', 'M0,0L0,0')
							.style('marker-end', 'url(#mark-end-arrow)');

					// svg nodes and edges 
					thisGraph.paths = svgG.append("g").selectAll("g");
					thisGraph.circles = svgG.append("g").selectAll("g");

					thisGraph.drag = d3.behavior.drag().origin(function(d) {
						return {
							x : d.x,
							y : d.y
						};
					}).on("drag", function(args) {
						thisGraph.state.justDragged = true;
						thisGraph.dragmove.call(thisGraph, args);
					}).on("dragend", function() {
						// todo check if edge-mode is selected
					});

					// listen for key events
					d3.select(window).on("keydown", function() {
						thisGraph.svgKeyDown.call(thisGraph);
					}).on("keyup", function() {
						thisGraph.svgKeyUp.call(thisGraph);
					});
					svg.on("mousedown", function(d) {
						thisGraph.svgMouseDown.call(thisGraph, d);
					});
					svg.on("mouseup", function(d) {
						thisGraph.svgMouseUp.call(thisGraph, d);
					});

					// listen for dragging
					var dragSvg = d3.behavior.zoom().on("zoom", function() {
						if (d3.event.sourceEvent.shiftKey) {
							// TODO  the internal d3 state is still changing
							return false;
						} else {
							thisGraph.zoomed.call(thisGraph);
						}
						return true;
					}).on(
							"zoomstart",
							function() {
								var ael = d3.select(
										"#" + thisGraph.consts.activeEditId)
										.node();
								if (ael) {
									ael.blur();
								}
								if (!d3.event.sourceEvent.shiftKey)
									d3.select('body').style("cursor", "move");
							}).on("zoomend", function() {
						d3.select('body').style("cursor", "auto");
					});

					svg.call(dragSvg).on("dblclick.zoom", null);

					// listen for resize
					window.onresize = function() {
						thisGraph.updateWindow(svg);
					};

					

					
															// handle uploaded data

					d3
							.select("#upload-input3")
							.on(
									"click",
									function() {
										
										thisGraph.deleteGraph(true);
										
		<%try {

				Class.forName("org.postgresql.Driver");

			} catch (ClassNotFoundException e) {

				System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
				e.printStackTrace();
				return;

			}

			System.out.println("PostgreSQL JDBC Driver Registered!");

			java.sql.Connection connection3 = null;

			try {

				connection3 = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}

			if (connection3 != null) {

				Statement s3 = connection3.createStatement();
				ResultSet rs3 = null, ry3 = null;
				String q1 = "Select * from node where building_name = 'lib' and floor = 3";/* session.getAttribute("building_name") */

				// add floor number also in the query

				rs3 = (s3.executeQuery(q1));
				String q2 = "Select * from edge where building_name = 'lib' and floor = 3";/* session.getAttribute("building_name") */

				// add floorr number also in the query

				while (rs3.next()) {
					String id = rs3.getString("node_id");
					String x = rs3.getString("latitude");
					String y = rs3.getString("longitude");
					System.out.println(id + " " + x + " " + y);%>
					
				
			                           var idd =		"<%=id%>";
										var xx =		"<%=x%>";
										var yy =		"<%=y%>";
var ut  = idd.substr(idd.lastIndexOf("_")+1);
							//	alert(ut);
								if(ut > maxNode) maxNode = ut ;
								
									//	alert(idd + " " + xx + " " + yy);

										thisGraph.setIdCt(thisGraph.idct++);
										thisGraph.nodes.push({
											"id" : idd,
											"title" : "",
											"x" : xx,
											"y" : yy
										});
										thisGraph.updateGraph();
		<%}%>
				    
				   d3.selectAll('circle').attr("id",function(d){return d.id;});
				
					var newEdges = [];
				<%ry3 = (s3.executeQuery(q2));

				while (ry3.next()) {
					String eid = ry3.getString("edge_id");
					String ex = ry3.getString("start_node");
					String ey = ry3.getString("end_node");
					//System.out.println(eid + " " + ex + " " + ey);%>
					
				
			                           var iidd =		"<%=eid%>";
										var exx =		"<%=ex%>";
										var eyy =		"<%=ey%>";

									//alert(iidd + " " + exx + " " + eyy);
										var ut = iidd.substr(iidd
												.lastIndexOf("_") + 1);
										//alert(ut);
										if (ut > maxEdge)
											maxEdge = ut;

										newEdges.push({
											"id" : iidd,
											"source" : exx,
											"target" : eyy
										});
		<%}%>
			newEdges
												.forEach(function(e, i) {
													newEdges[i] = {
														id : e.id,
														source : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.source;
																})[0],
														target : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.target;
																})[0]
													};

												});
										thisGraph.edges = newEdges;
										thisGraph.updateGraph();
										maxNode++;
										maxEdge++; // for the new ids to be unique
		<%}

			else {

				System.out.println("Failed to make connection!");

			}%>
			});

					// handle delete graph
					d3.select("#delete-graph").on("click", function() {
						thisGraph.deleteGraph(false);
					});
				};

				GraphCreator.prototype.setIdCt = function(idct) {
					this.idct = idct;
				};
				GraphCreator.prototype.setCdCt = function(cdct) {
					this.cdct = cdct;
				};
				GraphCreator.prototype.consts = {
					selectedClass : "selected",
					connectClass : "connect-node",
					circleGClass : "conceptG",
					graphClass : "graph",
					activeEditId : "active-editing",
					BACKSPACE_KEY : 8,
					DELETE_KEY : 46,
					ENTER_KEY : 13,
					nodeRadius : 10
				};

				/* PROTOTYPE FUNCTIONS */

				/*  GraphCreator.prototyragmove = function(d) {
					var thisGraph = this;
					if (thisGraph.state.shiftNodeDrag) {
						thisGraph.dragLine.attr('d', 'M' + d.x + ',' + d.y
								+ 'L' + d3.mouse(thisGraph.svgG.node())[0]
								+ ',' + d3.mouse(this.svgG.node())[1]);
					} else {
						d.x += d3.event.dx;
						d.y += d3.event.dy;
						thisGraph.updateGraph();
					}
				}; */

				GraphCreator.prototype.deleteGraph = function(skipPrompt) {
					var thisGraph = this, doDelete = true;
					if (!skipPrompt) {
						doDelete = window
								.confirm("Press OK to delete this graph");
					}
					if (doDelete) {
						thisGraph.nodes = [];
						thisGraph.edges = [];
						thisGraph.updateGraph();
					}
				};

				/* select all text in element: taken from http://stackoverflow.com/questions/6139107/programatically-select-text-in-a-contenteditable-html-element */
				GraphCreator.prototype.selectElementContents = function(el) {
					var range = document.createRange();
					range.selectNodeContents(el);
					var sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange(range);
				};

				/* insert svg line breaks: taken from http://stackoverflow.com/questions/13241475/how-do-i-include-newlines-in-labels-in-d3-charts */
				GraphCreator.prototype.insertTitleLinebreaks = function(gEl,
						title) {
					var words = title.split(/\s+/g), nwords = words.length;
					var el = gEl.append("text").attr("text-anchor", "middle")
							.attr("dy", "-" + (nwords - 1) * 7.5);

					for (var i = 0; i < words.length; i++) {
						var tspan = el.append('tspan').text(words[i]);
						if (i > 0)
							tspan.attr('x', 0).attr('dy', '15');
					}
				};

				// remove edges associated with a node
				GraphCreator.prototype.spliceLinksForNode = function(node) {
					var thisGraph = this, toSplice = thisGraph.edges
							.filter(function(l) {
								return (l.source === node || l.target === node);
							});
					toSplice.map(function(l) {
						thisGraph.edges.splice(thisGraph.edges.indexOf(l), 1);
					});
				};

				GraphCreator.prototype.replaceSelectEdge = function(d3Path,
						edgeData) {
					var thisGraph = this;
					d3Path.classed(thisGraph.consts.selectedClass, true);
					if (thisGraph.state.selectedEdge) {
						thisGraph.removeSelectFromEdge();
					}
					thisGraph.state.selectedEdge = edgeData;
				};

				GraphCreator.prototype.replaceSelectNode = function(d3Node,
						nodeData) {
					var thisGraph = this;
					d3Node.classed(this.consts.selectedClass, true);
					if (thisGraph.state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}
					thisGraph.state.selectedNode = nodeData;
				};

				GraphCreator.prototype.removeSelectFromNode = function() {
					var thisGraph = this;
					thisGraph.circles.filter(function(cd) {
						return cd.id === thisGraph.state.selectedNode.id;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedNode = null;
				};

				GraphCreator.prototype.removeSelectFromEdge = function() {
					var thisGraph = this;
					thisGraph.paths.filter(function(cd) {
						return cd === thisGraph.state.selectedEdge;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedEdge = null;
				};

				GraphCreator.prototype.pathMouseDown = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;

					if (state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}

					var prevEdge = state.selectedEdge;
					if (!prevEdge || prevEdge !== d) {
						thisGraph.replaceSelectEdge(d3path, d);
					} else {
						thisGraph.removeSelectFromEdge();
					}
				};

				// mousedoubleclick on edge
				GraphCreator.prototype.pathMouseClick = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;
					edgeopen(d.id,d.source.id,d.target.id);
				};
				// mousedown on node
				GraphCreator.prototype.circleMouseDown = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownNode = d;
					if (d3.event.shiftKey) {
						state.shiftNodeDrag = d3.event.shiftKey;
						// reposition dragged directed edge
						thisGraph.dragLine.classed('hidden', false).attr('d',
								'M' + d.x + ',' + d.y + 'L' + d.x + ',' + d.y);
						return;
					}
				};

				// mousedoubleclick on node
				GraphCreator.prototype.circleMouseClick = function(d3node, d) {

					var thisGraph = this, state = thisGraph.state;

					d3.event.stopPropagation();
					state.mouseDownNode = d;
					nodeopen(d.id,d.x,d.y);

				};
				/* place editable text on node in place of svg text */
				GraphCreator.prototype.changeTextOfNode = function(d3node, d) {
					var thisGraph = this, consts = thisGraph.consts, htmlEl = d3node
							.node();
					d3node.selectAll("text").remove();
					var nodeBCR = htmlEl.getBoundingClientRect(), curScale = nodeBCR.width
							/ consts.nodeRadius, placePad = 5 * curScale, useHW = curScale > 1 ? nodeBCR.width * 0.71
							: consts.nodeRadius * 1.42;
					// replace with editableconent text
					var d3txt = thisGraph.svg
							.selectAll("foreignObject")
							.data([ d ])
							.enter()
							.append("foreignObject")
							.attr("x", nodeBCR.left + placePad)
							.attr("y", nodeBCR.top + placePad)
							.attr("height", 2 * useHW)
							.attr("width", useHW)
							.append("xhtml:p")
							.attr("id", consts.activeEditId)
							.attr("contentEditable", "true")
							.text(d.title)
							.on("mousedown", function(d) {
								d3.event.stopPropagation();
							})
							.on(
									"keydown",
									function(d) {
										d3.event.stopPropagation();
										if (d3.event.keyCode == consts.ENTER_KEY
												&& !d3.event.shiftKey) {
											this.blur();
										}
									}).on(
									"blur",
									function(d) {
										d.title = this.textContent;
										thisGraph.insertTitleLinebreaks(d3node,
												d.title);
										d3.select(this.parentElement).remove();
									});
					return d3txt;
				};

				// mouseup on nodes
				GraphCreator.prototype.circleMouseUp = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// reset the states
					state.shiftNodeDrag = false;
					d3node.classed(consts.connectClass, false);

					var mouseDownNode = state.mouseDownNode;

					if (!mouseDownNode)
						return;

					thisGraph.dragLine.classed("hidden", true);

					if (mouseDownNode !== d) {
						// we're in a different node: create new edge for mousedown edge and add to graph
						var newEdge = {
							id : "path_3" + "_"
									+ ( maxEdge +thisGraph.cdct++),
							source : mouseDownNode,
							target : d
						};
						var filtRes = thisGraph.paths.filter(function(d) {
							if (d.source === newEdge.target
									&& d.target === newEdge.source) {
								thisGraph.edges.splice(thisGraph.edges
										.indexOf(d), 1);
							}
							return d.source === newEdge.source
									&& d.target === newEdge.target;
						});
						if (!filtRes[0].length) {
							thisGraph.edges.push(newEdge);
							thisGraph.updateGraph();
						}
					} else {
						// we're in the same node
						if (state.justDragged) {
							// dragged, not clicked
							state.justDragged = false;
						} else {
							// clicked, not dragged
							if (d3.event.shiftKey) {
								// shift-clicked node: edit text content
								var d3txt = thisGraph.changeTextOfNode(d3node,
										d);
								var txtNode = d3txt.node();
								thisGraph.selectElementContents(txtNode);
								txtNode.focus();
							} else {
								if (state.selectedEdge) {
									thisGraph.removeSelectFromEdge();
								}
								var prevNode = state.selectedNode;

								if (!prevNode || prevNode.id !== d.id) {
									thisGraph.replaceSelectNode(d3node, d);
								} else {
									thisGraph.removeSelectFromNode();
								}
							}
						}
					}
					state.mouseDownNode = null;
					return;

				}; // end of circles mouseup

				// mousedown on main svg
				GraphCreator.prototype.svgMouseDown = function() {
					this.state.graphMouseDown = true;
				};

				// mouseup on main svg
				GraphCreator.prototype.svgMouseUp = function() {
					var thisGraph = this, state = thisGraph.state;
					if (state.justScaleTransGraph) {
						// dragged not clicked
						state.justScaleTransGraph = false;
					} else if (state.graphMouseDown && d3.event.shiftKey) {
						// clicked not dragged from svg
						alert("hihi")
						var xycoords = d3.mouse(thisGraph.svgG.node()), d = {
							id : "node_3"
								
								+ "_" + (maxNode +thisGraph.idct++),
							title : "",
							x : xycoords[0],
							y : xycoords[1]
						};
						thisGraph.nodes.push(d);
						thisGraph.updateGraph();
						// make title of text immediently editable
						var d3txt = thisGraph.changeTextOfNode(
								thisGraph.circles.filter(function(dval) {
									return dval.id === d.id;
								}), d), txtNode = d3txt.node();
						thisGraph.selectElementContents(txtNode);
						txtNode.focus();
					} else if (state.shiftNodeDrag) {
						// dragged from node
						state.shiftNodeDrag = false;
						thisGraph.dragLine.classed("hidden", true);
					}
					state.graphMouseDown = false;
				};

				// keydown on main svg
				GraphCreator.prototype.svgKeyDown = function() {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// make sure repeated key presses don't register for each keydown
					if (state.lastKeyDown !== -1)
						return;

					state.lastKeyDown = d3.event.keyCode;
					var selectedNode = state.selectedNode, selectedEdge = state.selectedEdge;

					switch (d3.event.keyCode) {
					case consts.BACKSPACE_KEY:
					case consts.DELETE_KEY:
						d3.event.preventDefault();
						if (selectedNode) {
							my_id = thisGraph.nodes[thisGraph.nodes
									.indexOf(selectedNode)].id;
							delOpen();
							thisGraph.nodes.splice(thisGraph.nodes
									.indexOf(selectedNode), 1);
							thisGraph.spliceLinksForNode(selectedNode);
							state.selectedNode = null;
							thisGraph.updateGraph();
						} else if (selectedEdge) {
							my_id = thisGraph.edges[thisGraph.edges
									.indexOf(selectedEdge)].id;
							dellOpen();
							thisGraph.edges.splice(thisGraph.edges
									.indexOf(selectedEdge), 1);
							state.selectedEdge = null;
							thisGraph.updateGraph();
						}
						break;
					}
				};

				GraphCreator.prototype.svgKeyUp = function() {
					this.state.lastKeyDown = -1;
				};

				// call to propagate changes to graph
				GraphCreator.prototype.updateGraph = function() {

					var thisGraph = this, consts = thisGraph.consts, state = thisGraph.state;

					thisGraph.paths = thisGraph.paths.data(thisGraph.edges,
							function(d) {
								return String(d.source.id) + "+"
										+ String(d.target.id);
							});
					var paths = thisGraph.paths;
					// update existing paths
					paths.style('marker-end', 'url(#end-arrow)').classed(
							consts.selectedClass, function(d) {
								return d === state.selectedEdge;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							});

					// add new paths
					paths.enter().append("path").style('marker-end',
							'url(#end-arrow)').classed("link", true).attr("id",
							function(d, i) {
								return d.id;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							}).on(
							"mousedown",
							function(d) {
								thisGraph.pathMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {
								thisGraph.pathMouseClick.call(thisGraph, d3
										.select(this), d);

								;
							}).on("mouseup", function(d) {
						state.mouseDownLink = null;
					});

					// remove old links
					paths.exit().remove();

					// update existing nodes
					thisGraph.circles = thisGraph.circles.data(thisGraph.nodes,
							function(d) {
								return d.id;
							});
					thisGraph.circles.attr("transform", function(d) {
						return "translate(" + d.x + "," + d.y + ")";
					});

					// add new nodes
					var newGs = thisGraph.circles.enter().append("g");

					newGs.classed(consts.circleGClass, true).attr("transform",
							function(d) {
								return "translate(" + d.x + "," + d.y + ")";
							}).on("mouseover", function(d) {
						if (state.shiftNodeDrag) {
							d3.select(this).classed(consts.connectClass, true);
						}
					}).on("mouseout", function(d) {
						d3.select(this).classed(consts.connectClass, false);
					}).on(
							"mousedown",
							function(d) {
								
								thisGraph.circleMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"mouseup",
							function(d) {
								thisGraph.circleMouseUp.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {

								thisGraph.circleMouseClick.call(thisGraph, d3
										.select(this), d);

							}).call(thisGraph.drag);

					newGs
							.append("circle")
							.attr("r", String(consts.nodeRadius))
							.attr(
									"id",
									function(d, i) {
										return "node_3"
												
												+ "_" + (maxNode++);
									});

					newGs.each(function(d) {
						thisGraph.insertTitleLinebreaks(d3.select(this),
								d.title);
					});

					// remove old nodes
					thisGraph.circles.exit().remove();
				};

				/* GraphCreator.prototype.zoomed = function() {
				this.state.justScaleTransGraph = true;
				d3.select("." + this.consts.graphClass).attr(
						"transform",
						"translate(" + d3.event.translate + ") scale("
								+ d3.event.scale + ")");
				}; */

				GraphCreator.prototype.updateWindow = function(svg) {
					var docEl = document.documentElement, bodyEl = document
							.getElementsByTagName('body')[0];
					var x = window.innerWidth || docEl.clientWidth
							|| bodyEl.clientWidth;
					var y = window.innerHeight || docEl.clientHeight
							|| bodyEl.clientHeight;
					svg.attr("width", x).attr("height", y);
				};

				/**** MAIN ****/

				// warn the user when leaving
				window.onbeforeunload = function() {
					return "Make sure to save your graph locally before leaving :-)";
				};

				var docEl = document.documentElement, bodyEl = document
						.getElementsByTagName('body')[0];

				var width = window.innerWidth || docEl.clientWidth
						|| bodyEl.clientWidth, height = window.innerHeight
						|| docEl.clientHeight || bodyEl.clientHeight;

				var xLoc = width / 2 - 25, yLoc = 100;

				// initial node data
				var nodes = [];
				var edges = [];

				/** MAIN SVG **/
				var svg = d3.select("#plan3").append("svg").attr("width", width)
						.attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
			
			d3.selectAll("circle")
			   .append("svg:title")
			   .text(function(d) { return d.x; });
		</script>
	</div>


	<div id="plan4" style="width: 700px; margin: 0 auto;">
		<script src="//d3js.org/d3.v3.js" charset="utf-8"></script>
		<script src="//cdn.jsdelivr.net/filesaver.js/0.1/FileSaver.min.js"></script>
		<script>
			document.onload = (function(d3, saveAs, Blob, undefined) {
				"use strict";

				// define graphcreator object
				var GraphCreator = function(svg, nodes, edges) {
					var thisGraph = this;
					thisGraph.idct = 0;thisGraph.cdct = 0;

					thisGraph.nodes = nodes || [];
					thisGraph.edges = edges || [];

					thisGraph.state = {
						selectedNode : null,
						selectedEdge : null,
						mouseDownNode : null,
						mouseDownLink : null,
						justDragged : false,
						justScaleTransGraph : false,
						lastKeyDown : -1,
						shiftNodeDrag : false,
						selectedText : null
					};

					// define arrow markers for graph links
					var defs = svg.append('svg:defs');
					defs.append('svg:marker').attr('id', 'end-arrow').attr(
							'viewBox', '0 0 0 0').attr('refX', "0").attr(
							'markerWidth', 0).attr('markerHeight', 0).attr(
							'orient', 'auto').append('svg:path').attr('d',
							'M0,0');

					// define arrow markers for leading arrow
					defs.append('svg:marker').attr('id', 'mark-end-arrow')
							.attr('viewBox', '0 0 00 00').attr('refX', 0).attr(
									'markerWidth', 0).attr('markerHeight', 0)
							.attr('orient', 'auto').append('svg:path').attr(
									'd', 'M0,00');

					thisGraph.svg = svg;
					thisGraph.svgG = svg.append("g").classed(
							thisGraph.consts.graphClass, true);
					var svgG = thisGraph.svgG;

					// displayed when dragging between nodes
					thisGraph.dragLine = svgG.append('svg:path').attr('class',
							'link dragline hidden').attr('d', 'M0,0L0,0')
							.style('marker-end', 'url(#mark-end-arrow)');

					// svg nodes and edges 
					thisGraph.paths = svgG.append("g").selectAll("g");
					thisGraph.circles = svgG.append("g").selectAll("g");

					thisGraph.drag = d3.behavior.drag().origin(function(d) {
						return {
							x : d.x,
							y : d.y
						};
					}).on("drag", function(args) {
						thisGraph.state.justDragged = true;
						thisGraph.dragmove.call(thisGraph, args);
					}).on("dragend", function() {
						// todo check if edge-mode is selected
					});

					// listen for key events
					d3.select(window).on("keydown", function() {
						thisGraph.svgKeyDown.call(thisGraph);
					}).on("keyup", function() {
						thisGraph.svgKeyUp.call(thisGraph);
					});
					svg.on("mousedown", function(d) {
						thisGraph.svgMouseDown.call(thisGraph, d);
					});
					svg.on("mouseup", function(d) {
						thisGraph.svgMouseUp.call(thisGraph, d);
					});

					// listen for dragging
					var dragSvg = d3.behavior.zoom().on("zoom", function() {
						if (d3.event.sourceEvent.shiftKey) {
							// TODO  the internal d3 state is still changing
							return false;
						} else {
							thisGraph.zoomed.call(thisGraph);
						}
						return true;
					}).on(
							"zoomstart",
							function() {
								var ael = d3.select(
										"#" + thisGraph.consts.activeEditId)
										.node();
								if (ael) {
									ael.blur();
								}
								if (!d3.event.sourceEvent.shiftKey)
									d3.select('body').style("cursor", "move");
							}).on("zoomend", function() {
						d3.select('body').style("cursor", "auto");
					});

					svg.call(dragSvg).on("dblclick.zoom", null);

					// listen for resize
					window.onresize = function() {
						thisGraph.updateWindow(svg);
					};

					

					
															// handle uploaded data

					d3
							.select("#upload-input4")
							.on(
									"click",
									function() {
										
										thisGraph.deleteGraph(true);
										
		<%try {

				Class.forName("org.postgresql.Driver");

			} catch (ClassNotFoundException e) {

				System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
				e.printStackTrace();
				return;

			}

			System.out.println("PostgreSQL JDBC Driver Registered!");

			java.sql.Connection connection4 = null;

			try {

				connection4 = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}

			if (connection4 != null) {

				Statement s4 = connection4.createStatement();
				ResultSet rs4 = null, ry4 = null;
				String q1 = "Select * from node where building_name = 'lib' and floor = 4";/* session.getAttribute("building_name") */

				// add floor number also in the query

				rs4 = (s4.executeQuery(q1));
				String q2 = "Select * from edge where building_name = 'lib' and floor = 4";/* session.getAttribute("building_name") */

				// add floorr number also in the query

				while (rs4.next()) {
					String id = rs4.getString("node_id");
					String x = rs4.getString("latitude");
					String y = rs4.getString("longitude");
					System.out.println(id + " " + x + " " + y);%>
					
				
			                           var idd =		"<%=id%>";
										var xx =		"<%=x%>";
										var yy =		"<%=y%>";
var ut  = idd.substr(idd.lastIndexOf("_")+1);
							//	alert(ut);
								if(ut > maxNode) maxNode = ut ;
								
								//	alert(idd + " " + xx + " " + yy);

										thisGraph.setIdCt(thisGraph.idct++);
										thisGraph.nodes.push({
											"id" : idd,
											"title" : "",
											"x" : xx,
											"y" : yy
										});
										thisGraph.updateGraph();
		<%}%>
				    
				   d3.selectAll('circle').attr("id",function(d){return d.id;});
				
					var newEdges = [];
				<%ry4 = (s4.executeQuery(q2));

				while (ry4.next()) {
					String eid = ry4.getString("edge_id");
					String ex = ry4.getString("start_node");
					String ey = ry4.getString("end_node");
					//System.out.println(eid + " " + ex + " " + ey);%>
					
				
			                           var iidd =		"<%=eid%>";
										var exx =		"<%=ex%>";
										var eyy =		"<%=ey%>";

										//		alert(iidd + " " + exx + " " + eyy);
										var ut = iidd.substr(iidd
												.lastIndexOf("_") + 1);
										//alert(ut);
										if (ut > maxEdge)
											maxEdge = ut;

										newEdges.push({
											"id" : iidd,
											"source" : exx,
											"target" : eyy
										});
		<%}%>
			newEdges
												.forEach(function(e, i) {
													newEdges[i] = {
														id : e.id,
														source : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.source;
																})[0],
														target : thisGraph.nodes
																.filter(function(
																		n) {
																	return n.id == e.target;
																})[0]
													};

												});
										thisGraph.edges = newEdges;
										thisGraph.updateGraph();
										maxNode++;
										maxEdge++; // for the new ids to be unique
		<%}

			else {

				System.out.println("Failed to make connection!");

			}%>
			});

					// handle delete graph
					d3.select("#delete-graph").on("click", function() {
						thisGraph.deleteGraph(false);
					});
				};

				GraphCreator.prototype.setIdCt = function(idct) {
					this.idct = idct;
				};
				GraphCreator.prototype.setCdCt = function(cdct) {
					this.cdct = cdct;
				};
				GraphCreator.prototype.consts = {
					selectedClass : "selected",
					connectClass : "connect-node",
					circleGClass : "conceptG",
					graphClass : "graph",
					activeEditId : "active-editing",
					BACKSPACE_KEY : 8,
					DELETE_KEY : 46,
					ENTER_KEY : 13,
					nodeRadius : 10
				};

				/* PROTOTYPE FUNCTIONS */

				/*  GraphCreator.prototyragmove = function(d) {
					var thisGraph = this;
					if (thisGraph.state.shiftNodeDrag) {
						thisGraph.dragLine.attr('d', 'M' + d.x + ',' + d.y
								+ 'L' + d3.mouse(thisGraph.svgG.node())[0]
								+ ',' + d3.mouse(this.svgG.node())[1]);
					} else {
						d.x += d3.event.dx;
						d.y += d3.event.dy;
						thisGraph.updateGraph();
					}
				}; */

				GraphCreator.prototype.deleteGraph = function(skipPrompt) {
					var thisGraph = this, doDelete = true;
					if (!skipPrompt) {
						doDelete = window
								.confirm("Press OK to delete this graph");
					}
					if (doDelete) {
						thisGraph.nodes = [];
						thisGraph.edges = [];
						thisGraph.updateGraph();
					}
				};

				/* select all text in element: taken from http://stackoverflow.com/questions/6139107/programatically-select-text-in-a-contenteditable-html-element */
				GraphCreator.prototype.selectElementContents = function(el) {
					var range = document.createRange();
					range.selectNodeContents(el);
					var sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange(range);
				};

				/* insert svg line breaks: taken from http://stackoverflow.com/questions/13241475/how-do-i-include-newlines-in-labels-in-d3-charts */
				GraphCreator.prototype.insertTitleLinebreaks = function(gEl,
						title) {
					var words = title.split(/\s+/g), nwords = words.length;
					var el = gEl.append("text").attr("text-anchor", "middle")
							.attr("dy", "-" + (nwords - 1) * 7.5);

					for (var i = 0; i < words.length; i++) {
						var tspan = el.append('tspan').text(words[i]);
						if (i > 0)
							tspan.attr('x', 0).attr('dy', '15');
					}
				};

				// remove edges associated with a node
				GraphCreator.prototype.spliceLinksForNode = function(node) {
					var thisGraph = this, toSplice = thisGraph.edges
							.filter(function(l) {
								return (l.source === node || l.target === node);
							});
					toSplice.map(function(l) {
						thisGraph.edges.splice(thisGraph.edges.indexOf(l), 1);
					});
				};

				GraphCreator.prototype.replaceSelectEdge = function(d3Path,
						edgeData) {
					var thisGraph = this;
					d3Path.classed(thisGraph.consts.selectedClass, true);
					if (thisGraph.state.selectedEdge) {
						thisGraph.removeSelectFromEdge();
					}
					thisGraph.state.selectedEdge = edgeData;
				};

				GraphCreator.prototype.replaceSelectNode = function(d3Node,
						nodeData) {
					var thisGraph = this;
					d3Node.classed(this.consts.selectedClass, true);
					if (thisGraph.state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}
					thisGraph.state.selectedNode = nodeData;
				};

				GraphCreator.prototype.removeSelectFromNode = function() {
					var thisGraph = this;
					thisGraph.circles.filter(function(cd) {
						return cd.id === thisGraph.state.selectedNode.id;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedNode = null;
				};

				GraphCreator.prototype.removeSelectFromEdge = function() {
					var thisGraph = this;
					thisGraph.paths.filter(function(cd) {
						return cd === thisGraph.state.selectedEdge;
					}).classed(thisGraph.consts.selectedClass, false);
					thisGraph.state.selectedEdge = null;
				};

				GraphCreator.prototype.pathMouseDown = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;

					if (state.selectedNode) {
						thisGraph.removeSelectFromNode();
					}

					var prevEdge = state.selectedEdge;
					if (!prevEdge || prevEdge !== d) {
						thisGraph.replaceSelectEdge(d3path, d);
					} else {
						thisGraph.removeSelectFromEdge();
					}
				};

				// mousedoubleclick on edge
				GraphCreator.prototype.pathMouseClick = function(d3path, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownLink = d;
					edgeopen(d.id, d.source.id, d.target.id);
				};
				// mousedown on node
				GraphCreator.prototype.circleMouseDown = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state;
					d3.event.stopPropagation();
					state.mouseDownNode = d;
					if (d3.event.shiftKey) {
						state.shiftNodeDrag = d3.event.shiftKey;
						// reposition dragged directed edge
						thisGraph.dragLine.classed('hidden', false).attr('d',
								'M' + d.x + ',' + d.y + 'L' + d.x + ',' + d.y);
						return;
					}
				};

				// mousedoubleclick on node
				GraphCreator.prototype.circleMouseClick = function(d3node, d) {

					var thisGraph = this, state = thisGraph.state;

					d3.event.stopPropagation();
					state.mouseDownNode = d;
					nodeopen(d.id, d.x, d.y);

				};
				/* place editable text on node in place of svg text */
				GraphCreator.prototype.changeTextOfNode = function(d3node, d) {
					var thisGraph = this, consts = thisGraph.consts, htmlEl = d3node
							.node();
					d3node.selectAll("text").remove();
					var nodeBCR = htmlEl.getBoundingClientRect(), curScale = nodeBCR.width
							/ consts.nodeRadius, placePad = 5 * curScale, useHW = curScale > 1 ? nodeBCR.width * 0.71
							: consts.nodeRadius * 1.42;
					// replace with editableconent text
					var d3txt = thisGraph.svg
							.selectAll("foreignObject")
							.data([ d ])
							.enter()
							.append("foreignObject")
							.attr("x", nodeBCR.left + placePad)
							.attr("y", nodeBCR.top + placePad)
							.attr("height", 2 * useHW)
							.attr("width", useHW)
							.append("xhtml:p")
							.attr("id", consts.activeEditId)
							.attr("contentEditable", "true")
							.text(d.title)
							.on("mousedown", function(d) {
								d3.event.stopPropagation();
							})
							.on(
									"keydown",
									function(d) {
										d3.event.stopPropagation();
										if (d3.event.keyCode == consts.ENTER_KEY
												&& !d3.event.shiftKey) {
											this.blur();
										}
									}).on(
									"blur",
									function(d) {
										d.title = this.textContent;
										thisGraph.insertTitleLinebreaks(d3node,
												d.title);
										d3.select(this.parentElement).remove();
									});
					return d3txt;
				};

				// mouseup on nodes
				GraphCreator.prototype.circleMouseUp = function(d3node, d) {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// reset the states
					state.shiftNodeDrag = false;
					d3node.classed(consts.connectClass, false);

					var mouseDownNode = state.mouseDownNode;

					if (!mouseDownNode)
						return;

					thisGraph.dragLine.classed("hidden", true);

					if (mouseDownNode !== d) {
						// we're in a different node: create new edge for mousedown edge and add to graph
						var newEdge = {
							id : "path_4" + "_" + ( maxEdge + thisGraph.cdct++ ),
							source : mouseDownNode,
							target : d
						};
						var filtRes = thisGraph.paths.filter(function(d) {
							if (d.source === newEdge.target
									&& d.target === newEdge.source) {
								thisGraph.edges.splice(thisGraph.edges
										.indexOf(d), 1);
							}
							return d.source === newEdge.source
									&& d.target === newEdge.target;
						});
						if (!filtRes[0].length) {
							thisGraph.edges.push(newEdge);
							thisGraph.updateGraph();
						}
					} else {
						// we're in the same node
						if (state.justDragged) {
							// dragged, not clicked
							state.justDragged = false;
						} else {
							// clicked, not dragged
							if (d3.event.shiftKey) {
								// shift-clicked node: edit text content
								var d3txt = thisGraph.changeTextOfNode(d3node,
										d);
								var txtNode = d3txt.node();
								thisGraph.selectElementContents(txtNode);
								txtNode.focus();
							} else {
								if (state.selectedEdge) {
									thisGraph.removeSelectFromEdge();
								}
								var prevNode = state.selectedNode;

								if (!prevNode || prevNode.id !== d.id) {
									thisGraph.replaceSelectNode(d3node, d);
								} else {
									thisGraph.removeSelectFromNode();
								}
							}
						}
					}
					state.mouseDownNode = null;
					return;

				}; // end of circles mouseup

				// mousedown on main svg
				GraphCreator.prototype.svgMouseDown = function() {
					alert("hi")
					this.state.graphMouseDown = true;
				};

				// mouseup on main svg
				GraphCreator.prototype.svgMouseUp = function() {
					var thisGraph = this, state = thisGraph.state;
					if (state.justScaleTransGraph) {
						// dragged not clicked
						state.justScaleTransGraph = false;
					} else if (state.graphMouseDown && d3.event.shiftKey) {
						// clicked not dragged from svg
						alert("hihi")
						var xycoords = d3.mouse(thisGraph.svgG.node()), d = {
							id : "node_4"

							+ "_" + (maxNode + thisGraph.idct++),
							title : "",
							x : xycoords[0],
							y : xycoords[1]
						};
						thisGraph.nodes.push(d);
						thisGraph.updateGraph();
						// make title of text immediently editable
						var d3txt = thisGraph.changeTextOfNode(
								thisGraph.circles.filter(function(dval) {
									return dval.id === d.id;
								}), d), txtNode = d3txt.node();
						thisGraph.selectElementContents(txtNode);
						txtNode.focus();
					} else if (state.shiftNodeDrag) {
						// dragged from node
						state.shiftNodeDrag = false;
						thisGraph.dragLine.classed("hidden", true);
					}
					state.graphMouseDown = false;
				};

				// keydown on main svg
				GraphCreator.prototype.svgKeyDown = function() {
					var thisGraph = this, state = thisGraph.state, consts = thisGraph.consts;
					// make sure repeated key presses don't register for each keydown
					if (state.lastKeyDown !== -1)
						return;

					state.lastKeyDown = d3.event.keyCode;
					var selectedNode = state.selectedNode, selectedEdge = state.selectedEdge;

					switch (d3.event.keyCode) {
					case consts.BACKSPACE_KEY:
					case consts.DELETE_KEY:
						d3.event.preventDefault();
						if (selectedNode) {
							my_id = thisGraph.nodes[thisGraph.nodes
									.indexOf(selectedNode)].id;
							delOpen();
							thisGraph.nodes.splice(thisGraph.nodes
									.indexOf(selectedNode), 1);
							thisGraph.spliceLinksForNode(selectedNode);
							state.selectedNode = null;
							thisGraph.updateGraph();
						} else if (selectedEdge) {
							my_id = thisGraph.edges[thisGraph.edges
									.indexOf(selectedEdge)].id;
							dellOpen();
							thisGraph.edges.splice(thisGraph.edges
									.indexOf(selectedEdge), 1);
							state.selectedEdge = null;
							thisGraph.updateGraph();
						}
						break;
					}
				};

				GraphCreator.prototype.svgKeyUp = function() {
					this.state.lastKeyDown = -1;
				};

				// call to propagate changes to graph
				GraphCreator.prototype.updateGraph = function() {

					var thisGraph = this, consts = thisGraph.consts, state = thisGraph.state;

					thisGraph.paths = thisGraph.paths.data(thisGraph.edges,
							function(d) {
								return String(d.source.id) + "+"
										+ String(d.target.id);
							});
					var paths = thisGraph.paths;
					// update existing paths
					paths.style('marker-end', 'url(#end-arrow)').classed(
							consts.selectedClass, function(d) {
								return d === state.selectedEdge;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							});

					// add new paths
					paths.enter().append("path").style('marker-end',
							'url(#end-arrow)').classed("link", true).attr("id",
							function(d, i) {
								return d.id;
							}).attr(
							"d",
							function(d) {
								return "M" + d.source.x + "," + d.source.y
										+ "L" + d.target.x + "," + d.target.y;
							}).on(
							"mousedown",
							function(d) {
								thisGraph.pathMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {
								thisGraph.pathMouseClick.call(thisGraph, d3
										.select(this), d);

								;
							}).on("mouseup", function(d) {
						state.mouseDownLink = null;
					});

					// remove old links
					paths.exit().remove();

					// update existing nodes
					thisGraph.circles = thisGraph.circles.data(thisGraph.nodes,
							function(d) {
								return d.id;
							});
					thisGraph.circles.attr("transform", function(d) {
						return "translate(" + d.x + "," + d.y + ")";
					});

					// add new nodes
					var newGs = thisGraph.circles.enter().append("g");

					newGs.classed(consts.circleGClass, true).attr("transform",
							function(d) {
								return "translate(" + d.x + "," + d.y + ")";
							}).on("mouseover", function(d) {
						if (state.shiftNodeDrag) {
							d3.select(this).classed(consts.connectClass, true);
						}
					}).on("mouseout", function(d) {
						d3.select(this).classed(consts.connectClass, false);
					}).on(
							"mousedown",
							function(d) {

								thisGraph.circleMouseDown.call(thisGraph, d3
										.select(this), d);
							}).on(
							"mouseup",
							function(d) {
								thisGraph.circleMouseUp.call(thisGraph, d3
										.select(this), d);
							}).on(
							"dblclick",
							function(d) {

								thisGraph.circleMouseClick.call(thisGraph, d3
										.select(this), d);

							}).call(thisGraph.drag);

					newGs.append("circle").attr("r", String(consts.nodeRadius))
							.attr("id", function(d, i) {
								return "node_4"

								+ "_" + (maxNode++);
							});

					newGs.each(function(d) {
						thisGraph.insertTitleLinebreaks(d3.select(this),
								d.title);
					});

					// remove old nodes
					thisGraph.circles.exit().remove();
				};

				/* GraphCreator.prototype.zoomed = function() {
				this.state.justScaleTransGraph = true;
				d3.select("." + this.consts.graphClass).attr(
						"transform",
						"translate(" + d3.event.translate + ") scale("
								+ d3.event.scale + ")");
				}; */

				GraphCreator.prototype.updateWindow = function(svg) {
					var docEl = document.documentElement, bodyEl = document
							.getElementsByTagName('body')[0];
					var x = window.innerWidth || docEl.clientWidth
							|| bodyEl.clientWidth;
					var y = window.innerHeight || docEl.clientHeight
							|| bodyEl.clientHeight;
					svg.attr("width", x).attr("height", y);
				};

				/**** MAIN ****/

				// warn the user when leaving
				window.onbeforeunload = function() {
					return "Make sure to save your graph locally before leaving :-)";
				};

				var docEl = document.documentElement, bodyEl = document
						.getElementsByTagName('body')[0];

				var width = window.innerWidth || docEl.clientWidth
						|| bodyEl.clientWidth, height = window.innerHeight
						|| docEl.clientHeight || bodyEl.clientHeight;

				var xLoc = width / 2 - 25, yLoc = 100;

				// initial node data
				var nodes = [];
				var edges = [];

				/** MAIN SVG **/
				var svg = d3.select("#plan4").append("svg")
						.attr("width", width).attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
		</script>
	</div>

</body>

</html>





<!-- 	 -->

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

	function changeBackground(url_of_pic) {
		document.body.style.backgroundImage = url("'" + url_of_pic + "'");
	}
	var popupnodeWindow = null , popupdelWindow=null;

	

	function nodeparent_disable() {
		if (popupnodeWindow && !popupbnodeWindow.closed)
			popupnodeWindow.focus();
	}
		function dellOpen() {
			//	var pp =window.open();
					 popupdelWindow = window
							.open(
									"OpenForEDelete.jsp?param="+my_id,
									"_blank",
									"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500,left=440,top=0")
		           setTimeout(function () { popupdelWindow.close();}, 1);  
				}
		
		function delOpen() {
					//	var pp =window.open();
					 popupdelWindow = window
							.open(
									"OpenForDelete.jsp?param="+my_id,
									"_blank",
									"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500,left=440,top=0")
		           setTimeout(function () { popupdelWindow.close();}, 1);  
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

#plan {
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
	fill: gray;
}

g.conceptG:hover circle {
	stroke-width: 8px;
	stroke: gray;
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

#wide {
	float: left;
	width: calc(100% - 200px);
	background: lightgreen;
}

path.link {
	fill: pink;
	stroke: gray;
	stroke-width: 6px;
	cursor: default;
}

path.link:hover {
	stroke: gray;
}

g.connect-node circle {
	fill: gray;
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

path.link.selected {
	stroke: rgb(229, 172, 247);
}
</style>
<script type="text/javascript">
    
     <%String var1=new String(""),var2=new String(""),var3=new String("");%>
	var imageArray = [ "kresit_0_Floor_plan.png", "kresit_1_Floor_plan.png",
			"kresit_2_Floor_plan.png", "kresit_3_Floor_plan.png",
			"kresit_4_Floor_plan.png" ];

	function changeFloor() {

		//alert("before")
		var Index = menuForm.select1.selectedIndex;
		plan.style.backgroundImage = 'url(' + imageArray[Index] + ')';
	}
</script>

</head>

<body onload="document.getElementById('upload-input').click();" onFocus="parent_disable();" onclick="parent_disable();">

	<div id="wide">
		<input type="button" id="upload-input"> <input type="image"
			id="delete-graph" title="delete graph" src="delete.png"
			alt="delete graph" width=20 height=20>

	</div>

	<div style="width: 1100px; margin: 0 auto;">
		<form id="menuForm">
			<select id="select1" name="floors ">
				<!-- onchange="changeFloor()" -->
				<option value="0">Floor 0</option>
				<option value="1">Floor 1</option>
				<option value="2">Floor 2</option>
				<option value="3">Floor 3</option>
				<option value="4">Floor 4</option>
			</select> <input type="button" onclick="changeFloor();" value="Load" />
		</form>
	</div>


	<div id="plan" style="width: 700px; margin: 0 auto;">
		<script src="//d3js.org/d3.v3.js" charset="utf-8"></script>
		<script src="//cdn.jsdelivr.net/filesaver.js/0.1/FileSaver.min.js"></script>
		<script>
		
		<% String p = request.getParameter("param1");
		   String temp[] = p.split("__");
		   var1 = temp[0];
		   var2 = temp[1];
		   var3 = temp[2];
		   
		%>
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
							.select("#upload-input")
							.on(
									"click",
									function() {
										//clock()
										thisGraph.deleteGraph(true);
										
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

			java.sql.Connection connection = null;

			try {

				connection = DriverManager.getConnection(url, username, password);

			} catch (Exception e) {

				System.out.println("Connection Failed! Check output console");
				e.printStackTrace();
				return;

			}

			if (connection != null) {

				Statement s = connection.createStatement();
				ResultSet rs = null, ry = null;
				String q1 = "Select * from node where building_name = 'lib' and floor="+var3;/* session.getAttribute("building_name") */

				// add floor number also in the query

				rs = (s.executeQuery(q1));
				String q2 = "Select * from edge where building_name = 'lib' and floor="+var3;/* session.getAttribute("building_name") */

				// add floorr number also in the query

				while (rs.next()) {
					String id = rs.getString("node_id");
					String x = rs.getString("latitude");
					String y = rs.getString("longitude");
					System.out.println(id + " " + x + " " + y);%>
					
				
			                           var idd =		"<%=id%>";
										var xx =		"<%=x%>";
										var yy =		"<%=y%>";
var ut  = idd.substr(idd.lastIndexOf("_")+1);
							//	alert(ut);
								if(ut > maxNode) maxNode = ut ;
								
										//alert(idd + " " + xx + " " + yy);

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
				<%ry = (s.executeQuery(q2));

				while (ry.next()) {
					String eid = ry.getString("edge_id");
					String ex = ry.getString("start_node");
					String ey = ry.getString("end_node");
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
										
										
										<%
								        String mynodes[] = var1.split(",");
										String myedges[] = var2.split(",");
						                int i=0;
										for (i = 0; i < mynodes.length; i++) {
										    System.out.println("My node"+mynodes[i]);
											ResultSet rsq = null;
											String q3 = "Select * from node where building_name = 'lib' and floor=" + var3
													+ " and node_id='"+mynodes[i]+"'";/* session.getAttribute("building_name") */
											rsq = s.executeQuery(q3);
									        
													if(rsq.next()){
														%>
														       var qw = "<%=mynodes[i]%>";
														 <%
														 if(i==0){%>d3.select("#"+qw).style("fill","red");
														<%}
														 else{
															 %>d3.select("#"+qw).style("fill","black");
																<%
														 }
														 
													
														 
													}
													else{
														%>
														var qw = "<%=mynodes[i-1]%>";
														d3.select("#"+qw).style("fill","green");
														<%
														break;
													}
													
										}
										    var1="";
										    for(int j=i; j<mynodes.length; j++){
										    	var1 +=","+mynodes[j];
										    }
										   if(var1.compareTo("")!=0){ var1 = var1.substring(1);
										    System.out.println(var1);}
										
										for (i = 0; i < myedges.length; i++) {
											
											   System.out.println(myedges[i]);
												ResultSet rsq = null;
											String q3 = "Select * from edge where building_name = 'lib' and floor=" + var3
													+ " and edge_id='"+myedges[i]+"'";/* session.getAttribute("building_name") */
											rsq = s.executeQuery(q3);
										
											
											
											
												  if(rsq.next()){
												%>
												
											       var qw = "<%=myedges[i]%>";
											       //alert(qw);
											       
											       d3.select("#"+qw).style("stroke","black");
											     
											
											<%
										}else{
											break;
										}
													
										}
										var2="";
									    for(int j=i; j<myedges.length; j++){
									    	var2 +=","+myedges[j];
									    }
									    if(var2.compareTo("")!=0){var2 = var2.substring(1);
									    System.out.println(var2);}
									    
									   
								        if(var1.compareTo("")!=0 && var2.compareTo("")!=0){
								        	
								        	 ResultSet rsq = null;
												String q3 = "Select floor from edge where building_name = 'lib' and edge_id='"+myedges[i]+"'";/* session.getAttribute("building_name") */
												rsq = s.executeQuery(q3);
										        while(rsq.next()){
										        	
										        	 var3 = rsq.getString("floor");
										        	 System.out.println(var3);
										        		        }
								//	    Thread a = Thread.currentThread();
										  	    Thread.sleep(3000); 										  	    
										%>
										   // alert("Go to next");
										<%	
										String po = var1+"__"+var2+"__"+var3;
										%>
										var pass = "<%=po%>";
										var popupStoD = window.open("StoD.jsp?param1="+pass,
												"_self",
										"visible=none,directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1100,height=700,left=100,top=0");
					<%
								        }
								        else{
								       // 	 Thread a = Thread.currentThread();
										  	   // Thread.sleep(3000); 
								        %>
								        var qw = "<%=mynodes[i]%>";
										d3.select("#"+qw).style("fill","green");
										
								       // window.close();
								        <%
								        }
		}

			
			    
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
							id : "path_" + menuForm.select1.selectedIndex + "_"
									+ (thisGraph.cdct++ + maxEdge),
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
							id : "node_"
								+ menuForm.select1.selectedIndex
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
										return "node_"
												+ menuForm.select1.selectedIndex
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
				/* window.onbeforeunload = function() {
					return "Make sure to save your graph locally before leaving :-)";
				}; */

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
				var svg = d3.select("#plan").append("svg").attr("width", width)
						.attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
		</script>
	</div>


</body>

</html>


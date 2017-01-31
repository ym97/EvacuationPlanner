
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
	function changeBackground(url_of_pic) {
		document.body.style.backgroundImage = url("'" + url_of_pic + "'");
	}
	var popupnodeWindow = null;
	var my_id,idd, xx, yy , eid, ex, ey;
	function nodechild_open() {
       //  alert("hi");
		popupnodeWindow = window
				.open(
						'NodeForm.jsp',
						"_blank",
						"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=700,left=440,top=0")

	}
	var  popupdelWindow=null;
	function delOpen() {
	//	var pp =window.open();
			 popupdelWindow = window
					.open(
							"OpenForDelete.jsp?param="+my_id,
							"_blank",
							"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500,left=440,top=0")
           setTimeout(function () { popupdelWindow.close();}, 1);  
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
	function nodeparent_disable() {
		if (popupnodeWindow && !popupbnodeWindow.closed)
			popupnodeWindow.focus();
	}

	var popupedgeWindow = null;

	function edgechild_open() {
		//req.setAttribute("givenid",id);
		//req.getRequestDispatcher("EdgeForm.jsp").forward(req, resp);

		popupedgeWindow = window
				.open(
						'EdgeForm.jsp',
						"_blank",
						"directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=440,left=440 , top=148'");
	}

	function edgeparent_disable() {
		if (popupedgeWindow && !popupedgeWindow.closed)
			popupedgeWindow.focus();
	}

	function myFunction() {
		document.getElementById("myDropdown").classList.toggle("show");
	}

	// Close the dropdown menu if the user clicks outside of it
	window.onclick = function(event) {
		if (!event.target.matches('.dropbtn')) {

			var dropdowns = document.getElementsByClassName("dropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
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
/* Dropdown Button */
.dropbtn {
	background-color: #4CAF50;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

/* Dropdown button on hover & focus */
.dropbtn:hover, .dropbtn:focus {
	background-color: #3e8e41;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
	position: relative;
	display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

/* Links inside the dropdown */
.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
	background-color: #f1f1f1
}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {
	display: block;
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

path.link.selected {
	stroke: rgb(229, 172, 247);
}
</style>
<script type="text/javascript">
	var imageArray = [ "kresit_0_Floor_plan.png", "kresit_1_Floor_plan.png",
			"kresit_2_Floor_plan.png", "kresit_3_Floor_plan.png",
			"kresit_4_Floor_plan.png" ];
	//	altArray = new Array("", "Red Star", "Yellow Star", "Pink Star");

	function changeFloor() {

		//alert("before")
		var Index = menuForm.select1.selectedIndex;
		//var Index = document.menuForm.select1.option[document.menuForm.select1.selectedIndex].value;
		//alert(imageArray[Index]);
		//document.plan.src = imageArray[Index];

		plan.style.backgroundImage = 'url(' + imageArray[Index] + ')';
	}
</script>

</head>

<body onFocus="parent_disable();" onclick="parent_disable();">
	<div>
		<input type="image" id="delete-graph" title="delete graph"
			src="delete.png" alt="delete graph" width=20 height=20><input
			type="button" id="mybutton" />
	</div>

	<div style="width: 1100px; margin: 0 auto;">
		<form id="menuForm">
			<select id="select1" name="floors ">
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
			document.onload = (function(d3, saveAs, Blob, undefined) {
				"use strict";

				// define graphcreator object
				var GraphCreator = function(svg, nodes, edges) {
					var thisGraph = this;
					thisGraph.idct = 0;
					thisGraph.cdct = 0;

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

					/// i ve deleted the upload download one//
					
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

				GraphCreator.prototype.dragmove = function(d) {
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
				d3.select("#mybutton").on("click", function() {

					var ids = [ "1", "2", "4" ];
					var i;
					for (i = 0; i < ids.length; i++) {

						d3.select("#node_" +menuForm.select1.selectedIndex + "_"+ ids[i]).selectAll('circle').style("fill", "blue");
						/* d3.select("#path_" + ids[i]).style("stroke",
								"orange").style("stroke-width",
								2 * i + 1); */

					}

				});
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
			//		alert(d.id+" "+d.source.id+" "+d.target.id);
					eid = d.id;
					ex = d.source.id;
					ey= d.target.id;
					//alert(ex+" "+ey+" "+eid);
					edgechild_open();
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
					//alert(d3node.id);
					state.mouseDownNode = d;
					idd = d.id;
					xx = d.x;
					yy = d.y;
					nodechild_open();
					
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
								id : "path_"+menuForm.select1.selectedIndex+"_"+thisGraph.cdct++ ,
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
						var xycoords = d3.mouse(thisGraph.svgG.node()), d = {
							id : "node_" + menuForm.select1.selectedIndex + "_"
									+ thisGraph.idct++,
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
							
							my_id = thisGraph.nodes[thisGraph.nodes.indexOf(selectedNode)].id;
							delOpen();
			thisGraph.nodes.splice(thisGraph.nodes
									.indexOf(selectedNode), 1);
							thisGraph.spliceLinksForNode(selectedNode);
							state.selectedNode = null;
							thisGraph.updateGraph();
						} else if (selectedEdge) {
							my_id = thisGraph.edges[thisGraph.edges.indexOf(selectedEdge)].id;
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
								+"_" + i;
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
								//  alert("hi" +this.id +" bye  "+d.id);

								d3.select(this).attr("id", d.id);
								//alert(this.id);
								//this.id = d.id;

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
								d3.select(this).attr("id", d.id);

								thisGraph.circleMouseClick.call(thisGraph, d3
										.select(this), d);

							}).call(thisGraph.drag);

					newGs.append("circle").attr("r", String(consts.nodeRadius))
					/* .attr(
							"id",
							function(d, i) {
								return "Node_"
										+ menuForm.select1.selectedIndex
										+ "_" + i;
							}) */;

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
				};
				 */
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
				var svg = d3.select("#plan").append("svg").attr("width", width)
						.attr("height", height);
				var graph = new GraphCreator(svg, nodes, edges);
				graph.setIdCt(0);
				graph.setCdCt(ss0);
				graph.updateGraph();
			})(window.d3, window.saveAs, window.Blob);
		</script>
	</div>
</body>

</html>

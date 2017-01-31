<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>My site</title>
<link rel="stylesheet" type="text/css" href="demo.css" />
<link rel="stylesheet" href="menu.css" type="text/css" media="screen" />
<%@ include file="connectionString.jsp" %>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<script type="text/javascript" src="script.js"></script>
</head>
<%
connectionString cs = new connectionString();
 System.out.println(cs.password + cs.url + cs.username);

%>
<body>
<div id="main1">
  <ul id="menu2">
      <li><a href="building_created.jsp" target="f2"><font size="4">Home</font></a>
      <!-- Begin Home Item -->
      <!-- End 2 columns container -->
    </li>
    <!-- End Home Item -->
    <li><a href="#" class="drop"><font size="4">Building</font></a>
      <!-- Begin 5 columns Item -->
      <div class="dropdown_1column align_right">
        <div class="col_1">
          <ul class="simple">
            <li><a href="Register_Building.jsp" target="f2">Register New building</a></li>
           <!--  <li><a href="View_data.jsp" target="f3">View data</a></li> -->
            <li><a href="edit_data.jsp" target="f2">Edit building data</a></li>
            <li><a href="Load_img.jsp" target="f2">Upload floorplan </a></li>
            <li><a href="Create_scenario.jsp" target="f2">Create Scenario</a></li>
           <!--  <li><a href="Output.jsp" target="f2">Compare Output</a></li> -->
                        <!--li><a href="test_animation.jsp" target="f3">Animation</a></li-->
                         <!-- <li><a href="Animation.jsp" target="f2">Visualization</a></li> -->
           <li><a href="Delete_Build.jsp" target="f2">Delete building</a></li>              
          </ul>
        </div>
      </div>
      <!-- End 5 columns container -->
    </li>
    <!-- End 5 columns Item -->
    <li><a href="building_for_run.jsp" target="f2"><font size="4">Get Evacuation Plan</font></a>
      <!-- Begin 4 columns Item -->

      <!-- End 4 columns container -->
    </li>
    
    <!-- End 4 columns Item -->
    
    <li><a href="Animation.jsp" target="f2"><font size="4">Visualization</a></font></a>
    
    <li class="menu_right"><a href="#" class="drop"><font size="4">Help</font></a>
      <div class="dropdown_1column align_right">
        <div class="col_1">
          <ul class="simple">
            <li><a href="Help.jsp" target="f2">FAQ</a></li>
            <li><a href="Manual.html" target="f2">Manual</a></li>
            <li><a href="DataModeling.jsp" target="f2">Input data format</a></li>
            <li><a href="References.jsp" target="f2">References</a></li>            
          </ul>
        </div>
      </div>
    </li>

    <!-- End 3 columns Item -->
    
    <li>          </li>
    <li class="menu_right"><b><a href="#" class="drop"><font size="4" color="silver" > <% String a=session.getAttribute("uName").toString(); out.println("Welcome "+a+ "!!"); %></b></font></a>
   		<div class="dropdown_1column align_right">
        <div class="col_1">
          <ul class="simple">
           <li><a href="User_Login.jsp" >Log Out</a></li> 
                        
          </ul>
        </div>
      </div>
    </li>
  	
  	         
  </ul>  
</div>

 <!-- <div id="fot">
  <div id="fotlinks1">
      <br/><p align="right"><h2>Building Evacuation Planner</h2></p>
    </div>
    
  </div> 

<div id="fotlinks6">
  <div align="center">Copyright 2010 Your Website<br />
Thanks to <a href="http://www.makarska-rivijeraapartment.com/">Croatia Makarska Riviera</a></div>
</div> -->
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript">
if (self != top) {
    if (document.images)
        top.location.replace(window.location.href);
    else
        top.location.href = window.location.href;
}
</script>
</head>
<body>
<center>
 <div id="fotlinks1">
      <br/><p align="right"><h2>Building Evacuation Planner</h2></p>
    </div>
</center>    
<table border="0" cellpadding="5" cellspacing="5" width="30%" align="left">
<tr><td></td></tr>
</table>
<table border="0" cellpadding="5" cellspacing="5" width="40%" >
<tr>
<!-- ------------------------------------------------------------------------------------>
<td bgcolor="white">
			<h2>
                        
                            Evacuation in large building complexes
                        
                        </h2>
				<p>
                                <font color ="Black" size="3" face="arial" >
                                <br/>    
                        This tool for evacuation planning will help you to organize your emergency action 
                        plan to evacuate your building, given the topology of the building and 
                        approximate occupancy of the building.<br/><br/>
                        Given the building input as a graph, the tool provides a plan of 
                        how many number of people should be evacuated by which path, so that 
                        it minimizes the evacuation time.<br/><br/>
                        The user can store the building graph with capacity of each room, corridors, 
                        staircase and travel time of each. When there is need of evacuation, user needs 
                        input the approximate number of persons currently at the places.<br/><br/>
                        In this project, we explore algorithms to carry out evaluation planning from large buildings (offering multiple exits, multi-modal travel options) taking into account capacity constraints as well as priorities in evacuation. We also consider specific scenario of a building for example fire, bomb blast where we need to focus on the priority of a node based on its danger level. We also provide interface for visualization of a building where we can visualize the situation of building in a particular timestamp as well as path going from a source node.
<br/><br/> For more details Contact us at: <a href="mailto:giseiitb@gmail.com"><b>giseiitb@gmail.com</b></a>
                                </font>    
                                </p>					
</td>
</tr>
 </table>
<table border="0" cellpadding="5" cellspacing="5" width="30%">

<tr>
<!-------------------------------------------------------------------------------------->

<center>
    <form method="post" action="UserVerification.jsp">
    <div id="fot">
 
    
  </div> 
	<center>
	
            <table border="0" cellpadding="3" align="center" bgcolor="gray" >
                <thead>
                    <tr>
                        <th colspan="2">Login</th>
                    </tr>
                </thead>
                <tbody>
                	
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="pwd" value="" /></td>
                    </tr>
                   
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Login" /><input type="reset" value="Reset" /></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td >Not yet  registered?? <a href="Registration_User.jsp">Register Here</a></td>
                    </tr>
                </tbody>
            </table>
            
              
            </center>
        </form>
</center>       
<!-- <a href="frame3.jsp"><font color="black"><b> Back </b></font></a> --> 

</tr>
</table>
</body>
</html>
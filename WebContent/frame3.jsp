<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
<body vlink="black" alink="black" link="black">
 
<!-- <table border="0" cellpadding="5" cellspacing="5" width="70%" align="center">
<tr>
----------------------------------------------------------------------------------
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
 </table> -->
 
 
	
	
            <!-- 
                <thead>
                	
                    <tr>
                    <h2>
                        <th colspan="2" rowspan="3">Register here</th>
                        </h2>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td ><input type="submit" value="SignUp" /><input type="reset" value="Reset" /></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td >Already registered?? <a href="User_Login.jsp">Login Here</a></td>
                    </tr>
                </tbody>
            </table>
             -->
       
       <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td>
                    <a href="view_basic_data.jsp"><font color="black"><b>1. View Basic information of a building </b></font></a><br/><br/>                        
                    <a href="view_scenario.jsp"><font color="black"><b>2. View Scenario of a building </b></font></a><br/><br>
                    <a href="view_ladderplacement_data.jsp"><font color="black"><b>3. View Ladder Placement information of a building </b></font></a><br/><br/>                        
                    <a href="view_name.jsp"><font color="black"><b>4. All Scenario name of a building</b></font></a><br/><br/>
                    <a href="view_history.jsp"><font color="black"><b>5. View past runs</b></font></a><br/><br/>
                    
                </td>
            </tr>
        </table>    
</body>
</html>
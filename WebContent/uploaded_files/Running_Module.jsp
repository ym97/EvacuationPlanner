<%-- 
    Document   : Running_Module
    Created on : Feb 18, 2012, 9:26:52 AM
    Author     : abc
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
<script type="text/javascript">
function changeVisibility(id){
    if(id.checked)
        document.getElementById("ladder").style.visibility="visible";
    else{
        document.getElementById("ladder").style.visibility="hidden";
        document.getElementById("ladderNum").value="0";        
    }
}
</script>

    </head>
<body>
<center>    
<table border="0" cellpadding="2" cellspacing="2" width="100%">
<tr>
<td width="30%"> </td>
<td bgcolor=#EDFBBB><font size="4"><a href ="index11.jsp">Home</a></td>
<td bgcolor=#EDFBBB><font size="4">Planning</td>
<td bgcolor=#EDFBBB><font size="4">Application</td>
<td bgcolor=#EDFBBB><font size="4">Data Modeling</td>
<td bgcolor=#EDFBBB><font size="4">References</td>
<td bgcolor=#EDFBBB><font size="4">Help</td>
<td width="30%"> </td>
</tr>
</table>
</center>
<br>
<!--<font color="blue" size="4"> Database Selected "spatial-db</font><br><br>
<FONT color="RED" size="3">Help in Using System</FONT>
-->
<table border="1" cellpadding="5" cellspacing="5" width="100%">
<tr>
<td bgcolor=#EDFBBB width="20%">

     <table>         
         <tr><td><font size="4"><center>Register Building,Here</center></td></tr>     
         <tr><td><center><img src ="img_building.jpg" width="200" height="400"/></center><td></tr>
     </table>

</td>
<!-- ------------------------------------------------------------------------------------>
<td bgcolor=#EDFBBB>
<center>
<center>
	<form action="BuildingEvacuationPlanner" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
	<table>
            <tr>
                <td>Building Name</td> 
                <td><input type="text" name="userName"></input></td>
            </tr>
            <tr>
                <td>Node File </td>
                <td><input type="file" name="file1"><!-- Here You Can Add more numbers of Files For Uploading --></td>
            </tr>
	    <tr>
                <td>Edge File </td>
                <td><input type="file" name="file1"> </td>
            </tr>
            </table>            
                <input type="checkbox" onclick="changeVisibility(this)">With Ladders<label id="ladder"style="visibility: hidden">&nbsp;&nbsp;Number of ladders <input type="text" size="10" id="ladderNum" name="ladderNum"  value="0"></label>
                <br>
                <select name="algo" id="algo" >
                <option value="1">CCRP</option>
                <option value="11">HDEEP 1 with Heuristic 1</option>
                <option value="12">HDEEP 1 with Heuristic 2</option>
                <option value="13">HDEEP 1 with Heuristic 3</option>
                <option value="21">HDEEP 2 with Heuristic 1</option>
                <option value="22">HDEEP 2 with Heuristic 2</option>
                <option value="23">HDEEP 2 with Heuristic 3</option>
                <option value="24">HDEEP 2 with Heuristic 4</option>
                </select>          
        <input type="submit" value="Submit">
	</form>
</center>
</center>
</td>
</tr>
</table>
</body>
</html>

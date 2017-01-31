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
<td bgcolor=#EDFBBB><font size="4"><a href ="index11.jsp"><font size="4">Home</font></a></td>
<td bgcolor=#EDFBBB><font size="4"><a href="Planning.jsp"><font size="4">Planning</font></a></td>
<td bgcolor=#EDFBBB><font size="4"><a href="Application.jsp"><font size="4">Application</font></a></td>
<td bgcolor=#EDFBBB><font size="4"><a  href="DataModeling.jsp"><font size="4">Data Modeling</font></a></td>
<td bgcolor=#EDFBBB><font size="4"><a href="References.jsp"><font size="4">References</font></a></td>
<td bgcolor=#EDFBBB><font size="4"><a href="Help.jsp"><font size="4">Help</font></a></td>
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
<td bgcolor=#EDFBBB width="20%" valign="top" align="left">
<h2>
  <font size="4" >
    Register Building
  </font>
</h2>
<!--
     <table>
         <tr><td align="center" valign="top"><text valign="top">Register Building,Here</text></td></tr>     
         <tr><td>  </td></tr>
         <tr><td>  </td></tr>
         <tr><td>  </td></tr>
         <tr><td>  </td></tr>
         <!--<tr><td valign="top"><img src ="img_building.jpg" width="180" height="400"/></td><tr>-->
    <!-- </table>-->
			<ul>
				<li>
                                <h2><font size="4">Types</font></h2>
                                <ul>
                                    <li><a href ="#"><font color ="Black" size="2.8" face="arial" >Without Dynamic exit</a></li>
                                    <li><a href ="#"><font color ="Black" size="2.8" face="arial" >With Dynamic exit</a></li>
                                    <li><a href ="#"><font color ="Black" size="2.8" face="arial" >With Ladders</a></li>
                                </ul>
                                </li>
				<li>

                                    <h4><font size="4">Types</font></h4>
					<ul>
						<li><a href="#">General CCRP algorithm</a><br/>one line about ccrp</li>
						<li><a href="#">HDEEP1 with huiristic 1</a><br/>Huiristic 1</li>
                                                <li><a href="#">HDEEP1 with huiristic 2</a><br/>Huiristic 2</li>
                                                <li><a href="#">HDEEP2 with huiristic 1</a><br/>Huiristic 1</li>
                                                <li><a href="#">HDEEP2 with huiristic 1</a><br/>Huiristic 2</li>
                                                <li><a href="#">HDEEP2 with huiristic 1</a><br/>Huiristic 3</li>
                                                <li><a href="#">HDEEP2 with huiristic 1</a><br/>Huiristic 4</li>
                                        </ul>
				</li>

				
			</ul>

</td>
<!-- ------------------------------------------------------------------------------------>
<td bgcolor=#EDFBBB valign="top">
<center>
<center>
			<h2>
                        <font size="4" >
                            Planning
                        </font>
                        </h2>
			
				<p>
                                <font color ="Black" size="3" face="arial" >
                                <br/>    
                                1.<a href ="#ccrp"> General CCRP</a> <br/>
                                2.<a href ="#dynamicexit"> Concept of dynamic exit points</a> <br/>
                                3.<a href ="#optimization"> Optimization model</a> <br/>
                              
                                ----------------------------------------
                                <br/>
                                <br/>
                                </font>    
                                <font color ="Black" size="3" face="arial" >
                                    1. <a name ="ccrp">General CCRP </a><br/>    
                                </font>    
                                <font color ="Black" size="3" face="arial" >
                                    2. <a name ="dynamicexit">Concept of dynamic exit points </a><br/>    
                                </font>
                                <font color ="Black" size="3" face="arial" >
                                    3. <a name ="optimization">Optimization model</a><br/>    
                                </font>        
                                </p>
			
			
</center>
</center>
</td>
<td bgcolor=#EDFBBB width="15%"></td>
</tr>
</table>
</body>
</html>
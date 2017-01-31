<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr><td colspan="8" valign="top" bgcolor="white">    
                    <table border="1" cellpadding="5" cellspacing="5" width="10%">    
                        <tr><th>Node data</th></tr>    
                        <tr><td valign="top">Node ID</td><td valign="top">Node Name</td><td valign="top">Floor</td><td valign="top">Actual Capacity</td><td valign="top">Initial Capacity</td><td valign="top">Latitude</td><td valign="top">Longitude</td><td valign="top">Ladder placement</td></tr>        
                    </table>  
            </tr> 


            <tr><td colspan="8" valign="top" bgcolor="white">
                    <table border="1" cellpadding="5" cellspacing="5" width="10%">   
                        <tr><th>Edge data</th></tr>
                        <tr><td valign="top">Edge ID</td><td valign="top">Edge Name</td><td valign="top">Start Node</td><td valign="top">End Node</td><td valign="top">Travel Time</td><td valign="top">Edge Capacity</td><td valign="top">Floor Number</td><td valign="top">Edge Name</td></tr>                            
                    </table>
                </td>  
            </tr>


            <tr><td colspan="14" valign="top" bgcolor="white">
                    <table border="1" cellpadding="5" cellspacing="5" width="10%"> 
                        <tr><th colspan="2">Node data with Ladder</th></tr>   
                        <tr><td valign="top">Node ID</td><td valign="top">Node Name</td><td valign="top">Floor</td><td valign="top">Actual Capacity</td><td valign="top">Initial Capacity</td><td valign="top">Latitude</td><td valign="top">Longitude</td><td valign="top">Ladder placement</td>
                            <td valign="top">Number of Ladder</td><td valign="top">Ladder Load</td><td valign="top">Ladder TravelTime</td><td valign="top">Ladder Capacity</td><td valign="top">Ladder Start Node</td><td valign="top">Ladder End Node</td></tr>        
                    </table>
                </td>  
            </tr>


            <tr><td colspan="4" valign="top">
                    <table border="1" cellpadding="5" cellspacing="5" width="10%"> 
                        <tr><th colspan="2">Node data with Scenario</th></tr>   
                        <tr><td valign="top">Node ID</td><td valign="top">Danger Level</td><td valign="top">Floor</td><td valign="top">Waiting Time</td></tr>        
                    </table>
                </td>
            </tr>
        </table>

</body>
</html>
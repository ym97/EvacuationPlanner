
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">
                    <h2>
                        <font size="4" >
                            Loading an image
                        </font>
                    </h2>
                </td>
                <tr>
                <%String buildingName = request.getParameter("building_name");%>
                For building: <%out.println(buildingName);%>
            <form action="RegisterBuilding2" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
                <input type="hidden" name="building_name" value = <% out.println(request.getParameter("building_name"));%>/>
                <tr><td>Floor Number</td><td><input type="text" name="flr_num"/></td>
                    <td>Upload Image </td><td><input type="file" name="file1"/></td>                
                </tr>
                <tr><td><input type="submit" value="Submit"/></td></tr>
            </form> 
        </table>
    </body>
</html>            
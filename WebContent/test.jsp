<%-- 
    Document   : test
    Created on : Jun 2, 2013, 11:56:29 AM
    Author     : kabii
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@include file="connectionString.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.*"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%String building_name = (String)session.getAttribute("building_name");
        String scenario_desc = (String)session.getAttribute("scenario_desc");
        int scenario_id = (Integer)session.getAttribute("scenario_id");
                out.println("testingggggggg : " + building_name + scenario_desc+ scenario_id);%>
    </body>
</html>

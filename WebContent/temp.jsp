<%@ page import = "in.ac.iitb.gise.Algorithms.MainP" %>
<%@ page import = "sensors.Algorithm.MainProgram" %>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
<% 
	
	String scenario = session.getAttribute("scenario_name").toString();
	String building = session.getAttribute("building_name").toString();
	String algo = request.getParameter("algo");
	

	 out.println("Building : "+building);
	 out.println("Scenario : "+scenario);
	   
	    
	connectionString cs = new connectionString();
	String url = cs.url;
	String username = cs.username;
	String password = cs.password;
	System.out.println(scenario+" "+ building);
	System.out.println(url+" "+ username+" "+ password);
	int run_id=-1;
	if(algo.equalsIgnoreCase("CCRP_extended")){
		MainP myObject = new MainP();
		run_id =myObject.startEvacuationPlanner(url, username, password, scenario, building, algo);
	}
	else{
		MainProgram myObject = new MainProgram();
		run_id =myObject.startEvacuationPlanner(url, username, password, scenario, building, algo);

	}
	
	session.setAttribute("run_id", run_id);
	String redirectURL = "output_option.jsp";
 	 response.sendRedirect(redirectURL);  
%>
 </center>
</body>
</html>
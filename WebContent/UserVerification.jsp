<%@include file="connectionString.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%--@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<table border="0" cellpadding="5" cellspacing="5" width="40%">
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
            <table border="0" cellpadding="3" align="center" bgcolor="gray">
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
                        <td><input type="reset" value="Reset" /><input type="submit" value="Login" /></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td >Not yet  registered?? <a href="Registration_User.jsp">Register Here</a></td>
                    </tr>
               
	<%
        String uName = request.getParameter("uname");
        String pwd = request.getParameter("pwd");
        
        session.setAttribute("uName", uName);
        session.setAttribute("pwd", pwd);
        
        
        //String userType = request.getParameter("usertype");
        
        connectionString cs = new connectionString();
        String url = cs.url;
        String username = cs.username;
        String password = cs.password;
        String name_exists = "";
        try {
			
            
            
            Class.forName("org.postgresql.Driver");
            //String url = "jdbc:postgresql://localhost:5432/MTP";
            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
            Connection con = DriverManager.getConnection(url, username, password);
            ResultSet rs = null;

            //out.println("connection established");
            Statement s = con.createStatement();
            String create_user_table = "CREATE TABLE IF NOT EXISTS users(user_id SERIAL NOT NULL PRIMARY KEY, username varchar(225) NOT NULL UNIQUE, password varchar(225) NOT NULL, email varchar(225) NOT NULL UNIQUE, first_name varchar(225) NOT NULL, last_name varchar(225) NOT NULL, email building_name(5000))";
            s.executeUpdate(create_user_table);

            String readEntry = "SELECT * FROM users";
            boolean flag = false;
            String uName_ = null;
            String pwd_= null;
            rs = s.executeQuery(readEntry);
            while (rs.next()) {
            	uName_ = rs.getString("username");
            	System.err.println("Here");
            	
            	pwd_=rs.getString("password");
            	System.err.println("Here2");
                //out.println(""+b_name);
                if (uName_.equals(uName)) {
                	if(pwd_.equals(pwd) )
                		 flag=true;
                		
                	
                } // if building name is already present then send a message 
            }
            if (!flag) {
       %>
       <tr>
                           <td></td>
                           <td><font color="red">  <b>Wrong username or password. Try again. </b></font></td> 
                       
       </tr>                
                       
       <%      } else {
    	  
    	 String redirectURL = "index.jsp";
      	 response.sendRedirect(redirectURL);  
        }
       
            rs.close();
            s.close();
            con.close();
        } catch (Exception e) {//Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }

    %>    
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
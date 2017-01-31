<%@include file="connectionString.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>

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
<table border="0" cellpadding="5" align="center" bgcolor="gray">
                <thead>
                	
                    <tr>
                    	<h2>
                        <th colspan="2" rowspan="3">Register here</th>
                        </h2>
                    </tr>
                </thead>
                <tbody>
                <tr>
                        <td>First Name</td>
                        <td><input type="text" name="fName" value="" /></td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td><input type="text" name="lName" value="" /></td>
                    </tr>
                   
                    <tr>
                       <td>Enter Username</td>
                        <td><input type="text" name="uname" value="" /></td>
                      
                    </tr>
                    
                    <tr>
                    	<td>Enter password</td>
                        <td><input type="password" name="pwd" value="" /></td>
                    </tr>
                   <tr>
                        <td>Email</td>
                        <td><input type="text" name="email" value="" /></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td ><input type="submit" value="Register" /><input type="reset" value="Reset" /></td>
                    </tr>
           
	<%
        String uName = request.getParameter("uname");
        String pwd = request.getParameter("pwd");
        String eid = request.getParameter("email");
        String fName = request.getParameter("fName");
        String lName = request.getParameter("lName");
      	System.out.println(uName+" "+pwd+" "+eid+" "+fName+" "+lName);
        if(uName==null || pwd==null || eid==null || fName==null || lName==null){%>
		<tr><td></td>
			<td><font color="red">  <b>
      		 Fill empty fields</b><br/>
    		</font></td>
		</tr>	
		<%
  		}
        else{	
        session.setAttribute("uname", uName);
        session.setAttribute("pwd", pwd);
        session.setAttribute("eid", eid);
        session.setAttribute("fName", fName);
        session.setAttribute("lName", lName);
        //String userType = request.getParameter("usertype");
        
        connectionString cs = new connectionString();
        String url = cs.url;
        String username = cs.username;
        String password = cs.password;
        String name_exists = "";
        
        
        //======================================================
/*         		public static void sendEmailRegistrationLink(String id, String email, String hash) throws AddressException, MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", Setup.MAIL_SMTP_HOST);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
          new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Setup.MAIL_USERNAME, Setup.MAIL_PASSWORD);
            }
          });

        String link = Setup.MAIL_REGISTRATION_SITE_LINK+"?scope=activation&userId="+id+"&hash="+hash;
        
          StringBuilder bodyText = new StringBuilder(); 
            bodyText.append("<div>")
                 .append("  Dear User<br/><br/>")
                 .append("  Thank you for registration. Your mail ("+email+") is under verification<br/>")
                 .append("  Please click <a href=\""+link+"\">here</a> or open below link in browser<br/>")
                 .append("  <a href=\""+link+"\">"+link+"</a>")
                 .append("  <br/><br/>")
                 .append("  Thanks,<br/>")
                 .append("  SodhanaLibrary Team")
                 .append("</div>");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Setup.MAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(email));
            message.setSubject("Email Registration");
            message.setContent(bodyText.toString(), "text/html; charset=utf-8");
            Transport.send(message);
    }
 */        //======================================================
       /*  String result;
        // Recipient's email ID needs to be mentioned.
        String to = eid;

        // Sender's email ID needs to be mentioned
        //PWD=root123gise
        String from = "giseiitb.evacuationplan@gmail.com";

        // Assuming you are sending email from localhost
        String host = "localhost";

        // Get system properties object
        Properties properties = System.getProperties();

        // Setup mail server
        properties.setProperty("mail.smtp.host", host);

        // Get the default Session object.
        Session mailSession = Session.getDefaultInstance(properties);

        try{
        	
            String link = Setup.MAIL_REGISTRATION_SITE_LINK+"?scope=activation&userId="+uName+"&hash="+hash;
            
            StringBuilder bodyText = new StringBuilder(); 
              bodyText.append("<div>")
                   .append("  Dear User<br/><br/>")
                   .append("  Thank you for registration. Your mail ("+eid+") is under verification<br/>")
                   .append("  Please click <a href=\""+link+"\">here</a> or open below link in browser<br/>")
                   .append("  <a href=\""+link+"\">"+link+"</a>")
                   .append("  <br/><br/>")
                   
                   .append("</div>");

           // Create a default MimeMessage object.
           MimeMessage message = new MimeMessage(mailSession);
           // Set From: header field of the header.
           message.setFrom(new InternetAddress(from));
           // Set To: header field of the header.
           message.addRecipient(Message.RecipientType.TO,
                                    new InternetAddress(to));
           // Set Subject: header field
            message.setSubject("Email Registration");
           // Now set the actual message
            message.setContent(bodyText.toString(), "text/html; charset=utf-8");
           // Send message
           Transport.send(message);
           result = "Sent message successfully....";
        }catch (MessagingException mex) {
           mex.printStackTrace();
           result = "Error: unable to send message....";
        }

        
 */        
        try {
            
            Class.forName("org.postgresql.Driver");
            //String url = "jdbc:postgresql://localhost:5432/MTP";
            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
            Connection con = DriverManager.getConnection(url, username, password);
            ResultSet rs = null;
            
            
            //out.println("connection established");
            Statement s = con.createStatement();
             /* String del="drop table users";
            s.execute(del);  */
            String create_user_table = "CREATE TABLE IF NOT EXISTS users(user_id SERIAL NOT NULL PRIMARY KEY, username varchar(225) NOT NULL UNIQUE, password varchar(225) NOT NULL, email varchar(225) NOT NULL UNIQUE, first_name varchar(225) NOT NULL, last_name varchar(225) NOT NULL, building_name varchar(5000)"+")";/*   email_verification_hash varchar(45) DEFAULT NULL,"+ */
            		/*   "email_verification_attempts int(11) DEFAULT NULL,"+
            		  "status varchar(15) DEFAULT 'new',"+
            		  "created_time timestamp NULL DEFAULT CURRENT_TIMESTAMP,"+ */
			
            s.executeUpdate(create_user_table);

            String readEntry = "SELECT * FROM users";
            boolean flag = false;
            String uName_ = null;
            String pwd_= null;
            rs = s.executeQuery(readEntry);
            while (rs.next()) {
            	uName_ = rs.getString("username");
            	pwd_=rs.getString("password");
            	//System.out.println("&&&& "+uName);
                //out.println(""+b_name);
                if (uName_.equals(uName))
                		 flag=true;
                } // if user name is already present then send a message 
            
            	  if (flag) {
       %>
 						<tr>
 							<td>
                        		<font color="red">  <b>
                          		 Username already exists.</b><br/>
                        		</font>
                      		 </td>
                       		<td>
                       			 <a href="Registration_User.jsp"><font color ="blue">Please try again  Here.</font></a> <br/>
                       		 </td>
                        </tr>
       <%          }
       				else {
    	  	
                            String ins = "INSERT INTO users(username, password, email, first_name, last_name) VALUES('" + uName +"', '"+pwd+"', '"+eid+"', '"+fName+"', '"+lName+"')";
                            s.executeUpdate(ins);
                            System.out.println("Here");
                            FileWriter fstream = new FileWriter(getServletContext().getRealPath("") + "/User_Name.txt", true);
                            System.out.println("Here1");
                            BufferedWriter out11 = new BufferedWriter(fstream);
                            out11.write(uName);
                            //out11.write(count2);
                            out11.write("\n");
                            System.out.println("Here");
                            //Close the output stream
                            out11.close();
                            //}
                            /*String q1 = "Select * from users where user_name = '" + uName + "'";
                            rs = (s.executeQuery(q1));
                             int user_id = 0;
                            while (rs.next()) {
                                user_id = rs.getInt("user_id");
                              
                            } */
        			}
        
            rs.close();
            s.close();
            con.close();
            String redirectURL = "User_Login.jsp";
         	 response.sendRedirect(redirectURL);  
        } catch (Exception e) {//Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }
        }
    %>    
              
                </tbody>
            </table>      
</body>
</html>
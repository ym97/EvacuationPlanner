<%-- 
    Document   : newjsp
    Created on : May 6, 2012, 4:42:07 PM
    Author     : abc
--%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
    </head>
    <body>
        <h1>Hello World!</h1>
        <FORM method="post">

your response:<BR>
<TEXTAREA NAME="comments" COLS=40 ROWS=6>
John said
: I think it's a great idea \n
: but it needs more thought \n
</TEXTAREA>

<P><INPUT TYPE=SUBMIT VALUE="submit">
    </FORM>
    <%
    String ss = getServletContext().getRealPath("")+"/"+"Result";
               File s1 = new File(ss); 
               s1.createNewFile();
    //s1.delete();
    //File s1_new = new File(ss);
    //ss.createNewFile();      
               FileWriter fstream = new FileWriter(ss, true);
               BufferedWriter out12 = new BufferedWriter(fstream);
               out12.write("comments");
               out12.close();
    out.println("comments");%>    
    </body>
</html>

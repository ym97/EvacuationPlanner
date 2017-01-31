<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
            <td>
                <%
                    String building_name = request.getParameter("building_name");
                    String view_option = request.getParameter("view_opt");
                    int view_opt = Integer.parseInt(view_option);
                    System.out.println("before session set :" + building_name);
                    request.setAttribute("build", building_name);
                    //session.setAttribute("view_opt", view_opt);
                    RequestDispatcher dis = null;
                    if(view_opt == 1) {
                        // response.sendRedirect("view_basic_data.jsp?building_name=" + building_name);
                        request.getRequestDispatcher("view_basic_data.jsp?building_name="+building_name);
                        dis.forward(request, response);
                                         }  %>
                <%--jsp:forward page="view_basic_data.jsp">
        <jsp param ="building_name" value=<%=building_name%>>
        </jsp:forward--%>


                <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

        </tr>
    </table>
</body>
</html>

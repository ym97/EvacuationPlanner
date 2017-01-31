<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">
                    <h2>
                        <font size="4" >
                            Edge Information of building:<% out.println(request.getParameter("building_name"));%>
                        </font>
                    </h2>

                    <table border="1" cellpadding="5" cellspacing="5" width="10%">    
                        <%
                            String building_name = request.getParameter("building_name");
                            //System.out.println("Hello");
                            try {
                                String ss = getServletContext().getRealPath("") + "/" + building_name + "_Static_Edge_data";
                                File s1 = new File(ss);
                                s1.delete();
                                FileWriter fstream = new FileWriter(ss, true);
                                BufferedWriter out12 = new BufferedWriter(fstream);

                                String i1 = request.getParameter("token_number");
                                String j1 = request.getParameter("j");
                                int i1_ = Integer.parseInt(i1);
                                int j1_ = Integer.parseInt(j1);
                                int k = 0, l = 0;
                                String token = "token_" + i1_ + "_" + j1_;
                                for (k = 0; k < j1_; k++) {
                        %><tr><%
                                    for (l = 0; l < i1_; l++) {
                            %><td><%
                                     token = "token_" + l + "_" + k;
                                     out.println(request.getParameter(token));
                                     out12.write(request.getParameter(token) + ",");
                                %></td><%
                                     }
                                     out12.write("\n");
                                %></tr><%
                                     }
                                     out12.close();
                                  } catch (Exception e) {//Catch exception if any
                                System.err.println("Error: " + e.getMessage());
                                //out.println(count2);
                            }
                            %>
                        </table>
                </td>
            </tr>
        </table>
    </body>
</html>

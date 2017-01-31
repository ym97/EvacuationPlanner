<%-- 
    Document   : Running_Module
    Created on : Feb 18, 2012, 9:26:52 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%    
    	//String image;
    int buildingId = 0;
%>
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <table border="0" cellpadding="5" cellspacing="5" width="100%">
        <tr>
            <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white">  
                <center>
                    <%
                        connectionString cs = new connectionString();
                        String url = cs.url;
                        String username = cs.username;
                        String password = cs.password;
                        String name_exists = "";
                        try {
                            
                        	
                        	
                        	    
                        	System.out.println("IN input_files");
                            String buildingName = session.getAttribute("building_name").toString();
                            System.out.println("Here");
                            System.out.println("buildingName "+buildingName);
                            String description = session.getAttribute("description").toString();
                        	String floors = session.getAttribute("floors").toString();
                        	//image = request.getParameter("floors");
                            String uName = session.getAttribute("uName").toString();
                            
                            
                            
                            Class.forName("org.postgresql.Driver");
                            //String url = "jdbc:postgresql://localhost:5432/MTP";
                            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                            Connection con = DriverManager.getConnection(url, username, password);
                            ResultSet rs = null;

                            //out.println("connection established");
                            Statement s = con.createStatement();
                            String create_build_table = "CREATE TABLE IF NOT EXISTS buildings(building_name varchar(225) NOT NULL PRIMARY KEY, creator character varying(225) REFERENCES users(username) ON DELETE CASCADE, floors integer, description varchar(225), timestmp timestamp with time zone NOT NULL default now(), image bytea, image_name character varying(5000)) ";
                            s.executeUpdate(create_build_table);

                            String readEntry = "SELECT building_name FROM buildings where creator = '"+uName+"'";
                            boolean flag = false;
                            String b_name = null;
                            rs = s.executeQuery(readEntry);
                            while (rs.next()) {
                                b_name = rs.getString("building_name");
                                //out.println(""+b_name);
                                if (b_name.equals(buildingName)) {
                                    flag = true;
                                } // if building name is already present then send a message 
                            }
                            if (flag) {
                    %>
                    <font color="red"> The Building with name <b><font color="blue">"</font>
                            <%out.println(buildingName);%><font color="blue">"</font></b> already exist. <br/>
                        Please Register again. </font> <br/><br/> <a href="Register_Building.jsp"><font color ="black">Register Building Here</font></a> <br/>
                        <%          } else {
                        	System.out.println("inserting "+buildingName+" "+uName+" "+floors+" "+description);
                            String ins = "INSERT INTO buildings(building_name, creator, floors, description) VALUES('" + buildingName + "', '"+ uName+"', '"+ floors+"', '"+ description+"')";
                            s.executeUpdate(ins);
                            FileWriter fstream = new FileWriter(getServletContext().getRealPath("") + "/Building_Name.txt", true);
                            BufferedWriter out11 = new BufferedWriter(fstream);
                            out11.write(buildingName);
                            //out11.write(count2);
                            out11.write("\n");

                            //Close the output stream
                            out11.close();
                            //}
                            String q1 = "SELECT * FROM buildings where creator = '"+uName+"'";
                            /* rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //   System.out.println("print building iddddd" + building_id);
                            }
                            session.setAttribute("building_id", building_id ); */
                            
                            
                            
                            
                           // File file = new File("myimage.gif");
                            /* FileInputStream fis = new FileInputStream(file);
                            PreparedStatement ps = con.prepareStatement("INSERT INTO buildings(image_name, ) VALUES (?, ?)");
                            ps.setString(1, file.getName());
                            ps.setBinaryStream(2, fis, (int)file.length());
                            ps.executeUpdate();
                            ps.close();
                            fis.close(); */
                            
                            
                        %>    
                </center>
                <font size="4"><b>
                        Add the data for building :  '
                        <%
                            //                   buildingName = buildingName.replace("_", " ");
                            out.println(buildingName);
                            //                 buildingName = buildingName.replace(" ", "_");
%>'
                    </b></font>
                <br/><br/>
                <table><tr>
                        <td><font color=#105690><b>1.</b> </td>
                        <td><font color=#105690><b>Add Data from Files </b></font> </td>
                    </tr>            
                    <tr><td></td><td>            
                            <font color="black"> Enter data files of Nodes and Edges. 
                            </font>
                            <br>Enter Node file[Format: (NodeId, NodeName, MaximumCapacity, FloorNo, Latitude, Longitude, Contains_Node_Ladder)]
                            <br/>
                            <form action="RegisterBuilding3" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="building_name" value = <% out.println(buildingName);%> />
                                <%
                                %>

                                <table>    
                                    <tr>
                                        <td>Node File </td>
                                        <td><input type="file" name="file1"><!-- Here You Can Add more numbers of Files For Uploading --></td>
                                    </tr>
                                    <tr>
                                    	<td><input type="submit" value="Submit"></td>
                                    </tr>
                                </table>
                            </form>                     
                        </td></tr>
                    <tr></tr><tr><td></td><td bgcolor=#105690></td></tr>
                    <tr>
                        <td><font color=#105690><b>2.</b></td>
                        <td><font color=#105690><b>Add data as nodes and edges one by one.</b></font></td>
                    </tr>
                    <tr><td></td><td>
                            If there is no data file, enter the data with by adding nodes and edges one by one<!--<a href="edit_data.jsp"><font color="red">option</font></a>-->.</font>
                            <br/>
                            <%-- <%
                                String q2 = "CREATE TABLE IF NOT EXISTS node_" + building_id + "_withoutladder(building_id integer, node_id integer, node_name varchar(225), floor varchar(225), max_cap integer, /* in_cap integer, */ lat numeric , long numeric, node_type varchar(225), fit_people integer DEFAULT 0, injured_people integer DEFAULT 0, rescuers integer DEFAULT 0)";
                                s.executeUpdate(q2);
                                String q3 = "CREATE TABLE IF NOT EXISTS edge_" + building_id + "(building_id integer, edge_id integer, edge_name varchar(225), start_node integer, end_node integer, time numeric, capacity integer,edge_floor varchar(255))";
    //System.out.println("inside input_files for 2nd opt : " + q3);                            
    s.executeUpdate(q3);%> --%>
                            <form action="add_another_node.jsp" method="post" name="Add Node">

                                <input type="hidden" name="building_name" value = <% out.println(buildingName);%> >
                                <input type="submit" value="Add node">
                            </form>
                        </td>
                    </tr>
                    <tr><td></td><td>
                            <form action="add_another_edge.jsp" method="post" name="Add Edge">
                                <input type="hidden" name="building_name" value = <% out.println(buildingName);%> >
                                <input type="submit" value="Add Edge">
                            </form>
                        </td></tr>
                    <tr></tr><tr><td></td><td bgcolor=#105690 width=100%></td></tr>                
                    <tr>
                        <td><b><font color=#105690>3.</b></td>
                        <td><b><font color=#105690>Add image of the plan and then add nodes and edges with reference to floor plans.</b></td></font>   
                    </tr>
                    <tr>
                    <form action="RegisterBuilding2" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="building_name" value = <% out.println(buildingName);%> >
                        <tr><td></td>
                            <td>
                                <table>
                                    <tr>    
                                        <td>Floor Number</td><td><input type="text" name="flr_num"></td>
                                        <td>Upload Image </td>
                                        <td><input type="file" name="file1"><!-- Here You Can Add more numbers of Files For Uploading --></td>                
                                    </tr>
                                    <tr><td>
                                            <input type="submit" value="Submit">
                                        </td>
                                    </tr>
                                </table>
                            </td>                
                    </form> 
        </tr>    
        <tr></tr><tr></tr>
        <tr><td></td><td>                                
            </td>
        </tr>  
    </table>    
    <%
            }
            rs.close();
            s.close();
            con.close();
        } catch (Exception e) {//Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }

    %>
</td>
</tr>
</table>
</body>
</html>

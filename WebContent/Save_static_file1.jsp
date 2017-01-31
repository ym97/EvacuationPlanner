<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.*"%> 
<%--@ page contentType="text/html;charset=UTF-8" language="java" --%>
<%
	String uName = session.getAttribute("uName").toString();
    boolean uploadSuccess = false;
    String filePath = getServletContext().getRealPath("") + "/" + request.getAttribute("value").toString();
    System.out.println(getServletContext().getRealPath("") + "/../.." + filePath);
    String optionalFileName1 = "", optionalFileName2 = "";
    //String buildingName = request.getParameter("building_name");
    String buildingName = (String) session.getAttribute("building_name");

    String file_name1 = "";
    String filePathArray[] = new String[2];
    FileItem fileItem = null;
    int count = 0;
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
    } else {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = null;
        try {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
            Object obj = itr.next();
            FileItem item = (FileItem) obj;
            if (item.isFormField()) {
                if (item.getFieldName().equals("building_name")) {
                    buildingName = item.getString();
                } else if (item.getFieldName().equals("file2")) {
                    optionalFileName1 = item.getString();
                }

            } else {
                fileItem = item;

                try {
                    uploadSuccess = false;
                    String itemName = item.getName();
                    File savedFile = new File(filePath + itemName);
                    item.write(savedFile);
                    System.out.println("savedFile : " + savedFile.toString());
                    uploadSuccess = true;
                    filePathArray[count++] = filePath + itemName;

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }


            if (fileItem != null) {

                /*
                 * Save the uploaded file if its size is greater than 0.
                 */

                //String dirName = "C:\\Users\\abc\\Desktop\\";     
                String pathname1 = "";
                if (fileItem.getSize() > 0) {
                    if (optionalFileName1.trim().equals("")) //fileName = FilenameUtils.getName(fileName);
                    {
                        file_name1 = buildingName + "_Static_Edge_data";
                        // file_name2 = buildingName+"_Static_Edge_data";
                        filePathArray[0] = getServletContext().getRealPath("") + "/";
                        // filePathArray[1]= "C:\\Users\\abc\\Desktop\\";
                        pathname1 = filePathArray[0] + file_name1;
                        System.out.println("pathname1 : " + pathname1.toString());
                        // pathname2 = filePathArray[1]+file_name2; 
                    } else //fileName = optionalFileName;
                    {
                        System.out.println("Wrong file names");
                    }

                    File saveTo1 = new File(pathname1);
                    //File saveTo2 = new File(pathname2);
                    try {
                        fileItem.write(saveTo1);
                        //fileItem.write(saveTo2);
                        /*
                         * connectionString cs = new connectionString(); String
                         * url = cs.url; String username = cs.username; String
                         * password = cs.password; try {
                         * Class.forName("org.postgresql.Driver"); //String url
                         * = "jdbc:postgresql://localhost:5432/MTP";
                         * //Connection con = DriverManager.getConnection(url,
                         * "postgres", "postgres"); Connection con =
                         * DriverManager.getConnection(url, username, password);
                         * ResultSet rs = null;
                         * System.out.println("connectionnnn stablished");
                         * Statement s = con.createStatement(); String q1 =
                         * "Select * from buildings where building_name = '" +
                         * buildingName + "'"; System.out.println(q1 + "--"); rs
                         * = (s.executeQuery(q1)); int building_id = 0; while
                         * (rs.next()) { building_id = rs.getInt("building_id");
                         * // System.out.println("print building iddddd" +
                         * building_id); } System.out.println("save static file
                         * 1 : building id : " + building_id); String q2 =
                         * "CREATE TABLE IF NOT EXISTS edge_" + building_id +
                         * "(building_id integer , edge_id integer, edge_name
                         * varchar(255), start_node integer, end_node integer,
                         * time numeric, capacity integer, edge_floor
                         * varchar(255))"; System.out.println("create edge query
                         * : " + q2); s.executeUpdate(q2);
                         *
                         * String s1 = getServletContext().getRealPath("") + "/"
                         * + buildingName + "_Static_edge_data"; FileInputStream
                         * fstream = new FileInputStream(s1); // Get the object
                         * of DataInputStream DataInputStream in1 = new
                         * DataInputStream(fstream); BufferedReader br1 = new
                         * BufferedReader(new InputStreamReader(in1)); String
                         * strLine1; //System.out.println("Hello"); //Read File
                         * Line By Line int j = 0; int count_nrow = 0;
                         *
                         * while ((strLine1 = br1.readLine()) != null) {
                         * count_nrow++; String tempArray[] = new String[15];
                         * int index = 0;
                         *
                         *
                         * // Print the content on the console
                         * System.out.println("strline in node " + strLine1);
                         * StringTokenizer st = new StringTokenizer(strLine1,
                         * ","); while (st.hasMoreElements()) { String token =
                         * st.nextToken(); tempArray[index++] = token; } if
                         * (count_nrow == 1) { continue; } else { String ins =
                         * "INSERT INTO edge_" + building_id + " VALUES (" +
                         * building_id + " , " + Integer.parseInt(tempArray[0])
                         * + " , '" + tempArray[1] + "' , " +
                         * Integer.parseInt(tempArray[2]) + " , " +
                         * Integer.parseInt(tempArray[3]) + " , " +
                         * Float.parseFloat(tempArray[4]) + " , " +
                         * Integer.parseInt(tempArray[5]) + ", '" + tempArray[6]
                         * + "' )"; System.out.println("testing in save static
                         * file 1 : " + ins); s.executeUpdate(ins); } } //Close
                         * the input stream in1.close(); rs.close(); s.close();
                         * con.close();
                         *
                         * } catch (Exception e) {//Catch exception if any
                         * System.err.println("Error: " + e.getMessage());
                         * //out.println(count2);
                        }
                         */


%>

<!--<b>The uploaded file has been saved successfully. path -- out.println(saveTo1);--</b>-->

<%
} catch (Exception e) {
%>

<!--<b>An error occurred when we tried to save the uploaded file.</b>-->

<%                    }
                }
            }



        }
    }

    try {
        connectionString cs = new connectionString();
        String url = cs.url;
        String username = cs.username;
        String password = cs.password;

        Class.forName("org.postgresql.Driver");
        //String url = "jdbc:postgresql://localhost:5432/MTP";
        //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
        Connection con = DriverManager.getConnection(url, username, password);
        ResultSet rs = null;
        System.out.println("connectionnnn stablished");
        Statement s = con.createStatement();
        /* String q1 = "SELECT building_id FROM buildings where creator = '"+uName+"' and building_name = '"+buildingName+"'";
        System.out.println(q1 + "--");
        rs = (s.executeQuery(q1));
        int building_id = 0;
        while (rs.next()) {
            building_id = rs.getInt("building_id");
            //   System.out.println("print building iddddd" + building_id);
        } */
        //System.out.println("save static file 1 : building id : " + building_id);
       /*  String q2 = "CREATE TABLE IF NOT EXISTS edge_" + building_id + "(building_id integer , edge_id integer, edge_name varchar(255), start_node integer, end_node integer, time numeric, capacity integer, edge_floor varchar(255))";
        System.out.println("create edge query : " + q2); 
        s.executeUpdate(q2); */

        String s1 = getServletContext().getRealPath("") + "/" + buildingName + "_Static_Edge_data";
        FileInputStream fstream = new FileInputStream(s1);
        // Get the object of DataInputStream
        DataInputStream in1 = new DataInputStream(fstream);
        BufferedReader br1 = new BufferedReader(new InputStreamReader(in1));
        String strLine1;
        //System.out.println("Hello");
        //Read File Line By Line
        int j = 0;
      //  int count_nrow = 0;

        String q3 = "CREATE TABLE IF NOT EXISTS edge (edge_id varchar(225) NOT NULL, edge_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE, floor integer NOT NULL, start_node varchar(225) NOT NULL, end_node varchar(225) NOT NULL, capacity integer NOT NULL, edge_length integer NOT NULL, Primary key(edge_id, building_name))";
        s.executeUpdate(q3);
        while ((strLine1 = br1.readLine()) != null) {
          //  count_nrow++;
            String tempArray[] = new String[15];
            int index = 0;


            // Print the content on the console
            System.out.println("strline in node " + strLine1);
            StringTokenizer st = new StringTokenizer(strLine1, ",");
            while (st.hasMoreElements()) {
                String token = st.nextToken();
                tempArray[index++] = token;
            }
          
            	/* String ins = "INSERT INTO edge VALUES('" + Edge_Id + "', '"+ Edge_name+"', "+building_id + " , " +Integer.parseInt(Edge_floor)+ " , '"+From_Node + "' , '" + To_Node + "' , " + Integer.parseInt(Edge_capacity)+", " +Float.parseFloat(Edge_length)+")"; */
                String ins = "INSERT INTO edge VALUES ('" + tempArray[0] + "' , '" + tempArray[1] + "' , '"+buildingName+"' ," + Integer.parseInt(tempArray[2]) + " , '" + (tempArray[3]) + "' , '" + tempArray[4] + "' , " + tempArray[5] + ", " + Integer.parseInt(tempArray[6]) + " )";
                System.out.println("testing in save static file 1 : " + ins);
                s.executeUpdate(ins);
            
        }
        //Close the input stream
        in1.close();
        rs.close();
        s.close();
        con.close();

    } catch (Exception e) {//Catch exception if any
        System.err.println("Error: " + e.getMessage());
        //out.println(count2);
    }
%>

<!--              
<table border=1 align="center">
    <tr align="center">
        
    </tr>
</table>
-->
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white">   


                <center>
                    <center>                   
                        <font size="4"><b>You have successfully registered the building " <%
                         //   buildingName = buildingName.replace("_", " ");
                            out.println(buildingName);
                          //  buildingName = buildingName.replace(" ", "_");
                                %> ".</b></font>
                        <br/>
                        <a href="run.jsp"><font color="black">You can run the module to see evacuation plan here.</font></a>
                    </center>
                </center>
            </td>
        </tr>
    </table>
</body>
</html>
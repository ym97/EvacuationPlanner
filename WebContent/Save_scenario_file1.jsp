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

    boolean uploadSuccess = false;
    String filePath = getServletContext().getRealPath("") + "/" + request.getAttribute("value").toString();
    System.out.println(getServletContext().getRealPath("") + "/../.." + filePath);
    String optionalFileName1 = "", optionalFileName2 = "";
    String building_name = (String) session.getAttribute("building_name");
    String scenario_desc = (String) session.getAttribute("scenario_desc");
    int scenario_id = (Integer) session.getAttribute("scenario_id");
   // String building_id = (String) session.getAttribute("building_id");
    System.out.println(" ******************** inside savefile1 " + building_name + scenario_id + scenario_desc);
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
        }
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
            Object obj = itr.next();
            FileItem item = (FileItem) obj;
            if (item.isFormField()) {
                if (item.getFieldName().equals("building_name")) {
                    building_name = item.getString();
                } else if (item.getFieldName().equals("file6")) {
                    optionalFileName1 = item.getString();
                }

            } else {
                fileItem = item;
                try {
                    uploadSuccess = false;
                    String itemName = item.getName();
                    File savedFile = new File(filePath + itemName);
                    item.write(savedFile);
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
                        file_name1 = building_name + "_Edge_Scenario_" + "_data";
                        // file_name2 = buildingName+"_Static_Edge_data";
                        filePathArray[0] = getServletContext().getRealPath("") + "/";
                        // filePathArray[1]= "C:\\Users\\abc\\Desktop\\";
                        pathname1 = filePathArray[0] + file_name1;
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
                        connectionString cs = new connectionString();
                        String url = cs.url;
                        String username = cs.username;
                        String password = cs.password;
                        try {
                            Class.forName("org.postgresql.Driver");
                            //String url = "jdbc:postgresql://localhost:5432/MTP";
                            //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                            Connection con = DriverManager.getConnection(url, username, password);
                            ResultSet rs = null;
                            //   System.out.println("connectionnnn stablished");
                            Statement s = con.createStatement();
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                //   System.out.println("print building iddddd" + building_id);
                            } */

                            String s1 = getServletContext().getRealPath("") + "/" + building_name + "_Edge_Scenario_" + "_data";;
                            FileInputStream fstream = new FileInputStream(s1);
                            // Get the object of DataInputStream
                            DataInputStream in1 = new DataInputStream(fstream);
                            BufferedReader br1 = new BufferedReader(new InputStreamReader(in1));
                            String strLine1;
                            //System.out.println("Hello");
                            //Read File Line By Line
                            int j = 0;
                         //   int count_nrow = 0;

                           String q3 = "CREATE TABLE IF NOT EXISTS scenario_edge (sedge_id serial primary key, building_name varchar(225) not null references buildings(building_name) ON DELETE CASCADE, scenario_id integer not null, edge_id varchar(225) not null, scenario_description varchar(255), danger_level integer not null default 1, travel_speed_fit float not null default 1, travel_speed_injured float not null default 1, UNIQUE(building_name, scenario_id, edge_id))";
                                s.executeUpdate(q3);
                                
                            while ((strLine1 = br1.readLine()) != null) {
                              
                                String tempArray[] = new String[15];
                                int index = 0;


                                // Print the content on the console
                                System.out.println("strline in edge " + strLine1);
                                StringTokenizer st = new StringTokenizer(strLine1, ",");
                                while (st.hasMoreElements()) {
                                    String token = st.nextToken();
                                    tempArray[index++] = token;
                                }
                                
                                    String ins = "INSERT INTO scenario_edge VALUES( '" + building_name + "' , "+scenario_id+", '"+tempArray[0] + "' , '" +scenario_desc +"', "+Integer.parseInt(tempArray[1])+", "+Float.parseFloat(tempArray[2])+", "+Float.parseFloat(tempArray[3]) +")";
                                    s.executeUpdate(ins);
                                
                            }
                            //Close the input stream
                            in1.close();
                            s.close();
                            con.close();

                        } catch (Exception e) {//Catch exception if any
                            System.err.println("Error: " + e.getMessage());
                            //out.println(count2);
                        }

                    } catch (Exception e) {
                    }
                }
            }
        }
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
                    <font size="4"><b>You have successfully loaded scenario data for the building " <%
                        building_name = building_name.replace("_", " ");
                        out.println(building_name);
                        building_name = building_name.replace(" ", "_");
                            %> ".</b></font>
                    <br/>
                </center>
           
        </tr>
    </table>
    <form method="post" action="Create_scenario.jsp">
         <input type="submit" value="Back">
    </form>
</body>
</html>
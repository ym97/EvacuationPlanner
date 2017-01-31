<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@include file="connectionString.jsp" %>
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
    System.out.println("file path : " + filePath);
    String optionalFileName1 = "", optionalFileName2 = "";
    String buildingName = session.getAttribute("building_name").toString();   // cant access buildingName here because of encode (null value prints here) 
    //String buildingName = (String) session.getAttribute("building_name");
    /// System.out.println("inside save static file : " + buildingName);

    String file_name1 = "";
    String filePathArray[] = new String[2];
    FileItem fileItem = null;         // fileItem might be uploaded node file or building image or add node option  
    int count = 0;
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    // System.out.println("value of isMulti " + isMultipart );
    if (!isMultipart) {
    } else {

        FileItemFactory factory = new DiskFileItemFactory();         // FileItemFactory: instance for creating fileItem instance
        ServletFileUpload upload = new ServletFileUpload(factory);   // API for processing uploads
        List items = null;
        try {
            items = upload.parseRequest(request);                   // store all registered building name (here node file name)
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
                                   System.out.println("inside item.isFormField buildingName " + buildingName);
                } else if (item.getFieldName().equals("file1")) {       //  if file is uploaded
                    optionalFileName1 = item.getString();
                                 System.out.println("inside item.isFormField  optionalFileName1" + optionalFileName1);
                }

            } else {
                fileItem = item;
/* 
                try {
                    uploadSuccess = false;
                    String itemName = item.getName();
                    File savedFile = new File(filePath + itemName);
                    //System.out.println("wat is saved file?? : " + savedFile.getName());
                    item.write(savedFile);
                    uploadSuccess = true;
                    filePathArray[count++] = filePath + itemName;

                } catch (Exception e) {
                    e.printStackTrace();
                } */
            }


            if (fileItem != null) {
                /*
                 * Save the uploaded file if its size is greater than 0.
                 */

                String pathname1 = "";
                if (fileItem.getSize() > 0) {
                    if (optionalFileName1.trim().equals("")) //fileName = FilenameUtils.getName(fileName);
                    {

                        file_name1 = buildingName + "_Static_Node_data";
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
                            /* String q1 = "SELECT building_id FROM buildings where building_name = '"+buildingName+"' and creator = '"+uName+"'";
                            rs = (s.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                                   System.out.println("print building iddddd" + building_id);
                            } */

                           /*  String q2 = "CREATE TABLE IF NOT EXISTS node_" + building_id + "_withoutladder(building_id integer, node_id integer, node_name varchar(225), floor varchar(225), max_cap integer, in_cap integer, lat numeric , long numeric)";
                            s.executeUpdate(q2); */
                            
                            String s1 = getServletContext().getRealPath("") + "/" + buildingName + "_Static_Node_data";
                            FileInputStream fstream = new FileInputStream(s1);
                            // Get the object of DataInputStream
                            DataInputStream in1 = new DataInputStream(fstream);
                            BufferedReader br1 = new BufferedReader(new InputStreamReader(in1));
                            String strLine1;
                            //System.out.println("Hello");
                            //Read File Line By Line
                            int j = 0;
                           // int count_nrow = 0;
							
                            String q3 = "CREATE TABLE IF NOT EXISTS node(node_id varchar(225) NOT NULL, node_name varchar(225) NOT NULL, building_name varchar(225) NOT NULL references buildings(building_name) ON DELETE CASCADE, capacity integer NOT NULL, floor integer NOT NULL, latitude float NOT NULL, longitude float NOT NULL, node_ladder character varying(5) NOT NULL DEFAULT 'no', Primary key(node_id, building_name))";
                            s.executeUpdate(q3);
                            
                            while ((strLine1 = br1.readLine()) != null) {
                              //  count_nrow++;
                              //  System.out.println(count_nrow);
                                String tempArray[] = new String[15];
                                int index = 0;
                                // Print the content on the console
                                System.out.println("strline in node " + strLine1);
                                StringTokenizer st = new StringTokenizer(strLine1, ",");
                                //System.out.println("Here2");
                                while (st.hasMoreElements()) {
                                    String token = st.nextToken();
                                    tempArray[index++] = token;
                                    System.out.print(token+" ");
                                }
                              
                                 
                                     String ins = "INSERT INTO node VALUES (" +tempArray[0] + " , '" + tempArray[1] + "', '" + buildingName+"', '" +Integer.parseInt(tempArray[2]) + "' , " + Integer.parseInt(tempArray[3]) + " , " + Float.parseFloat(tempArray[4]) + " , " + Float.parseFloat(tempArray[5]) +", '"+  (tempArray[6]) + "')";
                                     s.executeUpdate(ins);
                                    
                            }
                             
                            
                            //Close the input stream
                          // System.out.println("Here3");
                            in1.close();
                            s.close();
          					  con.close();


                        } catch (Exception e) {//Catch exception if any
                            System.err.println("Error: " + e.getMessage());
                            //out.println(count2);
                        }
                    }  catch (Exception e) {
                    } 
                }
            }



        }
    }
    session.setAttribute("building_name", buildingName);  
%>

<html>
    <head>
        <title>Evacuation Planner</title>
    </head>

    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
            <td bgcolor="white">   


              
                    
                        <br/>
                        Successfully Loaded Node file. for <%// buildingName = buildingName.replace("_", " ");
                            out.println(buildingName);
                          //  buildingName = buildingName.replace(" ", "_");
                        %>

                        <br/> Enter Edge File[ Format: (EdgeID, EdgeName, Building, FloorNo, Start_node, End_node, Capacity, Edge_length)]
                        <form action="RegisterBuilding1" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
                            
                            <table>    
                                <tr>
                                <td>Edge File </td>
                                <td><input type="file" name="file2"> </td>
                                <input type="hidden" name="building_name" value = <% out.println(buildingName);%> > 
                               
                                </tr>
                                <tr><td>
                                    <input type="submit" value= "Submit" >
                                </td></tr>
                            </table>
                        </form>                 
                   
               
            </td>
        </tr>
    </table>
</body>
</html>
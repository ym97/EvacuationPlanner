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

    boolean uploadSuccess = false;
    String filePath = getServletContext().getRealPath("") + "/" + request.getAttribute("value").toString();
    System.out.println("file path : " + filePath);
    String optionalFileName1 = "", optionalFileName2 = "";
    String building_name =  session.getAttribute("building_name").toString();
    String scenario_desc =  session.getAttribute("scenario_desc").toString();
    //String building_id =  session.getAttribute("building_id").toString();
    String scenario_id = session.getAttribute("scenario_id").toString();

    System.out.println("inside save static file : "  + scenario_desc + building_name);

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
                    building_name = item.getString();
                    //System.out.println("inside item.isFormField buildingName " + building_name);
                } else if (item.getFieldName().equals("file4")) {       //  if file is uploaded
                    optionalFileName1 = item.getString();
                    //System.out.println("inside item.isFormField  optionalFileName1" + optionalFileName1);
                }

            } else {
                fileItem = item;

               /*  try {
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
                        file_name1 = building_name + "_Node_Scenario_data";
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
                        System.out.println("connectionnnn stablished");
                        Statement s = con.createStatement();
                        
                        String s1 = getServletContext().getRealPath("") + "/" + building_name + "_Node_Scenario_data";

                        System.out.println("s1 : file_name1 " + s1 + file_name1);
                        FileInputStream fstream = new FileInputStream(s1);
                        // Get the object of DataInputStream
                        DataInputStream in1 = new DataInputStream(fstream);
                        BufferedReader br1 = new BufferedReader(new InputStreamReader(in1));
                        String strLine1;
                        //System.out.println("Hello");
                        //Read File Line By Line
                        int j = 0;
                  //      int count_nrow = 0;

                        String check="select exists (select 1 from pg_type where typname = 'node_type');";
						boolean b=s.execute(check);
						if(!b){
							String type_create="CREATE TYPE node_type if not exists AS ENUM ('source', 'destination', 'rescueCentre', 'normal');";
						}
						
                  		String q2 = "CREATE TABLE IF NOT EXISTS scenario_node(snode_id serial primary key, building_name varchar(225) not null references buildings(building_name) ON DELETE CASCADE, scenario_id integer not null, node_id varchar(225) not null, scenario_description varchar(255), node_type node_type default 'source', fit_people integer default 0, injured_people integer default 0, rescuer integer default 0, danger_level integer default 1, priority integer default 1, UNIQUE(building_name, scenario_id, node_id))";
                                s.executeUpdate(q2);

                        while ((strLine1 = br1.readLine()) != null) {
                        //    count_nrow++;
                            String tempArray[] = new String[15];
                            int index = 0;
                            // Print the content on the console
                            System.out.println("strline in node " + strLine1);
                            StringTokenizer st = new StringTokenizer(strLine1, ",");
                            while (st.hasMoreElements()) {
                                String token = st.nextToken();
                                tempArray[index++] = token;
                            }

                            for (int i = 0; i < index; i++) {
                                System.out.println(tempArray[i]);
                            }
                           /*  if (count_nrow == 1) {
                                continue;
                            } else { */
                                String ins = "INSERT INTO scenario_node(building_name, scenario_id, node_id, scenario_description, node_type, fit_people, injured_people, rescuer, danger_level, priority) VALUES(" + building_name + "' , " + Integer.parseInt(scenario_id) +", '"+tempArray[0] + "', " +scenario_desc+", '"+ tempArray[1] + "', " + tempArray[2] +", " + tempArray[3] +", " + tempArray[4] +", " + tempArray[5] +", " + tempArray[6]+ ")";
                                System.out.println(ins);
                                s.executeUpdate(ins);
                           // }
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
                }
            }
        }
    }
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
                <center>
                    <center>
                        <br/>
                        Successfully Loaded Node Scenario file. for <% building_name = building_name.replace("_", " ");
                            out.println(building_name);
                            building_name = building_name.replace(" ", "_");
                        %>

                        <br/> Enter Edge Scenario File.
                        <form action="RegisterBuilding6" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
                            <table>    
                                <tr>
                                <td>Edge Scenario File </td>
                                <td><input type="file" name="file6"> </td>
                                <!--input type="hidden" name="building_name" value = <% out.println(building_name);%> />
                                <input type="hidden" name="scenario_id" value = <% out.println(scenario_id);%> />
                                <input type="hidden" name="scenario_desc" value = <% out.println(scenario_desc);%> /-->

                                </tr>
                                <tr><td>
                                    <input type="submit" value= "Submit" >
                                </td></tr>
                            </table>
                        </form>                 
                    </center>
                </center>
            </td>
        </tr>
    </table>
</body>
</html>
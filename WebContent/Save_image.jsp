<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.*"%> 
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%

    boolean uploadSuccess = false;
    String pathname1 = "";
    String filePath = getServletContext().getRealPath("") + "/" + request.getAttribute("value").toString();  //path where files are going to be upload.. value means folder named "uploaded_files" 
    System.out.println(getServletContext().getRealPath("") + "/../.." + filePath);
    String optionalFileName1 = "", optionalFileName2 = "";
    String buildingName = request.getParameter("building_name");
    String flr_num = request.getParameter("flr_num");
    String file_name1 = "";
    String filePathArray[] = new String[2];
    FileItem fileItem = null;
    int count = 0;
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
        System.out.println("inside if statement : ");
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
                    buildingName = item.getString();
                } else if (item.getFieldName().equals("flr_num")) {
                    flr_num = item.getString();
                } else if (item.getFieldName().equals("file1")) {
                    optionalFileName1 = item.getString();
                }

            } else {
                fileItem = item;
                
                /* try {
                    uploadSuccess = false;
                    
                    String itemName = item.getName();
                    File savedFile = new File(filePath + itemName);
                    item.write(savedFile);
                    System.out.println(" savedFile "+savedFile);
                    
                    uploadSuccess = true;
                    filePathArray[count++] = filePath + itemName;

                } catch (Exception e) {
                    e.printStackTrace();
                } */
                
            }


            if (fileItem != null) {
                if (fileItem.getSize() > 0) {
                    if (optionalFileName1.trim().equals("")) //fileName = FilenameUtils.getName(fileName);
                    {
                    	
                      	 file_name1 = buildingName + "_" + flr_num + "_Floor_plan.png";
                       // file_name2 = buildingName+"_Static_Edge_data";
                       filePathArray[0] = getServletContext().getRealPath("") + "/";
                        //filePathArray[0] = ("C:/users/kabii/Desktop/HDEEP_1_new_may12_withCSS/build/web/");
                        //System.out.println("path for image is : " + filePathArray[0]);
                        // filePathArray[1]= "C:\\Users\\abc\\Desktop\\";
                        pathname1 = filePathArray[0] + file_name1;
                        System.out.println("pathname1 is : " + pathname1);
                        // pathname2 = filePathArray[1]+file_name2; 
                    } else //fileName = optionalFileName;
                    {
                        System.out.println("Wrong file names");
                    }

                    File saveTo1 = new File(pathname1);
                    System.out.println("File saveTo "+saveTo1);
                    try {
                    	System.out.println(saveTo1.toString());
                    	System.out.println("fileItem "+fileItem.toString());
                        fileItem.write(saveTo1);
                        System.out.println("successfully saved.. ");
                    } catch (Exception e) {
                       // System.out.println("in cache");
                        System.out.println(e.getMessage());
                    
                    }
                }
            }
        }
    }
%>

<html>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">   
                    <br/>
                    <%
                        File fi = new File(pathname1);
                        //System.out.println("file name for testinggggg :::" +fi.getName() + file_name1 + fi.getAbsolutePath());
                        if (fi.exists()) {
                    %>
                    <b>Successfully Loaded following Image for '<font color="red"><% //buildingName = buildingName.replace("_", " ");
                        out.println(buildingName);
                       // buildingName = buildingName.replace(" ", "_");
                            %>'</font> for the floor <%out.println(flr_num);
                        } else {
                        %> <font color="red"> <%out.println("There is some problem in uploading image.. Please upload try again later..");
                                }%></font>
                    </b><br/><br/>
                    <table><tr><td><form action="add_node_ref_image.jsp"  method="post">
                                    <input type="hidden" name="building_name" value = <% out.println(buildingName);%>/>
                                    <input type="hidden" name="flr_num" value = <% out.println(flr_num);%>/>            
                                    <input type="submit" name="B1" value="1. Add Nodes with reference to the image"/>
                                </form></td>                    
                        </tr>            
                        <tr><td><form action="add_edge_ref_image.jsp"  method="post">
                                    <input type="hidden" name="building_name" value = <% out.println(buildingName);%>/>
                                    <input type="hidden" name="flr_num" value = <% out.println(flr_num);%>/>
                                    <input type="submit" name="B1" value="2. Add Edges with reference to the image"/>
                                </form></td>
                        </tr>     
                        <tr><td><form action="Load_img_build_name.jsp" >
                                    <input type="hidden" name="building_name" value = <% out.println(buildingName);%>/>
                                    <input type="submit" name="B1" value="3. Add another Floor's plan"/>
                                </form></td>
                        </tr>
                        <tr><td>The Uploaded Image:</td></tr>
                        <tr><td><img src="<%out.println(file_name1);%>" height="100%" width="100%"/></td></tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
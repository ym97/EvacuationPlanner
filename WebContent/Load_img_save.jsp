<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.*"%> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    boolean uploadSuccess = false;
    String pathname1 = "";
    String filePath = getServletContext().getRealPath("") + "/" + request.getAttribute("value").toString();
    System.out.println(getServletContext().getRealPath("") + "/../.." + filePath);
    String optionalFileName1 = "", optionalFileName2 = "";
    String buildingName = request.getParameter("building_name");
    String flr_num = request.getParameter("flr_num");
    String file_name1 = "";
    //String file_name2="";
    String filePathArray[] = new String[2];
    //FileItem fileItem1 = null;
    //FileItem fileItem2 = null;
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
            //System.out.println(obj);
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

                if (fileItem.getSize() > 0) {              //save uploaded image with modified name (buildingName_floor_plan)
                    if (optionalFileName1.trim().equals("")) //fileName = FilenameUtils.getName(fileName);
                    {
                        file_name1 = buildingName + "_" + flr_num + "_Floor_plan.png";
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
                    } catch (Exception e) {
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
                <br/>
                <b>Successfully Loaded following Image for '<font color="red"><b><% buildingName = buildingName.replace("_", " ");
                    out.println(buildingName);
                    buildingName = buildingName.replace(" ", "_");
                            %>'</b></font>
                    for the floor <%out.println(flr_num);%></b>
                <br/><br/>
                <table>
                    <tr><td>
                        <form action="Load_img_build_name.jsp" >
                            <input type="hidden" name="building_name" value = <% out.println(buildingName);%> >
                            <input type="submit" name="B1" value="3. Add another Floor's plan"/>
                        </form>
                    <tr><td>The Uploaded Image:</td></tr>
                    <tr><td><img src="<%out.println(file_name1);%>" width="100%" height="100%" /></td></tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
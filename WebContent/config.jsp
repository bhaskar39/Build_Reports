<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.taglibs.standard.lang.jstl.StringLiteral"%>
<%

String tst = request.getParameter("tst");
String pre = request.getParameter("pre");
String prd = request.getParameter("prd");

File fil = new File("/root/jenkins/apache-tomcat-7.0.57/webapps/Build_Reports/master_conf.yml");
fil.createNewFile();
FileWriter fw = new FileWriter(fil);
fw.write("test:"+tst+"\n");
fw.write("preprod:"+pre+"\n");
fw.write("prod:"+prd+"\n");
fw.flush();
fw.close();
fil = new File("/root/jenkins/apache-tomcat-7.0.57/webapps/Build_Reports/config.yml");
fw=new FileWriter(fil);
fw.write("\nTestEnv:\n\tpercentage:\n\t\t"+tst);
fw.write("\nPreProdEnv:\n\tpercentage:\n\t\t"+pre);
fw.write("\nProdEnv:\n\tpercentage:\n\t\t"+prd);
fw.flush();
fw.close();
out.println("New Values Updated");
%>

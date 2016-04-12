<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.taglibs.standard.lang.jstl.StringLiteral"%>
<%

String tst = request.getParameter("tst");
String pre = request.getParameter("pre");
String prd = request.getParameter("prd");

File fil = new File("C:\\Users\\kishore.netala\\Desktop\\master_conf.yml");
fil.createNewFile();
FileWriter fw = new FileWriter(fil);
fw.write("test:"+tst+"\n");
fw.write("preprod:"+pre+"\n");
fw.write("prod:"+prd+"\n");
fw.flush();
fw.close();
fil = new File("C:\\Users\\kishore.netala\\Desktop\\conf.yml");
fw=new FileWriter(fil);
fw.write("TestEnv:\n\t\t\t\tpercentage:\n\t\t\t\t\t\t\t\t\t"+tst);
fw.write("\nPreProdEnv:\n\t\t\t\tpercentage:\n\t\t\t\t\t\t\t\t\t"+pre);
fw.write("\nProdEnv:\n\t\t\t\tpercentage:\n\t\t\t\t\t\t\t\t\t"+prd);
fw.flush();
fw.close();
out.println("New Values Updated");
%>

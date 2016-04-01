<%@page import="java.util.Scanner"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dev Env Build Reports</title>
</head>
<script type="text/javascript" src="jquery-1.10.0.min.js"></script>
<style>

  .table1{
    border:1px solid #000;
    width:70%;
  }
  .table1 tr td,th{
    
    min-width:100px;
    height:35px;
    text-align:center;
  }
  .table1 tr:nth-child(even){
    background:#EAE7E7 ;
  }
  .table1 tr:nth-child(even) td{
    border-bottom:1px solid #CCB0B0;
  }
.button1{
	border: 2px solid rgb(255, 255, 255); 
	background: rgb(94, 94, 255) none repeat scroll 0% 0%; 
	color: rgb(255, 255, 255); 
	font-weight: bold; 
	height: 30px;
	cursor:pointer;
}

</style>
<body>
<%
JsonParser jp;
JsonObject ob,ob1;
String hostname = "http://52.49.174.229:8080";
//String jobname="Server";
String jobname= (String) request.getParameter("jobname");
%>
<center>
<div style="background:#fff;width:80%;height:100%;box-shadow:0px 0px 5px #000;">
<h2><img src="headshot.png" style="width:100px;height:100px"/><%=jobname %> Build Reports</h2>
<table cellspacing=0 class="table1">
<tr>
	<th># Build</th>
	<th># Success</th>
	<th># Fail</th>
	<th>Success Rate</th>
	<th>Goto Test Report</th>
</tr>
<%

String pag = request.getParameter("pagn");
String url1;
try
  {
   URL url = new URL(hostname+"/jenkins/job/"+jobname+"/api/json");
   java.util.Scanner sc = new java.util.Scanner(url.openStream());
   String respon = sc.useDelimiter("\\Z").next();
   jp = new JsonParser();
   ob = (JsonObject)jp.parse(respon);
   
   int i=0,le=ob.getAsJsonArray("builds").size(),si=10;
   if (le<10 || pag.equals("full")) si=le;
   for (i=0;i<si;i++){
	   url1=((JsonObject)(ob.getAsJsonArray("builds").get(i))).getAsJsonPrimitive("url").getAsString();
	   url=new URL(url1+"api/json");
	   sc= new Scanner(url.openStream());
	   respon=sc.useDelimiter("\\Z").next();
	   ob1=(JsonObject)jp.parse(respon);
	   if(!ob1.getAsJsonPrimitive("result").getAsString().equals("FAILURE")){
		   
	   JsonObject obj = (JsonObject)ob1.getAsJsonArray("actions").get(ob1.getAsJsonArray("actions").size()-1);
	   
	   if(obj.has("totalCount"))
	   {
	   int totalCount=Integer.parseInt(obj.getAsJsonPrimitive("totalCount").toString());
	   int failCount=Integer.parseInt(obj.getAsJsonPrimitive("failCount").toString());
	   int succCount=totalCount-failCount;
	   //out.println(ob1.getAsJsonPrimitive("number")+" "+ob1.getAsJsonPrimitive("result")+"</br>");
	   %>
	   <tr>
	   		<td><%=((JsonObject)(ob.getAsJsonArray("builds").get(i))).getAsJsonPrimitive("number") %></td>
	   		<td><%=succCount %></td>
	   		<td><%=failCount%></td>
	   		<td><% out.println(((Float.parseFloat(String.valueOf(succCount)))/totalCount)*100); %></td>
	        <td><input type="submit" onclick="viewReport('<%=url1 %>',<%=totalCount %>,<%=ob1.getAsJsonPrimitive("number") %>)" value="View" class="button1"></td>
	   </tr>
<%
	   }
	   else{
%>
		<tr>
	   		<td><%=((JsonObject)(ob.getAsJsonArray("builds").get(i))).getAsJsonPrimitive("number") %></td>
	   		<td colspan=4>No Test Cases Found</td>
	   </tr>
<%		   
	   }
	   }
	   else{
%>
		<tr style="background:rgb(183, 97, 97);font-weight:bold;color:#FFF">
	   		<td ><%=((JsonObject)(ob.getAsJsonArray("builds").get(i))).getAsJsonPrimitive("number") %></td>
	   		<td colspan=4 ><center>Build Failed</center></td>
	   		
	   </tr>
<%
		   
	   }
	   
   }
  }
catch (Exception e)
  {
	out.println(e);
  }
%>
</table>
<%
if(!pag.equals("full")){
	

%>
<input class="button1" type="button" value="View Full Reports" onclick="load_page('all_tests.jsp','full','<%=jobname %>')">
<%
}
%>
</div>
</center>
<script type="text/javascript">

</script>
</body>
</html>

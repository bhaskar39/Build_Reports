<%@page import="org.apache.taglibs.standard.lang.jstl.StringLiteral"%>
<%@page import="java.net.URL"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonParser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
String test_url = (String)request.getParameter("url");
String totalCount = request.getParameter("total_tests");
int tc = Integer.parseInt(totalCount);
String build_no = request.getParameter("build_no");
JsonParser jp;
JsonObject ob;
URL url = new URL(test_url);
java.util.Scanner sc = new java.util.Scanner(url.openStream());
String respon = sc.useDelimiter("\\Z").next();
jp = new JsonParser();
ob = (JsonObject)jp.parse(respon);

JsonObject tests = (JsonObject) ob.getAsJsonArray("suites").get(0);


     
%>
<style>
.table2{
	border:1px solid #000;
	min-width:80%;
}
.table2 tr{
	height:35px;
	text-align:center;
}
.table2 tr:nth-child(even){
    background:#EAE7E7;
}
.table2 tr:nth-child(even) td{
    border-bottom:1px solid #CCC;
}
.success{
	color:#FFF;
	background:#54B054;
	
}
.failure{
	color:#FFF;
	background:#F87171;
}

</style>
<button onclick="$('#fade_black').hide()" style="display:inline-block;float:right;cursor:pointer;color:#fff;background:red;border:0px;font-weight:bold;">X
</button>
<center>
	<div style="font-weight:bold;font-size:25px;color:blue;"><%=build_no %> Build TestCases Report</div>
	
		<p style="display:inline-block;min-width:150px;font-weight:bold;color:green;">Passed:<%=ob.getAsJsonPrimitive("passCount") %></p>
		<p style="display:inline-block;min-width:150px;font-weight:bold;color:red;">Failed:<%=ob.getAsJsonPrimitive("failCount") %></p>
	
	<table class="table2" cellspacing=0>
		<tr>
			<th>TestCase</th>
			<th width="150px">Name</th>
			<th width="120px">Status</th>
			<th>Details</th>
		</tr>
		<%
			int i;
			JsonObject case1;
			String err;
			String clas;
			for(i=0;i<tc;i++){
				case1 = (JsonObject)tests.getAsJsonArray("cases").get(i);
				err="No Error";
				clas="success";
				if(case1.getAsJsonPrimitive("status").getAsString().equals("REGRESSION")||case1.getAsJsonPrimitive("status").getAsString().equals("FAILED")){
					err=case1.getAsJsonPrimitive("errorDetails").getAsString();
					clas="failure";
					
				}
		%>
			<tr>
				<td><%=i+1 %></td>
				<td><%=case1.getAsJsonPrimitive("name").getAsString() %></td>
				<td class="<%=clas%>"><%=case1.getAsJsonPrimitive("status").getAsString() %></td>
				<td><textarea style="background:none;border:0px;resize:none;" rows=1 cols=35 title='<%=err%>'><%=err %></textarea></td>
			</tr>
		<%
			}
		%>
	</table>
	&nbsp;
</center>
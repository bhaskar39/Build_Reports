<%@page import="java.beans.Encoder"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.nio.charset.CharsetEncoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Build Reports</title>
<script type="text/javascript" src="jquery-1.10.0.min.js"></script>
<style>

.scaled{  
  -ms-transform: scale(0.5);
  -webkit-transform: scale(0.5);
  -o-transform: scale(0.5);
  -moz-transform: scale(0.5);
  transform: scale(0.5);
}
.display_block{
	display:inline-block;
	min-width:150px;
	min-height:100px;
	color:#fff;
	vertical-align: middle;
	line-height:90px;
	padding:5px;
	font-weight:bold;
	border-radius:5px;
	margin-top:5%;
	cursor:pointer;
}
</style>
</head>
<body style="background-image: url(bg.jpg)">


<center>
<div id="iim"><img src="headshot.png"/></div>
<div id="load_data">
<div onclick="load_page('all_tests.jsp','first','JenkinsServer')" style="background:#0505C6" class="display_block">Developer Env Reports</div>
<div onclick="load_page('all_tests.jsp','first','TestEnv')"  style="background:rgb(228, 36, 36);" class="display_block">Tester Env Reports</div>
<div onclick="load_page('all_tests.jsp','first','PreProdEnv')"  style="background:#116B11;" class="display_block">Pre Prod Reports</div>
</div>
</center>
<div id ='fade_black'  style='display:none;position:fixed;top:0px;left:0px;width:100%;height:100%;background-color:rgba(16,16,16,0.6)  ;'>
     <div id='black_container'  style="position:fixed;top:10%;left:15%;width:70%;background:#fff;box-shadow:0px 0px 5px #fff;">
     </div>
</div>

<script type="text/javascript">
function load_page(url,pag,jobname)
{
	var xmlhttp;
	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState<4)
		{
			document.getElementById("load_data").innerHTML="<h1 align=center style='margin-top:10%'><img src='load.gif' align=center /></h1>";
		}
		else if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("load_data").innerHTML=xmlhttp.responseText;
			$("#iim").hide();
		}
		else if(xmlhttp.status==404)
		{
			document.getElementById("load_data").innerHTML="<div style='margin:200px 0px 0px 250px'><img src='load.gif' /><br />Page Under Construction...</div>";

		}
	}
	xmlhttp.open("GET",url+"?jobname="+jobname+"&pagn="+pag,true);
	xmlhttp.send();
	
	
}
function viewReport(url,total,bd)
{
	$.post("testreport.jsp",{"total_tests":total,"url":url+"testReport/api/json","build_no":bd},function(data){
		$("#fade_black").show(500);
		$("#black_container").html(data);
	})
}
</script>
</body>
</html>

<%@page import="java.io.IOException"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="java.net.URL"%>
<%!
String hostname="http://52.8.92.246:8080";
int[] lnum=new int[6];
String[] jobs={"JenkinsServer","ServerResultAnalyzer","TestEnv","TestEnvResultAnalyzer","PreProdEnv","PreProdEnvResultAnalyzer"};
public int get_res(int j,String jobname,String num){
	URL url;
	java.util.Scanner sc;
	JsonParser jp = new JsonParser();
	JsonObject ob;
	try{
		url=new URL(hostname+"/jenkins/job/"+jobname+"/"+num+"/api/json");
		sc = new java.util.Scanner(url.openStream());
		String respon = sc.useDelimiter("\\Z").next();
		ob = (JsonObject)jp.parse(respon);
//		System.out.println(respon);
		if(ob.getAsJsonPrimitive("building").getAsString().equals("true")) return get_res(j,jobname,num);
		if(ob.getAsJsonPrimitive("result").getAsString().equals("FAILURE") && j%2!=0){
			return 0;
		}
		else
			return 1;
		
		}
		catch(FileNotFoundException e){
			return get_res(j,jobname,num);
		}
	 	catch (MalformedURLException e) {
			// TODO Auto-generated catch block
	 		return 0;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			return 0;
		}
}
%>
<%

URL url;
java.util.Scanner sc;
JsonParser jp;
JsonObject ob;
/*
try{
	   for(int i=0;i<6;i++)
	    {
	   url = new URL(hostname+"/jenkins/job/"+jobs[i]+"/api/json");
	   sc = new java.util.Scanner(url.openStream());
	   String respon = sc.useDelimiter("\\Z").next();
	   jp = new JsonParser();
	   ob = (JsonObject)jp.parse(respon);
	   lnum[i]=Integer.parseInt(ob.getAsJsonPrimitive("nextBuildNumber").getAsString());
//	   out.println(lnum[i]);
	    }
	   }
	catch(Exception e)
	 {out.println(e);}

int j=0;
out.println("Build Started");
for(j=0;j<6;j++){
if(get_res(j)==1)
	out.println(jobs[j]+" build success </br>");
else{
	out.println("Build Stopped at "+jobs[j]);
	break;
	}
}
*/
String jobname = request.getParameter("job_name");
String num = request.getParameter("build_n");
int j = Integer.parseInt(request.getParameter("j"));
int data = get_res(j, jobname, num);
if(data==1)
	if (j%2==0)
		out.println("<div>Deployed App at "+jobname+"<input style='display:none' id='rslt"+j+"' value="+data+"></div>");
	else
		out.println("<div>"+jobname+" Success<input style='display:none' id='rslt"+j+"' value="+data+"></div>");
else
	out.println("<div>"+jobname+" Failed<input style='display:none' id='rslt"+j+"' value="+data+"></div>");

/*
while(true){
	try{
	url=new URL(hostname+"/jenkins/job/"+jobs[j]+"/"+338+"/api/json");
	sc = new java.util.Scanner(url.openStream());
	String respon = sc.useDelimiter("\\Z").next();
	ob = (JsonObject)jp.parse(respon);
	if(ob.getAsJsonPrimitive("result").getAsString().equals("FAILURE") && j%2!=0){
		out.println("Build stopped");
		break;
	}
	out.println(ob.getAsJsonPrimitive("fullDisplayName"));
	
	}
	catch(Exception e){
		out.println(e);
	}
}
*/

%>

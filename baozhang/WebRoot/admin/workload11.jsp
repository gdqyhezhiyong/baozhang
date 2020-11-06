<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String  username = (String) request.getSession().getAttribute("username");
if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="../login.jsp";
			</script>
		<%
		return;	
			}	
			
			//记录日志
			String user_name=(String)request.getSession().getAttribute("username");
			String name1=(String)request.getSession().getAttribute("name");
			// (new AdminService()).log(user_name,name1,"工作量统计查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));

			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>类别统计</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css"href="js/resources/css/ext-all.css" />
	<link href="futionchart/chart_css/style.css" rel="stylesheet" type="text/css" />

		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>
		<script type="text/javascript" src="futionchart/chart_js/FusionCharts.js"></script>
<style type="text/css">
 #container{
   vertical-align: center;
	margin-top: 20px;
	margin-left: 100px;
	width:1300px;
   }
   
   #mytable{
   vertical-align: center;
	margin-top: 10px;
	margin-left: 30px;
	width:1350px;
   }
</style>
 
  </head>
  
 
  <script type="text/javascript">
  
 

Ext.onReady(function(){
   
    
    var myChart = new FusionCharts( "futionchart/swf/Pie3D.swf", "myChartId", "800", "500", "0", "0" ); 
     myChart.setJSONUrl("servlet/WorkServlet");  
     myChart.render("container");      
});
  
  </script>
  <body>
 <div id="container"></div>

  </body>
</html>

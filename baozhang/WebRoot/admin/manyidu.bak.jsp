<%@ page language="java" import="java.util.*, gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username = (String) request.getSession().getAttribute("username");
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
	   	// (new AdminService()).log(user_name,name1,"满意度查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>满意度</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css"href="js/resources/css/ext-all.css" />

		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>
		<script type="text/javascript" src="futionchart/chart_js/FusionCharts.js"></script>
		<script type="text/javascript" src="futionchart/chart_js/jquery.min.js"></script>
		
 <style type="text/css">
 body, div, address, blockquote, iframe, ul, ol, dl, dt, dd, li, dl, h1, h2, h3, h4, pre, table, caption, th, td, form, legend, fieldset, input, button, select, textarea {margin:0; padding:0;font-style: normal;font:12px/22px Arial, Helvetica, sans-serif;} 
	 ol, ul ,li{list-style: none;} img {border: 0; vertical-align:middle;} body{color:#000000;background:#FFF; text-align:center;}
	 .clear{clear:both;height:1px;width:100%; overflow:hidden; margin-top:-1px;} a{color:#000000;text-decoration:none; } 
	 a:hover{color:#BA2636;text-decoration:underline;}
	 .red ,.red a{ color:#F00;} 
	 .lan ,.lan a{ color:#1E51A2;} 	
  #main{
    margin: 10px auto;
	width:820px;
   }
 
 
   #container{
   margin: 10px auto;
	width:800px;
   }
   #toolbar{
   margin: 10px auto;
	width:400px;
   }
</style>
 
  </head>
  <script type="text/javascript">
  
    $(document).ready(function() {  
            $.ajax({  
                type: "GET",  
                contentType: "application/json; charset=utf-8",  
                url: "servlet/SatisfyServlet",  
                data: "{}",  
                dataType: 'json',  
  
                success: function(json) {  
                    var data = eval('(' + json.d + ')');  
                    alert(json.responseText);
                    var myChart = new FusionCharts( "futionchart/swf/Pie3D.swf", "myChartId1", "700", "320", "0", "1" ); 
                    myChart.setJSONData(data);  
                    myChart.render("container");   
                     
                },  
  
                error: function(xhr) { //如果没有上面的捕获出错会执行这里的回调函数  
                    alert('页出错\n\r' + xhr.responseText);  
                }  
            });  
        });  
  
  </script>
  <body>
  <div id="main">
    <div id="container"></div>
      <div id="toolbar">
  </div>
    </div>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="shortcut icon" href="images/favicon.ico" type="image/jpg"/>
    <link rel="stylesheet" type="text/css" href="style/login.css"/>
    
    <link rel="stylesheet" type="text/css"
			href="js/resources/css/ext-all.css" />

		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>
    <title>网上报修系统</title>
  </head>
  
  <style type="text/css">
  body, div, address, blockquote, iframe, ul, ol, dl, dt, dd, li, dl, h1, h2, h3, h4, pre, table, caption, th, td, form, legend, fieldset, input, button, select, textarea {margin:0; padding:0;font-style: normal;font:12px/22px Arial, Helvetica, sans-serif;} 
	 ol, ul ,li{list-style: none;} img {border: 0; vertical-align:middle;} body{color:#000000;background:#FFF; text-align:center;}
	 .clear{clear:both;height:1px;width:100%; overflow:hidden; margin-top:-1px;} a{color:#000000;text-decoration:none; } 
	 a:hover{color:#BA2636;text-decoration:underline;}
	 .red ,.red a{ color:#F00;} 
	 .lan ,.lan a{ color:#1E51A2;} 

.log_box{
background: url(images/net.jpg) no-repeat;
width:560px;
height:416px;
margin:100px auto;
algin:center;
}

#login_{
width:50px;
height:30px;
algin:center;
}
#code{
margin-left:5px;
font-size: 12px;
padding:2px 8px 0pt 3px;
height:25px;
width:130px;
border:1px solid #CCC;
background-color:#FFF;
	
}
.log_box p{
height:35px;
padding-left:3px;
padding-right:3px;
font-family:"宋体";
font-size: 16px;
font-weight:bold;
text-inline:center;
}
#password{
margin-left:4px;
font-size: 12px;
padding:2px 8px 0pt 3px;
height:25px;
width:130px;
border:1px solid #CCC;
background-color:#FFF;	
}
#cp{
margin-top:25px;
font-size:13px;
color:2A0000;
}
#tishi{
margin-top:10px;
font-size:15px;
color:red;
}


  </style>
  <script type="text/javascript">
  function check_user(){

  var user_name = document.getElementById("code").value;
  var user_psd = document.getElementById("password").value;
  if(user_psd==''){
  Ext.MessageBox.alert("提示","密码不能为空!");
  document.getElementById("password").focus();
  return false;
  }if(user_name==''){
  Ext.MessageBox.alert("提示","用户名不能为空!");
  document.getElementById("code").focus();
  return false;
  }
  
  else{
  return true;
  }
  }
  function dofocu(){
  document.getElementById("code").focus();
  }
  </script>
 <BODY onload="dofocu()">
                <div class="log_box">
                    <form  method="post" action="servlet/NetLoginServlet" onSubmit="return check_user();">
                    <input  type="hidden"  name="sys" id="sys" value="1"/>
               <p align="center" > 用户名:<input type="text"  name="code" id="code"/></p>
              <p align="center">&nbsp;密  码:<input type="password" name="password" id="password"/>
			 <!--  <p align="center">&nbsp;&nbsp;<input type="radio" name="role" value="admin" checked>管理人员&nbsp; <input type="radio" name="role" value="user">学生</p> -->
			 <p align="center">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" id="login_" name="" value="登陆"/>
         </p>
           <p id="tishi" align="center">
           <%if("11".equals(request.getParameter("result"))){
           %>
                &nbsp;&nbsp;&nbsp;用户不存在！
           <%
           
           }if("12".equals(request.getParameter("result"))){
           
            %>
                 &nbsp;&nbsp;&nbsp; 密码不正确！
           <%
           
           } %>
           </p>
        <div  id="cp" align="center">
		  Copyright © 2013 广东轻工职业技术学院 后勤产业处 版权所有      &nbsp;&nbsp;     网络信息中心技术支持
		  </div>
  </form>
          </div>
		 
 </BODY>
</html>

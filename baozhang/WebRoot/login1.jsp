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
.log_box{
background: url(images/login.jpg) no-repeat;
width:646px;
height:408px;
margin:50px 200px;
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

.p #tishi{
font-family:"Times New Roman", Times, serif;
font-style:italic;
color:#FF0000;
height:30px;
padding-left:3px;
padding-right:3px;
margin-top:20px;
font-size: 12px;
}
  </style>
  <script type="text/javascript">
  function check_user(){

  var user_name = document.getElementById("code").value;
  var user_psd = document.getElementById("password").value;
  if(user_psd==''||user_name==''){
  Ext.MessageBox.alert("提示","用户名或密码不能为空!");
  }
  
  else{
  Ext.Ajax.request({
   url: 'servlet/LoginServlet',
   params: { user_name: user_name,user_psd:user_psd},
   success: function(response){
     //返回1登陆成功
   if(response.responseText=="4"){
    window.location.href="client/client.jsp";
   }else if(response.responseText=="1"||response.responseText=="2"||response.responseText=="3"){
    window.location.href="admin/admin.jsp";
   }
   //返回2用户不存在
   else if(response.responseText=="11"){
    document.getElementById("tishi").innerText="用户名"+user_name+"不存在，请重新输入！";
   }
   //返回3密码不正确
   else if(response.responseText=="12"){
    document.getElementById("tishi").innerText="输入密码不正确,请重新输入！";
   }
   else{
    document.getElementById("tishi").innerText="系统错误！";
   }
   },
   failure: function(){
   }
   
});

  
  }
  

  }
  </script>
 <BODY>
                <div class="log_box">
                    <form  method="post">
               <p align="center" > 用户名:<input type="text"  name="code" id="code"/></p>
              <p align="center">&nbsp;密  码:<input type="password" name="password" id="password"/>
			 <!--  <p align="center">&nbsp;&nbsp;<input type="radio" name="role" value="admin" checked>管理人员&nbsp; <input type="radio" name="role" value="user">学生</p> -->
			 <p align="center">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="login_" name="" value="登陆" onClick="check_user()"/>
         </p>
         <p  align="center" id="tishi"></p>
  </form>
          </div>
 </BODY>
</html>

<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
   
	String name = "";
	String username="";
	String sql="";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 username = (String) request.getSession().getAttribute("client_id");
	 
if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="bz.gdqy.edu.cn";
			</script>
		<%
		return;	
			}	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>修改密码</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"href="js/resources/css/ext-all.css" />
		<style type="text/css">
#form1 {
	text-align: center;
	vertical-align: center;
	margin: 150px auto;
}
</style>
		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>

		<script language="javascript">
    
     Ext.onReady(function () {
     Ext.QuickTips.init();
    // Ext.BLANK_IMAGE_URL="js/resources/images/default/s.gif";  
    var padform= new Ext.form.FormPanel({ 
     title:"密码修改", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 300, 
     labelWidth: 80,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:150},        
      items:[
              {inputType:"password",fieldLabel: "新密码", name: "password2", id:"password2"},
              {inputType:"password", fieldLabel: "新密码确认", name: "password3", id:"password3"}
       ],      
      buttons: [{
            //id:'tijiao',
            text: '提交',
            // cls:"x-btn-text-icon", 
            //评价数据提交后台
            handler:function(){
             var password2 = Ext.getCmp('password2').getValue();
              var password3 = Ext.getCmp('password3').getValue();
              var user_name="<%=username%>";
            var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/ChangPsdServlet", //提交的后台地址     
                     params:{
                    password2:password2,
                    user_name:user_name
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="1"){
                     
                      Ext.MessageBox.alert("提示","密码修改成功！");
                      }else{
                     Ext.MessageBox.alert("提示","密码修改失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","密码修改失败！");}　
　 }
);
            }
        },
        { text: '重置',  handler:function(){padform.getForm().reset();}
        }
        ]     
                       });
                    
   padform.render("form1");
     });
       

</script>
	</head>

	<body>

		<div id="form1">
		</div>
	</body>
</html>

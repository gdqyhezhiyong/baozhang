<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String username = (String) request.getSession().getAttribute("username");
if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="../net.jsp";
			</script>
		<%
		return;	
			}	

//记录日志
			String user_name=(String)request.getSession().getAttribute("username");
			String name1=(String)request.getSession().getAttribute("name");
			 (new AdminService()).log(user_name,name1,"当天报修情况查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>当天统计</title>
    
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
 <style type="text/css">
 #mytable{
  vertical-align: left;
  margin-top: 20px;
  margin-left: 150px;
  width:700px;
   }
   
   #container{
    vertical-align: left;
	margin-top: 0px;
	margin-left: 150px;
	width:700px;
   }
</style>
 
  </head>
  <script type="text/javascript">
  Ext.chart.Chart.CHART_URL = 'js/resources/charts.swf';

Ext.onReady(function(){
//满意度数据
var  todayStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/TodayServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'name', 
             successProperty:true, 
             id: 'name'  
             },
            [
            {name : "name", mapping : "name"}, 
             {name : "number", mapping : "number"}
             ]
              )}); 
       todayStore.load();  

   
    
    var form= new Ext.form.FormPanel({
        width:700,
        height: 450,
        title: '今日报修情况',
       // renderTo: 'container',
        items: [
        {
            store: todayStore,
            xtype: 'piechart',
            dataField: 'number',
            categoryField: 'name',
            //extra styles get applied to the chart defaults
            extraStyle:
            {
                legend:
                {
                    display: 'bottom',
                    padding: 0,
                    font:
                    {
                        family: 'Tahoma',
                        size: 16
                    }
                }
            }
        }
        
        ]
    });
    form.render("container");
    
    //初始化表格数据
   var griddate=new Array();
  
   todayStore.on("load",function(store){
   var total=0;
  for(var i=0;i<todayStore.getCount();i++){
  total+=parseInt(todayStore.getAt(i).get("number"));
  }
  var opanel = document.getElementById("mytable"); 
  
  var pchildren = opanel.childNodes; 
  //清空表中的行和列 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
 

 var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
 newTR.style.cssText="line-height:25px;border-color:#808080";
 for(var i=0;i<todayStore.getCount();i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML =todayStore.getAt(i).get("name") ;  
 }
 var newNameTD = newTR.insertCell(todayStore.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML ="总数";
 
 
 var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
 for(var i=0;i<todayStore.getCount();i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
 newNameTD.innerHTML =todayStore.getAt(i).get("number") ;  
 }
 var newNameTD = newTR.insertCell(todayStore.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
 newNameTD.innerHTML =total;
   });
   
});
  
  </script>
  <body>
    <div id="container"></div>
    <div><table id="mytable"></table></div>
  </body>
</html>

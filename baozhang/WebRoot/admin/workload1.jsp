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

		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>
<style type="text/css">
 #container{
  vertical-align: center;
	margin-top: 50px;
	margin-left: 30px;
	width:1200px;
   }
   
   #mytable{
   vertical-align: center;
	margin-top: 10px;
	margin-left: 30px;
	width:1200px;
   }
</style>
 
  </head>
  
 
  <script type="text/javascript">
  
 

Ext.onReady(function(){
   
    
    var  store = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/WorkServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
        remoteSort: true,
         reader: new Ext.data.JsonReader(
         {  
             totalProperty : 'result',  
             root : 'work', 
             successProperty:true, 
             id: 'work'  
             },
           [
            {name : "work", mapping : "work"}, 
             {name : "number", mapping : "number"}
             ]
              )
              
              }); 
       store.load();  
    
    var startdate=new Ext.form.DateField({
                   
                    xtype: "datefield",
                    name:"start",
                    id:"start",
                    emptyText:'开始时间',
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
                
   var enddate=new Ext.form.DateField({
                    emptyText:'截止时间',
                    xtype: "datefield",
                    name:"end",
                    id:"end",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
    
    new Ext.Panel({
        width: 1200,
        height: 300,
        renderTo: 'container',
        title: '工作量统计分布图',
        tbar: [
        startdate,
        enddate,
        {
            text: '查询最新数据',
            handler: function(){
               var start = startdate.getRawValue();
                var end = enddate.getRawValue();
             
               store.reload({                                      
                  url: "servlet/WorkServlet",                              
                  params: {                                  
                  start:start,
                  end:end               
                  }                  
                  }); 
            }
        }],
        items: {
            xtype: 'columnchart',
            store: store,
            width:1200,
            yField: 'number',
	    url: 'js/resources/charts.swf',
            xField: 'work',
            xAxis: new Ext.chart.CategoryAxis({
                title: '维修人员'
            }),
            yAxis: new Ext.chart.NumericAxis({
                title: '故障数量(件)'
            }),
            extraStyle: {
               xAxis: {
                    labelRotation: 0
                   
                }
            }
        }
    });
    
    
    
    
    //初始化表格数据
   var griddate=new Array();
  
   store.on("load",function(store){
   var total=0;
  for(var i=0;i<store.getCount();i++){
  total+=parseInt(store.getAt(i).get("number"));
  }
  var opanel = document.getElementById("mytable"); 
  
  var pchildren = opanel.childNodes; 
  //清空表中的行和列 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
 

 var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  

newTR.style.cssText="line-height:25px;border-color:#808080";
 for(var i=0;i<store.getCount();i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:48px;border-color:#808080;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML =store.getAt(i).get("work") ;  
 }
 var newNameTD = newTR.insertCell(store.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:48px;border-color:#808080;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML ="总数";
 
 
  newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
 for(var i=0;i<store.getCount();i++){
 var n=parseFloat(store.getAt(i).get("number"));
 var percent=Math.round((n/total)*10000)/100;
 var newNameTD = newTR.insertCell(i);  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
 newNameTD.innerHTML =store.getAt(i).get("number")+"  ("+percent+"%)";  
 }
  newNameTD = newTR.insertCell(store.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
 newNameTD.innerHTML =total;
 
 
 
 
 
   })
});
  
  </script>
  <body>
 <div id="container"></div>
 <div ><table id="mytable"></table></div>
  </body>
</html>

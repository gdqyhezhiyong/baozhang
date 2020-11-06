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
 <style type="text/css">
 body, div, address, blockquote, iframe, ul, ol, dl, dt, dd, li, dl, h1, h2, h3, h4, pre, table, caption, th, td, form, legend, fieldset, input, button, select, textarea {margin:0; padding:0;font-style: normal;font:12px/22px Arial, Helvetica, sans-serif;} 
	 ol, ul ,li{list-style: none;} img {border: 0; vertical-align:middle;} body{color:#000000;background:#FFF; text-align:center;}
	 .clear{clear:both;height:1px;width:100%; overflow:hidden; margin-top:-1px;} a{color:#000000;text-decoration:none; } 
	 a:hover{color:#BA2636;text-decoration:underline;}
	 .red ,.red a{ color:#F00;} 
	 .lan ,.lan a{ color:#1E51A2;} 	
   
   #container{
	margin: 50px auto;
	width:600px;
   }
   #d{
    margin: 10px auto;
	width:600px;
   }
</style>
 
  </head>
  <script type="text/javascript">
  Ext.chart.Chart.CHART_URL = 'js/resources/charts.swf';

Ext.onReady(function(){
//满意度数据

 var startdate=new Ext.form.DateField({
                    emptyText: "开始时间",
                    xtype: "datefield",
                    name:"start",
                    id:"start",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
                
   var enddate=new Ext.form.DateField({
                    emptyText: "截止时间",
                    xtype: "datefield",
                    name:"end",
                    id:"end",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
var  satisfyStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/SatisfyServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'satisfy', 
             successProperty:true, 
             id: 'satisfy'  
             },
            [
            {name : "satisfy", mapping : "satisfy"}, 
             {name : "number", mapping : "number"}
             ]
              )}); 
        satisfyStore.load({                                                                 
                  params: {                                  
                  start:startdate.getRawValue(),
                  end:enddate.getRawValue(),
                  weixiu_id:'<%=username%>'                        
                  }                  
                  }); 
       
   
  
       
       
   
  
   
    
    var p= new Ext.Panel({
        width: 600,
        height: 400,
        title: '满意度统计结果',
        tbar: [
        startdate,
        enddate,
      
        {
            text: '查询最新数据',
            handler: function(){
              var start = startdate.getRawValue();
                var end = enddate.getRawValue();
               satisfyStore.reload({                                                                 
                  params: {                                  
                  start:start,
                  end:end,
                  weixiu_id:'<%=username%>'                        
                  }                  
                  }); 
            }
        }],
        items: [{
            store: satisfyStore,
            xtype: 'piechart',
            dataField: 'number',
            categoryField: 'satisfy',
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
   p.render("container");
   
   //初始化表格数据
   var griddate=new Array();
  
   satisfyStore.on("load",function(store){
   var total=0;
  for(var i=0;i<satisfyStore.getCount();i++){
  total+=parseInt(satisfyStore.getAt(i).get("number"));
  }
  var opanel = document.getElementById("mytable"); 
  
  var pchildren = opanel.childNodes; 
  //清空表中的行和列 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
 

 var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
 newTR.style.cssText="line-height:25px;border-color:#808080";
 for(var i=0;i<satisfyStore.getCount();i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML =satisfyStore.getAt(i).get("satisfy") ;  
 }
 var newNameTD = newTR.insertCell(satisfyStore.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML ="总数";
 
 
 var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
 for(var i=0;i<satisfyStore.getCount();i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
 newNameTD.innerHTML =satisfyStore.getAt(i).get("number") ;  
 }
 var newNameTD = newTR.insertCell(satisfyStore.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
 newNameTD.innerHTML =total;
   });
});
  
  </script>
  <body>
    <div id="container"></div>
    <div id="d">
    <table id="mytable" width="600px" border="1px"  cellspacing="2" cellpadding="0" ></table>
    </div>
  </body>
</html>

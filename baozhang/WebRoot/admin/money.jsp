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
    
    <title>耗材金额统计</title>
    
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
 	margin:10px auto;
	width:1100px;
   }
   #title{
   	margin: 10px auto;
	width:1200px;
   }
   
   #table1{
   margin: 5px auto;
	width:1200px;
   }
</style>
 
  </head>
  
 
  <script type="text/javascript">
  
 

Ext.onReady(function(){
   
    
    var  store = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/MoneyServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
        remoteSort: true,
         reader: new Ext.data.JsonReader(
         {  
             totalProperty : 'result',  
             root : 'money', 
             successProperty:true, 
             id: 'work'  
             },
           [
            {name : "work", mapping : "work"}, 
             {name : "number", mapping : "number"}
             ]
              )
              
              }); 
       //store.load();  
    
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
    
    //校区        
                var subschool = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "分校",                   
                  name : "chart1",                            
                  emptyText: "请选择分校",              
                  mode: 'local',            
                  autoLoad: true,              
                  editable: false,  
                  value:'1',            
                  allowBlank: false,             
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['1','广州'],['2','南海']
                    ]
   })
                   });      
    
    
    new Ext.Panel({
        width: 1000,
        height: 250,
        renderTo: 'container',
        title: '耗材使用金额明细',
        tbar: [
        subschool,
        startdate,
        enddate,
        {
            text: '查询',
            handler: function(){
               var start = startdate.getRawValue();
               var end = enddate.getRawValue();
               var area = subschool.getValue();
             
               store.reload({                                      
                  url: "servlet/MoneyServlet",                              
                  params: {                                  
                  start:start,
                  end:end,
                  area:area              
                  }                  
                  }); 
            }
        }],
        items: {
            xtype: 'linechart',
            store: store,
            width:1000,
            yField: 'number',
	    url: 'js/resources/charts.swf',
            xField: 'work',
            xAxis: new Ext.chart.CategoryAxis({
                title: '材料'
            }),
            yAxis: new Ext.chart.NumericAxis({
                title: '耗材金额统计(元)'
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
  total+=parseFloat(store.getAt(i).get("number"));
  }
  
   total=total+"";
  if((total.split(".")).length>1){
  total=total.substring(0,total.indexOf(".")+2)
  }
  
  
  var opanel = document.getElementById("mytable"); 
  var pchildren = opanel.childNodes; 
  //清空表中的行和列 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
 
 var tile = document.getElementById("title");
 tile.style.cssText="font-size:12px;heigth:20px;font-weight:bold";
 title.innerText="耗材金额总数:"+total+"元";
 /*var titleTD = newTR.insertCell(0); 
 titleTD = newTR.insertCell(1); 
 titleTD = newTR.insertCell(2); 
 titleTD = newTR.insertCell(3); 
 titleTD.style.cssText="";
 titleTD.innerHTML ="耗材金额总数 :" ;  
 titleTD = newTR.insertCell(4); 
 titleTD.style.cssText="align:left;font-size:12px;heigth:30px;font-weight:bold";
 titleTD.innerHTML =total+"元"
 titleTD = newTR.insertCell(5); 
 titleTD = newTR.insertCell(6); 
 titleTD = newTR.insertCell(7); 
  */
 var temp = parseInt(store.getCount()/10)+1;
for(var t=0;t<temp-1;t++){

newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);
newTR.style.cssText="height:20px";
 for(var i=0;i<10;i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;font-size:10px;heigth:15px;background-color: #B0D1DB"; 
 newNameTD.innerHTML =store.getAt(t*10+i).get("work") ;  
 }
 
  newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
  newTR.style.cssText="height:20px";
 for(var i=0;i<10;i++){
 var n=parseFloat(store.getAt(t*10+i).get("number"));
 var percent=Math.round((n/total)*10000)/100;
 var newNameTD = newTR.insertCell(i);  
 newNameTD.style.cssText="text-align:center;font-size:10px;heigth:15px;background-color:#D4DFFF"; 
 newNameTD.innerHTML =store.getAt(t*10+i).get("number")+"  ("+percent+"%)";  
 }
  var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);
  newTR.style.cssText="height:15px";
}



newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);
newTR.style.cssText="height:20px";
 for(var i=0;i<store.getCount()-10*(temp-1);i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;font-size:10px;heigth:20px;background-color: #B0D1DB"; 
 newNameTD.innerHTML =store.getAt(10*(temp-1)+i).get("work") ;  
 }

newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
  newTR.style.cssText="height:15px";
 for(var i=0;i<store.getCount()-10*(temp-1);i++){
 var n=parseFloat(store.getAt(10*(temp-1)+i).get("number"));
 var percent=Math.round((n/total)*10000)/100;
 var newNameTD = newTR.insertCell(i);  
 newNameTD.style.cssText="text-align:center;font-size:10px;heigth:20px;background-color:#D4DFFF"; 
 newNameTD.innerHTML =store.getAt(10*(temp-1)+i).get("number")+"  ("+percent+"%)";  
 }

 
 
 
 
 
 
 
 
 
 
   })
   
   
   
});
  
  
  </script>
  <body>
 <div id="container"></div>
 <div id="title"></div>
 <div id="table1"><table id="mytable"></table></div>
  </body>
</html>

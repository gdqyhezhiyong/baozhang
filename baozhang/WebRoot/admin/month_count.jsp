<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
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
		//	(new AdminService()).log(user_name,name1,"月度统计查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>月份统计</title>
    
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
    vertical-align: left;
	margin: 20px auto;
	width:1200px;
   }
   #yuefen{
    vertical-align: center;
	margin: 10px auto;
	width:1200px;
   }
   #manyidu{
    vertical-align: center;
	margin: 0px auto;
	width:1200px;
   }
   #category{
    vertical-align: center;
	margin: 15px auto;
	width:1200px;
   }
    
    </style>
 
  </head>
  <script type="text/javascript">
  Ext.chart.Chart.CHART_URL = 'js/resources/charts.swf';

Ext.onReady(function(){

   var startdate=new Ext.form.DateField({
                    emptyText: "最小时间",
                    xtype: "datefield",
                    name:"start",
                    id:"start",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
                
   var enddate=new Ext.form.DateField({
                     emptyText: "最大时间",
                    xtype: "datefield",
                    name:"end",
                    id:"end",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 

   

    var  store = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/MonthServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
        remoteSort: true,
         reader: new Ext.data.JsonReader(
         {  
             totalProperty : 'result',  
             root : 'name', 
             successProperty:true, 
             id: 'name'  
             },
           [
            {name : "name", mapping : "name"}, 
             {name : "number", mapping : "number"}
             ]
              )
              
              }); 
       store.load(); 
       
       //校区        
                var subschool = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "分校",                   
                  name : "chart1",                            
                  emptyText: "请选择分校",              
                  mode: 'local',            
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['1','广州'],['2','南海'],['3','全部']
                    ]
   })
                   });       
       
    new Ext.Panel({
        title: '报修月度统计折线图',
        renderTo: 'container',
        width:1200,
        height:300,
        layout:'fit',
        tbar: [
        subschool,
        startdate,
        enddate,
        {
            text: '查询最新数据',
            handler: function(){
               var start = startdate.getRawValue();
               var end = enddate.getRawValue();
               var area = subschool.getValue();
             
               store.reload({                                      
                  url: "servlet/MonthServlet",                              
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
            xAxis: new Ext.chart.CategoryAxis({
                title: '月份'
            }),
            yAxis: new Ext.chart.NumericAxis({
                title: '故障数量(件)'
            }),
            xField: 'name',
            yField: 'number',
			listeners: {
				itemclick: function(o){
				var month = store.getAt(o.index).get("name");
				var conn = new Ext.data.Connection();    
                conn.request( 
        {
            url: "servlet/DetailServlet",   
            params:{
            month:month
            },       
            method: 'post',  
            scope: this,     
            success:function(response){  
           
            //清空表中的行和列 
            var opanel = document.getElementById("manyidu"); 
            var pchildren = opanel.childNodes; 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
   
     opanel = document.getElementById("category"); 
     pchildren = opanel.childNodes; 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
    opanel = document.getElementById("yuefen"); 
     pchildren = opanel.childNodes; 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
   
   
   var yuefen = document.getElementById("yuefen").insertRow(document.getElementById("yuefen").rows.length);  
    yuefen.style.cssText="line-height:25px"; 
   var yuetd = yuefen.insertCell(i);  
               yuetd.style.cssText="text-align:center;font-size:16px;"; 
               yuetd.innerHTML =month; 
   
             var satisfys = response.responseText.split("|")[0];
             if(satisfys.length>0){
             var satisfy = satisfys.split(",");
              //Ext.MessageBox.alert("提示",satisfy[1]);
    var newTR = document.getElementById("manyidu").insertRow(document.getElementById("manyidu").rows.length);  
    newTR.style.cssText="line-height:25px;border-color:#808080";          
      for(var i=0;i<satisfy.length;i++){      
               var newNameTD = newTR.insertCell(i);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
               newNameTD.innerHTML =satisfy[i].split(":")[0]; 
             //var number = satisfy[i].split(":")[1];
             }

 var newNameTD = newTR.insertCell(satisfy.length);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
               newNameTD.innerHTML ="总数"; 

             
     newTR = document.getElementById("manyidu").insertRow(document.getElementById("manyidu").rows.length);  
    newTR.style.cssText="line-height:25px";          
      for(var i=0;i<satisfy.length;i++){      
               var newNameTD = newTR.insertCell(i);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
             
             var n=parseFloat(satisfy[i].split(":")[1]);
            var percent=Math.round((n/store.getAt(o.index).get("number"))*10000)/100;
             
               newNameTD.innerHTML =satisfy[i].split(":")[1]+"("+percent+"%)"; 
             }
var newNameTD = newTR.insertCell(satisfy.length);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
               newNameTD.innerHTML =store.getAt(o.index).get("number"); 
            
             }
       var categorys = response.responseText.split("|")[1];          
         if(categorys.length>0){
             var category = categorys.split(",");
              //Ext.MessageBox.alert("提示",satisfy[1]);
    var newTR = document.getElementById("category").insertRow(document.getElementById("category").rows.length);  
    newTR.style.cssText="line-height:25px;border-color:#808080";          
      for(var i=0;i<category.length;i++){      
               var newNameTD = newTR.insertCell(i);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
               newNameTD.innerHTML =category[i].split(":")[0]; 
             //var number = satisfy[i].split(":")[1];
             }
var newNameTD = newTR.insertCell(category.length);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
               newNameTD.innerHTML ="总数"; 
             
     newTR = document.getElementById("category").insertRow(document.getElementById("category").rows.length);  
    newTR.style.cssText="line-height:25px";          
      for(var i=0;i<category.length;i++){      
               var newNameTD = newTR.insertCell(i);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
              
                
             var n=parseFloat(category[i].split(":")[1]);
            var percent=Math.round((n/store.getAt(o.index).get("number"))*10000)/100;
               newNameTD.innerHTML =category[i].split(":")[1]+"("+percent+"%)"; 
             }
var newNameTD = newTR.insertCell(category.length);  
               newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:25px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF"; 
               newNameTD.innerHTML =store.getAt(o.index).get("number"); 
            
             }     
             },         
        failure: function() 
         {
         Ext.MessageBox.alert("提示","没有数据！");
         }　
　 });
				}
			}
        }
    });

   
});
  
  </script>
  <body>
    <div id="container"></div>
    <div>
     <table id="yuefen"></table>
    </div>
    <div id="m">
    <table id="manyidu"></table>
    </div>
    <div id="c">
   
    <table  id="category">
    </table></div>
  </body>
</html>

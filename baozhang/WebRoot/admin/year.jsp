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
			// (new AdminService()).log(user_name,name1,"年度统计查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));

			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>年度统计</title>
    
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
  vertical-align: center;
	margin: 10px auto;
	width:710px;
   }
#year{
   vertical-align: center;
	margin-top: 10px auto;
	width:710px;
}   
   #mytable{
   vertical-align: center;
	margin: 10px auto;
	width:710px;
   }
</style>
 
  </head>
  
 
  <script type="text/javascript">
  
 

Ext.onReady(function(){
   
    
    var  store = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/YearServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
        remoteSort: true,
         reader: new Ext.data.JsonReader(
         {  
             totalProperty : 'result',  
             root : 'category', 
             successProperty:true, 
             id: 'category'  
             },
           [
            {name : "category", mapping : "category"}, 
             {name : "number", mapping : "number"}
             ]
              )
              
              }); 
       store.load();  
    
   
   
   
    var yearCombo = new Ext.form.ComboBox({              
                  width : 100,                      
                  name : "floor",              
                  id: "floor",              
                  emptyText: "请选择年份",              
                  mode: 'local',          
                  autoLoad: true,              
                  editable: true,              
                  allowBlank: true,                 
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['2013','2013'],['2014','2014'],['2015','2015'],['2016','2016'],['2017','2017']
                    
                    ]
   })
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
                  allowBlank: false,  
                  value:'3',            
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
        width: 700,
        height: 300,
        renderTo: 'container',
        title: '故障年度统计',
        tbar: [
        subschool,
       yearCombo,
        {
            text: '查询',
            handler: function(){
               var year = yearCombo.getValue();
               var area = subschool.getValue();
              
               store.reload({                                      
                  url: "servlet/YearServlet",                              
                  params: {                                  
                  year:year,
                  area:area   
                  }                  
                  }); 
            }
        }],
        items: {
            xtype: 'columnchart',
            store: store,
            width:700,
            yField: 'number',
	    url: 'js/resources/charts.swf',
            xField: 'category',
            xAxis: new Ext.chart.CategoryAxis({
                title: '故障类别'
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
    //清空表中的行和列 
  var opanel = document.getElementById("mytable"); 
  var pchildren = opanel.childNodes; 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
    opanel = document.getElementById("year"); 
   pchildren = opanel.childNodes; 
  for(var a=0; a<pchildren.length; a++){  
  opanel.removeChild(pchildren[a]);
   }
 
 var yeartr = document.getElementById("year").insertRow(document.getElementById("year").rows.length);
 var yeartd = yeartr.insertCell(0);  
 yeartd.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB"; 
 if(yearCombo.getValue()=='')
 yeartd.innerHTML=(new Date()).getYear()+"年";
 else
 yeartd.innerHTML =yearCombo.getValue()+"年";
 

 var newTR = document.getElementById("mytable").insertRow(document.getElementById("mytable").rows.length);  
 newTR.style.cssText="line-height:25px;border-color:#808080";
 for(var i=0;i<store.getCount();i++){
 var newNameTD = newTR.insertCell(i);  
  newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
 newNameTD.innerHTML =store.getAt(i).get("category") ;  
 }
 var newNameTD = newTR.insertCell(store.getCount());  
 newNameTD.style.cssText="text-align:center;border-color:#000033;font-size:14px;border:1px;heigth:30px;border-color:#B0D1DB;background-color: #B0D1DB;font-weight:bold"; 
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
 <div><table id="year"></table></div>
 <div><table id="mytable"></table></div>
  </body>
</html>

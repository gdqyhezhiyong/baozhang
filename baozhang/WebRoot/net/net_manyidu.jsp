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
  Ext.chart.Chart.CHART_URL = 'js/resources/charts.swf';

Ext.onReady(function(){  
   //维修人员数据     
 var weixiuStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetWeiXiuServlet',// 设置代理请求的url  
          method:'GET'  
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'weixiu', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )}); 
       weixiuStore.load();  
       //维修人员下拉框                    
         var weixiuCombo = new Ext.form.ComboBox({   
                    width : 100,  
                     name : "wx",     
                     id: "wx",             
                     emptyText: "选择维修工",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: true,                          
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: weixiuStore
                  });  
       
       
       
   
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
                
                
    //报表类型          
                var chart1 = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "报表类型",                   
                  name : "chart1",                            
                  emptyText: "请选择报表类型",              
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
              data:[['1','饼图'],['2','柱形图']
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
                
                
   
    var i=2;
    var toolbar = new Ext.Toolbar( [
       startdate,
        enddate,
        subschool,
        weixiuCombo,
        chart1
        ,'-'
        ,'&nbsp;&nbsp;&nbsp;&nbsp;',
        
        {
            text: '查询',
           cls:"x-btn-text-icon",  
           icon: 'js/resources/icons/fam/search.gif',
            handler: function(){
              var varVhart = "myChartId"+i;
              var start = startdate.getRawValue();
                var end = enddate.getRawValue();
                var weixiu_id = weixiuCombo.getValue();
                var xiaoqu = subschool.getValue();
                if(chart1.getValue()=='1'){
                FusionCharts.setCurrentRenderer('javascript');
                 var myChart = new FusionCharts( "futionchart/swf/Pie3D.swf", varVhart, "700", "320", "0", "1" ); 
                 myChart.setJSONUrl("servlet/SatisfyServlet?start="+start+"&&end="+end+"&&weixiu_id="+weixiu_id+"&&area="+encodeURI(xiaoqu)+"&&sys="+0);  
                 myChart.render("container");
                 }else{
                  FusionCharts.setCurrentRenderer('javascript');
                 var myChart = new FusionCharts( "futionchart/swf/Pareto3D.swf", varVhart, "700", "320", "0", "1" ); 
                myChart.setJSONUrl("servlet/SatisfyServlet?start="+start+"&&end="+end+"&&weixiu_id="+weixiu_id+"&&area="+encodeURI(xiaoqu)+"&&sys="+0);  
                 myChart.render("container");
                 }   
                   i++;
                
                }
              
            }]);
   FusionCharts.setCurrentRenderer('javascript');
   toolbar.render("toolbar");
   var myChart = new FusionCharts( "futionchart/swf/Pie3D.swf", "myChartId1", "700", "320", "0", "1" ); 
     myChart.setJSONUrl("servlet/SatisfyServlet");  
     myChart.render("container");   
   
   
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

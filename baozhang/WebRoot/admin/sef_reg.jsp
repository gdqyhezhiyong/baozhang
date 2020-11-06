<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*,java.sql.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
<%
    String phone = "";
	String name = "";
	String area1 = "南海";
	String area2 = "";
	String area1_id ="2";
	String area2_id = "3";
	String building = "";
	String building_id = "";
	String floor = "";
	String room = "";
	String username="";
	String sql="";
	String logins = "";
	String inside="";
	ResultSet rs=null;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
   username = (String) request.getSession().getAttribute("username");

				
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>故障登记</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="js/resources/css/ext-all.css" />
		<style type="text/css">
		
	 body, div, address, blockquote, iframe, ul, ol, dl, dt, dd, li, dl, h1, h2, h3, h4, pre, table, caption, th, td, form, legend, fieldset, input, button, select, textarea {margin:0; padding:0;font-style: normal;font:12px/22px Arial, Helvetica, sans-serif;} 
	 ol, ul ,li{list-style: none;} img {border: 0; vertical-align:middle;} body{color:#000000;background:#FFF; text-align:center;}
	 .clear{clear:both;height:1px;width:100%; overflow:hidden; margin-top:-1px;} a{color:#000000;text-decoration:none; } 
	 a:hover{color:#BA2636;text-decoration:underline;}
	 .red ,.red a{ color:#F00;} 
	 .lan ,.lan a{ color:#1E51A2;} 	
		
	
      #div2 {
			margin: 100px auto;
			width:550px;
			height:400px;
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
     getdata();
     });
       
function getdata(){

Ext.override(Ext.form.RadioGroup, { 
getValue: function(){ 
var v;
 if (this.rendered) {
  this.items.each(function(item){
   if (!item.getValue()) 
   return true; 
   v = item.getRawValue(); 
   return false; });
    } else 
    { for (var k in this.items) {
     if (this.items[k].checked) {
      v = this.items[k].inputValue; break; 
      }
       }
        } 
        
        return v;
         }, 
        setValue: function(v){
         if (this.rendered) 
         this.items.each(function(item){
          item.setValue(item.getRawValue() == v); 
          
          }); else { 
          for (var k in this.items) {
           this.items[k].checked = this.items[k].inputValue == v; 
           } } } });



var buildinghidden =new Ext.form.Hidden({
id:'buildinghidden'
});
var buildingrawhidden =new Ext.form.Hidden({
id:'buildingrawhidden'
});

var oncehidden =new Ext.form.Hidden({
id:'oncehidden'
});
var inside =new Ext.form.Hidden({
id:'inside'
});

var adminRadio=new Ext.form.Radio({ 
        boxLabel:'广州', 
        inputValue:'1', 
        listeners:{ 
            'check':function(){ 
                //alert(adminRadio.getValue()); 
                if(adminRadio.getValue()){ 
                    userRadio.setValue(false); 
                    adminRadio.setValue(true); 
                     areaStore.load({                                                                 
                  params: {                                  
                  p_id: radiogroup.getValue()                             
                  }                  
                  });    
                } 
            } 
        } 
    }); 
              
    var userRadio=new Ext.form.Radio({ 
        boxLabel:'南海', 
        inputValue:'2',
        listeners:{ 
            'check':function(){ 
                if(userRadio.getValue()){ 
                    adminRadio.setValue(false); 
                    userRadio.setValue(true); 
                    areaStore.load({                                                                   
                  params: {                                  
                  p_id: radiogroup.getValue()                                
                  }                  
                  });    
                } 
            } 
        } 
    }); 

var radiogroup = new Ext.form.RadioGroup({
                fieldLabel: '校区',
                width: 100,
                items: [adminRadio,userRadio]
            });
            
       //区域数据数据     
 var areaStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetAreaServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'area', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )}); 
       areaStore.load({ params: {                                  
                  p_id: radiogroup.getValue()                             
                  } });  
     
       //楼栋数据
       var buildingStore =  new Ext.data.Store({  
          proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetBuildingServlet',// 设置代理请求的url  
          method:'GET' 
        }),  
        // autoLoad : true,
          remoteSort: true,
          reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'building', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )}); 
           
         
           
           
             // 区域下拉框  
                  var areaCombo = new Ext.form.ComboBox({              
                  width : 100,            
                  fieldLabel : "区域",              
                  name : "area2",              
                  id: "area2",  
                  value:'<%=area2%>',            
                  emptyText: "请选择区域",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: areaStore,// 数据源 
                   listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  buildingCombo.reset();                                  
                  buildingStore.load({                                      
                  url: "servlet/GetBuildingServlet",                              
                  params: {                                  
                  area_id: combo.value                              
                  }  
                  });                 
                  }            
                  }  
                   });                 
                         
        //楼栋下拉框              
         var buildingCombo = new Ext.form.ComboBox({   
                    width : 100,  
                     fieldLabel : "楼栋", 
                     name : "building",     
                     id: "building", 
                     value:'<%=building%>',                
                     emptyText: "请选择楼栋",              
                     mode: 'local',              
                     autoLoad: true,    
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: buildingStore// 数据源              
                    
                  });             
         
        /* var mytore = buildingCombo.getStore();
mytore .on('load', function (){
      buildingCombo.setValue('<%=building%>');    
});*/
         
        
         //楼层下拉框             
                var floorCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "楼层",                   
                  name : "floor",              
                  id: "floor",              
                  emptyText: "请选择楼层",              
                  mode: 'local',
                  value:'<%=floor%>',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['1','1'],['2','2'],['3','3'],['4','4'],['5','5'],['6','6'],
                    ['7','7'],['8','8'],['9','9'],['10','10']
                    
                    ]
   })
                   });   
                   
     //室号下拉菜单              
                var roomCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "房号",                   
                  name : "room",              
                  id: "room",              
                  emptyText: "请选择室间",              
                  mode: 'local',
                  value:'<%=room%>',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['1','01'],['2','02'],['3','03'],['4','04'],['5','05'],['6','06'],
                    ['7','07'],['8','08'],['9','09'],['10','10'],['11','11'],['12','12'],
                    ['13','13'],['14','14'],['15','15'],['16','16'],['17','17'],['18','18'],
                    ['19','19'],['20','20'],['21','21'],['22','22'],['23','23'],['24','24'],
                    ['25','25'],['26','26'],['27','27'],['28','28'],['29','29'],['30','30'],
                    ['31','31'],['32','32'],['33','33'],['34','34'],['35','35'],['36','36'],
                    ['37','37'],['38','38'],['39','39'],['40','40'],['41','41'],['42','42'],
                    ['43','43'],['44','44'],['45','45'],['46','46'],['47','47'],['48','48'],['49','49']
                    ]
   })
                   });   
           
            var array=[
             // ['1','08:00-10:00'],['2','10:00-14:30'],['3','15:00-17:00'],['4','17:30-22:00']
                    
                    ];        
                var timeStore = new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:array
   })
                  
                    
                     //预约时间段
                  var order_time = new Ext.form.ComboBox({              
                  width : 100,              
                 // fieldLabel : "预约时间",                   
                  name : "order_time",              
                  id: "order_time",              
                  emptyText: "请选择预约时间",              
                  mode: 'local',            
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: timeStore
                   });   
                   
                    
                   var orderdate=new Ext.form.DateField({
                    emptyText:'请选择预约日期',
                    xtype: "datefield",
                    name:"end",
                    id:"end",
                    minValue : new Date(),
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%",
                      listeners: {// select监听函数                             
                       select : function(field,newValue,oldValue){  
                  order_time.reset(); 
                  timeStore.removeAll();
                  var year1 = newValue.getYear();
                  var month1= newValue.getMonth()+1;
                  var date1= newValue.getDate();
                  var now_time= new Date();
                  var year_now = now_time.getYear();
                  var month_now=now_time.getMonth()+1;
                  var date_now=now_time.getDate();
                  var hours_now=now_time.getHours();
                  var time_select = year1+'-'+month1+'-'+date1;
                  var time_now = year_now+'-'+month_now+'-'+date_now;
                 //时间段的处理满足：
                 //1.当前时间超过的时间段不能选择
                 //2.某个时间段如果超过40单，这个时间段不能选择
                 
                  if(time_select==time_now){
                  //八点钟之前报障全部时间段可以选择
                  if(hours_now<8){
                  var record1 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time1 = new record1({  
                id : '1',  
                name : '08:00-10:00'  
                   }); 
                   timeStore.add(time1);
                   
                 
                  var record2 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time2 = new record2({  
                id : '2',  
                name : '11:00-14:30'  
                   }); 
                   timeStore.add(time2);
                 
                 
                  var record3 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time3 = new record3({  
                id : '3',  
                name : '15:00-17:00'  
                   }); 
                   timeStore.add(time3);
                   
                   
                   
                    var record4 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time4 = new record4({  
                id : '4',  
                name : '17:30-22:00'  
                   }); 
                   timeStore.add(time4);
                   
                  }else if(8<=hours_now&&hours_now<11){//8点<=时间<11点，时间段的处理，第1个时间段不能选择
                var record2 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time2 = new record2({  
                id : '2',  
                name : '11:00-14:30'  
                   }); 
                   timeStore.add(time2);
                   
                 
                 
                  var record3 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time3 = new record3({  
                id : '3',  
                name : '15:00-17:00'  
                   }); 
                   timeStore.add(time3);
                   
                   
                   
                    var record4 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time4 = new record4({  
                id : '4',  
                name : '17:30-22:00'  
                   }); 
                   timeStore.add(time4);
                   
                  
                  
                  }else if(11<=hours_now&&hours_now<15){ //11点<=时间<15点，时间段的处理，第1、2个时间段不能选择
                  
                 
                  var record3 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time3 = new record3({  
                id : '3',  
                name : '15:00-17:00'  
                   }); 
                   timeStore.add(time3);
                   
                   
                   
                    var record4 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time4 = new record4({  
                id : '4',  
                name : '17:30-22:00'  
                   }); 
                   timeStore.add(time4);
                   
                 
                  
                  
                  }else if(15<=hours_now&&hours_now<17){//15点<=时间<20点，时间段的处理，第1、2、3、4个时间段不能选择
                  
                    var record4 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time4 = new record4({  
                id : '4',  
                name : '17:30-22:00'  
                   }); 
                   timeStore.add(time4);
                  
                  }else {//20点之后时间段的处理，只能预约第二天的时间，没有时间段可以选择
                   Ext.MessageBox.alert("温馨提示！","<span color='red'>今天已经没有预约的时间了！请预约明天后的时间！</span>");
                  }
                  
                  }else{
                  var record1 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time1 = new record1({  
                id : '1',  
                name : '08:00-10:00'  
                   }); 
                   timeStore.add(time1);
                   
                   
                 var record2 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time2 = new record2({  
                id : '2',  
                name : '11:00-14:30'  
                   }); 
                   timeStore.add(time2);
                   
                 
                  var record3 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time3 = new record3({  
                id : '3',  
                name : '15:00-17:00'  
                   }); 
                   timeStore.add(time3);
                   
                    var record4 = new Ext.data.Record.create([  
                  {name : 'id',type : 'string'},  
                  {name : 'name',type : 'string'}  
                ]);  
                
                 var time4 = new record4({  
                id : '4',  
                name : '17:30-22:00'  
                   }); 
                   timeStore.add(time4);
                  
                  } 
                  
                  //以下是某个时间段超过30单的处理，方法是把已经达到30的时间段在下拉框去掉
                 var conn = new Ext.data.Connection();   
                  conn.request( 
                  {  
                     url: "servlet/CountBillServlet", //提交的后台地址     
                     params:{
                    select_date:time_select,
                    sys:"0"
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      var array_time= response.responseText.split('|');
                      var time_index=0;
                      if(array_time.length>2){
                      for(var i=0;i<array_time.length-1;i++){
                      var time_name=array_time[i].split(',')[0];
                      if(time_name=='08:00-10:00')time_index=1;
                      if(time_name=='11:00-14:30')time_index=2;
                      if(time_name=='15:00-17:00')time_index=3;
                      if(time_name=='17:30-22:00')time_index=4;
                           
                       var time_count=array_time[i].split(',')[1];
                       
                      //循环判断数据库里面时间段的账单，如果超过30从下拉框把该项去掉 
                       if(time_count>=30){
                    for(var n=0;n<timeStore.getCount();n++){
                    if(timeStore.getAt(n).get("name")==time_name)
                    timeStore.removeAt(n);
                    }
                    
                       }
                      }
                    
                      }         
             },         
        failure: function() {
        Ext.MessageBox.alert("提示","系统故障，请向后勤服务中心反映！！"); 
        
        }　
　 }
); 
                  }            
                  }  
                }); 
                   
                  
                   
                   
                   //一级类型数据     
 var projectStore1 = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/CategoryServlet?sys=0',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'project', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )});  
              //加载数据
              projectStore1.load({ params: {                                  
                  p_id:'0'                            
                  } });  
     
       //二级类型数据
       var projectStore2 =  new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/CategoryServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'project', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )});  
              
        //三级类型数据
       var projectStore3 =  new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/CategoryServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'project', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
            {name : "name", mapping : "name"},
            {name : "jinji", mapping : "jinji"}
             ]
              )});    
                           
         //一级类型下拉框                    
         var projectCombo1 = new Ext.form.ComboBox({   
                    width : 100,    
                     fieldLabel : "一级类别", 
                     name : "project1",     
                     id: "project1",             
                     emptyText: "请选择类别",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: projectStore1,// 数据源              
                     listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  projectCombo2.reset();                                  
                  projectStore2.load({                                      
                  url: "servlet/CategoryServlet",                              
                  params: {                                  
                  p_id: combo.value,
                  sys:"0"                           
                  }                  
                  });                 
                  }            
                  }  
                  });  
                  
                  // 二级类型下拉框  
                  var projectCombo2 = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "二级类别",              
                  name : "project2",              
                  id: "project2",              
                  emptyText: "请选择类别",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: projectStore2,// 数据源
                   listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  projectCombo3.reset();                                  
                  projectStore3.load({                                      
                  url: "servlet/CategoryServlet",                              
                  params: {                                  
                  p_id: combo.value,
                  sys:"0"                            
                  }                  
                  });                 
                  }            
                  }   
                   });   
                   
                    // 三级类型下拉框  
                  var projectCombo3 = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "三级类别",              
                  name : "project3",              
                  id: "project3",              
                  emptyText: "请选择类别",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值   
                           
                  store: projectStore3// 数据源 
                   });                   

projectCombo3.on('expand', function(comboBox) {
        comboBox.list.setWidth('180px'); //auto
        comboBox.innerList.setWidth('auto');
    }, this, { single: true }); 
    
projectCombo2.on('expand', function(comboBox) {
        comboBox.list.setWidth('180px'); //auto
        comboBox.innerList.setWidth('auto');
    }, this, { single: true }); 
    
    projectCombo1.on('expand', function(comboBox) {
        comboBox.list.setWidth('180px'); //auto
        comboBox.innerList.setWidth('auto');
    }, this, { single: true }); 


    






    var f= new Ext.form.FormPanel({ 
     title:"故障信息填写", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 515, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     listeners : {
    'render' : function() {
        this.findByType('textfield')[0].focus(true, true); 
     }
},
     defaults:{ xtype:"textfield",width:100},        
     items: [
     {xtype: 'fieldset',
      id:'user_check',
       bodyPadding: 10,
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .7,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '60%' },
            items:[
            {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空",  name: "user_name", id: "user_name",fieldLabel: "账号"}
            ]
            },
        {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:30,  
            defaults: {width: 30,anchor: '30%' },
            items:[
            {   xtype: 'button',  
                text: '获取用户信息    ',  
                iconCls: 'add', 
                 //disabled :true,   
                id: 'checkbutton',  
                height:'25',
                handler: function(){
                
                var user_name = Ext.getCmp("user_name").getValue();
                if(user_name.trim()==''||user_name.trim==null) {
                Ext.MessageBox.alert("提示","请输入要登记人的账号");
                return;
                }
                  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/CheckUserServlet", //提交的后台地址     
                     params:{
                    user_name:user_name
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     var responestr = response.responseText; 
                     if(responestr.trim()=='')  {
                     inside.setValue('no');
                     Ext.MessageBox.alert("提示","不存在此用户！请检查您的输入是否正确！");
                     } else{
                     var users= responestr.split(",");
            
            Ext.getCmp('username').setValue(users[0]);
            Ext.getCmp('phone').setValue(users[1]);  
            if(users[2]=='广州')       
            radiogroup.setValue('1');
            else
             radiogroup.setValue('2');
            Ext.getCmp('area2').setRawValue(users[3]);
           // building_id=users[4];
            buildinghidden.setValue(users[4]); 
             buildingrawhidden.setValue(users[5]); 
            Ext.getCmp('building').setValue(users[5]);
            Ext.getCmp('floor').setRawValue(users[6]);
            Ext.getCmp('room').setRawValue(users[7]); 
            oncehidden.setValue(users[8]); 
           // once=users[8];
                     }
             },         
        failure: function() {Ext.MessageBox.alert("提示","验证失败！"); }　
　 }
);
                
                }  
            }
            ]
            }
        ]
     },
     
     {xtype: 'fieldset',
      id:'phone_name',
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空",  name: "username", id: "username",fieldLabel: "姓名"}
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
             {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空",name: "phone", id: "phone", fieldLabel: "电话号码"}
            ]
            }
        ]
     },
     
     {xtype: 'fieldset',
      id:"quyu",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
               labelWidth:80,  
            defaults: {xtype:"radiogroup",width: 60,anchor: '90%' },
            items:[
             radiogroup
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
               labelWidth:80,   
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
             areaCombo
            ]
            }
        ]
     },
     
      {xtype: 'fieldset',
       id:"dizhi",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: 1/3,  
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
              buildingCombo
            ]
            },
        {  columnWidth: 1/3, 
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
             floorCombo
            ]
            },
            {  columnWidth: 1/3, 
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
             roomCombo
            ]
            } 
        ]
     },
     
    {xtype: 'fieldset',
     id:"leixing",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: 1/3,  
            layout: 'form',  
            labelWidth:60,  
            defaults: {xtype:"combo",width: 80,anchor: '99%' },
            items:[
             projectCombo1
            ]
            },
        {  columnWidth: 1/3, 
            layout: 'form',  
            labelWidth:60,  
            defaults: {xtype:"combo",width: 80,anchor: '99%' },
            items:[
             projectCombo2
            ]
            }    
       ,
        {  columnWidth: 1/3, 
            layout: 'form',  
            labelWidth:60,  
            defaults: {xtype:"combo",width: 80,anchor: '99%' },
            items:[
             projectCombo3
            ]
            }
           
        ]
     }, 
     
     {xtype: 'fieldset',
      id:"miaoshu",
        height: 120,  
        width: 500,  
        layout: 'column',
        items:[
        {  
            layout: 'form',  
            labelWidth:100,  
            defaults: {xtype:"textfield",width: 450,anchor: '80%' },
            items:[
              {xtype: "textarea",height: 100, width : 450, name: "description",emptyText:"输入限100字以内！", id:"description",fieldLabel: "报修项目描述"}
            ]
            }
               
        ]
     }, 
     
  
  {xtype: 'fieldset',
   id:"shijian",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
       {  columnWidth: .5,  
            layout: 'form',  
             labelWidth:10,  
            defaults: {xtype:"combo",width: 100,anchor: '90%' },
            items:[
              orderdate
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
              labelWidth:10,  
            defaults: {xtype:"combo",width: 100,anchor: '70%' },
            items:[
               order_time
            ]
            }
            
       
           
        ]
     }
  
      
     
       
         
          ],      
      buttons: [{
            id:'tijiao',
            text: '提交',
             cls:"x-btn-text-icon", 
            //保障数据提交后台
            handler:function(){
           
            var name= Ext.getCmp('phone_name').findById("username").getValue();
            var phone=Ext.getCmp('phone_name').findById("phone").getValue();
            var area1=radiogroup.getValue();
            if(area1=='1')
            area1='广州';
            else
            area1='南海';
            var area1_id=radiogroup.getValue();
            var area2_id= Ext.getCmp('area2').getValue();
            var area2= Ext.getCmp('area2').getRawValue();
            var building=Ext.getCmp('building').getRawValue();
             var building_id="";
            if(building!=buildingrawhidden.getValue())
             building_id=Ext.getCmp('building').getValue();
             else building_id=buildinghidden.getValue();
            var floor=Ext.getCmp('floor').getRawValue();
            var room=Ext.getCmp('room').getRawValue();
            var project1=Ext.getCmp('project1').getRawValue();
            var project2=Ext.getCmp('project2').getRawValue();
            var project3=Ext.getCmp('project3').getRawValue();
            var project1_id=Ext.getCmp('project1').getValue();
            var project2_id=Ext.getCmp('project2').getValue();
            var project3_id=Ext.getCmp('project3').getValue();
            var description=Ext.getCmp('description').getValue();
            
            var order_time=Ext.getCmp('order_time').getRawValue();
            var bz_id=Ext.getCmp('user_name').getValue();
            var logins = oncehidden.getValue();
            if(logins=='0')logins="once";
            else logins="more";
            var inside_value = inside.getValue();
           // alert("building_id:"+building_id+"logins:"+logins+"inside_value:"+inside_value);
             var user_name = Ext.getCmp("user_name").getValue();
                if(user_name.trim()==''||user_name.trim==null) {
                Ext.MessageBox.alert("提示","请输入要登记人的账号");
                return;
                }
             if(name==''||name==null){
             Ext.MessageBox.alert("温馨提示！","姓名不能为空");
             return;
            }
             if(phone==''||phone==null){
             Ext.MessageBox.alert("温馨提示！","电话号码不能为空");
             return;
            }
            if(area1==''||area1==null){
             Ext.MessageBox.alert("温馨提示！","校区必须选择！");
             return;
            }
            if(area2==''||area2==null){
             Ext.MessageBox.alert("温馨提示！","区域必须选择！");
             return;
            }
            if(building==''||building==null){
             Ext.MessageBox.alert("温馨提示！","楼栋必须选择！");
             return;
            }
            
             if(floor==''||floor==null){
             Ext.MessageBox.alert("温馨提示！","楼层必须选择！");
             return;
            }
             if(room==''||room==null){
             Ext.MessageBox.alert("温馨提示！","室间必须选择！");
             return;
            }
            
            if(project1==''||project1==null){
             Ext.MessageBox.alert("温馨提示！","项目类别不能为空！");
             return;
            }
            if(description==''||description==null){
             Ext.MessageBox.alert("温馨提示！","故障描述不能为空！");
             return;
            }
            
            if(description.length>100){
             Ext.MessageBox.alert("温馨提示！","您输入内容长度超过了100！");
             return;
            }
            
            if(project2==''||project2==null){
             Ext.MessageBox.alert("温馨提示！","项目类别不能为空！");
             return;
            }
            
            if(project3==''||project3==null){
             Ext.MessageBox.alert("温馨提示！","项目类别不能为空！");
             return;
            }
            
             //alert(order_date);
            if(orderdate.getValue()==''||orderdate.getValue()==null){
             Ext.MessageBox.alert("温馨提示！","预约日期不能为空！");
             return;
            }
            order_date=orderdate.getValue().getYear();
            
            if(order_time==''||order_time==null){
             Ext.MessageBox.alert("温馨提示！","预约时间不能为空！");
             return;
            }
            
           var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/RegServlet", //提交的后台地址     
                     params:{
                    name:name,
                    phone:phone,
                    project1:project1,
                    project2:project2,
                    project3:project3,
                    project1_id:project1_id,
                    project2_id:project2_id,
                    project3_id:project3_id,
                    description:description,
                    weixiu_date:order_date,
                    order_time:order_time,
                    bz_id:bz_id,
                    logins:'more',
                    inside:'yes',
                    area1:area1,
                    area1_id:area1_id,
                    area2:area2,
                    area2_id:area2_id,
                    building:building,
                    building_id:building_id,
                    floor:floor,
                    room:room,
                    sys:'0'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="succ"){
                      Ext.MessageBox.alert("提示","恭喜，登记已经成功!");
                      window.location.href="paidan.jsp";  
                      }else if(response.responseText=="rereg"){
                       Ext.MessageBox.alert("提示","该故障已经报过！");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","提交失败，登记未能成功！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","提交失败，登记未能成功！"); }　
　 }
);
           
          }
        },{
            text: '重置', id:"reset1", cls:"x-btn-text-icon",  handler:function(){f.getForm().reset();}
        }]     
                       });
                       f.render("div2");
}
</script>
	</head>

	<body>

		<div id="div2">
		</div>
	</body>
</html>

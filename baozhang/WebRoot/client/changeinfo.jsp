<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
    String phone = "";
	String name = "";
	String area = "广州";
	String building = "";
	String building_id = "";
	String floor = "";
	String room = "";
	String username="";
	String sql="";
	String area1="";
	String area1_id="";
	String area2="";
	String area2_id="";
	String sex="";
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
	 sql = "select * from t_user where user_name='" + username+ "'";
	//System.out.println("t_user:"+sql);
	 ResultSet rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
	if (rs.next()) {
		
		if(rs.getString("phon_number")!=null)
		phone = rs.getString("phon_number");
		
		if(rs.getString("name")!=null)
		name = rs.getString("name");
		
		if(rs.getString("area1")!=null)
		area1 = rs.getString("area1");
		
		if(rs.getString("area1_id")!=null)
		area1_id = rs.getString("area1_id");
		
		if(rs.getString("area2")!=null)
		area2 = rs.getString("area2");
		
		if(rs.getString("area2_id")!=null)
		area2_id = rs.getString("area2_id");
		
		if(rs.getString("building")!=null)
		building = rs.getString("building");
		
		if(rs.getString("building_id")!=null)
		building_id = rs.getString("building_id");
		
		if(rs.getString("floor")!=null)
		floor = rs.getString("floor");
		
		if(rs.getString("room")!=null)
		room = rs.getString("room");
		
		if(rs.getString("sex")!=null)
		sex = rs.getString("sex");
		
		
		
		
		
		
	}
	
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
			margin: 50px auto;
			width:520px;
			height:380px;
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




var adminRadio=new Ext.form.Radio({ 
        boxLabel:'广州', 
        inputValue:'1', 
        <%if(area1.equals("广州")){%>
         checked:true,
        <%}%>
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
        <%if(area1.equals("南海")){%>
        checked:true,
        <%}%>
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
                     emptyText: "请选择楼栋",              
                     mode: 'local',              
                     autoLoad: true, 
                     value:'<%=building%>',           
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: buildingStore// 数据源              
                    
                  });  
                  
                
        
    
                   
                   //性别
                  var sex = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "性别",                   
                  name : "sex",              
                  id: "sex",              
                  emptyText: "请选择",              
                  mode: 'local',            
                  autoLoad: true, 
                  value:'<%=sex%>',                         
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[
              ['男','男'],['女','女']
                    
                    ]
   })
                   });   
                   
       
       
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
              data:[['50','00'],['1','01'],['2','02'],['3','03'],['4','04'],['5','05'],['6','06'],
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
                   
     //房号下拉菜单              
                var roomCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "房号",                   
                  name : "room",              
                  id: "room",              
                  emptyText: "请选择房间",              
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
                    ['37','37'],['38','38'],['39','39'],['40','40'],['41','41'],['42','42']
                    ]
   })
                   });               
                 



    var f= new Ext.form.FormPanel({ 
     title:"个人信息修改", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 620, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:100},        
     items: [
     {xtype: 'fieldset',
      id:'phone_name',
        height: 40,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .35,  
            layout: 'form',  
            labelWidth:50,  
            defaults: {width: 200,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'20', allowBlank: false, blankText:"不能为空", value:'<%=name%>', name: "username", id: "username",fieldLabel: "姓名"}
            ]
            },
        {  columnWidth: .35, 
            layout: 'form',  
            labelWidth:70,  
            defaults: {width: 200,anchor: '90%' },
            items:[
             {xtype: 'textfield',height:'20', allowBlank: false, blankText:"不能为空", value:'<%=phone%>',name: "phone", id: "phone", fieldLabel: "电话号码"}
            ]
            },
        {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:40,  
            defaults: {width: 100,anchor: '80%' },
            items:[
             sex
            ]
            }
        ]
     },
     
     {xtype: 'fieldset',
      id:"loudong",
        height: 40,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .4,  
            layout: 'form',  
               labelWidth:80,  
            defaults: {xtype:"radiogroup",width: 150,anchor: '90%' },
            items:[
             radiogroup
            ]
            },
        {  columnWidth: .3, 
            layout: 'form',  
               labelWidth:50,   
            defaults: {xtype:"combo",width: 120,anchor: '90%' },
            items:[
             areaCombo
            ]
            },
        {  columnWidth: .3, 
            layout: 'form',  
               labelWidth:50,   
            defaults: {xtype:"combo",width: 120,anchor: '90%' },
            items:[
             buildingCombo
            ]
            }
              
        ]
     },
     
     {xtype: 'fieldset',
      id:"fanghao",
        height: 40,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
               labelWidth:80,  
            defaults: {xtype:"combo",width: 150,anchor: '70%' },
            items:[
            floorCombo
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
               labelWidth:80,   
            defaults: {xtype:"combo",width: 150,anchor: '70%' },
            items:[
            roomCombo
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
           var name= Ext.getCmp("username").getValue();
            var phone=Ext.getCmp('phone').getValue();
            var area1_id=radiogroup.getValue();
            if(area1_id=='1')area1='广州';
            else area1='南海';
            var area2=Ext.getCmp('area2').getRawValue();
            var area2_id=Ext.getCmp('area2').getValue();
            var building=Ext.getCmp('building').getRawValue();
            var building_id=Ext.getCmp('building').getValue();
            var floor=Ext.getCmp('floor').getRawValue();
            var room=Ext.getCmp('room').getRawValue();
            var sex =Ext.getCmp('sex').getRawValue();
            var user_name="<%=username%>";
           
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
            if(sex==''||sex==null){
             Ext.MessageBox.alert("温馨提示！","性别必须选择！");
             return;
            }
            if(building==''||building==null){
             Ext.MessageBox.alert("温馨提示！","楼栋必须选择！");
             return;
            }
            if(area2==''||area2==null){
             Ext.MessageBox.alert("温馨提示！","区域必须选择！");
             return;
            }
            
             if(floor==''||floor==null){
             Ext.MessageBox.alert("温馨提示！","楼层必须选择！");
             return;
            }
             if(room==''||room==null){
             Ext.MessageBox.alert("温馨提示！","房间必须选择！");
             return;
            }
            
            if(building!="<%=building%>")
             building_id=Ext.getCmp('building').getValue();
             else building_id="<%=building_id%>";
             
             if(area2!="<%=area2%>")
             area2_id=Ext.getCmp('area2').getValue();
             else area2_id="<%=area2_id%>";
           
           var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/InfoChangeServlet", //提交的后台地址     
                     params:{
                    name:name,
                    phone:phone,
                    area1:area1,
                    area2:area2,
                    area1_id:area1_id,
                    area2_id:area2_id,
                    user_name:user_name,
                    building:building,
                    building_id:building_id,
                    floor:floor,
                    room:room,
                    sex:sex
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="succ"){
                      Ext.MessageBox.alert("提示","修改成功！");
                      }else{
                     Ext.MessageBox.alert("提示","修改失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","修改失败!"); }　
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

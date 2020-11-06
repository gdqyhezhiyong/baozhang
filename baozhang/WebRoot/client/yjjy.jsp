<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
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
	String sql="";
	String logins = "";
	String username="";
	ResultSet rs=null;	
	String role_id ="";	
	String inside="";
    
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 username = (String) request.getSession().getAttribute("client_id");
	 name = (String)request.getSession().getAttribute("client_name");
	role_id = (String)request.getSession().getAttribute("client_role_id");
	inside = (String)request.getSession().getAttribute("inside");
  if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="bz.gdqy.edu.cn/baozhang";
			</script>
		<%
		return;	
			}
			
	
	 
	  sql="select status from t_bill where status=2 and sys=1 and bz_id= '"+username+"'";
	 rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
			if(rs.next()){
			//System.err.println("不能报修");
			response.sendRedirect("net_pingjia.jsp");
			return;
			}else{
		
	
	 sql = "select * from t_user where user_name='" + username+ "'";
	//System.out.println("t_user:"+sql);
	 rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
	if (rs.next()) {
	//System.out.println("第一次保障"+rs.getString("phon_number")+"--"+rs.getString("name"));
		
		if("0".equals(rs.getString("isonce"))){
		phone = rs.getString("phon_number")==null?"":rs.getString("phon_number");
		name = rs.getString("name")==null?"":rs.getString("name");
	    area1 = rs.getString("area1")==null?"":rs.getString("area1");
	    area2 = rs.getString("area2")==null?"":rs.getString("area2");
	    area1_id = rs.getString("area1_id")==null?"":rs.getString("area1_id");
	    area2_id = rs.getString("area2_id")==null?"":rs.getString("area2_id");
	    building = rs.getString("building")==null?"":rs.getString("building");
	    building_id = rs.getString("building_id")==null?"":rs.getString("building_id"); 
	    floor = rs.getString("floor")==null?"":rs.getString("floor");
        room = rs.getString("room")==null?"":rs.getString("room");
		logins="once";
		}else{
		phone = rs.getString("phon_number");
		name = rs.getString("name");
	    area1 = rs.getString("area1");
	    area2 = rs.getString("area2");
	    area1_id = rs.getString("area1_id");
	    area2_id = rs.getString("area2_id");
	    building = rs.getString("building");
	    building_id = rs.getString("building_id"); 
	    floor = rs.getString("floor");
        room = rs.getString("room");
		logins="more";
		}
		
	}
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>投诉</title>

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
        //alert('<%=basePath%>');
     Ext.QuickTips.init();
     Ext.BLANK_IMAGE_URL="js/resources/images/default/s.gif";  
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
        <%if("广州".equals(area1)){%>
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
        <%if("南海".equals(area1)){%>
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
                  area_id: combo.value,
                  sys:1                         
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
              data:[
                    ['50','00'],['1','01'],['2','02'],['3','03'],['4','04'],['5','05'],['6','06'],
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
                   
                   
                   //预约时间段
                  var order_time = new Ext.form.ComboBox({              
                  width : 110,         
                  fieldLabel : "预约时间",  
                  id: "order_time",              
                  name : "order_time",                       
                  emptyText: "请选择预约时间",              
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
              data:[
              ['1','08:00-10:00'],['2','12:30-14:00'],['3','18:30-22:00']
                    
                    ]
   })
                   });   
                   
                   
                   
                   //一级类型数据     
 var projectStore1 = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/CategoryServlet?sys=1',// 设置代理请求的url  
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
     
      
                           
         //一级类型下拉框                    
         var projectCombo1 = new Ext.form.ComboBox({   
                    width : 100,    
                     fieldLabel : "网络故障类别", 
                     name : "project1",     
                     id: "project1",             
                     emptyText: "请选择故障类别",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: projectStore1
                  });  
                  
                 
                   
                      
projectCombo1.on('expand', function(comboBox) {
        comboBox.list.setWidth('180px'); //auto
        comboBox.innerList.setWidth('auto');
    }, this, { single: true }); 




    var f= new Ext.form.FormPanel({ 
     title:"意见、投诉", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 515, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:100},        
     items: [
     
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
            {xtype: 'textfield',height:'20', allowBlank: false, blankText:"不能为空", value:'<%=name%>', name: "username", id: "username",fieldLabel: "姓名"}
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
             {xtype: 'numberfield',height:'20', allowBlank: false, blankText:"不能为空", value:'<%=phone%>',name: "phone", id: "phone", fieldLabel: "电话号码"}
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
      id:"miaoshu",
        height: 100,  
        width: 500,  
        layout: 'column',
        items:[
        {  
            layout: 'form',  
            labelWidth:100,  
            defaults: {xtype:"textfield",width: 370,anchor: '80%' },
            items:[
              {xtype: "textarea",height: 100, width : 370,emptyText:"输入限100字以内！", name: "description", id:"description",fieldLabel: "请输入投诉内容"}
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
            if(building!="<%=building%>")
             building_id=Ext.getCmp('building').getValue();
             else building_id="<%=building_id%>";
            var floor=Ext.getCmp('floor').getRawValue();
            var room=Ext.getCmp('room').getRawValue();
            
            var description=Ext.getCmp('description').getValue();
            var bz_id="<%=username%>";
           
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
           
            if(description==''||description==null){
             Ext.MessageBox.alert("温馨提示！","投诉内容不能为空！");
             return;
            }
             if(description.length>200){
             Ext.MessageBox.alert("温馨提示！","您填写的内容过长，请不要超过200字！");
             return;
            }
        
            
           var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/Complaint?sys=1", //提交的后台地址     
                     params:{
                    name:name,
                    phone:phone,
                    description:description,
                    bz_id:bz_id,
                    area1:area1,
                    area1_id:area1_id,
                    area2:area2,
                    area2_id:area2_id,
                    building:building,
                    building_id:building_id,
                    floor:floor,
                    room:room,
                    sys:"1"
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="s"){
                      Ext.MessageBox.alert("提示","我们已经收到投诉的宝贵意见，谢谢！");
                       window.close();
                      }
                      else{
                     Ext.MessageBox.alert("提示","提交失败，系统错误！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","提交失败，网络出错！"); }　
　 }
);
           
          }
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

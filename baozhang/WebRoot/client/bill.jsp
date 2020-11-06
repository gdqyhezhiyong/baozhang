<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
    String phone = "";
	String name = "";
	String area = "";
	String building = "";
	String floor = "";
	String room = "";
	String username="";
	String sql="";
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
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>撤单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"href="js/resources/css/ext-all.css" />

		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>
	<style type="text/css">
	.my-x-grid3-row{cursor:default;border:2px solid #ccc,border-top-color:#fff;}
	</style>

		<script language="javascript">
     function chedan(value){};
     function pingjia(){};
     
      Ext.onReady(function () {
      Ext.data.Store.prototype.applySort = function() {
    if (this.sortInfo && !this.remoteSort) {
        var s = this.sortInfo, f = s.field;
        var st = this.fields.get(f).sortType;
        var fn = function(r1, r2) {
            var v1 = st(r1.data[f]), v2 = st(r2.data[f]);
            if (typeof(v1) == "string") {
                return v1.localeCompare(v2);
            }
            return v1 > v2 ? 1 : (v1 < v2 ? -1 : 0);
        };
        this.data.sort(s.direction, fn);
        if(this.snapshot && this.snapshot != this.data) {
            this.snapshot.sort(s.direction, fn);
        }
    }
};
     Ext.QuickTips.init();
     Ext.BLANK_IMAGE_URL="ext/resources/images/default/s.gif"; 
    
    
     pingjia=function(){
     window.location.href="pingjia.jsp";
     }
     
     
     
     chedan=function(value){
    // Ext.MessageBox.alert("提示","dfsdfs"+value);
    
     var conn = new Ext.data.Connection();  
     
     conn.request( 
                  {  
                     url: "servlet/ChedanServlet", //提交的后台地址     
                     params:{
                     value:value,
                     username:"<%=username%>"
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     // alert(response.responseText);
                      if(response.responseText=="1"){
                     Ext.MessageBox.alert("提示","撤单成功!"); 
                    bill_grid.getStore().reload(); //重新load数据
                      }else{
                        Ext.MessageBox.alert("提示","撤单失败!"); 
                      }
             },           
        failure: function()  {Ext.MessageBox.alert("提示","撤单失败!");}　
　 });
                    
     };
     
     
     var adminRadio=new Ext.form.Radio({ 
        boxLabel:'广州', 
        inputValue:'1', 
        <%if(area.equals("广州")){%>
         checked:true,
        <%}%>
        listeners:{ 
            'check':function(){ 
                //alert(adminRadio.getValue()); 
                if(adminRadio.getValue()){ 
                    userRadio.setValue(false); 
                    adminRadio.setValue(true); 
                     buildingStore.load({                                      
                  url: "servlet/GetBuildingServlet",                              
                  params: {                                  
                  area_id: radiogroup.getValue()                             
                  }                  
                  });    
                } 
            } 
        } 
    }); 
    var userRadio=new Ext.form.Radio({ 
        boxLabel:'南海', 
        inputValue:'2',
        <%if(area.equals("南海")){%>
        checked:true,
        <%}%>
        listeners:{ 
            'check':function(){ 
                if(userRadio.getValue()){ 
                    adminRadio.setValue(false); 
                    userRadio.setValue(true); 
                    buildingStore.load({                                      
                  url: "servlet/GetBuildingServlet",                              
                  params: {                                  
                  area_id: radiogroup.getValue()                                
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
            
       //地址一级数据     
 var buildingStore = new Ext.data.Store({  
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
       buildingStore.load({ params: {                                  
                  area_id: radiogroup.getValue()                             
                  } });  
     
       //地址二级数据
       var floorStore =  new Ext.data.Store({  
          proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetFloorServlet',// 设置代理请求的url  
          method:'GET' 
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'floor', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "cell", mapping : "cell"}
             ]
              )}); 
                            
                         
         //地址一级下拉框                    
         var buildingCombo = new Ext.form.ComboBox({   
                    width : 100,  
                     
                     fieldLabel : "楼栋", 
                     name : "building",     
                     id: "building",             
                     emptyText: "请选择楼栋",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: buildingStore,// 数据源              
                     listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  floorCombo.reset();                                  
                  floorStore.load({                                      
                  url: "servlet/GetFloorServlet",                              
                  params: {                                  
                  p_id: combo.value                              
                  }                  
                  });                 
                  }            
                  }  
                  });  
                  
                  // 地址第二级下拉框  
                  var floorCombo = new Ext.form.ComboBox({              
                  width : 100,            
                  fieldLabel : "楼层",              
                  name : "floor",              
                  id: "floor",              
                  emptyText: "请选择楼层",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'cell',// 显示值              
                  store: floorStore// 数据源 
                   });
                   
     //房号下拉菜单              
                var roomCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "房号",                   
                  name : "room",              
                  id: "room",              
                  emptyText: "请选择房间",              
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
              data:[['1','01'],['2','02'],['3','03'],['5','04'],['5','05'],['6','06'],
                    ['7','07'],['8','08'],['9','09'],['10','10'],['11','11'],['12','12'],
                    ['13','13'],['14','14'],['15','15'],['16','16'],['17','17'],['18','18'],
                    ['19','19'],['20','20'],['21','21'],['22','22'],['23','23'],['24','24'],
                    ['25','25'],['26','26'],['27','27'],['28','28'],['29','29'],['30','30'],
                    ['31','31'],['32','32'],['33','33'],['34','34'],['35','35'],['36','36'],
                    ['37','37'],['38','38'],['39','39'],['40','40'],['41','41'],['42','42']
                    ]
   })
                   });   
                   
                   
                   //一级类型数据     
 var projectStore1 = new Ext.data.Store({  
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
                           
         //一级类型下拉框                    
         var projectCombo1 = new Ext.form.ComboBox({   
                    width : 100,    
                     fieldLabel : "报修项目一级类别", 
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
                  p_id: combo.value                              
                  }                  
                  });                 
                  }            
                  }  
                  });  
                  
                  // 二级类型下拉框  
                  var projectCombo2 = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "报修项目二级类别",              
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
                  store: projectStore2// 数据源 
                   });           

var order_time=new Ext.form.TimeField({   
    fieldLabel:'预约时间',   
    empty:'请选择时间',   
    minValue:'8:00',   
    maxValue:'18:00', 
    typeAhead : true,  
    format:'H:i',
    id:"time",
    name:"time",   
    increment:30,   
    invalidText:'日期格式无效，请选择时间或输入有效格式的时间'  
});   




     
     
     
     
     
      var toolbar = new Ext.Toolbar( [
      {  text : '报账',  
        cls:"x-btn-text-icon",  
         //icon: 'js/resources/icons/fam/add.gif',
        iconCls:'addIcon'  ,  
        handler : function addbill(){
        
        var f= new Ext.form.FormPanel({ 
     title:"故障信息填写", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 400, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:170},        
     items: [
     {allowBlank: false, blankText:"不能为空", value:'<%=name%>', name: "username", id: "username",fieldLabel: "姓名"}, 
     {allowBlank: false, blankText:"不能为空", value:'<%=phone%>',name: "phone", id: "phone", fieldLabel: "电话号码"}, 
     radiogroup,
     buildingCombo,
     floorCombo,
     roomCombo,
     projectCombo1,
     projectCombo2,

     {xtype: "textarea",allowBlank: false, blankText:"不能为空", width : 200,height:100, name: "description", id:"description",fieldLabel: "报修项目描述"},  
        {
                    fieldLabel: "预约日期",
                    xtype: "datefield",
                    name:"date",
                    minValue : new Date(),
                    id:"date",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                    disabledDays:[0,6], // 禁止选择周六和周日
                    disabledDaysText:"禁止选择该日期"
                },
         order_time
         
          ]     
                       });
                       
 var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 250,
        height :250 ,
        minHeight: 200,
        width:400,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'楼栋添加',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
              
      buttons: [{
            id:'tijiao',
            text: '提交',
             cls:"x-btn-text-icon", 
            //保障数据提交后台
            handler:function(){
           var name= Ext.getCmp("username").getValue();
            var phone=Ext.getCmp('phone').getValue();
            var area=radiogroup.getValue();
            var building=Ext.getCmp('building').getRawValue();
            var building_id=Ext.getCmp('building').getValue();
            var floor=Ext.getCmp('floor').getRawValue();
            var room=Ext.getCmp('room').getRawValue();
            var project1=Ext.getCmp('project1').getRawValue();
            var project2=Ext.getCmp('project2').getRawValue();
            var description=Ext.getCmp('description').getValue();
            var order_date=Ext.getCmp('date').getValue();
            var order_time=Ext.getCmp('time').getValue();
            var bz_id="<%=username%>";
           
            if(name==''||name==null){
             Ext.MessageBox.alert("温馨提示！","姓名不能为空");
             return;
            }
             if(phone==''||phone==null){
             Ext.MessageBox.alert("温馨提示！","电话号码不能为空");
             return;
            }
            if(area==''||area==null){
             Ext.MessageBox.alert("温馨提示！","校区必须选择！");
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
             Ext.MessageBox.alert("温馨提示！","房间必须选择！");
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
            
            if(project2==''||project2==null){
             Ext.MessageBox.alert("温馨提示！","项目类别不能为空！");
             return;
            }
            
            if(order_date==''||order_date==null){
             Ext.MessageBox.alert("温馨提示！","预约时间不能为空！");
             return;
            }
            if(order_time==''||order_time==null){
             Ext.MessageBox.alert("温馨提示！","预约时间不能为空！");
             return;
            }
            
            var address="";
            if(area==1){
            address="广州-"+building+"-"+floor+"-"+room;
            }else{
             address="南海-"+building+"-"+floor+"-"+room;
            }
           
           var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/RegServlet", //提交的后台地址     
                     params:{
                    name:name,
                    phone:phone,
                    project2:project2,
                    description:description,
                    order_time:order_time,
                    order_date:order_date,
                    address:address,
                    bz_id:bz_id,
                    building_id:building_id
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="succ"){
                      this.disable();
                      this.hide(); 
                      Ext.getCmp('reset1').disable();
                      Ext.getCmp('reset1').hide();
                      
                    Ext.getCmp("username").disable();
                    Ext.getCmp('phone').disable();
                    radiogroup.disable();
                    Ext.getCmp('building').disable();
                    Ext.getCmp('floor').disable();
                    Ext.getCmp('room').disable();
                    Ext.getCmp('project1').disable();
                    Ext.getCmp('project2').disable();
                    Ext.getCmp('description').disable();
                    Ext.getCmp('date').disable();
                    Ext.getCmp('time').disable();
                      
                      Ext.MessageBox.alert("提示","恭喜，登记已经成功，我们会尽快帮你处理！");
                      }else if(response.responseText=="rereg"){
                       Ext.MessageBox.alert("提示","你们宿舍已经报过障，系统正在处理中.....！");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","提交失败，报修未能成功！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","提交失败，报修未能成功！"); }　
　 }
);
           
          }
        },{
            text: '重置', id:"reset1", cls:"x-btn-text-icon",  handler:function(){f.getForm().reset();}
        }]
    });
    
  Edit_Window.show();
                        
                } 
                
    },'-',{  
        text : '删除', 
        cls:"x-btn-text-icon", 
        icon: 'js/resources/icons/fam/delete.gif', 
        iconCls : 'remove',  
        handler : function(){
         var row=building_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","该操作至少要选择一条记录！");
        return;
        }else{
        Ext.Msg.show({
　　
　　 title: '删除记录',
　　
　　 buttons: Ext.MessageBox.YESNOCANCEL,
　　
　　 msg: '你确定要删除这些记录吗？',
　　
　　 fn: function(btn){
　　
　　 if (btn == 'yes'){
　　
　　 var jsonData="";    
               for(var i=0,len=row.length;i<len;i++){
                var ss = row[i].get("id"); //这里为Grid数据源的Id列    
                
                if(i==0)      jsonData = jsonData + ss;   
                  else     jsonData = jsonData + ","+ ss;   
                      }    
                     
                        var conn = new Ext.data.Connection();    
                   conn.request( 
  {  url: "servlet/DeleteBuildingServlet", //提交的删除地址     
                     params:{ids:jsonData},       
                      method: 'post',  
                      scope: this,     
                      success:function(response){  
             Ext.MessageBox.alert("提示","成功删除"+response.responseText+"栋楼!"); 
              building_grid.getStore().reload({params:{start:0, limit:20}}); //重新load数据
             },         
        failure: function()  {Ext.MessageBox.alert("提示","所选记录删除失败！");}　
　 });
　　}
   }
　　 });
        
        }
         }
 },'-',
     {text : '修改',  
        cls:"x-btn-text-icon",  
         //icon: 'js/resources/icons/fam/add.gif',
        iconCls:'editIcon'  ,  
        handler : function(){
         var row=building_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","该操作至少要选择一条记录！");
        return;
        }else{
            var id = row[0].get("id"); 
            var name= row[0].get("name");
            var area_id= row[0].get("area_id");
            var weixiu= row[0].get("weixiu");
            
     var Edit_Panel=new Ext.form.FormPanel({     
     buttonAlign: 'center',       
     height: '100%',     
     width: 400, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:170},  
        items: 
        [ 
           radiogroup,
           {allowBlank: false,width:150, blankText:"不能为空", name: "building_name", id: "building_name",fieldLabel: "楼栋名字"}, 
          weixiuCombo,
          { name: "floor_min", width:50,id: "floor_min",fieldLabel: "最低层"},
          { name: "floor_max", width:50,id: "floor_max",fieldLabel: "最高层"}
        ]
    
    });
    Ext.getCmp("building_name").setValue(name);
    //Ext.getCmp("weixiu").setValue(weixiu);
    if(area_id==1) adminRadio.setValue(true); 
    else userRadio.setValue(true); 
    
    var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 250,
        height :250 ,
        minHeight: 200,
        width:400,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'楼栋修改',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
        buttons: [{
            text: '更新',
            //点击保存按钮后触发事件
            handler:function(){
            var building_name= Ext.getCmp("building_name").getValue();
            var area=radiogroup.getValue();
            var weixiu_id=Ext.getCmp('weixiu').getValue();
            var floor_min= Ext.getCmp("floor_min").getValue();
            var floor_max= Ext.getCmp("floor_max").getValue();
            
            
            
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/EditBuildingServlet", //提交的后台地址     
                     params:{
                     id:id,
                     building_name:building_name,
                     area:area,
                     weixiu_id:weixiu_id,
                     floor_max:floor_max,
                     floor_min:floor_min
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","更新成功！");
                       // window.location.reload();
                      building_grid.getStore().reload({params:{start:0, limit:20}});
                      }
                      else{
                     Ext.MessageBox.alert("提示","更新失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","更新失败！"); }　
　 }
);

                Edit_Window.hide();
              
            building_grid.getStore().reload({params:{start:0, limit:20}});
            
          }
        },{
            text: '重置',  handler:function(){Edit_Panel.getForm().reset();}
        }]
    });
    
  Edit_Window.show();
    
    
            
            }
        }
                
    }, '-',{   text: '查询',  
         cls:"x-btn-text-icon",  
        // icon: 'js/resources/images/access/form/search.gif',
         handler: function () {  
         
         var Edit_Panel=new Ext.form.FormPanel({    
        labelWidth: 100, 
        labelAlign:'right',
        frame:true,      
        bodyStyle:'padding:5px 5px 0',
        width: 380,
        defaults: {width: 150},
        defaultType: 'textfield',
        items: 
        [
          radiogroup,
            {
                //label名称
                fieldLabel: '维修员名字',
                //textfield名称
                name: 'weixiu',
                id:'weixiu'
                
            }
        ]
    
    });
     var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 300,
        height :150 ,
        minHeight: 200,
        width:400,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'请输入查询条件',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
        buttons: [{
            text: '查询',
            //点击保存按钮后触发事件
            handler:function(){
            var area_id=radiogroup.getValue();
            var weixiu =Ext.getCmp('weixiu').getValue();
           Ext.apply(   
                      building_grid.getStore().baseParams,   
                      {   
                           area_id:area_id,
                           weixiu:weixiu
                      }); 
                Edit_Window.hide();
            building_grid.getStore().reload({params:{start:0, limit:20}});
            
          }
        },{
            text: '重置',  handler:function(){Edit_Panel.getForm().reset();}
        }]
    });
    
  Edit_Window.show();
                 }  
    } ,'-',{   text: '刷新',  
         cls:"x-btn-text-icon",  
         handler: function () { 
         window.location.reload();
         }
         }
          ]);
     
     var sm = new Ext.grid.CheckboxSelectionModel({
                    mtext : "**",
                    mcol : 1,
                    align : "left"
                    
            });
     
      
     var cm = new Ext.grid.ColumnModel( 
     [
    new Ext.grid.RowNumberer({ align : "center", header : "序号",  width : 32}),
          sm,       
      {  
        align : "center",
        header : "报修人姓名",  
        width : 150,  
        dataIndex : 'bz_name',  
        sortable : true 
        
    }, 
    {  
        align : "left",
        header : "报修人电话号码",  
        width : 200,  
        dataIndex : 'phnone_number'
    },{  
        align : "left",
        header : "报修人地址",  
        width : 250,  
        dataIndex : 'address'
    }, { 
        align : "left",
        header : "预约日期",  
        width : 200,  
        dataIndex : 'order_date', 
        renderer:function(value){ 
        var a=value.substring(0,10);
        return a;  
},
  sortable : true 
    } , { 
        align : "left",
        header : "预约时间",  
        width : 150,  
        dataIndex : 'order_time',  
        sortable : true 
    },  { 

      
        align : "left",
        header : "完成时间",  
        width : 200,  
        dataIndex : 'finish_time',
          renderer:function(value){ 
        var a=value.substring(0,16);
        return a;  
},
          sortable : true  
    }, {  
         css:'height:27px; vertical-align:middle; font-size:12;',
        header : "状态",  
        width : 150,  
        align : "left",
        dataIndex : 'status',
        renderer: function status(value){
        if(value=='0')return '<span style="color:red;">未处理</span>';
        else if(value=='1')return '已经受理';
        else if(value=='2')return '已经完成';
        else if(value=='3')return '已经撤单';
        else if(value=='4')return '已经评价';
        else return '';
        
        }
    },{  
     
        header : "维修人姓名",  
        width : 150,  
        align : "left",
        dataIndex : 'weixiu_name'  
    },{  
     
        header : "维修人电话",  
        width : 150,  
        align : "left",
        dataIndex : 'weixiu_phone'  
    },{  
      
        header : "报修项目",  
        width : 150, 
        align : "left", 
        dataIndex : 'project_name',
        sortable : true 
    }, {  
     
        header : "操作",  
        width : 100,  
        align : "left",
        dataIndex : 'status',
        renderer: function status(value){
        if(value=='0'){
         var str = "<input type='button' value='撤单' onclick='chedan("+
         value+")'>";  
         return str;  
        }else if(value=='2'){
         var str = "<input type='button' value='评价' onclick='pingjia("+
         value+")'>";  
         return str;  
        }
        else return'';
        }
    }
     ]);  
     
      cm.defaultSortable = true;
     
     var bill_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/BillSelectServlet',// 设置代理请求的url  
          method:'GET',
          scripts:true 
        }),  
         remoteSort: true,
         reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'bill', 
             fields:[
             {name:'id',type:"string"},
             {name:'address',type:"string"},
             {name:'bz_id',type:"string"},
             {name:'bz_name',type:"string"},
             {name:'weixiu_id',type:"string"},
             {name:'weixiu_phone',type:"string"},
             {name:'weixiu_name',type:"string"},
             {name:'phnone_number',type:"string"},
             {name:'satisfy',type:"string"},
             {name:'suggestion',type:"string"},
             {name:'status',type:"int"},
             {name:'order_time',type:"string"},
             {name:'order_date',type:"string"},
             {name:'finish_time',type:"string"},
             {name:'project_id',type:"string"},
             {name:'project_name',type:"string"},
             {name:'descriptions',type:"string"}
       ] }
     )  
    });  
 
   
    var bill_grid = new Ext.grid.GridPanel( {// 创建Grid表格组件  
        applyTo : 'div2',// 设置表格现实位置  
        frame : true,// 渲染表格面板  
        border: true,
        trackMouseOver: true,
        stripeRows : true,// 显示斑马线  
        height:550,//表格高
        columnLines:true,
        tbar : toolbar,// 设置顶端工具栏
        autoScroll : true,// 当数据查过表格宽度时，显示滚动条  
       // selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),//设置单行选中模式, 否则将无法删除数据 
        store : bill_store,// 设置表格对应的数据集  
        viewConfig : {// 自动充满表格  
             forceFit:true,
             height:25
        },  
        loadMask:true,

        cm : cm,// 设置表格的列  
        sm:sm,
        bbar : new Ext.PagingToolbar( {  
            pageSize : 50,  
            store : bill_store,  
            displayInfo : true,  
            displayMsg : '显示{0}条到{1}条记录,一共{2}条记录',  
            emptyMsg : '没有记录'  
        })  
    });  
  bill_grid.addClass("my-x-grid3-row") 
 bill_store.setDefaultSort('id', 'desc');  
 bill_store.load({// 加载数据集  
        params : {  
            user_name:"<%=username%>"
            
        }  
    });
     });
</script>
	</head>

	<body>

		<div id="div2">
		</div>
	</body>
</html>

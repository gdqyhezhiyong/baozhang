<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
<%
   
	String username="";
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 username = (String) request.getSession().getAttribute("username");
	 if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="../login.jsp";
			</script>
		<%
			
			}	
			
			//记录日志
			//String user_name=(String)request.getSession().getAttribute("username");
			//String name1=(String)request.getSession().getAttribute("name");
			// (new AdminService()).log(user_name,name1,"类别管理",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));

			
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>故障类别管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="js/resources/css/ext-all.css" />
		<style type="text/css">
#div2 {
	vertical-align: center;
	margin-top: 50px;
	margin-left: 150px;
	width:650px;
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
             {name : "name", mapping : "name"}
             ]
              )});    
                           
         //一级类型下拉框                    
         var projectCombo1 = new Ext.form.ComboBox({   
                    width : 100,    
                     fieldLabel : "一级类别", 
                     name : "project1",     
                     id: "project1",             
                     //emptyText: "请选择类别",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                    // allowBlank: false,                  
                    // blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: projectStore1,// 数据源              
                     listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  Ext.getCmp("deletebutton").enable();
                  Ext.getCmp("addbutton2").enable();
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
                  fieldLabel : "二级类别",              
                  name : "project2",              
                  id: "project2",              
                 // emptyText: "请选择类别",              
                  mode: 'local',              
                  autoLoad: true,              
                 // editable: false,              
                 // allowBlank: false,              
                 // blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: projectStore2,// 数据源
                  listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                      Ext.getCmp("deletebutton2").enable();
                      Ext.getCmp("addbutton3").enable();
                      
                       projectCombo3.reset();                                  
                  projectStore3.load({                                      
                  url: "servlet/CategoryServlet",                              
                  params: {                                  
                  p_id: combo.value                              
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
                 // emptyText: "请选择类别",              
                  mode: 'local',              
                  autoLoad: true,              
                 // editable: false,              
                 // allowBlank: false,              
                 // blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: projectStore3,// 数据源
                  listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                      Ext.getCmp("deletebutton3").enable();
                  }
                  } 
                   });  
                   projectCombo3.on('expand', function(comboBox) {
        comboBox.list.setWidth('240px'); //auto
        comboBox.innerList.setWidth('auto');
    }, this, { single: true });                



    var f= new Ext.form.FormPanel({ 
     title:"类型管理界面", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 630, 
     labelWidth: 100,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield"},        
     
     items: [  
    {  
        xtype: 'fieldset',
        title:'一级类型',  
        height: 60,  
        width: 600,  
        layout: 'column', //解决横向并排的方法   
        items: [{  
            width:250,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 150},  
            items: [  
            {  
                xtype: 'textfield',  
                fieldLabel: '添加类型名称',  
                name: 'inputproject',  
                id: 'inputproject',
                 height:25
                  
                   
            }]  
        },
        {  
            width:180,  
            layout: 'form',  
            labelWidth: 60,  
            defaults: {width: 110},  
            items: [  
            projectCombo1
            ]  
        }
        ,
         {  
            width: 70,  
            layout: 'form',  
            labelWidth: 20,  
            defaults: {width: 40},  
            items:[  
            {  
                xtype: 'button',  
                text: '添加   ',  
                iconCls: 'add', 
                 //disabled :true,   
                id: 'addbutton',  
                handler: function(){
                
                var inputproject = Ext.getCmp("inputproject").getValue();
                if(inputproject.trim()==''||inputproject.trim==null) {
                Ext.MessageBox.alert("提示","请输入类型名称！");
                return;
                }
                  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/AddCategoryServlet", //提交的后台地址     
                     params:{
                     inputproject:inputproject,
                     p_id:'0',
                     c_level:'0'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","添加成功！");
                       projectStore1.load({ params: {                                  
                  p_id:'0'                            
                  } });  
                       // window.location.reload();
                    
                      }else if(response.responseText=="readd"){
                       Ext.MessageBox.alert("提示"," 该一级类型已经存在！请输入别的");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","添加失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);
                
                }  
            }]  
        } ,
        {  
            width: 70,  
            layout: 'form',  
            labelWidth: 20,  
            defaults: {width: 40},  
            items:[  
            {  
                xtype: 'button',  
                text: '删除    ',
                disabled :true,  
                iconCls: 'delete',  
                id: 'deletebutton',  
                handler: function(){
                
                Ext.Msg.show({
   title:'删除一级类型',
   msg: '删除一级类型会连同该类型下的二级、三级类型一并删除，你确定执行该操作吗？',
   buttons: Ext.MessageBox.YESNOCANCEL,
  　 fn: function(btn){
  if(btn=='yes'){
  var id = Ext.getCmp("project1").getValue();
 
  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/DeleteCategoryServlet", //提交的后台地址     
                     params:{
                    id:id,
                    c_level:'0'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","删除成功！");
                       projectStore1.load({ params: {                                  
                  p_id:'0'                            
                  } });  
                  
                  projectStore2.load({ params: {                                  
                  p_id:id                            
                  } });  
                      
                      
                      }
                      else{
                     Ext.MessageBox.alert("提示","删除失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","删除失败！"); }　
　 }
);
  }
  },
   icon: Ext.MessageBox.QUESTION
});
                
                
                }  
            }]  
        }   
        ]  
    },
    {  
        xtype: 'fieldset',
        title:'二级类型',  
        height: 60,  
        width: 600,  
        layout: 'column', //解决横向并排的方法   
        items: [{  
            width:250,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 150},  
            items: [  
            {  
                xtype: 'textfield',  
                fieldLabel: '添加类型名称',  
                name: 'inputproject2',  
                id: 'inputproject2',
                height:25
                  
                   
            }]  
        },
        {  
            width:180,  
            layout: 'form',  
            labelWidth: 60,  
            defaults: {width: 110},  
            items: [  
            projectCombo2
            ]  
        }
        ,
         {  
            width: 70,  
            layout: 'form',  
            labelWidth: 20,  
            defaults: {width: 40},  
            items:[  
            {  
                xtype: 'button',  
                text: '添加   ',  
                iconCls: 'add', 
                disabled :true,   
                id: 'addbutton2',  
                handler: function(){
                 var inputproject = Ext.getCmp("inputproject2").getValue();
                 var p_id=Ext.getCmp("project1").getValue();
                if(inputproject.trim()==''||inputproject.trim==null) {
                Ext.MessageBox.alert("提示","请输入类型名称！");
                return;
                }
                  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/AddCategoryServlet", //提交的后台地址     
                     params:{
                     inputproject:inputproject,
                     p_id:p_id,
                     c_level:'1'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","添加成功！");
                       projectStore2.load({ params: {                                  
                       p_id:p_id                            
                  } });  
                       // window.location.reload();
                    
                      }else if(response.responseText=="readd"){
                       Ext.MessageBox.alert("提示"," 该二级类型已经存在！请输入别的");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","添加失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);
                             
                }  
            }]  
        } ,
        {  
            width: 70,  
            layout: 'form',  
            labelWidth: 20,  
            defaults: {width: 40},  
            items:[  
            {  
                xtype: 'button',  
                text: '删除    ',
                disabled :true,  
                iconCls: 'delete',  
                id: 'deletebutton2',  
                handler: function(){
                    
                Ext.Msg.show({
   title:'删除二级类型',
   msg: '删除二级类型会连同该类型下的三级类型一并删除，你确定执行该操作吗？',
   buttons: Ext.MessageBox.YESNOCANCEL,
  　 fn: function(btn){
  if(btn=='yes'){
  var id = Ext.getCmp("project2").getValue();
  var p_id = Ext.getCmp("project1").getValue();
 
  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/DeleteCategoryServlet", //提交的后台地址     
                     params:{
                    id:id,
                    c_level:'1'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","删除成功！");
                       projectStore2.load({ params: {                                  
                      p_id:p_id                           
                  } });  
                      
                      }
                      else{
                     Ext.MessageBox.alert("提示","删除失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","删除失败！"); }　
　 }
);
  }
  },
   icon: Ext.MessageBox.QUESTION
});
                
  
                
                }  
            }]  
        }   
        ]  
    },
    {  
        xtype: 'fieldset',
        title:'三级类型',  
        height: 60,  
        width: 600,  
        layout: 'column', //解决横向并排的方法   
        items: [{  
            width:250,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 150},  
            items: [  
            {  
                xtype: 'textfield',  
                fieldLabel: '添加类型名称',  
                name: 'inputproject3',  
                id: 'inputproject3',
                height:25
                  
                   
            }]  
        },
        {  
            width:180,  
            layout: 'form',  
            labelWidth: 60,  
            defaults: {width: 110},  
            items: [  
            projectCombo3
            ]  
        }
        ,
         {  
            width: 70,  
            layout: 'form',  
            labelWidth: 20,  
            defaults: {width: 40},  
            items:[  
            {  
                xtype: 'button',  
                text: '添加   ',  
                iconCls: 'add', 
                disabled :true,   
                id: 'addbutton3',  
                handler: function(){
                 var inputproject = Ext.getCmp("inputproject3").getValue();
                 var p_id=Ext.getCmp("project2").getValue();
                if(inputproject.trim()==''||inputproject.trim==null) {
                Ext.MessageBox.alert("提示","请输入类型名称！");
                return;
                }
                  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/AddCategoryServlet", //提交的后台地址     
                     params:{
                     inputproject:inputproject,
                     p_id:p_id,
                     c_level:'2'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","添加成功！");
                       projectStore2.load({ params: {                                  
                       p_id:p_id                            
                  } });  
                       // window.location.reload();
                    
                      }else if(response.responseText=="readd"){
                       Ext.MessageBox.alert("提示"," 该三级类型已经存在！请输入别的");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","添加失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);
                             
                }  
            }]  
        } ,
        {  
            width: 70,  
            layout: 'form',  
            labelWidth: 20,  
            defaults: {width: 40},  
            items:[  
            {  
                xtype: 'button',  
                text: '删除    ',
                disabled :true,  
                iconCls: 'delete',  
                id: 'deletebutton3',  
                handler: function(){
                    
                Ext.Msg.show({
   title:'删除三级类型',
   msg: '你确定删除该类型吗？',
   buttons: Ext.MessageBox.YESNOCANCEL,
  　 fn: function(btn){
  if(btn=='yes'){
  var id = Ext.getCmp("project3").getValue();
  var p_id = Ext.getCmp("project2").getValue();
 
  var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/DeleteCategoryServlet", //提交的后台地址     
                     params:{
                    id:id,
                    c_level:'2'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","删除成功！");
                       projectStore2.load({ params: {                                  
                      p_id:p_id                           
                  } });  
                      
                      }
                      else{
                     Ext.MessageBox.alert("提示","删除失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","删除失败！"); }　
　 }
);
  }
  },
   icon: Ext.MessageBox.QUESTION
});
                
  
                
                }  
            }]  
        }   
        ]  
    }
    ] 
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

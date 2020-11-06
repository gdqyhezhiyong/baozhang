<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
    String phone = "";
	String name = "";
	String area = "";
	String area1="";
	String building = "";
	String floor = "";
	String room = "";
	String username="";
	String sql="";
	String role_id="";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
   username = (String) request.getSession().getAttribute("username");
    role_id=(String)request.getSession().getAttribute("role_id");
    area1 = (String) request.getSession().getAttribute("area");
	 if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="../login.jsp";
			</script>
		<%
			
			}	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>人员管理</title>

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
      Ext.onReady(function () {
     Ext.QuickTips.init();
     Ext.BLANK_IMAGE_URL="ext/resources/images/default/s.gif"; 
     pingjia=function(){
     window.location.href="pingjia.jsp";
     }
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
       checked:true,
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
                  
              // 区域下拉框  
         var areaCombo = new Ext.form.ComboBox({              
                  width : 100,            
                  fieldLabel : "区域",              
                  name : "area2",              
                  id: "area2",           
                  emptyText: "请选择区域",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: areaStore 
                   });                      
            
            
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
                     fieldLabel : "所属维修工", 
                     name : "weixiu",     
                     id: "weixiu",             
                     emptyText: "请选择维修工",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: weixiuStore
                  });  
                                  
     var toolbar = new Ext.Toolbar( [
      {  text : '添加',  
        cls:"x-btn-text-icon",  
         icon: 'js/resources/icons/fam/add.gif',
        iconCls:'addIcon'  ,  
        handler : function addhuman(){
        
        
       var Edit_Panel=new Ext.form.FormPanel({     
    buttonAlign: 'center',       
     height: '100%',     
     width: 620, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:100},      
        items: 
        [ 
        
        {xtype: 'fieldset',
      id:'area',
        height: 30,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
           radiogroup
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            areaCombo
            ]
            }
        ]
     },
     {xtype: 'fieldset',
      id:'building_weixiu',
        height: 30,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "building_name", fieldLabel: "楼栋名字"}
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
           weixiuCombo
            ]
            }
        ]
     }     
        ]
    
    });
     var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 300,
        height :200 ,
        minHeight: 200,
        width:550,
        modal:true,
        closeAction:"hide",
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'楼栋添加',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
        buttons: [{
            text: '提交',
            //点击保存按钮后触发事件
            handler:function(){
            var building_name= Edit_Panel.getForm().findField("building_name").getValue();
            var area1=radiogroup.getValue();
            var area2= areaCombo.getValue();
            var weixiu_id=weixiuCombo.getValue();
           
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/AddBuildingServlet", //提交的后台地址     
                     params:{
                     building_name:building_name,
                     area1:area1,
                     area2:area2,
                     weixiu_id:weixiu_id
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","添加成功！");
                    
                      building_grid.getStore().reload({params:{start:0, limit:20}});
                      //window.location.reload();
                      }else if(response.responseText=="readd"){
                       Ext.MessageBox.alert("提示","这栋楼在系统已经存在！");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","添加失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
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
         icon: 'js/resources/icons/edit.png',
        iconCls:'editIcon'  ,  
        handler : function(){
         var row=building_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","该操作至少要选择一条记录！");
        return;
        }else if(row.length>1)
        {
        Ext.MessageBox.alert("提示","一次只能修改一条记录！");
        return;
        }
        
        else{
            var id = row[0].get("id"); 
            var name= row[0].get("name");
            var area1_id= row[0].get("area1_id");
            var area2_id= row[0].get("area2_id");
            var area2_name= row[0].get("area2_name");
            var weixiu= row[0].get("weixiu");
            //alert("area1_id:"+area1_id+" area2_id:"+area2_id+" weixiu:"+weixiu);
      var Edit_Panel=new Ext.form.FormPanel({     
     buttonAlign: 'center',       
     height: '100%',     
     width: 520, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:100},      
        items: 
        [ 
        
        {xtype: 'fieldset',
      id:'area',
        height: 30,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
           radiogroup
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            areaCombo
            ]
            }
        ]
     },
     {xtype: 'fieldset',
      id:'building_weixiu',
        height: 30,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "building_name", fieldLabel: "楼栋名字"}
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            weixiuCombo
            ]
            }
        ]
     }     
        ]
    
    });
    Edit_Panel.getForm().findField("building_name").setValue(name);
    if(area1_id=='1')
    radiogroup.setValue(1); 
    else
    radiogroup.setValue(2); 
    areaCombo.setRawValue(area2_name);
    weixiuCombo.setRawValue(weixiu); 
    
    var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 250,
        height :180 ,
        minHeight: 100,
        width:540,
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
            var building_name= Edit_Panel.getForm().findField("building_name").getValue();
            var area1_id=radiogroup.getValue();
            var area2_id=areaCombo.getValue();
            var weixiu_id=weixiuCombo.getValue();
            
            if(building_name==''){
            Ext.MessageBox.alert("警告","楼栋名称不能为空！");
            return;
            }
            if(area1_id==''){
            Ext.MessageBox.alert("警告","校区必须选择！");
            return;
            }
            if(area2_id==''){
            Ext.MessageBox.alert("警告","区域必须选择！");
            return;
            }
            if(weixiu_id==''){
            Ext.MessageBox.alert("警告","维修工必须选择！");
            return;
            }
            
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/EditBuildingServlet", //提交的后台地址     
                     params:{
                     id:id,
                     building_name:building_name,
                     area1_id:area1_id,
                     area2_id:area2_id,
                     weixiu_id:weixiu_id
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
         icon: 'js/resources/icons/fam/search.gif',
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
                name: 'weixiu'
                
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
            var weixiu =Edit_Panel.getForm().findField('weixiu').getValue();
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
         icon: 'js/resources/icons/fam/table_refresh.png',  
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
        header : "所属校区",  
        width : 200,  
        dataIndex : 'area1_id',
        renderer:function area(value){ 
        if(value==1)return '广州';
        if(value==2)return '南海';
       }
    },
    {  
        align : "center",
        header : "所属区域",  
        width : 200,  
        dataIndex : 'area2_name',
        sortable : true
    },
     {  
        align : "center",
        header : "名称",  
        width : 200,  
        dataIndex : 'name',  
        sortable : true
    }, 
     { 
        align : "center",
        header : "维修人员姓名",  
        width : 200,
        dataIndex : 'weixiu'
},{ 
        align : "center",
        header : "维修人员电话",  
        width : 200,
        dataIndex : 'phone'
}
   ]);  
     
      cm.defaultSortable = true;
     
     var building_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/BuildingSlectServlet?area='+encodeURI('<%=area1%>')+'&&role_id=<%=role_id%>',// 设置代理请求的url  
          method:'GET',
          scripts:true 
        }),  
         remoteSort: true,
          reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'building', 
             successProperty:true
         
             },         
       [
     'id','name','area1_id','area2_id','area2_name','weixiu','phone'
     ]
     )  
    });  
 
   var building_grid = new Ext.grid.GridPanel( {// 创建Grid表格组件  
        //title: '查询结果',
        applyTo : 'div2',// 设置表格现实位置  
        frame : true,// 渲染表格面板  
        border: true,
        trackMouseOver: true,
        tbar : toolbar,// 设置顶端工具栏  
        stripeRows: true,
        stripeRows : true,// 显示斑马线  
        height:585,//表格高
        autoScroll : true,// 当数据查过表格宽度时，显示滚动条  
       // selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),//设置单行选中模式, 否则将无法删除数据 
        store : building_store,// 设置表格对应的数据集  
        viewConfig : {// 自动充满表格  
             forceFit:true  
        },  
        clicksToEdit: 1, 
        cm : cm,// 设置表格的列  
        sm:sm,
        bbar : new Ext.PagingToolbar( {  
            pageSize : 20,  
            store : building_store,  
            displayInfo : true,  
            displayMsg : '显示{0}条到{1}条记录,一共{2}条记录',  
            emptyMsg : '没有记录'  
        //  ,items:['-',new Ext.app.SearchField({store:userStore})]  
        })  
    });  
    
 building_store.setDefaultSort('id', 'desc');  
 building_store.load( {// 加载数据集  
        params : {  
            start : 0,  
            limit : 20  
        }  
    }); 
    } )
</script>
	</head>
	<body>
	  <div id="div1">
		<div id="div2">
		</div>
	</body>
</html>

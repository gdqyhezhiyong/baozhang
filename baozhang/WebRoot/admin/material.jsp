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
   username = (String) request.getSession().getAttribute("username");
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
		<title>材料管理</title>

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
    
     
                   //材料类型数据     
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
                  
          //材料类型下拉框                    
         var projectCombo1 = new Ext.form.ComboBox({   
                    width : 120,    
                     fieldLabel : "材料类别", 
                     name : "project1",     
                     id: "project1",             
                     emptyText: "请选择材料类别",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: projectStore1// 数据源              
                  });           
                  
                  
                                
     var toolbar = new Ext.Toolbar( [
      {  text : '添加',  
        cls:"x-btn-text-icon",  
         icon: 'js/resources/icons/fam/add.gif',
        iconCls:'addIcon'  ,  
        handler : function addMaterial(){
        
        
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
      id:'material1',
        height: 30,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .3,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "name", fieldLabel: "材料名称"}
            ]
            },
             {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:60,  
            defaults: {width: 150,anchor: '90%' },
            items:[
            {xtype: 'numberfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "unit_price", fieldLabel: "单价(元)"}
            ]
            },
        {  columnWidth: .4, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "provider", fieldLabel: "材料提供方"}
            ]
            }
      
        ]
     }  ,
      {xtype: 'fieldset',
      id:'material2',
        height: 30,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .3,  
            layout: 'form',  
            labelWidth:60,  
            defaults: {width: 150,anchor: '90%' },
            items:[
           {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "standard", fieldLabel: "材料规格"}
            ]
            },
             {  columnWidth: .4,  
            layout: 'form',  
            labelWidth:60,  
            defaults: {width: 150,anchor: '90%' },
            items:[
             projectCombo1
            ]
            },
       
             {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 150,anchor: '90%' },
            items:[
             {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "unit", fieldLabel: "材料计算单位"}
            ]
            }
        ]
     } ,
     
     
     
     {xtype: 'fieldset',
      id:'material3',
        height: 100,  
        width: 600,  
        layout: 'column',
        items:[
        {  
            layout: 'form',  
            labelWidth:100,  
            defaults: {xtype:"textfield",width: 370,anchor: '80%' },
            items:[
              {xtype: "textarea",height: 100, width : 400, name: "remark",emptyText:"输入限100字以内！", fieldLabel: "备注"}
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
        height :280 ,
        minHeight: 200,
        width:650,
        modal:true,
        closeAction:"hide",
        layout: 'form',//layout布局方式为form
        plain: true,
        title:' 材料添加',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
        buttons: [{
            text: '添加',
            //点击保存按钮后触发事件
            handler:function(){
            var name= Edit_Panel.getForm().findField("name").getValue();
            if(name==''||name==null){
             Ext.MessageBox.alert("温馨提示！","材料名称不能为空");
             return;
            }
            var unit_price= Edit_Panel.getForm().findField("unit_price").getValue();
          if(unit_price==''||unit_price==null){
             Ext.MessageBox.alert("温馨提示！","材料单价不能为空");
             return;
            }
            var provider= Edit_Panel.getForm().findField("provider").getValue();
            var standard= Edit_Panel.getForm().findField("standard").getValue();
            var category_name=projectCombo1.getRawValue();
            var category_id=projectCombo1.getValue();
            if(category_id==''||category_id==null){
             Ext.MessageBox.alert("温馨提示！","材料类别不能为空");
             return;
            }
            
            var unit= Edit_Panel.getForm().findField("unit").getValue();
             if(unit==''||unit==null){
             Ext.MessageBox.alert("温馨提示！","材料计算单位不能为空");
             return;
            }
            
              var remark= Edit_Panel.getForm().findField("remark").getValue();
            
           
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/AddMaterialServlet", //提交的后台地址     
                     params:{
                     name:name,
                     provider:provider,
                     standard:standard,
                     category_id:category_id,
                     unit_price:unit_price,
                     category_name:category_name,
                     unit:unit,
                     remark:remark
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","添加成功！");
                    
                      material_grid.getStore().reload({params:{start:0, limit:20}});
                      //window.location.reload();
                      }else if(response.responseText=="readd"){
                       Ext.MessageBox.alert("提示","该材料在系统已经存在！");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","添加失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);

                Edit_Window.hide();
              
            material_grid.getStore().reload({params:{start:0, limit:20}});
            
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
         var row=material_grid.getSelectionModel().getSelections();
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
  {  url: "servlet/DeleteMaterialServlet", //提交的删除地址     
                     params:{ids:jsonData},       
                      method: 'post',  
                      scope: this,     
                      success:function(response){  
             Ext.MessageBox.alert("提示","成功删除"+response.responseText+"种材料!"); 
              material_grid.getStore().reload({params:{start:0, limit:20}}); //重新load数据
             },         
        failure: function()  {Ext.MessageBox.alert("提示","所选的材料删除失败！");}　
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
         var row=material_grid.getSelectionModel().getSelections();
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
            var provider= row[0].get("provider");
            var standard= row[0].get("standard");
            var unit_price= row[0].get("unit_price");
            var unit= row[0].get("unit");
            var category_id= row[0].get("category_id");
            var category_name= row[0].get("category_name");
            var remark= row[0].get("remark");
            
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
      id:'material1',
        height: 30,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .3,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "name", fieldLabel: "材料名称"}
            ]
            },
             {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:60,  
            defaults: {width: 150,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "unit_price", fieldLabel: "单价(元)"}
            ]
            },
        {  columnWidth: .4, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "provider", fieldLabel: "材料提供方"}
            ]
            }
      
        ]
     }  ,
      {xtype: 'fieldset',
      id:'material2',
        height: 30,  
        width: 600,  
        layout: 'column',
        items:[
        {  columnWidth: .3,  
            layout: 'form',  
            labelWidth:60,  
            defaults: {width: 150,anchor: '90%' },
            items:[
           {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "standard", fieldLabel: "材料规格"}
            ]
            },
             {  columnWidth: .4,  
            layout: 'form',  
            labelWidth:60,  
            defaults: {width: 150,anchor: '90%' },
            items:[
             projectCombo1
            ]
            },
       
             {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 150,anchor: '90%' },
            items:[
             {xtype: 'textfield',height:'30', allowBlank: false, blankText:"不能为空",   name: "unit", fieldLabel: "材料计算单位"}
            ]
            }
        ]
     } ,
     
     
     
     {xtype: 'fieldset',
      id:'material3',
        height: 100,  
        width: 600,  
        layout: 'column',
        items:[
        {  
            layout: 'form',  
            labelWidth:100,  
            defaults: {xtype:"textfield",width: 370,anchor: '80%' },
            items:[
              {xtype: "textarea",height: 100, width : 400, name: "remark",emptyText:"输入限100字以内！", fieldLabel: "备注"}
            ]
            }
        ]
     }   
        ]
    
    });
    
    
    
           Edit_Panel.getForm().findField("name").setValue(name);
           Edit_Panel.getForm().findField("provider").setValue(provider);
           Edit_Panel.getForm().findField("standard").setValue(standard);
           projectCombo1.setValue(category_id);
           Edit_Panel.getForm().findField("unit").setValue(unit);
           Edit_Panel.getForm().findField("remark").setValue(remark);
           Edit_Panel.getForm().findField("unit_price").setValue(unit_price);
    
    
     var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 300,
        height :280 ,
        minHeight: 200,
        width:650,
        modal:true,
        closeAction:"hide",
        layout: 'form',//layout布局方式为form
        plain: true,
        title:' 材料修改',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
        buttons: [{
            text: '更新',
            //点击保存按钮后触发事件
            handler:function(){
            var name= Edit_Panel.getForm().findField("name").getValue();
            if(name==''||name==null){
             Ext.MessageBox.alert("温馨提示！","材料名称不能为空");
             return;
            }
            var unit_price= Edit_Panel.getForm().findField("unit_price").getValue();
          if(unit_price==''||unit_price==null){
             Ext.MessageBox.alert("温馨提示！","材料单价不能为空");
             return;
            }
            var provider= Edit_Panel.getForm().findField("provider").getValue();
            var standard= Edit_Panel.getForm().findField("standard").getValue();
            var category_name=projectCombo1.getRawValue();
            var category_id=projectCombo1.getValue();
            if(category_id==''||category_id==null){
             Ext.MessageBox.alert("温馨提示！","材料类别不能为空");
             return;
            }
            
            var unit= Edit_Panel.getForm().findField("unit").getValue();
             if(unit==''||unit==null){
             Ext.MessageBox.alert("温馨提示！","材料计算单位不能为空");
             return;
            }
            
              var remark= Edit_Panel.getForm().findField("remark").getValue();
            
           
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/EditMaterialServlet", //提交的后台地址     
                     params:{
                     id:id,
                     name:name,
                     provider:provider,
                     standard:standard,
                     category_id:category_id,
                     unit_price:unit_price,
                     category_name:category_name,
                     unit:unit,
                     remark:remark
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","修改材料成功！");
                    
                      material_grid.getStore().reload({params:{start:0, limit:20}});
                      //window.location.reload();
                      }
                      else{
                     Ext.MessageBox.alert("提示","修改材料失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","修改材料失败！"); }　
　 }
);

                Edit_Window.hide();
              
            material_grid.getStore().reload({params:{start:0, limit:20}});
            
          }
        },{
            text: '原来值',  handler:function(){
            Edit_Panel.getForm().reset();
            }
        }]
    });
    
  Edit_Window.show();
                  
            }
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
        header : "材料名称",  
        width : 200,  
        dataIndex : 'name'
    },
    {  
        align : "center",
        header : "材料提供方",  
        width : 200,  
        dataIndex : 'provider',
        sortable : true
    },
     {  
        align : "center",
        header : "材料规格",  
        width : 200,  
        dataIndex : 'standard',  
        sortable : true
    }, 
     { 
        align : "center",
        header : "单价(元)",  
        width : 200,
        dataIndex : 'unit_price'
},{ 
        align : "center",
        header : "计算单位",  
        width : 200,
        dataIndex : 'unit'
},
{ 
        align : "center",
        header : "材料类型",  
        width : 200,
        dataIndex : 'category_name'
},
{ 
        align : "center",
        header : "备注",  
        width : 200,
        dataIndex : 'remark'
}
   ]);  
     
      cm.defaultSortable = true;
     
     var material_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/MaterialSlectServlet',// 设置代理请求的url  
          method:'GET',
          scripts:true 
        }),  
         remoteSort: true,
          reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'material', 
             successProperty:true
         
             },         
       [
     'id','name','unit_price','standard','unit','provider','remark','category_name','category_id'
     ]
     )  
    });  
 
   var material_grid = new Ext.grid.GridPanel( {// 创建Grid表格组件  
        //title: '查询结果',
        applyTo : 'div2',// 设置表格现实位置  
        frame : true,// 渲染表格面板  
        border: true,
        trackMouseOver: true,
        tbar : toolbar,// 设置顶端工具栏  
        stripeRows: true,
        stripeRows : true,// 显示斑马线  
        height:580,//表格高
        autoScroll : true,// 当数据查过表格宽度时，显示滚动条  
       // selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),//设置单行选中模式, 否则将无法删除数据 
        store : material_store,// 设置表格对应的数据集  
        viewConfig : {// 自动充满表格  
             forceFit:true  
        },  
        clicksToEdit: 1, 
        cm : cm,// 设置表格的列  
        sm:sm,
        bbar : new Ext.PagingToolbar( {  
            pageSize : 20,  
            store : material_store,  
            displayInfo : true,  
            displayMsg : '显示{0}条到{1}条记录,一共{2}条记录',  
            emptyMsg : '没有记录'  
        //  ,items:['-',new Ext.app.SearchField({store:userStore})]  
        })  
    });  
    
 material_store.setDefaultSort('id', 'desc');  
 material_store.load( {// 加载数据集  
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

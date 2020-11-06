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
	String role_id="";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 username = (String) request.getSession().getAttribute("username");
	 role_id = (String) request.getSession().getAttribute("role_id");
	 area = (String) request.getSession().getAttribute("area");
	 if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="../login.jsp";
			</script>
		<%
			return;
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
   
   
  var user_gruop = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "用户组",                 
                  name : "user_gruop",              
                  id: "user_gruop",              
                  emptyText: "请选择用户组",              
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
              ['广州','广州'],['南海','南海']
                    ]
   })
                   });    
  
var roleCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "角色",                 
                  name : "role1",              
                  id: "role1",              
                  emptyText: "请选择角色",              
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
              ['1','管理员'],['2','派单员'],['3','维修人员'],['5','领导'],['6','宿管']
                    ]
   })
                   });    
 
 var roleComboSuper = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "角色",                 
                  name : "role1",              
                  id: "role1",              
                  emptyText: "请选择角色",              
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
              ['7','超级管理员'],['1','管理员'],['2','派单员'],['3','维修人员'],['5','领导'],['6','宿管']
                    ]
   })
                   });    
 
                   
    
     var toolbar = new Ext.Toolbar( [
      {  text : '添加',  
        icon: 'js/resources/icons/fam/user_add.gif',
        cls:"x-btn-text-icon",  
        iconCls:'addIcon'  ,  
        handler : function addhuman(){
        
        
        
       var Edit_Panel1=new Ext.form.FormPanel({    
        title:"个人基本信息填写", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 400, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:170},  
        items: 
        [
           {inputType:"textfield",allowBlank: false, blankText:"不能为空",  name: "username1", fieldLabel: "账号"},
           {inputType:"textfield",allowBlank: false, blankText:"不能为空",  name: "name1", fieldLabel: "姓名"}, 
           {inputType:"textfield",allowBlank: false, blankText:"不能为空",name: "phone1",  fieldLabel: "电话号码"},   
            <%if("7".equals(role_id)){%>
             user_gruop,
            roleComboSuper
            <%
            }else{%>
            roleCombo
            <%
            }
            %>
     
        ]
    
    });
     var Edit_Window1 =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 300,
        height :250 ,
        minHeight: 200,
        width:400,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        title:'请输入人员信息',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel1,
        buttons: [{
            text: '提交',
            //点击保存按钮后触发事件
            handler:function(){
            var username= Edit_Panel1.getForm().findField('username1').getValue();
            var name= Edit_Panel1.getForm().findField('name1').getValue();
            var phone=Edit_Panel1.getForm().findField('phone1').getValue();
            var role=roleCombo.getValue();
            var area ='<%=area%>';
            <%if("7".equals(role_id)){%>
            area = user_gruop.getValue();
            role=roleComboSuper.getValue();
            <%}%>
            
            if(username==''){
              Ext.MessageBox.alert("提示","账号不能为空！");
              return;
            }
            if(name==''){
              Ext.MessageBox.alert("提示","姓名不能为空！");
              return;
            }
            if(phone==''){
              Ext.MessageBox.alert("提示","电话号码不能为空！");
              return;
            }
            
            if(role==''){
              Ext.MessageBox.alert("提示","角色不能为空！");
              return;
            }
            
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/AddServlet", //提交的后台地址     
                     params:{
                     username:username,
                     name:name,
                     phone:phone,
                     role:role,
                     area:area
                    
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","添加成功！");
                     // user_grid.getStore().reload({params:{start:0, limit:20}});
                       user_grid.getStore().reload({params:{start:0, limit:20}});
                      }else if(response.responseText=="readd"){
                       Ext.MessageBox.alert("提示","用户已经存在！");
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","添加失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);

                Edit_Window1.hide();
               //window.location.reload();
          
            
          }
        },{
            text: '重置',  handler:function(){Edit_Panel1.getForm().reset();}
        }]
    });
    
  Edit_Window1.show();
                        
                } 
                
    },'-',{  
        text : '删除', 
        cls:"x-btn-text-icon", 
        icon: 'js/resources/icons/fam/user_delete.gif', 
        iconCls : 'remove',  
        handler : function(){
         var row=user_grid.getSelectionModel().getSelections();
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
                var ss = row[i].get("username"); //这里为Grid数据源的Id列    
                
                if(i==0)      jsonData = jsonData + ss;   
                  else     jsonData = jsonData + ","+ ss;   
                      }    
                     
                        var conn = new Ext.data.Connection();    
                   conn.request( 
  {  url: "servlet/DeleteUserServlet", //提交的删除地址     
                     params:{username:jsonData},       
                      method: 'post',  
                      scope: this,     
                      success:function(response){  
             Ext.MessageBox.alert("提示","成功删除"+response.responseText+"条记录!"); 
              user_grid.getStore().reload({params:{start:0, limit:20}}); //重新load数据
             },         
        failure: function()  {Ext.MessageBox.alert("提示","所选记录删除失败！");}　
　 });
　　}
   }
　　 });
        
        }
         }
 }
 
 ,'-',
     { text : '修改',  
        cls:"x-btn-text-icon",  
        icon: 'js/resources/icons/fam/user_edit.png',
        iconCls:'editIcon'  ,  
        handler : function(){
          
         var row=user_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","该操作至少要选择一条记录！");
        return;
        }else if(row.length>1){
         Ext.MessageBox.alert("提示","一次只能修改一条记录！");
        return;
        }
        else{
           var username = row[0].get("username"); 
            var name= row[0].get("name");
            var role_id= row[0].get("role_id");
            var phone_number= row[0].get("phone_number");      
            
        
      
      var Edit_Panel2=new Ext.form.FormPanel({    
     buttonAlign: 'center',       
     height: '100%',     
     width: 400, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:170},  
        items: 
        [
        {allowBlank: false, blankText:"不能为空",  name: "name2",fieldLabel: "姓名"}, 
        {allowBlank: false, blankText:"不能为空",name: "phone2",  fieldLabel: "电话号码"}, 
        <%if("7".equals(role_id)){%>
            user_gruop,
            roleComboSuper
            <%
            }else{%>
            roleCombo
            <%
            }
            %>
        ]
    
    });
    
    
    
    var Edit_Window2=  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 300,
        height :200 ,
        minHeight: 200,
        width:400,
        modal:true,
        closeAction:"hide",
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'人员信息修改',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel2,
        buttons: [{
            text: '修改',
            //点击保存按钮后触发事件
            handler:function(){
             var name_new= Edit_Panel2.getForm().findField("name2").getValue();
             var phone_new=Edit_Panel2.getForm().findField('phone2').getValue();
             var role_new=  roleCombo.getValue();
             var area ='<%=area%>';
            <%if("7".equals(role_id)){%>
            area = user_gruop.getValue();
            role_new=roleComboSuper.getValue();
            <%}%>
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/ChangeUserServlet", //提交的后台地址     
                     params:{
                     username:username,
                     name_new:name_new,
                     phone_new:phone_new,
                     role_new:role_new,
                     area:area
                    
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","修改成功！");
                      user_grid.getStore().reload({params:{start:0, limit:20}});
                      }
                      else{
                     Ext.MessageBox.alert("提示","修改失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","修改失败！"); }　
　 }
);

       
              Edit_Window2.hide();
           // window.location.reload();
           
          }
        },{
            text: '重置',  handler:function(){Edit_Panel2.getForm().reset();}
        }]
    });
    
            Edit_Panel2.getForm().findField("name2").setValue(name);
            Edit_Panel2.getForm().findField("phone2").setValue(phone_number);
            roleCombo.setValue(role_id);
            Edit_Window2.show();
            
        
         }        
    }
    }
 
    
    
    ,'-',{   text: '查询',  
         cls:"x-btn-text-icon",  
         icon: 'js/resources/icons/fam/search.gif',
         handler: function () {  
         
        
         
         var Edit_Panel3=new Ext.form.FormPanel({    
        labelWidth: 100, 
        labelAlign:'right',
        frame:true,      
        bodyStyle:'padding:5px 5px 0',
        width: 380,
        defaults: {width: 150},
        defaultType: 'textfield',
        items: 
        [
        roleCombo,
             {
                //label名称
                fieldLabel: '姓名',
                //textfield名称
                name: 'name3'
            }
        ]
    
    });
     var Edit_Window3 =  new Ext.Window({
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
        items: Edit_Panel3,
        buttons: [{
            text: '查询',
            //点击保存按钮后触发事件
            handler:function(){
            var role3=roleCombo.getValue();
            var name3=Edit_Panel3.getForm().findField('name3').getValue();
           Ext.apply(   
                      user_grid.getStore().baseParams,   
                      {   
                           role:role3,
                           name:name3
                      }); 
                Edit_Window3.hide();
             // window.location.reload();
            user_grid.getStore().reload({params:{start:0, limit:20}});
            
          }
        },{
            text: '重置',  handler:function(){Edit_Pane3.getForm().reset();}
        }]
    });
    
  Edit_Window3.show();
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
        header : "账号",  
        width : 200,  
        dataIndex : 'username',  
        sortable : true
        
    },{  
        align : "center",
        header : "姓名",  
        width : 200,  
        dataIndex : 'name',
         sortable : true
    }, { 
        align : "center",
        header : "角色",  
        width : 200,
        dataIndex : 'role_id', 
        renderer:function(value){ 
        if(!value)return '';
        else{
        switch(value){
        case 7:
        return '超级管理员';
        break;
        case 4:
        return '报障人';
        break;
        case 1:
        return '管理员';
        break;
        case 2:
        return '派单员';
        break;
         case 3:
        return '维修员';
        break;
        case 5:
        return '领导';
        break;
        case 6:
        return '宿管';
        break;
        default:
        return '';
        break;
        }
        }   
},
  sortable : true 
    } ,  
    {  
        align : "center",
        header : "用户组",  
        width : 200,  
        dataIndex : 'area',
         sortable : true
    },
    {
        align : "center",
        header : "电话号码",  
        width : 200,  
        dataIndex : 'phone_number',
        editor:new Ext.grid.GridEditor(new Ext.form.TextField({
                allowBlank:false
                }))
    }
     ]);  
     
      cm.defaultSortable = true;
     
     var user_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/UserSlectServlet?role_id=<%=role_id%>&&area='+encodeURI('<%=area%>'),// 设置代理请求的url  
          method:'GET',
          scripts:true 
        }),  
         remoteSort: true,
          reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'user', 
             successProperty:true
         
             },         
       [
     'username','name','role_id','phone_number','class_id','password','area'
     ]
     )  
    });  
 
   var user_grid = new Ext.grid.EditorGridPanel( {// 创建Grid表格组件  
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
        store : user_store,// 设置表格对应的数据集  
        viewConfig : {// 自动充满表格  
             forceFit:true  
        },  
        clicksToEdit: 1, 
        cm : cm,// 设置表格的列  
        sm:sm,
        bbar : new Ext.PagingToolbar( {  
            pageSize : 20,  
            store : user_store,  
            displayInfo : true,  
            displayMsg : '显示{0}条到{1}条记录,一共{2}条记录',  
            emptyMsg : '没有记录'  
        //  ,items:['-',new Ext.app.SearchField({store:userStore})]  
        })  
    });  
    
 user_store.setDefaultSort('user_name', 'desc');  
 user_store.load( {// 加载数据集  
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

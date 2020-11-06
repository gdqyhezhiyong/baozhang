<%@ page language="java" import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*" pageEncoding="UTF-8"%>
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
			parent.window.location.href="../net.jsp";
			</script>
		<%
			
			}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>"/>
		<title>类别管理</title>
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
#tree-div{
width:600px;
height:600px;;
margin-left:200px;
}	
		</style>
		<script language="javascript">
 Ext.onReady(function () {
     Ext.QuickTips.init();
     
     
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


     
     var tree = new Ext.tree.TreePanel({   
    renderTo:'tree-div',   
    title:'类别管理',   
    width:600,   
   // minSize:400,   
    //maxSize:700,   
    height:500,
    split:true,   
    autoScroll:true,   
    autoHeight:false,   
    collapsible:true, 
    listeners:{
     'contextmenu':function(n,e){   
               if (n.isLeaf()) {
                var myMenu1 = new Ext.menu.Menu({      
        items:[
         {      
                text: '删除' ,
                 handler :function del(){
                 var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/CategoryCRUDServlet", //提交的后台地址     
                     params:{
                    id:n.id,
                    operation:'D',
                    level:n.attributes.c_level
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     var responestr = response.responseText; 
                     if(responestr=='succ')   
                     Ext.MessageBox.alert("提示","删除成功！");  
                     else{
                     Ext.MessageBox.alert("提示","删除失败！");  
                     } 
                    // tree.getLoader()
                     history.go(0);
             },         
        failure: function() {Ext.MessageBox.alert("提示","删除失败！"); }　
　 }
);   
               
                }      
            },{      
                text: '修改',
                 handler:function modify(){
         
         var adminRadio=new Ext.form.Radio({ 
        boxLabel:'一般', 
        inputValue:0,
       // checked:true, 
        listeners:{ 
            'check':function(){ 
                if(adminRadio.getValue()){ 
                    userRadio.setValue(false); 
                    adminRadio.setValue(true); 
                } 
            } 
        } 
    }); 
    var userRadio=new Ext.form.Radio({ 
        boxLabel:'紧急', 
        inputValue:'1',
       
        listeners:{ 
            'check':function(){ 
                if(userRadio.getValue()){ 
                    adminRadio.setValue(false); 
                    userRadio.setValue(true); 
                     
                } 
            } 
        } 
    }); 

var radiogroup = new Ext.form.RadioGroup({
                fieldLabel: '是否紧急',
                width: 100,
                items: [adminRadio,userRadio]
            });        
                 
      if(n.attributes.jinji=='0')  {
      userRadio.setValue(false); 
      adminRadio.setValue(true); 
      }    else{
      userRadio.setValue(true); 
      adminRadio.setValue(false); 
      
      }     
                 
     var modify_panel=new Ext.form.FormPanel({     
     buttonAlign: 'center',       
     height: '100%',     
     width: 300, 
     labelWidth: 100,  
     labelAlign: 'left',   
     frame: true, 
     defaults:{xtype:"textfield",width:150},  
        items: 
        [
         {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空",  name: "c_name", fieldLabel: " 新类型名称"},
          radiogroup
        ]
    
    });
    
    modify_panel.getForm().findField("c_name").value=n.text;
    var modify_window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 290,
        height :150 ,
        minHeight: 100,
        width:300,
        modal:true,
        closeAction:"hide",
        layout: 'form',
        plain: true,
        title:'类型修改',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: modify_panel,
        buttons: [{
            text: '修改',
            handler:function(){
            var c_name = modify_panel.getForm().findField("c_name").getValue();
           
         var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/CategoryCRUDServlet", //提交的后台地址     
                     params:{
                    id:n.id,
                    operation:'U',
                    c_name:c_name,
                    jinji:radiogroup.getValue()
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     var responestr = response.responseText; 
                     if(responestr=="succ")   
                     Ext.MessageBox.alert("提示","修改成功！");  
                     else{
                     Ext.MessageBox.alert("提示","修改失败！");  
                     } 
                    // tree.getLoader()
                     history.go(0);
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);   
     modify_window.close();        
   
   }                  
　 }]
}
);

                modify_window.show();
                }      
            }
        ]      
    }) ;    
          myMenu1.showAt(e.getXY()); 
            }else{
            
            var myMenu = new Ext.menu.Menu({      
        items:[
         {      
                text: '添加子类别',
                handler : function add(){
           
       var adminRadio=new Ext.form.Radio({ 
        boxLabel:'一般', 
        inputValue:0,
       checked:true, 
        listeners:{ 
            'check':function(){ 
                if(adminRadio.getValue()){ 
                    userRadio.setValue(false); 
                    adminRadio.setValue(true); 
                } 
            } 
        } 
    }); 
    var userRadio=new Ext.form.Radio({ 
        boxLabel:'紧急', 
        inputValue:'1',
       
        listeners:{ 
            'check':function(){ 
                if(userRadio.getValue()){ 
                    adminRadio.setValue(false); 
                    userRadio.setValue(true); 
                     
                } 
            } 
        } 
    }); 

var radiogroup = new Ext.form.RadioGroup({
                fieldLabel: '是否紧急',
                width: 100,
                items: [adminRadio,userRadio]
            });        
                           
     var add_panel=new Ext.form.FormPanel({     
     buttonAlign: 'center',       
     height: '100%',     
     width: 300, 
     labelWidth: 60,  
     labelAlign: 'left',   
     frame: true, 
     defaults:{xtype:"textfield",width:170},  
        items: 
        [ 
         {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空",  name: "c_name", fieldLabel: "类型名称"}
         
        ]
    
    });
    if(n.attributes.c_level=='1'){
    add_panel.add(radiogroup);
    add_panel.doLayout（）;  
    
    }
    
    var add_window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 290,
        height :150 ,
        minHeight: 100,
        width:300,
        modal:true,
        closeAction:"hide",
        layout: 'form',
        plain: true,
        title:'添加类型',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: add_panel,
        buttons: [{
            text: '添加',
            handler:function(){
            var c_name = add_panel.getForm().findField("c_name").getValue();
           
         var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/CategoryCRUDServlet",  
                     params:{
                    id:n.id,
                    operation:'C',
                    c_name:c_name,
                    level:n.attributes.c_level,
                    jinji:radiogroup.getValue()
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     var responestr = response.responseText; 
                     if(responestr=='succ')   
                     Ext.MessageBox.alert("提示","添加成功！");  
                     else{
                     Ext.MessageBox.alert("提示","添加失败！");  
                     } 
                    // tree.getLoader()
                     history.go(0);
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);   
     add_window.close();        
   
   }                  
　 }]
}
);

                add_window.show();
    
    
    
    
               
                }    
            },{      
                text: '删除',
                handler : function del(){
                 var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/CategoryCRUDServlet", //提交的后台地址     
                     params:{
                    id:n.id,
                    operation:'D',
                    level:n.attributes.c_level
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     var responestr = response.responseText; 
                     if(responestr=='succ')   
                     Ext.MessageBox.alert("提示","删除成功！");  
                     else{
                     Ext.MessageBox.alert("提示","删除失败！");  
                     } 
                    // tree.getLoader()
                     history.go(0);
             },         
        failure: function() {Ext.MessageBox.alert("提示","删除失败！"); }　
　 }
);   
                }   
            },{      
                text: '修改',
                 handler : function modify(){
               var modify_panel=new Ext.form.FormPanel({     
     buttonAlign: 'center',       
     height: '100%',     
     width: 300, 
     labelWidth: 100,  
     labelAlign: 'left',   
     frame: true, 
     defaults:{xtype:"textfield",width:150},  
        items: 
        [ 
         {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空",  name: "c_name", fieldLabel: " 新类型名称"}
        ]
    
    });
    modify_panel.getForm().findField("c_name").value=n.text;
    
    var modify_window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 290,
        height :130 ,
        minHeight: 100,
        width:300,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'类型修改',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: modify_panel,
        buttons: [{
            text: '修改',
            handler:function(){
            var c_name = modify_panel.getForm().findField("c_name").getValue();
           
         var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/CategoryCRUDServlet", //提交的后台地址     
                     params:{
                    id:n.id,
                    operation:'U',
                    c_name:c_name
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     var responestr = response.responseText; 
                     if(responestr=="succ")   
                     Ext.MessageBox.alert("提示","修改成功！");  
                     else{
                     Ext.MessageBox.alert("提示","修改失败！");  
                     } 
                    // tree.getLoader()
                     history.go(0);
             },         
        failure: function() {Ext.MessageBox.alert("提示","添加失败！"); }　
　 }
);   
     modify_window.close();        
   
   }                  
　 }]
}
);

                modify_window.show();
    
    
                }  
                    
            }
        ]      
    }) ;   
             myMenu.showAt(e.getXY()); 
            }
            }   
        },  
    rootVisable:false, //不显示根节点   
    root:new Ext.tree.AsyncTreeNode({   
        id:'root',   
        text:'类别根目录',   
        draggable:false,   
        expanded:true ,
        loader:new Ext.tree.TreeLoader({
          applyLoader:true,
          url:"servlet/NetTreeServlet"
  })
    })   
});   


    tree.getRootNode().expand(false,true);
   
     
     })
    
    
    
       </script>
	</head>

	<body>
	<div >
	
	</div>
		<div id="tree-div">
		</div>
	</body>
</html>

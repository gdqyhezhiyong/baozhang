<%@ page language="java" import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String name="";
	String jsonurl="";
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			String userName = (String)request.getSession().getAttribute("username");
			String role_id= (String)request.getSession().getAttribute("role_id");
			//System.out.println("role_id:"+role_id);
			if("1".equals(role_id)){
			jsonurl="js/treedata_admin1.js";
			}
		
			if(userName==null){
			response.sendRedirect("../login.jsp");
			return;
			}else{
			ResultSet rs =DBHelper.getConnection().createStatement().executeQuery("select name from t_user where user_name= '"+userName+"'");
			if(rs.next()){
			name= rs.getString("name");
			}
			}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<title>后勤报修后台管理系统 </title>

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
#bar{
background:url(images/bj.gif) no-repeat;
width:1003px;
height:157px;
margin:0 auto;
}
#main_panel{
width:auto;
height:auto;
margin:0 auto;
}	
		</style>
		<script language="javascript">
    
    //左边功能树   
var menuTree = new Ext.tree.TreePanel({   
    region:'west',   
    title:'后勤报修',   
    width:180,   
    minSize:150,   
    maxSize:200,   
    split:true,   
    autoScroll:true,   
    autoHeight:false,   
    collapsible:true,   
    rootVisable:false, //不显示根节点   
    root:new Ext.tree.AsyncTreeNode({   
        id:'root',   
        text:'操作导航',   
        draggable:false,   
        expanded:true ,
        loader:new Ext.tree.TreeLoader({
          applyLoader:false,
          url:"<%=jsonurl%>"
  })
    })   
});   
menuTree.expandAll(); 
menuTree.on('click',treeClick); 

// 设置树的点击事件

    function treeClick(node, e) {
        if (node.isLeaf()) {

            e.stopEvent();
 contentPanel.remove(contentPanel.getActiveTab());
            var n = contentPanel.getComponent(node.id);
           
          if(node.id=='21'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/humanadmi.jsp"></iframe>'

                        });

            }
          } 
          else if(node.id=='22'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/category_tree.jsp"></iframe>'

                        });

            }
          } 
           else if(node.id=='23'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/addressAdmin.jsp"></iframe>'

                        });

            }
          } 
          else if(node.id=='01'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/paidan.jsp"></iframe>'

                        });

            }
          } else if(node.id=='02'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/phonereg.jsp"></iframe>'

                        });

            }
          } 
           else if(node.id=='03'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/print.jsp"></iframe>'

                        });

            }
          } 
           else if(node.id=='04'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/billcheck.jsp"></iframe>'

                        });

            }
          } 
          else if(node.id=='14'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/manyidu.jsp"></iframe>'

                        });

            }
          }
          
           else if(node.id=='11'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/search.jsp"></iframe>'

                        });

            }
          }
           else if(node.id=='15'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/leibie.jsp"></iframe>'

                        });

            }
          }
           else if(node.id=='16'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/month_count.jsp"></iframe>'

                        });

            }
          } 
          else if(node.id=='18'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/workload.jsp"></iframe>'

                        });

            }
          }
          
          
          else if(node.id=='19'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/delay.jsp"></iframe>'

                        });

            }
          }
          else if(node.id=='26'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/today.jsp"></iframe>'

                        });

            }
          }
           else if(node.id=='27'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/area.jsp"></iframe>'

                        });

            }
          }
        else if(node.id=='25'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/week.jsp"></iframe>'

                        });

            }
          }
         else if(node.id=='24'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/log.jsp"></iframe>'

                        });

            }
          }  
           else if(node.id=='17'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/year.jsp"></iframe>'

                        });

            }
          }   
          
           else if(node.id=='29'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/material.jsp"></iframe>'

                        });

            }
          }     
           else if(node.id=='30'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/work_hours.jsp"></iframe>'

                        });

            }
          }     
           else if(node.id=='31'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/supplies.jsp"></iframe>'

                        });

            }
          }     
          
          
          else if(node.id=='32'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : node.text,

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/money.jsp"></iframe>'

                        });

            }
          }     
          
          
          else{
        Ext.MessageBox.alert("提示","该功能还没有开放！");
        }
        
            contentPanel.setActiveTab(n);

        }

    }
    
    var name ="<%=name%>";
        var src = [];     
     src.push('<table width=100%><tr><td><img src="js/resources/images/bz_logo_houqin.jpg"/></td><td Style="font-size:15px"><img src="js/resources/icons/fam/user_suit.gif" style="padding-left:5px"/>');
    if (!Ext.isEmpty(name)) {
        src.push(name);
        src.push('，您好！欢迎进入后勤报修系统！');
    }
 
    src.push('<td ><a href="" onclick="return changepad()" align="left" Style="font-size:15px">修改密码</a></td>'); 
    src.push('<td ><a href="servlet/AdminLogoutServlet" align="left" Style="font-size:15px">退出系统</a></td></tr></table>');
   
 
    var toolbar = new Ext.BoxComponent({ // raw
        region:'north',
        autoHeight:true,
        autoEl: {
            tag:'blockquote',
            html:src.join('')
        }
    });
             
             
             
   var toolbar1 =  new Ext.BoxComponent({ // raw
        region:'south',
        autoHeight:true,
        autoEl: {
            tag:'blockquote',
            html:'<div style="text-align:center;">&copy;广东轻工职业技术学院  网络信息中心  2013 </div>'
        },
        height:32
    });
    
     var panel = new Ext.Panel({
    width:'auto',
    height:70,
    region:'north',
    bodyStyle:'background-color: #D4DFFF',
   // html:htmlArray.join('')
   items: [
    //imagebar,
    toolbar
        ]      
    });
  
//右边具体功能面板区   
var contentPanel = new Ext.TabPanel({   
    region:'center',   
    enableTabScroll:true,   
    activeTab:0,   
    items:[{   
        id:'homePage',   
        title:'报修受理',   
        autoScroll:true,   
        html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="admin/paidan.jsp"></iframe>',
         listeners:{
     activate:function(tab){
      tab.getUpdater().refresh();
     }
    }
    }]   
});   
  
Ext.onReady(function(){   
    new Ext.Viewport({  
        layout:'border', //使用border布局   
        defaults:{activeItem:0},   
        items:[panel,menuTree, contentPanel,toolbar1]   
    });   
});   


function changepad() { 
                
        var Edit_Panel1=new Ext.form.FormPanel({    
        title:"密码修改", 
     buttonAlign: 'center',       
     height: '100%',     
     width: 350, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:170},  
        items: 
        [
           {inputType:"textfield",allowBlank: false, blankText:"不能为空",  name: "password1", fieldLabel: "新密码"},
           {inputType:"textfield",allowBlank: false, blankText:"不能为空",  name: "password2", fieldLabel: "重新输入新密码"}
     
        ]
    
    });
     var Edit_Window1 =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 300,
        height :180 ,
        minHeight: 200,
        width:350,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        title:'',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel1,
        buttons: [{
            text: '提交',
            //点击保存按钮后触发事件
            handler:function(){
            var password1= Edit_Panel1.getForm().findField('password1').getValue();
            var password2= Edit_Panel1.getForm().findField('password2').getValue();
         
            if(password1==''||password2==''){
              Ext.MessageBox.alert("提示","密码不能为空！");
              return;
            }
            if(password1!=password2){
              Ext.MessageBox.alert("提示","你输入的密码不一致！");
              return;
            }
           
            
             var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/ChangePasswordServlet", //提交的后台地址     
                     params:{
                     password:password1
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                      if(response.responseText=="succ"){ 
                      Ext.MessageBox.alert("提示","密码修改成功！");
                    
                      }
                      else{
                     Ext.MessageBox.alert("提示","密码修改失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","密码修改失败！"); }　
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
               return false;
                   }
       </script>
	</head>

	<body>
	<div >
	
	</div>
		<div id="main_panel">
		</div>
	</body>
</html>

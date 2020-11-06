<%@ page language="java" import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*" pageEncoding="UTF-8"%>
<%
    String name="";
    String role_id="";
    String userName="";
    String inside="";

	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
		    userName = "2012108038";//(String)request.getSession().getAttribute("client_id");
			name ="何志勇"; //(String)request.getSession().getAttribute("client_name");
			role_id ="1";//(String)request.getSession().getAttribute("client_role_id");
			inside ="yes"; //(String)request.getSession().getAttribute("inside");
			
			
			if(userName==null){
			%>
		   <script language="javascript">
			parent.window.location.href="../index.jsp";
			</script>
		<%
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

		<title>网上报修系统 </title>
                <!--<meta name="viewport"  content="width=device-width, initial-scale=1">-->
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
    title:'网上报修',   
    width:180,   
    minSize:150,   
    maxSize:200, 
    bodyStyle:'background-color: #d4dfff',  
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
          url:"js/treedata_client.js"
  })
    })   
});   
menuTree.expandAll();
menuTree.on('click',treeClick); 

// 设置树的点击事件

    function treeClick(node, e) {
        if (node.isLeaf()) {
 contentPanel.remove(contentPanel.getActiveTab());
           // e.stopEvent();

            var n = contentPanel.getComponent(node.id);
          if(node.id=='01'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/reg.jsp"></iframe>'

                        });

            }
          }else if(node.id=='04'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                             'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/cancellation.jsp"></iframe>'

                        });

            }
          }
          else if(node.id=='02'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                             'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/tip.jsp"></iframe>'

                        });

            }
          }else if(node.id=='03'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/pingjia.jsp"></iframe>'

                        });

            }
          }else if(node.id=='22'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/changepassword.jsp"></iframe>'

                        });

            }
          }else if(node.id=='21'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/changeinfo.jsp"></iframe>'

                        });

            }
          }
          else if(node.id=='11'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/net_reg.jsp"></iframe>'

                        });

            }
          }
          else if(node.id=='12'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/net_pingjia.jsp"></iframe>'

                        });

            }
          }
          
          else if(node.id=='13'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/net_cancellation.jsp"></iframe>'

                        });

            }
          }

 else if(node.id=='14'){
          if (!n) {
               
                var n = contentPanel.add({

                            'id' : node.id,

                            'title' : "网上报修系统",

                            closable : true,

                           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/net_tip.jsp"></iframe>'

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
     src.push('<table width=100% style="background-color:2c57b6;color:#FFFFFF"><tr><td><img src="js/resources/images/bz_logo.jpg"/></td width="30%"><td Style="font-size:15px"><img src="js/resources/icons/fam/user_suit.gif" style="padding-left:5px"/>');
    if (!Ext.isEmpty(name)) {
        src.push(name);
        src.push('，您好！欢迎进入网上报修系统！');
    }
 
    
    src.push('</td>');
src.push('<td ><a href="http://bz.gdqy.edu.cn/tosd.jsp" align="left" Style="font-size:15px;color:#FFFFFF" target="_blank">水电费查询</a></td>');
    src.push('<td ><a href="http://www.gdqy.edu.cn"  align="left" Style="font-size:15px;color:#FFFFFF" target="_blank">学校主页</a></td>');  
     src.push('<td ><a href="" onclick="exitsys()" align="left" Style="font-size:15px;color:#FFFFFF">退出</a></td>'); 
    src.push('</tr></table>');
   var imagebar = new Ext.BoxComponent({ // raw
        xtype: 'box',
        height:60,
        width:470,
        layout:'fit',
        autoEl: {
           tag: 'img',      
           src: 'js/resources/images/bz_logo.jpg'
        }
    });
    var toolbar = new Ext.BoxComponent({ // raw
        autoHeight:true,
        autoEl: {
            tag:'blockquote',
            html:src.join('')
        }
    });
    
    var htmlArray =['<div style="text-align:center;padding-top:20px">','dfd','</div>'];
     var panel = new Ext.Panel({
    width:'auto',
    height:60,
    region:'north',
    bodyStyle:'background-color: #2c57b6',
   // html:htmlArray.join('')
   items: [
    //imagebar,
    toolbar
        ]      
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
  
//右边具体功能面板区   
var contentPanel = new Ext.TabPanel({   
    region:'center',   
    enableTabScroll:true,   
    activeTab:0,   
    items:[{   
        id:'homePage',   
        title:'报修流程与注意事项',   
        autoScroll:true,   
        html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="client/tip.jsp"></iframe>',
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


function exitsys() { 
                 //window.location.href="servlet/Logout";
                 window.close();
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

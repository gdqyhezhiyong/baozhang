<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
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
			parent.window.location.href="../net.jsp";
			</script>
		<%
			
			}	
			
			//记录日志
			String user_name=(String)request.getSession().getAttribute("username");
			String name1=(String)request.getSession().getAttribute("name");
			// (new AdminService()).log(user_name,name1,"延时单查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));

			
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>延时报修单</title>

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

<style type="text/css">


</style>
		<script language="javascript">
    
     
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
     
               
                         
         
                  
                  
                  
                   //工具栏维修人员下拉框                   
         var weixiubar = new Ext.form.ComboBox({   
                    width : 100,  
                     emptyText: "选择维修工",   
                     name : "weixiubar",     
                     id: "weixiubar",                     
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: true,                        
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: weixiuStore,
                     listeners: {// select监听函数                             
                      select : function(combo, record, index){                            
                  bill_store.load({                                      
                  url: "servlet/DelaySelectServlet",                              
                  params: {                                  
                  weixiu_id: combo.value,
                   start : 0,  
                   limit : 30                             
                  }  
                  });                 
                  }            
                  }  
                  });  
     
     
     var toolbar = new Ext.Toolbar( [
      
         weixiubar
          ,'-',{   text: '全部',  
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
      
     var cm = new Ext.grid.ColumnModel( {
     defaults: {
             css : 'height:30px; vertical-align:middle; font-size:13;border-width:1px;'
         },
   columns: [
    new Ext.grid.RowNumberer({ align : "center", header : "序号",  width : 32}),
     sm,
     {  
        align : "center",
        header : "校区",  
        width : 50,  
        dataIndex : 'area1',  
        sortable : true 
        
    },
    {  
        align : "center",
        header : "单号",  
        width : 50,  
        dataIndex : 'id',  
        sortable : true 
        
    }, 
     {  
        align : "center",
        header : "区域",  
        width : 50,  
        dataIndex : 'area2',  
        sortable : true 
        
    }, 
     {  
        align : "center",
        header : "楼栋",  
        width : 80,  
        dataIndex : 'building'
        
    },  
     {  
        align : "center",
        header : "楼层",  
        width : 50,  
        dataIndex : 'floor'
        
    },  
     {  
        align : "center",
        header : "房间",  
        width : 50,  
        dataIndex : 'room'
        
    },    
    { 
        align : "center",
        header : "紧急程度",  
        width : 80,  
        dataIndex : 'jinji',  
        sortable : true,
        renderer : function(value){
			if(value=='0')return '一般';
			if(value=='1')return '<span style="color:red;">紧急</span>';
} 
    },  
    
    {  
        align : "center",
        header : "延时时间",  
        width : 50,  
        dataIndex : 'delay_time',  
        sortable : true,
        renderer : function(value){
			if(value<3)return '<span>'+value+'小时'+'</span>';
			if(value>=3&&value<6)return '<span style="color:#FF7F00">'+value+'小时'+'</span>';
             else return '<span style="color:red">'+value+'小时'+'</span>';
} 
        
    },         
      {  
        align : "center",
        header : "报修人姓名",  
        width : 100,  
        dataIndex : 'bz_name'
        
    }, 
    {  
        align : "left",
        header : "报修人电话",  
        width : 80,  
        dataIndex : 'phnone_number'
    },{ 
        align : "center",
        header : "报修时间",  
        width : 120,  
        dataIndex : 'order_date', 
        renderer:function(value){ 
        var a=value.substring(0,16);
        return a;  
},
  sortable : true 
    } 
,{  
     
        header : "维修人姓名",  
        width : 100,  
        align : "center",
         sortable : true,
        dataIndex : 'weixiu_name'  
    },{  
     
        header : "维修人电话",  
        width : 100,  
        align : "center",
        dataIndex : 'weixiu_phone'  
    }
     ]
     }
     );  
     
      cm.defaultSortable = true;
     
     var bill_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/DelaySelectServlet',// 设置代理请求的url  
          method:'GET',
          scripts:true 
        }),  
         remoteSort: true,
         reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'bill', 
             fields:[
             {name:'id',type:"string"},
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
             {name:'project',type:"string"},
             {name:'descriptions',type:"string"},
             {name:'project1',type:"string"},
             {name:'project2',type:"string"},
             {name:'project3',type:"string"},
             {name:'area1',type:"string"},
             {name:'area2',type:"string"},
             {name:'building',type:"string"},
             {name:'floor',type:"string"},
             {name:'room',type:"string"},
             {name:'jinji',type:"string"},
             {name:'delay_time',type:"int"}
       ] }
     )  
    });  
 
   
    var bill_grid = new Ext.grid.GridPanel( {// 创建Grid表格组件  
        applyTo : 'div2',// 设置表格现实位置  
        frame : true,// 渲染表格面板  
        border: true,
        tbar : toolbar,// 设置顶端工具栏  
        trackMouseOver: true,
        stripeRows : true,// 显示斑马线  
        height:580,//表格高
        columnLines:true,
        autoScroll : true,// 当数据查过表格宽度时，显示滚动条  
       // selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),//设置单行选中模式, 否则将无法删除数据 
        store : bill_store,// 设置表格对应的数据集  
        viewConfig : {// 自动充满表格  
            forceFit:true,
            scrollOffset: 0
        },  
        loadMask:true,
        listeners : {
         'afterrender' : function(){
               var elments = Ext.select(".x-grid3-header");//.x-grid3-hd   
                elments.each(function(el) {   
                           el.setStyle("background-color", '#C1DBC6');// 设置不同的颜色  
                           el.setStyle("background-image", 'none');
                           el.setStyle("height", '30px');
                           el.setStyle("font-weight", 'bold');
                           el.setStyle("font-size", '18px');
                           // el.setStyle("font-weight", 'bold');
                        }, this) ;       
            }
        }

       ,
        cm : cm,// 设置表格的列  
        sm:sm,
        bbar : new Ext.PagingToolbar( {  
            pageSize : 30,  
            store : bill_store,  
            displayInfo : true,  
            displayMsg : '显示{0}条到{1}条记录,一共{2}条记录',  
            emptyMsg : '没有记录'  
        //  ,items:['-',new Ext.app.SearchField({store:userStore})]  
        }) 
    });  
    
   /* var viewConfig={ 
          templates:{   
 
            //  在模板中引入自己定义的样式。使用这个view的grid的header的样式就修改了。   
              header:new Ext.Template( 
                  ' <table border="0" cellspacing="0" cellpadding="0" >', 
                  ' <thead> <tr style="height:40px; vertical-align:middle; font-size:12;" id="my-grid-head">{mergecells} </tr>' + 
                  ' <tr id="x-grid3-hd-row">{cells} </tr> </thead>', 
                  " </table>" 
                  ), 
             mhcell: new Ext.Template( 
                  ' <td id="myrow" colspan="{mcols}"> <div align="center"> <b>{value} </b> </div>', 
                  " </td>" 
                  )   
          } 
      };
      
      bill_grid.view=new Ext.grid.GridView(viewConfig);
 // bill_grid.addClass("my-x-grid3-row")
 */ 
 bill_store.setDefaultSort('id', 'asc');  
 bill_store.load( {// 加载数据集  
        params : {  
            start : 0,  
            limit : 30  
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

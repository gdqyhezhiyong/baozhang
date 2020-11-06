<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
   
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
			return;
			}	
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>查询</title>

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
    var startdate=new Ext.form.DateField({
                   
                    xtype: "datefield",
                    name:"startdate",
                    emptyText: "开始时间", 
                    id:"startdate",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
    
    var finishdate=new Ext.form.DateField({
                    emptyText: "截止时间",
                    xtype: "datefield",
                    name:"finishdate",
                    id:"finishdate",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
    
     
    
     
     
     
     var toolbar = new Ext.Toolbar( [
     
       startdate,
       '&nbsp;&nbsp;',
       finishdate,
       '-', '&nbsp;&nbsp;',
          {   text: ' 查询',  
         cls:"x-btn-text-icon",  
         handler: function () { 
       
		var start_time = startdate.getRawValue();
		var end_time = finishdate.getRawValue();
		
		
		 bill_store.load({                                      
                  url: 'servlet/MyBillSelectServlet?weixiu_id=<%=username%>',                              
                  params: {                             
                  status:status,
                  start_time:start_time,
                  end_time:end_time,
                   start : 0,  
                   limit : 20                             
                  }  
                  });     
		
         }
         }, '&nbsp;&nbsp;',
          {   text: ' 清空',  
         cls:"x-btn-text-icon",  
         handler: function () {
		startdate.setValue('');
		finishdate.setValue('');
         
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
    new Ext.grid.RowNumberer({ align : "left", header : "序号",  width : 32}),
     {  
        align : "left",
        header : "单号",  
        width : 50,  
        dataIndex : 'id',  
        sortable : true 
        
    }, 
     {  
        align : "left",
        header : "区域",  
        width : 100,  
        dataIndex : 'area2',  
        sortable : true 
        
    }, 
     {  
        align : "left",
        header : "楼栋",  
        width : 80,  
        dataIndex : 'building'
    },  
     {  
        align : "left",
        header : "楼层",  
        width : 50,  
        dataIndex : 'floor'
        
    },  
     {  
        align : "left",
        header : "房间",  
        width : 50,  
        dataIndex : 'room'
        
    }, 
    
    { 
        align : "left",
        header : "类型",  
        width : 120,  
        dataIndex : 'project',  
      
         renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    }, 
     { 
        align : "left",
        header : "描述",  
        width : 100,  
        dataIndex : 'descriptions',  
       
        renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    },    
    
    { 
        align : "left",
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
        align : "left",
        header : "报修人姓名",  
        width : 80,  
        dataIndex : 'bz_name'
        
    }, 
    {  
        align : "left",
        header : "报修人电话",  
        width : 80,  
        dataIndex : 'phnone_number'
    },{ 
        align : "left",
        header : "报修时间",  
        width : 80,  
        dataIndex : 'order_date', 
        renderer:function(value){ 
        var a=value.substring(0,10);
        return a;  
},
  sortable : true 
    }, {  
         css:'height:27px; vertical-align:middle; font-size:12;',
        header : "状态",  
        width : 80,  
        align : "left",
         sortable : true ,
        dataIndex : 'status',
        renderer: function status(value){
        if(value=='0')return '<span style="color:red;">未处理</span>';
        else if(value=='1')return '已受理';
        else if(value=='2')return '已完成';
        else if(value=='3')return '已撤单';
        else if(value=='4')return '已评价';
        else return ''; 
        }
    },{  
        align : "left",
        header : "满意度",  
        width : 80,  
        dataIndex : 'satisfy',
        sortable : true, 
        renderer: function status(value){
        if(value=='0')return '<span style="color:#009FFF;">未评价</span>';
        else if(value=='1')return '很满意';
        else if(value=='2')return '一般满意';
        else if(value=='3')return '不满意';
        else if(value=='4')return '很不满意';
        else return ''; 
        }
    },
    { 
        align : "left",
        header : "评价",  
        width : 100,  
        dataIndex : 'suggestion',  
        sortable : true,
        renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    }
     ]
     }
     );  
     
      cm.defaultSortable = true;
     
     var bill_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/MyBillSelectServlet?weixiu_id=<%=username%>',// 设置代理请求的url  
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
             {name:'jinji',type:"string"}
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
        height:585,//表格高
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
            pageSize : 20,  
            store : bill_store,  
            displayInfo : true,  
            displayMsg : '显示{0}条到{1}条记录,一共{2}条记录',  
            emptyMsg : '没有记录'  
        //  ,items:['-',new Ext.app.SearchField({store:userStore})]  
        }) 
    });  
    
    
 bill_store.setDefaultSort('id', 'desc');  
 bill_store.load( {// 加载数据集  
        params : {  
            start : 0,  
            limit : 20
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

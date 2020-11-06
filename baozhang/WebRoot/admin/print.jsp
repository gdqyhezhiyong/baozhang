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
		<title>派单</title>

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
          url : 'servlet/GetWeiXiuServlet?area='+encodeURI('<%=area%>'),// 设置代理请求的url  
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
     
     
     //区域数据数据     
 var areaStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetAreaServlet?area='+encodeURI('<%=area%>'),// 设置代理请求的url  
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
              
             areaStore.load({                                      
                  url: "servlet/GetAreaServlet",                              
                  params: {                                  
                  p_id: <%if("广州".equals(area)){%>'1'<%}else{%>'2'<%}%>                        
                  }  
                  });  
       
         //楼栋数据
       var buildingStore =  new Ext.data.Store({  
          proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetBuildingServlet',// 设置代理请求的url  
          method:'GET' 
        }),  
        // autoLoad : true,
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
                  
                   //工具栏维修人员下拉框                   
         var weixiubar = new Ext.form.ComboBox({   
                    width : 100,  
                     emptyText: "选择维修工",   
                     name : "weixiubar",     
                     id: "weixiubar",                     
                     mode: 'local',              
                     autoLoad: true,              
                     editable: true,              
                     allowBlank: true,                        
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: weixiuStore/*,
                     listeners: {// select监听函数                             
                      select : function(combo, record, index){   
                       var area2 = areaCombo.getRawValue();                         
                 bill_store.load({                                      
                  url: "servlet/BillCheckSelectServlet",                              
                  params: {  
                  area2:area2, 
                  print:printCombo.getValue(),                                     
                  weixiu_id: combo.value,
                   project1_name:projectbarcom.getRawValue(),
                   start : 0,  
                   limit : 20                             
                  }  
                  });                 
                  }            
                  }  */
                  });  
                  
                  
     
     
             // 区域下拉框  
                  var areaCombo = new Ext.form.ComboBox({              
                  width : 100,            
                  fieldLabel : "区域",              
                  name : "area2",              
                  id: "area2",     
                  emptyText: "请选择区域",              
                  mode: 'local',              
                  autoLoad: true,              
                   editable: true,              
                  allowBlank: true,                
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: areaStore,
                   listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  buildingCombo.reset();                                  
                  buildingStore.load({                                      
                  url: "servlet/GetBuildingServlet",                              
                  params: {                                  
                  area_id: combo.value                              
                  }  
                  });                 
                  }            
                  }  
                   });    
                   
                     //楼栋下拉框              
         var buildingCombo = new Ext.form.ComboBox({   
                    width : 100,  
                     fieldLabel : "楼栋", 
                     name : "building",     
                     id: "building",              
                     emptyText: "请选择楼栋",              
                     mode: 'local',              
                     autoLoad: true,    
                     editable: true,              
                  allowBlank: true,                 
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: buildingStore// 数据源              
                    
                  });  
     
      //重复打印            
                var printCombo = new Ext.form.ComboBox({              
                  width : 140,              
                  fieldLabel : "楼层",                   
                  name : "print",              
                  id: "print",              
                  emptyText: "打印标记",              
                  mode: 'local',        
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值   
                  /*listeners: {// select监听函数                             
                      select : function(combo, record, index){   
                       var area2 = areaCombo.getRawValue();                         
                 bill_store.load({                                      
                  url: "servlet/BillCheckSelectServlet",                              
                  params: {  
                  area2:areaCombo.getRawValue(), 
                  print:combo.value,                                     
                  weixiu_id: weixiubar.getValue(),
                  project1_name:projectbarcom.getRawValue(),
                   start : 0,  
                   limit : 20                             
                  }  
                  });                 
                  }            
                  } ,  */          
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['0','没打印过的单'],['1','已打印过的单']
                    
                    ]
   })
                   }); 
                   
                   
                   
                     //一级工具栏类型数据     
 var projectbar = new Ext.data.Store({  
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
              projectbar.load({ params: {                                  
                  p_id:'0'                            
                  } }); 
                  
        //一级工具栏类型下拉框                    
         var projectbarcom = new Ext.form.ComboBox({   
                    width : 100,    
                     fieldLabel : "一级类别", 
                     name : "project1",     
                     id: "project1",             
                     emptyText: "请选择类别",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,                         
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: projectbar/*,// 数据源              
                   listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                      var weixiu_id = weixiubar.getValue();
                      var area2 = areaCombo.getRawValue();
                bill_store.load({                                      
                  url: "servlet/BillCheckSelectServlet",                              
                  params: {                                  
                   weixiu_id:weixiu_id,
                   area2 : area2,
                   print:printCombo.getValue(),
                   project1_name:projectbarcom.getRawValue(),
                   start : 0,  
                   limit : 20                             
                  }  
                  });       
                  }            
                  } */ 
                  });             
                  
     
     var toolbar = new Ext.Toolbar( [
         weixiubar
            ,'-',
          areaCombo
          ,'-',
          buildingCombo
           ,'-',
           printCombo
            ,'-',
            projectbarcom
            ,'-',
            {   text: ' 查询',  
         cls:"x-btn-text-icon",  
         icon: 'js/resources/icons/fam/search.gif',
         handler: function () { 
		var area2 = areaCombo.getRawValue();
		var building =buildingCombo.getRawValue();
		var weixiu_id = weixiubar.getValue();
		var print = printCombo.getValue();
		var project1_name = projectbarcom.getRawValue();
		Ext.apply(   
                      bill_store.baseParams,   
                      {   
                  area1:'<%=area%>',
                  area2:area2,  
                  building:building,                            
                  weixiu_id: weixiu_id,
                  project1_name:project1_name,
                  print:print
                      }); 
		
		 bill_store.reload({params:{start:0, limit:20}});     
		
         }
         },'-',
          {   text: '全部',  
         cls:"x-btn-text-icon", 
        icon: 'js/resources/icons/fam/table_refresh.png', 
         handler: function () { 
         window.location.reload();
         }
         }
          ,'-','&nbsp;',
          {  text : '维修单批量打印',  
        cls:"x-btn-text-icon",  
        icon: 'js/resources/icons/fam/print.gif',
        iconCls:'addIcon'  ,  
        handler : function paidan(){
        var row=bill_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","请选择要打印的报修单！");
        return;
        }else{
           var jsonData="";    
               for(var i=0,len=row.length;i<len;i++){
                var ss = row[i].get("id"); //这里为Grid数据源的Id列    
                
                if(i==0) {
                jsonData = jsonData + ss;   
                }
                     
                else    {
                jsonData = jsonData + ","+ ss;   
                }
                
                     
                      }    
                window.open("<%=basePath%>"+"admin/bill_print.jsp?ids="+jsonData);
        
        }
      } 
                
    },'-','&nbsp;',
          {  text : '报修单总表打印',  
        cls:"x-btn-text-icon",  
        icon: 'js/resources/icons/fam/print.gif',
        iconCls:'addIcon'  ,  
        handler : function paidan(){
        var row=bill_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","请选择要打印的报修单！");
        return;
        }else{
           var jsonData="";    
               for(var i=0,len=row.length;i<len;i++){
                var ss = row[i].get("id"); //这里为Grid数据源的Id列    
                
                if(i==0) {
                jsonData = jsonData + ss;   
                }
                     
                else    {
                jsonData = jsonData + ","+ ss;   
                }
                
                     
                      }    
                window.open("<%=basePath%>"+"admin/print1.jsp?ids="+jsonData);
        
        }
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
   sm,
    new Ext.grid.RowNumberer({ align : "center", header : "序号",  width : 30}),
     
     {  
        align : "center",
        header : "单号",  
        width : 70,  
        dataIndex : 'id',  
        sortable : true 
        
    }, 
     {  
        align : "center",
        header : "校区",  
        width : 50,  
        dataIndex : 'area1'
         //sortable : true 
        
    },  
     {  
        align : "center",
        header : "区域",  
        width : 50,  
        dataIndex : 'area2'  
        //sortable : true 
        
    }, 
     {  
        align : "center",
        header : "楼栋",  
        width : 50,  
        dataIndex : 'building',
        sortable : true 
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
        header : "类型",  
        width : 150,  
        dataIndex : 'project',
         renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    }, 
     { 
        align : "center",
        header : "描述",  
        width : 150,  
        dataIndex : 'descriptions',
        renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
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
        header : "报修人姓名",  
        width : 80,  
        dataIndex : 'bz_name'
        
    }, 
    {  
        align : "left",
        header : "报修人电话",  
        width : 100,  
        dataIndex : 'phnone_number'
    }
    ,
     { 
        align : "center",
        header : "报修时间",  
        width : 120,  
        dataIndex : 'order_date',
        sortable : true,
        renderer : function(value){
			return value.substring(0,16);
} 
    }
    
    ,{ 
        align : "center",
        header : "预约日期",  
        width : 80,  
         sortable : true ,
        dataIndex : 'weixiu_date'
    } ,
     { 
        align : "center",
        header : "预约时间",  
        width : 100,  
        dataIndex : 'order_time',  
        sortable : true 
    },{  
     
        header : "维修人姓名",  
        width : 80,  
        align : "center",
        dataIndex : 'weixiu_name' ,
         sortable : true  
    },{  
     
        header : "维修人电话",  
        width : 150,  
        align : "center",
        dataIndex : 'weixiu_phone'  
    }
     ]
     }
     );  
     
      cm.defaultSortable = true;
     
     var bill_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/BillCheckSelectServlet?area1='+encodeURI('<%=area%>'),// 设置代理请求的url  
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
             {name:'weixiu_date',type:"string"},
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
        height:580,//表格高
        columnLines:true,
        autoScroll : true,// 当数据查过表格宽度时，显示滚动条  
       // selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),//设置单行选中模式, 否则将无法删除数据 
        store : bill_store,// 设置表格对应的数据集  
       // viewConfig : {// 自动充满表格  
        //    forceFit:true,
        //    scrollOffset: 0
      //  },  
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

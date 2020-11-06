<%@ page language="java" import="java.util.*,gdqy.edu.cn.util.*" pageEncoding="utf-8"%>
<%@page import="gdqy.edu.cn.serviceImp.AdminService;"%>
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
			parent.window.location.href="../net.jsp";
			</script>
		<%
			return;
			}	
	//记录日志
			String user_name=(String)request.getSession().getAttribute("username");
			String name1=(String)request.getSession().getAttribute("name");
			String role_id=(String)request.getSession().getAttribute("role_id");
			// (new AdminService()).log(user_name,name1,"报修单查询",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));
	
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
                     editable: true,              
                    allowBlank: true,                           
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: weixiuStore/*,
                     listeners: {// select监听函数                             
                      select : function(combo, record, index){                            
                  bill_store.load({                                      
                  url: "servlet/BillCheckSelectServlet",                              
                  params: {                                  
                  weixiu_id: combo.value,
                   start : 0,  
                   limit : 20                             
                  }  
                  });                 
                  }            
                  } */ 
                  });  
     
    
    
    
    
      //校区数据     
 var schoolStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetSchoolServlet',// 设置代理请求的url  
          method:'GET'
            
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'shcool', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )}); 
       schoolStore.load({ params: {                                  
                  p_id: 0                             
                  } });   
     
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
              
               areaStore.load({                                      
                  url: "servlet/GetAreaServlet",                              
                  params: {                                  
                  p_id: '2'                           
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
           
     
     
      // 校区下拉框  
                  var schoolCombo = new Ext.form.ComboBox({              
                  width : 100,            
                  fieldLabel : "校区域",              
                  name : "school",              
                  id: "school",         
                  emptyText: "请选择校区",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: true,              
                  allowBlank: true,                      
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: schoolStore,// 数据源 
                   listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  areaCombo.reset();                                  
                  areaStore.load({                                      
                  url: "servlet/GetAreaServlet",                              
                  params: {                                  
                  p_id: combo.value                              
                  }  
                  });                 
                  }            
                  }  
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
                  store: areaStore,// 数据源 
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
     
      //状态下拉框             
                var statusCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "报修单状态",                   
                  name : "status",              
                  id: "status",              
                  emptyText: "请选择状态",              
                  mode: 'local',        
                  autoLoad: true,              
                  editable: true,              
                  allowBlank: true,                     
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['0','未处理'],['1','已受理'],['2','已完成'],['3','已撤单'],['4','已评价']]
   })
                   });   
                   
     
     
     
     
     
     var toolbar = new Ext.Toolbar( [
     <%if("1".equals(role_id)){%>
     {
     icon: 'js/resources/icons/fam/delete.gif',
      text: '删除',
        handler: function () {
         var row=bill_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","该操作至少要选择一条记录！");
        return;
        }else{
        
        Ext.Msg.show({
　　
　　 title: '警告！',
　　
　　 buttons: Ext.MessageBox.YESNOCANCEL,
　　
　　 msg: '您确定将这  '+row.length+' 条报修单删除吗？',
　　
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
        {
            url: "servlet/DeleteBillServlet", //提交的删除地址     
            params:{
            ids:jsonData
            },       
            method: 'post',  
            scope: this,     
            success:function(response){  
             Ext.MessageBox.alert("提示","您已经将  "+response.responseText+"  条报修单成功删除掉！"); 
            //window.location.reload();
             bill_grid.getStore().reload({weixiu_id:weixiubar.getValue(),params:{start:0, limit:30}}); //重新load数据
             },         
        failure: function() 
         {
         Ext.MessageBox.alert("提示","删除失败！");
         }　
　 });
　　}
   }
　　 });
        
        }
         }
     },
      '&nbsp;&nbsp;','-','&nbsp;&nbsp;',
     <%}%>
      schoolCombo,
      areaCombo,
      buildingCombo,
       '&nbsp;','-',
        weixiubar,
       '&nbsp;','-',
       statusCombo,
      '&nbsp;','-', 
       startdate,
       '&nbsp;',
       finishdate,
       '-',
          {   text: ' 查询',  
         cls:"x-btn-text-icon",  
         icon: 'js/resources/icons/fam/search.gif',
         handler: function () { 
        var area1 = schoolCombo.getRawValue();
		var area2 = areaCombo.getRawValue();
		var building =buildingCombo.getValue();
		var weixiu_id = weixiubar.getValue();
		var status = statusCombo.getValue();
		var start_time = startdate.getRawValue();
		var end_time = finishdate.getRawValue();
		Ext.apply(   
                      bill_store.baseParams,   
                      {   
                  area1:area1,
                  area2:area2, 
                  building:building,                                
                  weixiu_id: weixiu_id,
                  status:status,
                  start_time:start_time,
                  end_time:end_time
                      }); 
		
		 bill_store.reload({params:{start:0, limit:20}});     
		
         }
         },'-',
          {   text: ' 清空',  
         cls:"x-btn-text-icon",  
         handler: function () {
        schoolCombo.setValue('');
		areaCombo.setValue('');
	    buildingCombo.setValue('');
	    weixiubar.setValue('');
		statusCombo.setValue('');
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
             css : 'height:40px; vertical-align:middle; font-size:13;border-width:1px;'
         },
   columns: [
    new Ext.grid.RowNumberer({ align : "center", header : "序号",  width : 32}),
     sm,
     {  
        align : "center",
        header : "单号",  
        width : 50,  
        dataIndex : 'id',  
        sortable : true 
        
    }, 
    {  
        align : "center",
        header : "校区",  
        width : 50,  
        dataIndex : 'area1',  
        sortable : true 
        
    },
     {  
        align : "center",
        header : "区域",  
        width : 100,  
        dataIndex : 'area2',  
        sortable : true 
        
    }, 
     {  
        align : "center",
        header : "楼栋",  
        width : 100,  
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
        header : "类型",  
        width : 100,  
        dataIndex : 'project1',  
         renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    }, 
     { 
        align : "center",
        header : "描述",  
        width : 120,  
        dataIndex : 'descriptions',  
        renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    },    
    
   /* { 
        align : "center",
        header : "紧急程度",  
        width : 80,  
        dataIndex : 'jinji',  
        sortable : true,
        renderer : function(value){
			if(value=='0')return '一般';
			if(value=='1')return '<span style="color:red;">紧急</span>';
} 
    },   */     
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
    },{ 
        align : "center",
        header : "报修时间",  
        width : 100,  
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
        align : "center",
        dataIndex : 'status',
        sortable : true,
        renderer: function status(value){
        if(value=='0')return '<span style="color:red;">未处理</span>';
        else if(value=='1')return '已受理';
        else if(value=='2')return '已完成';
        else if(value=='3')return '已撤单';
        else if(value=='4')return '已评价';
        else return ''; 
        }
    },{  
        align : "center",
        header : "满意度",  
        width : 80, 
        sortable : true, 
        dataIndex : 'satisfy',
        renderer: function status(value){
        if(value=='0')return '未评价';
        else if(value=='1')return '很满意';
        else if(value=='2')return '一般满意';
        else if(value=='3')return '不满意';
        else if(value=='4')return '很不满意';
        else return ''; 
        }
    },
    { 
        align : "center",
        header : "评价",  
        width : 100,  
        dataIndex : 'suggestion',  
        renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    }, 
    { 
        align : "center",
        header : "解决方法",  
        width : 100,  
        dataIndex : 'solution',
         renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    },   
    {  
     
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
          url : 'servlet/SearchSelectServlet',// 设置代理请求的url  
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
             {name:'solution',type:"string"},
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

<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
	String username="";
	String sql="";
	String role_id="";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	username = (String) request.getSession().getAttribute("username");
	role_id = (String) request.getSession().getAttribute("role_id");
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
		<title>日志查询</title>

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
     
             
       //登陆人员数据     
 var peopleStore = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetPeopleServlet',// 设置代理请求的url  
          method:'GET'  
        }),  
          remoteSort: true,
                     reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'people', 
             successProperty:true, 
             id: 'id'  
             },
            [
            {name : "id", mapping : "id"}, 
             {name : "name", mapping : "name"}
             ]
              )}); 
       peopleStore.load();  
     
               
                         
         //登陆人员下拉框                    
         var peapleCombo = new Ext.form.ComboBox({   
                    width : 130,  
                     name : "people",     
                     id: "people",             
                     emptyText: "请选择要查询的人",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                        
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: peopleStore
                  });  
     
     
     
      var startdate=new Ext.form.DateField({
                   
                    xtype: "datefield",
                    name:"start",
                    id:"start",
                    emptyText:'开始时间',
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                }); 
                
   var enddate=new Ext.form.DateField({
                    emptyText:'截止时间',
                    xtype: "datefield",
                    name:"end",
                    id:"end",
                    format: "Y-m-d",
                    invalidText: "日期格式无效",
                     anchor: "90%"
                });              
              
     
     var toolbar = new Ext.Toolbar( [
     
      <%if("1".equals(role_id)||"7".equals(role_id)){%>
        { 
        text : '删除日志', 
        cls:"x-btn-text-icon", 
        icon: 'js/resources/icons/fam/delete.gif', 
        iconCls : 'remove',  
        handler : function(){
         var row=log_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","删除操作至少要选择一条日志！");
        return;
        }else{
        Ext.Msg.show({
　　
　　 title: '警告!',
　　
　　 buttons: Ext.MessageBox.YESNOCANCEL,
　　
　　 msg: '你确定要删除已选中的日志吗？',
　　
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
  {  url: "servlet/DeleteLogsServlet", //提交的删除地址     
                     params:{ids:jsonData},       
                      method: 'post',  
                      scope: this,     
                      success:function(response){  
             Ext.MessageBox.alert("提示","您已经成功删除了"+response.responseText+"条日志!"); 
              log_grid.getStore().reload({params:{start:0, limit:30}}); //重新load数据
             },         
        failure: function()  {Ext.MessageBox.alert("提示","所选记录删除失败！");}　
　 });
　　}
   }
　　 });
        
        }
         }
 },'-',<%}%>
         peapleCombo
          ,'-',
          startdate
          ,'-',
         enddate 
         ,'-',  
          {   text: '查询',  
         cls:"x-btn-text-icon", 
          icon: 'js/resources/icons/fam/search.gif', 
         handler: function () { 
               var start_time = startdate.getRawValue();
                var end_time = enddate.getRawValue();
                var user_name = peapleCombo.getValue();
             
             
             Ext.apply(   
                      log_store.baseParams,   
                      {   
                  start_time:start_time,
                   end_time:end_time,
                   user_name:user_name  
                      }); 
		
		 log_store.reload({params:{start:0, limit:30}});  
             
         }
         }
          ,'-',  
          {   text: '全部',  
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
             css : 'height:20px; vertical-align:middle; font-size:13;border-width:3px;'
         },
   columns: [
   sm,
    new Ext.grid.RowNumberer({ align : "center", header : "序号",  width : 40}),
     
     {  
        align : "left",
        header : "操作人账号",  
        width : 100,  
        dataIndex : 'username',
         sortable : true 
        
    }, 
     {  
        align : "left",
        header : "操作人姓名",  
        width : 100,  
        dataIndex : 'name'
        
    },  
     {  
        align : "left",
        header : "操作时间",  
        width : 100,  
        dataIndex : 'time',  
          renderer:function(value){ 
        var a=value.substring(0,19);
        return a;  
},
        sortable : true 
        
    }, 
    {  
        align : "left",
        header : "ip地址",  
        width : 100,  
        dataIndex : 'ip',  
        sortable : true 
        
    },
     {  
        align : "left",
        header : "操作内容",  
        width : 100,  
        dataIndex : 'operation',  
        sortable : true 
        
    }
     ]
     }
     );  
     
      cm.defaultSortable = true;
     
     var log_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/LogSelectServlet',// 设置代理请求的url  
          method:'GET',
          scripts:true 
        }),  
         remoteSort: true,
         reader: new Ext.data.JsonReader({  
             totalProperty : 'result',  
             root : 'logs', 
             fields:[
             {name:'id',type:"string"},
             {name:'username',type:"string"},
             {name:'name',type:"string"},
             {name:'time',type:"string"},
             {name:'operation',type:"string"},
             {name:'ip',type:"string"},
             {name:'type',type:"string"}             
       ] }
     )  
    });  
 
   
    var log_grid = new Ext.grid.GridPanel( {// 创建Grid表格组件  
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
        store : log_store,// 设置表格对应的数据集  
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
            store : log_store,  
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
      
      log_grid.view=new Ext.grid.GridView(viewConfig);
 // log_grid.addClass("my-x-grid3-row")
 */ 
 log_store.setDefaultSort('id', 'asc');  
 log_store.load( {// 加载数据集  
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

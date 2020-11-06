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
	 username ="2012108038"; //(String) request.getSession().getAttribute("client_id");
if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="bz.gdqy.edu.cn";
			</script>
		<%
		return;	
			}	
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>报修记录</title>

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
     pingjia=function(){
     window.location.href="pingjia.jsp";
     }
     
     
     
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
        
                   
                   //一级类型数据     
 var projectStore1 = new Ext.data.Store({  
         proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/CategoryServlet?sys=1',// 设置代理请求的url  
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
     
       
                           
         //一级类型下拉框                    
         var projectCombo1 = new Ext.form.ComboBox({   
                    width : 100,    
                     fieldLabel : "网络故障类别", 
                     name : "project1",     
                     id: "project1",             
                     emptyText: "请选择类别",              
                     mode: 'local',              
                     autoLoad: true,              
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: projectStore1
                  });  
                  
                 
                   
                   projectCombo1.on('expand', function(comboBox) {
        comboBox.list.setWidth('180px'); //auto
        comboBox.innerList.setWidth('auto');
    }, this, { single: true }); 
    
    
     var toolbar = new Ext.Toolbar( [
      {  text : '撤单',  
        cls:"x-btn-text-icon",  
        icon: 'js/resources/icons/fam/filterArrow.gif',
        iconCls:'addIcon'  ,  
        handler : function paidan(){
        var row=bill_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","请选择要撤的单！");
        return;
        }else{
         for(var i=0,len=row.length;i<len;i++){
         if(row[i].get("status")!='0'){
         Ext.MessageBox.alert("警告","已经处理过的报修单不能撤!");
         return;
         }
         }
         
        
        
         Ext.Msg.show({
　　
　　 title: '撤单',
　　
　　 buttons: Ext.MessageBox.YESNOCANCEL,
　　
　　 msg: '您确定撤掉 选中的 '+row.length+' 条未处理的报修单吗？',
　　
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
            url: "servlet/ChedanServlet", //提交的删除地址     
            params:{ids:jsonData},       
            method: 'post',  
            scope: this,     
            success:function(response){  
             Ext.MessageBox.alert("提示","您已经成功撤掉  "+response.responseText+"  条未处理的报修单！"); 
             bill_store.load({// 加载数据集  
        params : {  
            start:0,
            limit:30   
        }  
    });
             },         
        failure: function() 
         {
         Ext.MessageBox.alert("提示","派单失败！");
         }　
　 });
　　}
   }
　　 });     
        }
      } 
                
    },'-',{
     text:'改单',
     icon: 'js/resources/icons/edit.png',
      handler : function(){
         var row=bill_grid.getSelectionModel().getSelections();
          if(row.length<=0){
        Ext.MessageBox.alert("提示","请选择您要修改的报修单！");
        return;
        }else if(row.length>1){
        Ext.MessageBox.alert("提示","一次只能修改一条报修单！");
        return;
        }else if(row[0].get("status")!='0'){
         Ext.MessageBox.alert("提示","已经处理过的报修单不能再修改！");
        return;
        }
        else{   
        var adminRadio=new Ext.form.Radio({ 
        boxLabel:'广州', 
        inputValue:'1',
        checked:row[0].get("area1")=='广州'?true:false,
        listeners:{ 
            'check':function(){ 
                //alert(adminRadio.getValue()); 
                if(adminRadio.getValue()){ 
                    userRadio.setValue(false); 
                    adminRadio.setValue(true); 
                     areaStore.load({                                                                 
                  params: {                                  
                  p_id: radiogroup.getValue()                             
                  }                  
                  });    
                } 
            } 
        } 
    }); 
    var userRadio=new Ext.form.Radio({ 
        boxLabel:'南海', 
        inputValue:'2',
       checked:row[0].get("area1")=='南海'?true:false,
        listeners:{ 
            'check':function(){ 
                if(userRadio.getValue()){ 
                    adminRadio.setValue(false); 
                    userRadio.setValue(true); 
                    areaStore.load({                                                                   
                  params: {                                  
                  p_id: radiogroup.getValue()                                
                  }                  
                  });    
                } 
            } 
        } 
    }); 

var radiogroup = new Ext.form.RadioGroup({
                fieldLabel: '校区',
                width: 100,
                items: [adminRadio,userRadio]
            }); 
        
  
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
       areaStore.load({ params: {                                  
                  p_id:radiogroup.getValue()                            
                  } });  
     
       //楼栋数据
       var buildingStore =  new Ext.data.Store({  
          proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/GetBuildingServlet?sys=1',// 设置代理请求的url  
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
           
         
           
           
             // 区域下拉框  
                  var areaCombo = new Ext.form.ComboBox({              
                  width : 100,            
                  fieldLabel : "区域",              
                  name : "area2",              
                  id: "area2",       
                  emptyText: "请选择区域",              
                  mode: 'local',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: areaStore,// 数据源 
                   listeners: {// select监听函数                             
                      select : function(combo, record, index){  
                  buildingCombo.reset();                                  
                  buildingStore.load({                                      
                  url: "servlet/GetBuildingServlet?sys=1",                              
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
                     value:'<%=building%>',                
                     emptyText: "请选择楼栋",              
                     mode: 'local',              
                     autoLoad: true,    
                     editable: false,              
                     allowBlank: false,                  
                     blankText:"不能为空",              
                     triggerAction: 'all',              
                     valueField: 'id', // 实际值            
                     displayField: 'name',// 显示值              
                     store: buildingStore// 数据源              
                    
                  });             
         
        /* var mytore = buildingCombo.getStore();
mytore .on('load', function (){
      buildingCombo.setValue('<%=building%>');    
});*/
         
        
         //楼层下拉框             
                var floorCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "楼层",                   
                  name : "floor",              
                  id: "floor",              
                  emptyText: "请选择楼层",              
                  mode: 'local',
                  value:'<%=floor%>',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['1','1'],['2','2'],['3','3'],['4','4'],['5','5'],['6','6'],
                    ['7','7'],['8','8'],['9','9'],['10','10']
                    
                    ]
   })
                   });   
                   
     //室号下拉菜单              
                var roomCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "房号",                   
                  name : "room",              
                  id: "room",              
                  emptyText: "请选择室间",              
                  mode: 'local',
                  value:'<%=room%>',              
                  autoLoad: true,              
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[['50','00'],['1','01'],['2','02'],['3','03'],['4','04'],['5','05'],['6','06'],
                    ['7','07'],['8','08'],['9','09'],['10','10'],['11','11'],['12','12'],
                    ['13','13'],['14','14'],['15','15'],['16','16'],['17','17'],['18','18'],
                    ['19','19'],['20','20'],['21','21'],['22','22'],['23','23'],['24','24'],
                    ['25','25'],['26','26'],['27','27'],['28','28'],['29','29'],['30','30'],
                    ['31','31'],['32','32'],['33','33'],['34','34'],['35','35'],['36','36'],
                    ['37','37'],['38','38'],['39','39'],['40','40'],['41','41'],['42','42'],
                    ['43','43'],['44','44'],['45','45'],['46','47'],['48','48'],['49','49']
                    ]
   })
                   });   
     
        
        
     var Edit_Panel=new Ext.form.FormPanel({
     buttonAlign: 'center',       
     height: '100%',     
     width: 515, 
     labelWidth: 120,  
     labelAlign: 'left',   
     frame: true, 
     defaults:{ xtype:"textfield",width:100},        
     items: [
     
     {xtype: 'fieldset',
      id:'phone_name',
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: .5,  
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'20', readOnly:'true', name: "name",fieldLabel: "姓名"}
            ]
            },
        {  columnWidth: .5, 
            layout: 'form',  
            labelWidth:80,  
            defaults: {width: 120,anchor: '90%' },
            items:[
             {xtype: 'textfield',height:'20', name: "phone", fieldLabel: "电话号码"}
            ]
            }
        ]
     },
     
     {xtype: 'fieldset',
      id:"quyu",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        
        {  columnWidth: .5, 
            layout: 'form',  
               labelWidth:80,   
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
            radiogroup
            
            ]
            }
        ,{  columnWidth: .5,  
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
             areaCombo
            ]
            }    
       
           
        ]
     },
     
      {xtype: 'fieldset',
       id:"dizhi",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        
        {  columnWidth: .35, 
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
            buildingCombo
            ]
            },
            {  columnWidth: .35, 
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
            floorCombo
            ]
            },
             {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:50,  
            defaults: {xtype:"combo",width: 80,anchor: '90%' },
            items:[
             roomCombo
            ]
            } 
        ]
     },
     
    {xtype: 'fieldset',
     id:"leixing",
        height: 40,  
        width: 500,  
        layout: 'column',
        items:[
        {  columnWidth: 2/3,  
            layout: 'form',  
            labelWidth:120,  
            defaults: {xtype:"combo",width: 100,anchor: '99%' },
            items:[
             projectCombo1
            ]
            }
           
        ]
     }, 
     
     {xtype: 'fieldset',
      id:"miaoshu",
        height: 100,  
        width: 500,  
        layout: 'column',
        items:[
        {  
            layout: 'form',  
            labelWidth:100,  
            defaults: {xtype:"textfield",width: 370,anchor: '80%' },
            items:[
              {xtype: "textarea",height: 100, width : 370,emptyText:"输入限100字以内！", name: "descriptions", fieldLabel: "网络故障目描述"}
            ]
            }
               
        ]
     }
  
  ]     
        });
        
        var area2=row[0].get("area2");
            areaCombo.setValue(area2);
            
            var building=row[0].get("building");
            var building_id=row[0].get("building_id");
            
            buildingCombo.setValue(building);
            
            var floor=row[0].get("floor");
            floorCombo.setValue(floor);
            
            var room=row[0].get("floor");
             roomCombo.setValue(room);
            
             var room=row[0].get("floor");
             roomCombo.setValue(room);
            
            var project1=row[0].get("project1");
            projectCombo1.setValue(project1);
            
            var descriptions=row[0].get("descriptions");
            var bz_id=row[0].get("bz_id");
             var id=row[0].get("id");
            var bz_name=row[0].get("bz_name");
            var phone_number=row[0].get("phnone_number");
         
            Edit_Panel.getForm().findField("name").setValue(bz_name);
            Edit_Panel.getForm().findField("phone").setValue(phone_number);
            Edit_Panel.getForm().findField("descriptions").setValue(descriptions);

   
    var Edit_Window =  new Ext.Window({
        collapsible: true,
        maximizable: true,
        minWidth: 520,
        height :400 ,
        minHeight: 400,
        width:520,
        modal:true,
        closeAction:"hide",
        //所谓布局就是指容器组件中子元素的分布，排列组合方式
        layout: 'form',//layout布局方式为form
        plain: true,
        title:'报修单修改',
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: Edit_Panel,
        buttons: [{
            id:'tijiao',
            text: '更新',
             cls:"x-btn-text-icon", 
            //保障数据提交后台
            handler:function(){
            var name= Edit_Panel.getForm().findField("name").getValue();
            var phone=Edit_Panel.getForm().findField("phone").getValue();
             
             var area1 = radiogroup.getValue();
             area2_id= Ext.getCmp('area2').getValue();
             var area2= Ext.getCmp('area2').getRawValue();
             building=Ext.getCmp('building').getRawValue();


               if(buildingCombo.getValue()!=buildingCombo.getRawValue())
             building_id= Ext.getCmp('building').getValue();

             floor=Ext.getCmp('floor').getRawValue();
             room=Ext.getCmp('room').getRawValue();
             project1=Ext.getCmp('project1').getRawValue();
             descriptions = Edit_Panel.getForm().findField("descriptions").getValue();
             project1_id=Ext.getCmp('project1').getValue();
            
              if(area1==''||area1==null){
             Ext.MessageBox.alert("温馨提示！","校区必须选择！");
             return;
            }
        
            if(name==''||name==null){
             Ext.MessageBox.alert("温馨提示！","姓名不能为空");
             return;
            }
             if(phone==''||phone==null){
             Ext.MessageBox.alert("温馨提示！","电话号码不能为空");
             return;
            }
            
            if(area2==''||area2==null){
             Ext.MessageBox.alert("温馨提示！","区域必须选择！");
             return;
            }
            if(building==''||building==null){
             Ext.MessageBox.alert("温馨提示！","楼栋必须选择！");
             return;
            }
            
             if(floor==''||floor==null){
             Ext.MessageBox.alert("温馨提示！","楼层必须选择！");
             return;
            }
             if(room==''||room==null){
             Ext.MessageBox.alert("温馨提示！","室间必须选择！");
             return;
            }
            
            if(project1==''||project1==null){
             Ext.MessageBox.alert("温馨提示！","项目类别不能为空！");
             return;
            }
            if(descriptions==''||descriptions==null){
             Ext.MessageBox.alert("温馨提示！","故障描述不能为空！");
             return;
            }
             if(descriptions.length>100){
             Ext.MessageBox.alert("温馨提示！","您输入内容长度超过了100！");
             return;
            }
                   
           var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/UpdateRegServlet?sys=1", //提交的后台地址     
                     params:{
                    name:name,
                    phone:phone,
                    id:id,
                    bz_id:bz_id,
                    project1:project1,
                    descriptions:descriptions,
                    area1:area1,
                    area2:area2,
                    building:building,
                    building_id:building_id,
                    floor:floor,
                    room:room
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="succ"){
                       Ext.MessageBox.alert("提示", "修改成功！", 
                       function (id) {
             
                       if(id=='ok') 
                      Edit_Window.close();
                    window.location.reload();
                       });
                       
                      }
                      
                      else{
                     Ext.MessageBox.alert("提示","修改失败，报修未能成功！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","修改失败，报修未能成功！"); }　
　 }
);
           
          }
        },{
            text: '重置', id:"reset1", cls:"x-btn-text-icon",  handler:function(){f.getForm().reset();}
        }]     
    });
    
  Edit_Window.show();
        }
         }
     
     },'-',{   text: '刷新',  
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
      
     var cm = new Ext.grid.ColumnModel( 
     [
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
        header : "区域",  
        width : 50,  
        dataIndex : 'area2',  
        sortable : true 
        
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
        header : "楼层区",  
        width : 50,  
        dataIndex : 'floor',  
        sortable : true 
        
    },  
     {  
        align : "center",
        header : "房间",  
        width : 50,  
        dataIndex : 'room',  
        sortable : true 
        
    }, 
    
    { 
        align : "center",
        header : "故障类别",  
        width : 100,  
        dataIndex : 'project1',  
        sortable : true ,
         renderer : function(v, metadata, record, rowIndex, columnIndex, store){
			metadata.attr = ' ext:qtip="' + v + '"';    
			return v;
} 
    }, 
             
      {  
        align : "center",
        header : "报修人姓名",  
        width : 80,  
        dataIndex : 'bz_name',  
        sortable : true 
        
    }, 
    {  
        align : "center",
        header : "报修人电话",  
        width : 80,  
        dataIndex : 'phnone_number'
    },{ 
        align : "center",
        header : "报修时间",  
        width : 80,  
        dataIndex : 'order_date', 
        renderer:function(value){ 
        var a=value.substring(0,16);
        return a;  
},
  sortable : true 
    } ,
/*
{  
        align : "center",
        header : "网管姓名",  
        width : 80,  
        dataIndex : 'weixiu_name'
    },
{  
        align : "center",
        header : "网管电话",  
        width : 80,  
        dataIndex : 'weixiu_phone'
    },
*/
     { 
        align : "center",
        header : "完成时间",  
        width : 100,  
        dataIndex : 'finish_time',
          renderer:function(value){ 
        var a=value.substring(0,16);
        return a;  
},
          sortable : true  
    }, 

{  
        align : "center",
        header : "解决办法",  
        width : 80,  
        dataIndex : 'solution'
    },

{  
         css:'height:27px; vertical-align:middle; font-size:12;',
        header : "状态",  
        width : 80,  
        align : "center",
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
        align : "center",
        header : "满意度",  
        width : 80,  
        dataIndex : 'satisfy',
        renderer: function status(value){
        if(value=='0')return '未评价';
        else if(value=='1')return '很满意';
        else if(value=='2')return '一般满意';
        else if(value=='3')return '不满意';
        else if(value=='4')return '很不满意';
        else return ''; 
        }
    }
     ]);  
     
      cm.defaultSortable = true;
     
     var bill_store = new Ext.data.Store( {// 定义数据集对象  
        proxy : new Ext.data.HttpProxy( {  
          url : 'servlet/BillSelectServlet?user_name=<%=username%>&&sys=1',// 设置代理请求的url  
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
             {name:'solution',type:"string"},
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
             {name:'building_id',type:"string"},
             {name:'floor',type:"string"},
             {name:'room',type:"string"}
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
        },
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
 // bill_grid.addClass("my-x-grid3-row") 
 bill_store.setDefaultSort('id', 'desc');  
 bill_store.load({// 加载数据集  
        params : {  
            start:0,
            limit:30  
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

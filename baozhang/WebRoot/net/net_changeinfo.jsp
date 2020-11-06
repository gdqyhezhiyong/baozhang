<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
    String phone = "";
	String name = "";
	String area = "广州";
	String building = "";
	String building_id = "";
	String floor = "";
	String room = "";
	String username="";
	String sql="";
	
	String sex="";
	String grade="";
	String departments="";
	String classes="";
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
	 sql = "select * from t_user where user_name='" + username+ "'";
	//System.out.println("t_user:"+sql);
	 ResultSet rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
	if (rs.next()) {
		
		if(rs.getString("phon_number")!=null)
		phone = rs.getString("phon_number");
		
		if(rs.getString("name")!=null)
		name = rs.getString("name");
		
		
		
		if(rs.getString("sex")!=null)
		sex = rs.getString("sex");
		
		if(rs.getString("grade")!=null)
		grade = rs.getString("grade");
		
		if(rs.getString("departments")!=null)
		departments = rs.getString("departments");
		
		if(rs.getString("classes")!=null)
		classes = rs.getString("classes");
	}
	
	sql="select a1.name+'校区->'+a.name+'->'+b.name as building from t_user u inner join t_building b on u.user_name=b.net_weixiu "+
 "inner join t_area  a1 on a1.id=b.area1_id inner join t_area a on b.area2_id=a.id where sys=1 and u.user_name='"+username+"'";
 //System.out.println(sql);
	 rs = DBHelper.getConnection().createStatement().executeQuery(sql);
	 String address="<table>";
     int i=0;
     
	 while(rs.next()){
	 i++;
	 if(i%3==0){
	  address=address+"<td>"+rs.getString("building")+"<td/></tr>";
	 }else  if(i%3==1){
	  address=address+"<tr><td>"+rs.getString("building")+"<td/>";
	 }
	 else {
	  address=address+"<td>"+rs.getString("building")+"<td/>";
	 }
	 }
	if(i%3==0)
	address=address+"</table>";
	else if(i%3==1)
	address=address+"<td>&nbsp;</td><td>nbsp;</td></tr></table>";
	else if(i%3==2)
	address=address+"<td>&nbsp;</td></tr></table>";
	 System.out.println(address);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>个人信息修改</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="js/resources/css/ext-all.css" />
		<style type="text/css">


	 body, div, address, blockquote, iframe, ul, ol, dl, dt, dd, li, dl, h1, h2, h3, h4, pre, table, caption, th, td, form, legend, fieldset, input, button, select, textarea {margin:0; padding:0;font-style: normal;font:12px/22px Arial, Helvetica, sans-serif;} 
	 ol, ul ,li{list-style: none;} img {border: 0; vertical-align:middle;} body{color:#000000;background:#FFF; text-align:center;}
	 .clear{clear:both;height:1px;width:100%; overflow:hidden; margin-top:-1px;} a{color:#000000;text-decoration:none; } 
	 a:hover{color:#BA2636;text-decoration:underline;}
	 .red ,.red a{ color:#F00;} 
	 .lan ,.lan a{ color:#1E51A2;} 	
#div2 {
	
			margin: 30px auto;
			width:800px;
			height:300px;
}
span{
font-size:14px;
font-color:red;
}

 td{
text-align:center;border-color:#000033;font-size:12px;border:5px;heigth:20px;border-color:#B0D1DB;font-weight:bold;background-color:#D4DFFF;
}

tr{
line-height:20px;border-color:#808080;
}
</style>
		<!-- GC -->
		<!-- LIBS -->
		<script type="text/javascript" src="js/adapter/ext/ext-base.js"></script>
		<!-- ENDLIBS -->

		<script type="text/javascript" src="js/ext-all.js"></script>
		<script type="text/javascript" src="js/src/locale/ext-lang-zh_CN.js"></script>

		<script language="javascript">
    
     Ext.onReady(function () {
     Ext.QuickTips.init();
    // Ext.BLANK_IMAGE_URL="js/resources/images/default/s.gif";  
     getdata();
     });
       
function getdata(){
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
                   
                   //性别
                  var sex = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "性别",                   
                  name : "sex",              
                  id: "sex",              
                  emptyText: "请选择",              
                  mode: 'local',            
                  autoLoad: true, 
                  value:'<%=sex%>',                         
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[
              ['男','男'],['女','女']
                    
                    ]
   })
                   });   
                   
           //年级
                var d = new Date();    
                var  nowYear = parseInt(d.getFullYear());
                  var yearCombo = new Ext.form.ComboBox({              
                  width : 100,              
                  fieldLabel : "年级",                   
                  name : "grade",              
                  id: "grade",              
                  emptyText: "请选择",              
                  mode: 'local',            
                  autoLoad: true, 
                  value:'<%=grade%>',                         
                  editable: false,              
                  allowBlank: false,              
                  blankText:"不能为空",              
                  triggerAction: 'all',              
                  valueField: 'id',// 实际值              
                  displayField: 'name',// 显示值              
                  store: new Ext.data.SimpleStore({
                fields : ['id', 'name'],
              data:[
              [nowYear-2,nowYear-2],[nowYear-1,nowYear-1],[nowYear,nowYear]
                    
                    ]
   })
                   });             
                   
                   
       
    var f= new Ext.form.FormPanel({ 
     title:"个人信息修改", 
      buttonAlign: 'center',       
     height: '100%',     
     width: 800, 
     labelWidth: 120,  
     labelAlign: 'right',   
     frame: true,  
 listeners : {
    'render' : function() {
        this.findByType('textfield')[0].focus(true, true); 
     }
},
     defaults:{ xtype:"textfield",width:100},        
     items: [
     {xtype: 'fieldset',
      id:'phone_name',
        height: 40,  
        width: 800,  
        layout: 'column',
        items:[
        {  columnWidth: .35,  
            layout: 'form',  
            labelWidth:50,  
            defaults: {width: 200,anchor: '90%' },
            items:[
            {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空", value:'<%=name%>', name: "username", id: "username",fieldLabel: "姓名"}
            ]
            },
        {  columnWidth: .35, 
            layout: 'form',  
            labelWidth:70,  
            defaults: {width: 200,anchor: '90%' },
            items:[
             {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空", value:'<%=phone%>',name: "phone", id: "phone", fieldLabel: "电话号码"}
            ]
            },
        {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:40,  
            defaults: {width: 100,anchor: '100%' },
            items:[
             sex
            ]
            }
        ]
     },
     
     {xtype: 'fieldset',
      id:"banji",
        height: 40,  
        width: 800,  
        layout: 'column',
        items:[
        {  columnWidth: .35,  
            layout: 'form',  
            labelWidth:50,  
            defaults: {width: 100,anchor: '90%' },
            items:[
          yearCombo
            ]
            },
        {  columnWidth: .35, 
            layout: 'form',  
               labelWidth:70,   
            defaults: {width: 150,anchor: '90%' },
            items:[
           {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空", value:'<%=departments%>',name: "departments", id: "departments", fieldLabel: "院系"}
            ]
            },
             {  columnWidth: .3, 
            layout: 'form',  
            labelWidth:80,   
            defaults: {width: 150,anchor: '100%' },
            items:[
             {xtype: 'textfield',height:'25', allowBlank: false, blankText:"不能为空", value:'<%=classes%>',name: "classes", id: "classes", fieldLabel: "班级"}
            ]
            }
              
        ]
     },
      {xtype: 'fieldset',
        id:"adss",
        title : '负责的楼栋',
        height: '40',  
        width: 800,  
        layout: 'form',
        items:[
        new Ext.BoxComponent({ // raw
        //region:'center',
        autoHeight:true,
        autoEl: {
            tag:'blockquote',
            html:'<div style="font-size:12px;algin:center"><%=address%> </div>'
        }
    })
              
        ]
     }
      
        
          ],      
       buttons: [{
            id:'tijiao',
            text: '提交',
             cls:"x-btn-text-icon", 
            //保障数据提交后台
            handler:function(){
            var name= Ext.getCmp("username").getValue();
            var phone=Ext.getCmp('phone').getValue();
            
             var grade=Ext.getCmp('grade').getValue();
             var departments=Ext.getCmp('departments').getRawValue();
             var classes=Ext.getCmp('classes').getValue();
           
            var sex =Ext.getCmp('sex').getRawValue();
            var user_name="<%=username%>";
           
            if(name==''||name==null){
             Ext.MessageBox.alert("温馨提示！","姓名不能为空");
             return;
            }
            
              if(phone==''||phone==null){
             Ext.MessageBox.alert("温馨提示！","性别不能为空");
             return;
            }
             if(grade==''||grade==null){
             Ext.MessageBox.alert("温馨提示！","年级不能为空");
             return;
            }
           if(departments==''||departments==null){
             Ext.MessageBox.alert("温馨提示！","院系不能为空");
             return;
            }
           
           if(phone==''||phone==null){
             Ext.MessageBox.alert("温馨提示！","电话号码不能为空");
             return;
            }
           
           if(classes==''||classes==null){
             Ext.MessageBox.alert("温馨提示！","班级不能为空");
             return;
            }
           
            
          
           
           var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/NetInfoChangeServlet", //提交的后台地址     
                     params:{
                    name:name,
                    phone:phone,
                    user_name:user_name,
                    grade:grade,
                    departments:departments,
                    classes:classes,
                    sex:sex
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="succ"){
                      Ext.MessageBox.alert("提示","修改成功！");
                      }else{
                     Ext.MessageBox.alert("提示","修改失败！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","修改失败!"); }　
　 }
);
           
          }
        },{
            text: '重置', id:"reset1", cls:"x-btn-text-icon",  handler:function(){f.getForm().reset();}
        }]    
                       });
                       f.render("div2");
}
</script>
	</head>

	<body>

		<div id="div2">
		</div>
	</body>
</html>

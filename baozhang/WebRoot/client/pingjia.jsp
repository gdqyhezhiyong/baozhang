<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
  String username="";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 username = (String) request.getSession().getAttribute("client_id");
	 
if(username==null){
		%>
		<script language="javascript">
			parent.window.location.href="../login.jsp";
			</script>
		<%
		return;	
			}	
			
   String phone = "";
	String name = "";
	String area = "";
	String building = "";
	String floor = "";
	String room = "";
	String id="";
	String order_date="";
	String project1="";
	String project2="";
	String project3="";
	
	String sql="";
	  sql="select top 1 * from t_bill where sys=0 and status=2 and bz_id= '"+username+"'";
	  //System.out.println(sql);
		
	ResultSet rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
			if(rs.next()){
			 id=rs.getString("id");
	         order_date=rs.getString("order_date").substring(0,10);
	         project1=rs.getString("project1_name");
	         project2=rs.getString("project2_name");
	         project3=rs.getString("project3_name");
	         System.err.println("id:"+id);
	         System.err.println("order_date:"+order_date);
	         System.err.println("project1_name:"+project1);
	         System.err.println("project2_name:"+project2);
	         System.err.println("project3_name:"+project3);
			}else{
			response.sendRedirect("nopingjia.html");
			return;
			}
			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户评价</title>

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
#div1 {
	text-align: center;
	vertical-align: center;
	margin: 30px auto;
}
	
      #div2 {
			margin: 10px auto;
			width:450px;
			height:380px;
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
     Ext.BLANK_IMAGE_URL="js/resources/images/default/s.gif";  
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

 var radio1=new Ext.form.Radio({ 
        boxLabel:'很满意', 
        inputValue:'1',
        checked:true,
        listeners:{ 
            'check':function(){ 
                if(radio1.getValue()){ 
                    radio3.setValue(false); 
                    radio2.setValue(false);
                    radio4.setValue(false);
                    radio1.setValue(true); 
                } 
            } 
        } 
        
       
    }); 
var radio2=new Ext.form.Radio({ 
        boxLabel:'基本满意', 
        inputValue:'2',
       
        listeners:{ 
            'check':function(){ 
                //alert(adminRadio.getValue()); 
                if(radio2.getValue()){ 
                    radio1.setValue(false); 
                    radio4.setValue(false);
                    radio3.setValue(false);
                    radio2.setValue(true); 
                } 
            } 
        } 
        
        
    }); 
    
    var radio3=new Ext.form.Radio({ 
        boxLabel:'不满意', 
        inputValue:'3',
        listeners:{ 
            'check':function(){ 
                //alert(adminRadio.getValue()); 
                if(radio3.getValue()){ 
                    radio1.setValue(false); 
                    radio2.setValue(false);
                    radio4.setValue(false);
                    radio3.setValue(true); 
                } 
            } 
        } 
    }); 
    
     var radio4=new Ext.form.Radio({ 
        boxLabel:'很不满意', 
        inputValue:'4',
        listeners:{ 
            'check':function(){ 
                //alert(adminRadio.getValue()); 
                if(radio4.getValue()){ 
                    radio1.setValue(false); 
                    radio2.setValue(false);
                    radio3.setValue(false);
                    radio4.setValue(true); 
                } 
            } 
        } 
        
    }); 
   
   
var radiogroup = new Ext.form.RadioGroup({          
                width: 350,
                items: [radio1,radio2,radio3,radio4]
            });



    var f=new  Ext.form.FormPanel({ 
    title:"用户评价", 
    buttonAlign: 'center',       
     height: '100%',     
     width: 420, 
     labelWidth: 10,  
     labelAlign: 'right',   
     frame: true, 
     defaults:{ xtype:"textfield",width:360},        
      items:[
      
          {
            id:"manyidu",
            xtype:'fieldset',
            title: '请选择',
            collapsible: true,
            autoHeight:true,
            width:400,
            defaults: {width: 360},
            defaultType: 'textfield',
            items :[radiogroup]
                },
                 {
            id:"jianyi",
            xtype:'fieldset',
            title: '评价',
            collapsible: true,
            autoHeight:true,
            width:400,
            defaults: {width: 350},
            defaultType: 'textfield',
            items :[ {xtype: "textarea",emptyText:"输入限100字以内！",width : 300,height:100, name: "pingjia", id:"pingjia"}]
                }
       ],      
      buttons: [{
            id:'tijiao',
            text: '提交',
             cls:"x-btn-text-icon", 
            //评价数据提交后台
            handler:function(){
             var satisfy=radiogroup.getValue();
             var suggestion = Ext.getCmp('jianyi').findById("pingjia").getValue();
             if((satisfy=='3'||satisfy=='4')&&suggestion==''){
               Ext.MessageBox.alert("提示","说说您不满意的理由，以便我们改进，谢谢！");
               return;
             }
             if(suggestion.length>100){
             Ext.MessageBox.alert("提示","您输入的内容超过了100，请检查！");
               return;
             }
              var bz_id="<%=username%>";
            var conn = new Ext.data.Connection();    
           conn.request( 
                  {  
                     url: "servlet/PinjiaServlet", //提交的后台地址     
                     params:{
                    satisfy:satisfy,
                    suggestion:suggestion,
                    bz_id:bz_id,
                    bill_id:'<%=id%>'
                     },       
                      method: 'post',  
                      scope: this,     
                      success:function(response){ 
                     
                      if(response.responseText=="1"){
                      this.disable();
                      this.hide(); 
                     // Ext.getCmp('reset1').disable();
                      //Ext.getCmp('reset1').hide();
                      Ext.MessageBox.alert("提示","评价完成，谢谢您的合作！");
                       window.location.href="<%=basePath %>"+"client/reg.jsp";
                      }else{
                     Ext.MessageBox.alert("提示","您好，提交失败请重新操作！");
                      }
                      
             },         
        failure: function() {Ext.MessageBox.alert("提示","您好，提交失败请重新操作！");}　
　 }
);
            }
        },
        { text: '重置', id:"reset1", cls:"x-btn-text-icon",  handler:function(){f.getForm().reset();}
        }
        ]     
                       });
                        f.render("div2");

     });
       

</script>
	</head>

	<body >
      <div id="div1">
      <p>您在 <span style="color: #2A00AA;font-weight:bold;font-size:15px;"><%=order_date %></span> 报的 <span style="color: #2A00AA;font-weight:bold;font-size:15px;"> <%=project3%></span> 故障已经处理完成，请在下面对我们的工作进行评价！</p>
		</div>
		<div id="div2">
		</div>
	</body>
</html>

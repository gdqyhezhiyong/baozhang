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
	 username = (String) request.getSession().getAttribute("client_id");
if(username==null){
	response.sendRedirect("/baozhang/pIndex.jsp");
		return;	
			} 	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>报修记录</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">


<script  type="text/javascript" src="js/jquery.min.js"></script>
<script  type="text/javascript" src="js/bootstrap.min.js"></script>
<script  type="text/javascript" src="js/bootstrap-suggest.min.js"></script>
<script  type="text/javascript" src="js/prototype.js"></script>
<script   type="text/javascript" src="easyui/jquery.easyui.min.js"></script>


<script>
jQuery(function(){ 
//jQuery.messager.alert('提示','执行jquery','info');
	 jQuery.ajax({ 
			url: '../servlet/GetPhoneBill?user_name=<%=username%>&&sys=1',
		    async:false,
			cache: false,
			type:"GET",
			dataType:'json',
			success:function(data){
			var size = data["result"]
	        var formarrys = data["bill"];
	        
	      if(formarrys.length>0){
	          for(var i=0;i<formarrys.length;i++){
	          
	          var satisfy = formarrys[i]["satisfy"];
	          
	          if(satisfy=='1'||satisfy=='2') satisfy='满意';
	          else if(satisfy=='3'||satisfy=='4')satisfy= '不满意';
              else satisfy= '未评价';
	          
	          var finish_time = formarrys[i]["finish_time"];
	          if(finish_time.length>16)finish_time=finish_time.substring(0,16);
	          else finish_time="未处理";
	          
	          var status = formarrys[i]["status"];	
	          if(status=='0') status="未处理";
              else if(status=='1')status= '已受理';
              else if(status=='2')status= '已处理';
              else if(status=='3')status= '已撤单';
              else if(status=='4')status= '已评价';
              else status= ''; 
              jQuery("#net_list").append(
     "<div class='list-group'><a href='#' class='list-group-item'>"+
     "<h5 class='list-group-item-heading' align='center'><span>单号"+(i+1)+"</span></h5>"+
     "<h5>地址：&nbsp;<span style='color: #2A00AA;' >"+formarrys[i]["area1"]+" "+formarrys[i]["area2"]+" "+formarrys[i]["building"]+" "+formarrys[i]["floor"]+formarrys[i]["room"]+"</span></h5>"+
     "<h5> 故障类别：&nbsp;<span style='color: #2A00AA;'>"+formarrys[i]["project1"]+"</span></h5>"+
     "<h5> 报修时间：&nbsp;<span style='color: #2A00AA;'>"+formarrys[i]["order_date"].substring(0,16)+"</span></h5>"+
     "<h5>状态：<span style='color: #2A00AA;'>"+status+"</span></h5>"+
     "<h5>网管处理时间：<span style='color: #2A00AA;'>"+finish_time+"</span></h5>"+
     "<h5>网管处理结果：<span style='color: #2A00AA;'>"+formarrys[i]["solution"]+"</span></h5>"+
       "<h5>评价：<span style='color: #2A00AA;'>"+satisfy+"</span></h5>"+
     "</a></div>");
                 }
	         
	        }else{
	        jQuery("#net_list").append("<div class='list-group'> <h5 class='list-group-item'> 目前你还没有请假记录！</h5></div>");
	        }  
	        }
				
		});	
	});
</script>
<style type="text/css">
.list-group-item{
     background-color: #F0F0F0;
   }
</style>
</head>
<body>
<div class="list-group">
    <a href="preg.jsp" class="list-group-item active">
        <h4 class="list-group-item-heading">
           <span class="glyphicon glyphicon-home"></span>&nbsp; 登记网络故障 &nbsp;>>>
        </h4>
    </a>
</div>
<div id="net_list"></div>      
</body>
</html>
<%@ page language="java"
	import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
	pageEncoding="UTF-8"%>
<%
   String username="";
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	username = (String) request.getSession().getAttribute("client_id");
	 if(username==null){
	response.sendRedirect("/baozhang/pIndex.jsp");
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
	String finish_time="";
	String descriptions="";
	String solution="";
	String sql="";
	  sql="select top 1 * from t_bill where sys=1 and status=2 and bz_id= '"+username+"'";
	  ResultSet rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
			if(rs.next()){
			 id=rs.getString("id");
	         order_date=rs.getString("order_date").substring(0,10);
	         finish_time=rs.getString("finish_time").substring(0,16);
	         descriptions=rs.getString("descriptions");  
	         project1=rs.getString("project1_name");
	         solution=rs.getString("solution");
			}else{
			response.sendRedirect("/baozhang/pIndex.jsp");
			return;
			}
			
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">

<style >

body {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 12px;
  line-height: 1.428571429;
  color: #333333;
  background-color: #ffffff;
}

a:hover,
a:focus {
  color: #2a6496;
  text-decoration: underline;
}

a:focus {
  outline: thin dotted #333;
  outline: 5px auto -webkit-focus-ring-color;
  outline-offset: -2px;
}

.container {
   padding-right: 15px;
   padding-left: 15px;
   margin:30px auto
}

.shortselect{  
    background:#fafdfe;  
    height:28px;  
    width:180px;  
    line-height:28px;  
    border:1px solid #9bc0dd;  
    -moz-border-radius:2px;  
    -webkit-border-radius:2px;  
    border-radius:2px;  
}

</style>
<script  type="text/javascript" src="js/jquery.min.js"></script>
<script  type="text/javascript" src="js/bootstrap.min.js"></script>
<script  type="text/javascript" src="js/bootstrap-suggest.min.js"></script>
<script  type="text/javascript" src="js/prototype.js"></script>
<script   type="text/javascript" src="easyui/jquery.easyui.min.js"></script>


<title>评价</title>

</head>
<body>

<div class="form-group">
        <h4 class="list-group-item active" align='center'>评价 </h4>
</div>
<div class="container" style="padding: 5px 10px;">
 <div id="div1">
 
 <div class='list-group'><a href='#' class='list-group-item'>
 <h5> 报修日期：&nbsp;<span style="color: #2A00AA;"><%=order_date %></span></h5>
 <h5> 故障类别：&nbsp;<span style="color: #2A00AA;"> <%=project1%></span></h5>
 <h5> 故障描述：&nbsp;<span style="color: #2A00AA;"> <%=descriptions%></span></h5>
 <h5> 网管处理结果：&nbsp;<span style="color: #2A00AA;"> <%=solution%></span></h5>
 <h5> 网管处理时间：&nbsp;<span style="color: #2A00AA;"> <%=finish_time%></span></h5>
 </a></div>
 
	<form id="form1" action="#" method="GET" charset="utf-8" class="form-horizontal">
    <input type="hidden" id="sys" name="sys" value="1">
   
	
		
     
         
     <div class="form-group ">
      
             <div class="row " style="padding:0px 40px">
             <label class="radio-inline" for="name">您对处理结果：</label>
               <label class="radio-inline ">
		           <input type="radio" name="evaluate" id="radio1" value="2" checked>满意
               </label>
	           <label class="radio-inline ">
		            <input type="radio" name="evaluate" id="radio2"  value="3"> 不满意
	           </label>
             </div>
      </div> 
    
   <div class="form-group">
             <div class="row" style="padding:0px 40px">
             <label for="name">请填写意见：</label>
          	<textarea  rows="5"  name="suggestion" id="suggestion" class="form-control input-md" required="required" style="margin-right:0px"></textarea>
      </div>	
      </div>
	

<div class="form-group">
     <input type="button" id="submitbtn" value="提交" class="btn btn-primary btn-lg btn-block"/>
  </div>

	</form>
</div>

	<script type="text/javascript">
		(function() {
		
		//数据前端校验
			jQuery("#submitbtn").click(function(){  
		    var bz_id="<%=username%>";	//学工号	
		    var name= "<%=name%>";  //姓名
		    var  bill_id = <%=id%>;
		   
		    var satisfy=jQuery('input:radio[name="evaluate"]:checked').val();
            var suggestion = jQuery('#suggestion').val();
		   
		    
		    
		  
		     
		     if(satisfy==''||name==satisfy){
             jQuery.messager.alert('提示','请选择评价选项！','info');
             return;
            }
              
            
            jQuery.messager.confirm("操作提示", "您确定提交吗？", function (data) {
           if(data) {
         //提交数据到后台
		   jQuery.ajax({
		        type:"post",
		        data:{
				    'satisfy':satisfy,
                    'suggestion':suggestion,
                    'bz_id':bz_id,
                    'bill_id':bill_id
				},
				url:"../servlet/PinjiaServlet",
				success:function(jsonstr){
				 if(jsonstr=='1'){
                  window.location.href="list.jsp";
				 }else{
				 jQuery.messager.alert('提示','网络错误！','info');
				 }
				
         	   }}); 
                   }
 
                   });
            
             
       		
			});
		
			
		}());
	</script>
</body>
</html>
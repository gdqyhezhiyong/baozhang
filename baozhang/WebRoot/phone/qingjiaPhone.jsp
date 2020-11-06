<%@page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.security.Principal"%>
<%@page import="org.jasig.cas.client.authentication.AttributePrincipal"%>
<%@page import="java.util.Iterator"%>
<%@ page import="java.net.*, java.util.*,java.sql.*"%>


<%

// System.out.println("student_id:  "+session.getAttribute("student_id"));
if(session.getAttribute("student_id")==null){
	//用户没有登陆
	response.sendRedirect("/seeyon/qj.jsp");
	return;
}	
    String student_id=(String)session.getAttribute("student_id");
	String userName = (String)session.getAttribute("student_name");  
	 //String student_id="2017010001302";
	//String userName = "蔡奕灿";
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
   margin-right: auto;
   margin-left: auto;
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
<script  type="text/javascript" src="../js/jquery.min.js"></script>
<script  type="text/javascript" src="../js/bootstrap.min.js"></script>
<script  type="text/javascript" src="../js/bootstrap-suggest.min.js"></script>
<script  type="text/javascript" src="../js/prototype.js"></script>
<script  type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
 <script   type="text/javascript" src="easyui/jquery.easyui.min.js"></script>


<title>广东轻工职业技术学院学生请假单</title>

</head>
<body>
<div class="list-group">
    <a href="qjListPhone.jsp" class="list-group-item active">
        <h4 class="list-group-item-heading">
            查看请假记录&nbsp;>>
        </h4>
    </a>
</div>
<div class="container" style="padding: 5px 25px;">

	<div align="center" style="margin:10px auto">
		<h4>广东轻工职业技术学院学生请假单</h4>
	</div>
	<form id="form1" action="/seeyon/sendQingjiaServlet" method="POST" enctype="multipart/form-data" accept-charset="utf-8" class="form-horizontal">
  
   <input type="hidden" id="student_id" name="student_id" value="<%=student_id%>">
    <input type="hidden" id="fwzd" name="fwzd" value="phone">
		 <div class="form-group">
            <div class="row" style="padding:0px 40px">
            <label for="name" >请假人：</label>
            <input type="text" class="form-control input-md" id="username" name="username" value="<%=userName %>" readOnly="true" required="required"style="margin-right:0px">
         </div>
         </div>
		
      
       <div class="form-group">
            <div class="row" style="padding:0px 40px">
             <label for="name">所属学院：</label>
          <input type="text" class="form-control input-md" id="xueyuan" readOnly="true" name="xueyuan" value="" required="required" style="margin-right:0px">
         </div>
         </div>
			
     <div class="form-group">
              <div class="row" style="padding:0px 40px">
                 <label for="name">班别：</label>
          	<input type="text" class="form-control input-md" readOnly="true" id="class" name="class" value="" required="required" style="margin-right:0px">
              </div>
      </div>
      
	 <div class="form-group">     
            <div class="row" style="padding:0px 40px">
              <label for="name">班主任：</label>
               <div class="input-group">
                <input type="hidden" id="teacherCode" name="teacherCode">
          	       <input type="text" class="form-control input-md" id="teacher" name="teacher" placeholder="请输入老师姓名">
						 <div class="input-group-btn">
						      <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                              </button>
							<ul class="dropdown-menu dropdown-menu-right" role="menu"></ul>
						</div>
			    </div>			
	         </div>					
      </div>		
    
     <div class="form-group">
             <div class="row" style="padding:0px 40px">
               <label for="name">请假类型：</label>
          	<select id="leaveType" class="form-control input-md shortselect" name="leaveType" required="required" style="margin-right:0px">
						<option>病假</option>
						<option>事假</option>
						<option>丧假</option>
						<option>其他</option>
				</select>
      </div>
      </div> 
	
	<div class="form-group">
          
             <div class="row" style="padding:0px 40px">
               <label for="name">开始时间：</label>
          	<input id="startTime" name="startTime"  type="text" style="margin-right:0px" class="form-control input-md"
					onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
      </div>	
      </div>
      
      <div class="form-group">
             <div class="row" style="padding:0px 40px">
               <label for="name">结束时间：</label>
          	<input id="endTime" name="endTime"  type="text" style="margin-right:0px" class="form-control input-md"
					onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
      </div>
      </div>
      
       <div class="form-group">
             <div class="row" style="padding:0px 40px">
              <label for="name">请假原因：</label>
          	<textarea  rows="5"  name="reason" id="reason" class="form-control input-md" required="required" style="margin-right:0px"></textarea>
      </div>	
      </div>
			
	 <div class="form-group">
             <div class="row" style="padding:0px 40px">
               <label for="name">附件上传：</label>
          	<input type="file" id="file" class="form-control input-md" name="fileN" style="margin-right:0px" />
      </div>
      </div>
      
      <div class="form-group">
            <label for="name">说明：</label>
           <p class="help-block">
1、 请假不超过两天的，由导师（班主任）批准；一周以内，导师（班主任）签署意见并由二级学院主管教学工作的领导批准；一周至三周由导师（班主任）、二级学院主管教学工作的领导签署意，并报教务处副处长批准；
三周以上由导师（班主任）、二级学院主管教学工作的领导签署意，并报教务处处长批准（超过一个月的需办理休学手续）。<br> 

2、 凡请假期间有考试安排的，必须办理缓考手续。<br>

3、 请假时间不能间断，周末时间计入请假时间。</p>
      </div>	
		

<div class="form-group">
     <input type="button" id="submitbtn" value="提交" class="btn btn-primary btn-lg btn-block"/>
  </div>

	</form>
</div>

	<script type="text/javascript">
	
	 var admdirector =jQuery("#teacher").bsSuggest({
		    indexId : 2, //data.value 的第几个数据，作为input输入框的内容
			indexKey : 1, //data.value 的第几个数据，作为input输入框的内容
			allowNoKeyword : false, //是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
			multiWord : false, //以分隔符号分割的多关键字支持
			separator : ",", //多关键字支持时的分隔符，默认为空格
			getDataMethod : "url", //获取数据的方式，总是从 URL 获取
			effectiveFieldsAlias : {
				Id : "序号",
				teacherName : "姓名(教工号)",
				teacherDept : "部门"
			},
			showHeader : false,
			url : "/seeyon/SuggestServlet?teacherName=",
			processData: function(json){// url 获取数据时，对数据的处理，作为 getData 的回调函数                
				var index, len, data = {
						value : []
					};

					if (!json || !json.rows || !json.rows.length) {
						return false;
					}

					len = json.rows.length;

					for (index = 0; index < len; index++) {
						data.value.push({
							"Id" : (index + 1),
							"teacherName" : json.rows[index].teacherName+"("+json.rows[index].teacherCode+")",
							"teacherDept" : json.rows[index].teacherDept
						});
					}
					console.log('返回数据: ', data);
					return data;            
		                 }
		             });
	 
	 
		(function() {
			
			//根据填写人学号自动填充他所在的院系何班级字段
			jQuery.ajax({
				url:"/seeyon/getStudentServlet?studentid="+<%=student_id%>,
				success:function(result){
					 var str = result.split("|");
					 jQuery("#xueyuan").val(str[0]);
					 jQuery("#class").val(str[1]);
		    }});
		
			//数据前端校验
			jQuery("#submitbtn").click(function(){
				var username = jQuery("#username").val();
				var xueyuan = jQuery("#xueyuan").val();
				var bj = jQuery("#class").val();
				var teacher = jQuery("#teacher").val();
				var teacherName= teacher.substring(0,teacher.indexOf("("))
				var teacherCode = teacher.substring(teacher.indexOf("(")+1,teacher.length-1);
				var leaveType = jQuery("#leaveType").val();
				var startTime = jQuery("#startTime").val();
				var endTime = jQuery("#endTime").val();
				var reason = jQuery("#reason").val();
				var checkedTeacher = '0';
				

				if(username==null||username=='')
					{
					
					jQuery.messager.alert('警告','请假人不能为空！','info');
					return;
					}
				if(xueyuan==null||xueyuan=='')
				{
				
				jQuery.messager.alert('警告','所属学院不能为空！','info');
				return;
				}
				if(bj==null||bj=='')
				{
				
				jQuery.messager.alert('警告','班级不能为空！','info');
				return;
				}
				if(teacher==null||teacher=='')
				{
				
				jQuery.messager.alert('警告','班主任不能为空！','info');
				return;
				}
				if(leaveType==null||leaveType=='')
				{
				
				jQuery.messager.alert('警告','请假类型不能为空！','info');
				return;
				}
				
				if(startTime==null||startTime=='')
				{
				
				jQuery.messager.alert('警告','请假开始时间不能为空！','info');
				return;
				}
				
				if(endTime==null||endTime=='')
				{
				
				jQuery.messager.alert('警告','请假结束时间不能为空！','info');
				return;
				}
				
				if(reason==null||reason=='')
				{
				
				jQuery.messager.alert('警告','请假原因不能为空！','info');
				return;
				}
				
				//alert(teacher);
				jQuery.ajax({
					url:"/seeyon/CheckedTeacherServlet?teacher="+teacherCode,
					//type: 'post',
					async: false,
					success:function(result){
						 checkedTeacher=result;
			    }});
				
				//alert("checkedTeacher: "+checkedTeacher);
				if(checkedTeacher!='1') {
					jQuery.messager.alert('警告','您输入的班主任不存在，请查证后输入！','info');
					return;
				}
			  
				jQuery("#form1").submit();
			});
			
		}());
	</script>
</body>
</html>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*" pageEncoding="UTF-8"%>


<%
 String phone = "";
	String name = "";
	String area1 = "南海";
	String area2 = "";
	String area1_id ="2";
	String area2_id = "3";
	String building = "";
	String building_id = "";
	String floor = "";
	String room = "";
	String sql="";
	String logins = "";
	String username="";
	ResultSet rs=null;	
	String role_id ="";	
	String inside="";
    
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	 username = (String) request.getSession().getAttribute("client_id");
	 name = (String)request.getSession().getAttribute("client_name");
	 role_id =(String)request.getSession().getAttribute("client_role_id");
	 inside = (String)request.getSession().getAttribute("inside");
  if(username==null){
	response.sendRedirect("/baozhang/pIndex.jsp");
		return;	
			} 
	  sql="select status from t_bill where status=2 and sys=1 and bz_id= '"+username+"'";
	 rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
			if(rs.next()){
			//System.err.println("不能报修");
			response.sendRedirect("pj.jsp");
			return;
			}else{
		
	
	 sql = "select * from t_user where user_name='" + username+ "'";
	//System.out.println("t_user:"+sql);
	 rs = DBHelper.getConnection().createStatement()
			.executeQuery(sql);
	if (rs.next()) {
	//System.out.println("第一次保障"+rs.getString("phon_number")+"--"+rs.getString("name"));
		
		if("0".equals(rs.getString("isonce"))){
		phone = rs.getString("phon_number")==null?"":rs.getString("phon_number");
		name = rs.getString("name")==null?"":rs.getString("name");
	    area1 = rs.getString("area1")==null?"":rs.getString("area1");
	    area2 = rs.getString("area2")==null?"":rs.getString("area2");
	    area1_id = rs.getString("area1_id")==null?"":rs.getString("area1_id");
	    area2_id = rs.getString("area2_id")==null?"":rs.getString("area2_id");
	    building = rs.getString("building")==null?"":rs.getString("building");
	    building_id = rs.getString("building_id")==null?"":rs.getString("building_id"); 
	    floor = rs.getString("floor")==null?"":rs.getString("floor");
        room = rs.getString("room")==null?"":rs.getString("room");
		logins="once";
		}else{
		phone = rs.getString("phon_number");
		name = rs.getString("name");
	    area1 = rs.getString("area1");
	    area2 = rs.getString("area2");
	    area1_id = rs.getString("area1_id");
	    area2_id = rs.getString("area2_id");
	    building = rs.getString("building");
	    building_id = rs.getString("building_id"); 
	    floor = rs.getString("floor");
        room = rs.getString("room");
		logins="more";
		}
		
	}
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
<script  type="text/javascript" src="js/jquery.min.js"></script>
<script  type="text/javascript" src="js/bootstrap.min.js"></script>
<script  type="text/javascript" src="js/bootstrap-suggest.min.js"></script>
<script  type="text/javascript" src="js/prototype.js"></script>
<script   type="text/javascript" src="easyui/jquery.easyui.min.js"></script>


<title>网络故障登记</title>

</head>
<body>
<div class="list-group">
    <a href="list.jsp" class="list-group-item active">
        <h4 class="list-group-item-heading">
           <span class="glyphicon glyphicon-home"></span>&nbsp; 查看报修记录&nbsp;>>>
        </h4>
    </a>
</div>
<div class="container" style="padding: 5px 10px;">

	<form id="form1" action="#" method="GET" charset="utf-8" class="form-horizontal">
    <input type="hidden" id="sys" name="sys" value="1">
   
		 <div class="form-group ">
            <div class="row" style="padding:0px 40px">
            <label for="name" >姓名：</label>
            <input type="text" class="form-control input-md" id="username" name="username" value="<%=name%>" readOnly="true" required="required"style="margin-right:0px">
         </div>
         </div>
		
      
       <div class="form-group">
            <div class="row" style="padding:0px 40px">
             <label for="name">电话号码：</label>
          <input type="text" class="form-control input-md" id="phone"  name="phone" value="<%=phone%>" required="required" style="margin-right:0px">
         </div>
         </div>
         
     <div class="form-group ">
      
             <div class="row " style="padding:0px 40px">
              <label for="name">校区：</label>
               <label class="radio-inline ">
		           <input type="radio" name="area1" id="optionsRadios1" value="1"> 广州
               </label>
	           <label class="radio-inline ">
		            <input type="radio" name="area1" id="optionsRadios2"  value="2"> 南海
	           </label>
             </div>
      </div> 
      
      
      <div class="form-group ">
             <div class="row" style="padding:0px 40px">
               <label for="name">区域：</label>
          	<select  class="form-control  shortselect" id="area2" name="area2" required="required" style="margin-right:0px">	
						
				</select>
      </div>
      </div> 
      
      
       <div class="form-group ">
             <div class="row" style="padding:0px 40px">
               <label for="name">楼栋：</label>
          	<select  class="form-control   shortselect" id="building" name="building" required="required" style="margin-right:0px">
						
				</select>
      </div>
      </div> 
         
      <div class="form-group ">
             <div class="row" style="padding:0px 40px">
               <label for="name">楼层：</label>
          	<select  class="form-control   shortselect" id="floor" name="floor" required="required" style="margin-right:0px">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>
				</select>
      </div>
      </div>
      
      <div class="form-group ">
             <div class="row" style="padding:0px 40px">
               <label for="name">房号：</label>
          	<select  class="form-control   shortselect" id="room" name="room" required="required" style="margin-right:0px">
			<option value="01">01</option> <option value="02">02</option><option value="03">03</option>
			<option value="04">04</option><option value="05">05</option><option value="06">06</option>
			<option value="07">07</option><option value="08">08</option><option value="09">09</option>			
			<option value="10">10</option><option value="11">11</option><option value="12">12</option>				
			<option value="13">13</option><option value="14">14</option><option value="15">15</option>	
			<option value="16">16</option><option value="17">17</option><option value="18">18</option>	
			<option value="19">19</option><option value="20">20</option><option value="21">21</option>	
			<option value="22">22</option><option value="23">23</option><option value="24">24</option>	
			<option value="25">25</option><option value="26">26</option><option value="27">27</option>	
			<option value="28">28</option><option value="29">29</option><option value="30">30</option>	
			<option value="31">31</option><option value="32">32</option><option value="33">33</option>	
			<option value="34">34</option><option value="35">35</option><option value="36">36</option>	
			<option value="37">37</option><option value="38">38</option><option value="39">39</option>	
			<option value="40">40</option><option value="41">41</option><option value="42">42</option>	
			<option value="43">43</option><option value="44">44</option><option value="45">45</option>	
			<option value="46">46</option><option value="47">47</option><option value="48">48</option>	
			<option value="49">49</option><option value="50">50</option>			
				</select>
      </div>
      </div>   
   
       <div class="form-group ">
              <div class="row" style="padding:0px 40px">
               <label for="name">网络故障类别：</label>
          	<select  class="form-control  shortselect" id="project" name="project" required="required" style="margin-right:0px">
						
				</select>
      </div>
      </div>
	 
   <div class="form-group">
             <div class="row" style="padding:0px 40px">
              <label for="name">报修故障描述：</label>
          	<textarea  rows="5"  name="description" id="description" class="form-control input-md" required="required" style="margin-right:0px"></textarea>
      </div>	
      </div>
	
	
		
		

<div class="form-group">
     <input type="button" id="submitbtn" value="提交" class="btn btn-primary btn-lg btn-block"/>
  </div>

	</form>
</div>

	<script language="javascript">
		(function() {
		// 设置默认校区
           if("<%=area1%>"=="广州"){
	           jQuery("#optionsRadios1").attr("checked","checked");
	           jQuery("#optionsRadios2").removeAttr("checked");
          }else{
	           jQuery("#optionsRadios2").attr("checked","checked");
	           jQuery("#optionsRadios1").removeAttr("checked");
           }
			
		//根据校区初始化区域下拉框数据
		    var val = jQuery('input:radio[name="area1"]:checked').val();
			jQuery.ajax({
				url:"../servlet/GetAreaServlet?p_id="+val,
				async:false,
				success:function(jsonstr){
				var rsl = eval('(' + jsonstr + ')'); 
				var len = rsl.result;
				var data = rsl.area;
				   for(var i=0;i<len;i++){
		        jQuery("#area2").append("<option value='"+ data[i].id +"'>"+data[i].name+"</option>");
				   }
				    //设置默认区域
                        jQuery("#area2").val("<%=area2_id.trim()%>"); 
                    	var area2_tmp=jQuery('#area2').val(); 
                   	//根据默认区域初始化楼栋数据
                     jQuery.ajax({
			        	url:"../servlet/GetBuildingServlet?area_id="+area2_tmp,
			        	async:false,
						success:function(jsonstr){
						var rsl = eval('(' + jsonstr + ')'); 
						var len = rsl.result;
						//alert("长度："+len);
						var data = rsl.building;
						for(var i=0;i<len;i++){
						jQuery("#building").append("<option value='"+ jQuery.trim(data[i].id) +"'>"+jQuery.trim(data[i].name)+"</option>");				                 
				                   }
				           //设置默认楼栋                
				        jQuery("#building").val("<%=building_id.trim()%>");          
         	 }});
         }});
         
     
                      //设置默认楼层              
				        jQuery("#floor").val("<%=floor.trim()%>"); 
				        
				       //设置默房号               
				        jQuery("#room").val("<%=room.trim()%>");    
        
       
         	 
         	 
       //初始化网络故障下拉框数据
		   jQuery.ajax({
				url:"../servlet/CategoryServlet?sys=1&&p_id=0",
				success:function(jsonstr){
				var rsl = eval('(' + jsonstr + ')'); 
				var len = rsl.result;
				//alert(len);
				var data = rsl.project;
				 for(var i=0;i<len;i++){
		        jQuery("#project").append("<option value='"+ data[i].id +"'>"+data[i].name+"</option>");
				  
				  }
         	 }});  	 
         	 
         
       //选择校区，重新初始化区域下拉框数据  	 
       jQuery("input:radio[name='area1']").change(function (){
         jQuery("#area2").empty();
          var opt=jQuery('input:radio[name="area1"]:checked').val();
          
          jQuery.ajax({
				url:"../servlet/GetAreaServlet?p_id="+opt,
				success:function(jsonstr){
				var rsl = eval('(' + jsonstr + ')'); 
				var len = rsl.result;
				var data = rsl.area;
				   for(var i=0;i<len;i++){
		jQuery("#area2").append("<option value='"+ data[i].id +"'>"+data[i].name+"</option>");
				  
				   }
         	 }});
        });
        
        
        //选择区域，重新初始化楼栋下拉框数据  
         jQuery("#area2").change(function (){
         jQuery("#building").empty();
          var qy=jQuery('#area2').val();
         // jQuery.messager.alert('警告',qy,'info');
          
           jQuery.ajax({
				url:"../servlet/GetBuildingServlet?area_id="+qy,
				success:function(jsonstr){
				var rsl = eval('(' + jsonstr + ')'); 
				var len = rsl.result;
				//alert("长度："+len);
				var data = rsl.building;
				
				 for(var i=0;i<len;i++){
		      jQuery("#building").append("<option value='"+ data[i].id +"'>"+data[i].name+"</option>");
				  
				   }
				  
         	 }});
         	    
          
          });
    
			
			
		
			//数据前端校验
			jQuery("#submitbtn").click(function(){  
		    var bz_id="<%=username%>";		
		    var name= "<%=name%>";
		    var phone=jQuery('#phone').val(); 
		    
		    var area1_id=jQuery('input:radio[name="area1"]:checked').val();
		    var area1=(area1_id=='1'?'广州':'南海');
		    
		    var area2_id=jQuery('#area2').val();
		    var area2 = jQuery("#area2").find("option:selected").text();
		  
		    var building_id=jQuery('#building').val();
		    var building = jQuery("#building").find("option:selected").text();
		    
            var floor=jQuery('#floor').val();
		    var room=jQuery('#room').val();
		    var project_id=jQuery('#project').val();
		    var project = jQuery("#project").find("option:selected").text();
		    var description=jQuery('#description').val();
		     
		     if(name==''||name==null){
             jQuery.messager.alert('警告','姓名不能为空！','info');
             return;
            }
             if(phone==''||phone==null){
            jQuery.messager.alert('警告','电话号码不能为空！','info');
             return;
            }
            
            if(area1_id==''||area1_id==null){
             jQuery.messager.alert('警告','请选择校区！','info');
             return;
            }
            if(area2_id==''||area2_id==null){
              jQuery.messager.alert('警告','请选择宿舍区域！','info');
             return;
            }
            if(building_id==''||building_id==null){
             jQuery.messager.alert('警告','请选择宿舍楼！','info');
             return;
            }
            
             if(floor==''||floor==null){
              jQuery.messager.alert('警告','请选择楼层！','info');
             return;
            }
             if(room==''||room==null){
             jQuery.messager.alert('警告','请选择宿舍房间号！','info');
             return;
            }
            
            if(project_id==''||project_id==null){
             Ext.MessageBox.alert("温馨提示！","请选择网络故障类别！");
             return;
            }
            if(description==''||description==null){
               jQuery.messager.alert('警告','故障描述不能为空！','info');
             return;
            }
             if(description.length>100){
           jQuery.messager.alert('警告','故障描述内容不要超过100字！','info');
             return;
            }
            
             
            
            //数据提交后台
		   jQuery.ajax({
		        type:"post",
		        data:{
				    'name':name,
                    'phone':phone,
                    'project1':project,
                    'project1_id':project_id,
                    'description':description,
                    'bz_id':bz_id,
                    'logins':"<%=logins%>",
                    'inside':"<%=inside%>",
                    'area1':area1,
                    'area1_id':area1_id,
                    'area2':area2,
                    'area2_id':area2_id,
                    'building':building,
                    'building_id':building_id,
                    'floor':floor,
                    'room':room,
                    'sys':"1"
				},
				url:"../servlet/RegServlet",
				success:function(jsonstr){
				 jQuery.messager.alert('警告',jsonstr,'info');
				 if(jsonstr=="succ"){
                    jQuery.messager.alert('警告','报修成功！','info');
                       window.location.href="list.jsp";
                      }else if(jsonstr=="rereg"){
                        jQuery.messager.alert('警告','您已经重复报修！','info');
                      }
                      else{
                        jQuery.messager.alert('警告','报修失败！','info');
                      }
         	   }}); 
			});
		}());
		
		
	</script>
</body>
</html>
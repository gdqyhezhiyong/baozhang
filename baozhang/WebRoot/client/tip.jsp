<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>公告提示</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

    <style type="text/css">
<!--
.STYLE2 {color: #FFFFFF;}
-->
    </style>
</head>
  
  <body>
    <div align="center" style="margin-top:100px"> 
	
	<table width="95%">
	<tr>
	<th width="400"><div align="center"><span>报修流程</span></div></th>
	<th width="400"><div align="center">报修注意事项</div></th>
	</tr>
	
	<tr>
	<td height="450"><div align="center"><img src="images/lct.jpg" width="380" height="390"></td>
	<td><p style="font-size:15px;">1.请在填写报修内容时尽量详细描述，在预约时间段内留人在宿舍。报修预约时间段：08：00—10：00，11：00—12：30，12：30—14：30，15：00—17：00，18：30—22：00。 <br>
          2.一般维修在1天内解决，特殊维修根据工作量大小而定，如：电风扇电机坏需要三天。床护栏要烧焊需两天。门窗玻璃烂需两天。大门玻璃、大门更换需要订购材料。紧急维修即时解决。 <br>
          3.紧急维修（如遇爆水管、停电等）可拨打紧急报修电话,<br>
		  公寓区:13413242686(662686) 教学区：13413249283(669283)<br>
           或者到值班室登记<br>
         公寓区:各区域宿管值班室<br>
         教学楼:1栋金鱼池旁物业值班室<br>
	 图书馆:C105 物业值班室<br>
	 第四实训:C108物业值班室<br>
	 第三实训:C112 物业值班室<br>


          4.9-24栋热水器、电话及网络不属于本部门维护管理。9-24栋热水器故障请到18栋101值班室报修，铁通电话故障请打10050报修，中国电信电话故障请打10000报修，网络故障请向网络信息中心报修</p>	</td>
	</tr>
	</table>
	
	

  </body>
</html>

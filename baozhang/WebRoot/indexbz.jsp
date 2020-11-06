<%@page 
	language="java"
	contentType="text/html; charset=gb2312"
	pageEncoding="GB2312"	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>广东轻工职业技术学院统一身份认证系统</title>


<meta name="copyright" content="广东轻工业技术学院"/>
<meta name="keywords" content="广东轻工业技术学"/>
<meta name="description" content="广东轻工业技术学院"/>


<link href="style/loginbz.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
<!--

#login-table input {
   border:1px solid #bfbfc7;
}
.STYLE21 {font-size: 12px; color: #000433; font-family: "Courier New", Courier, monospace; font-weight: bold; }
.STYLE22 {font-size: 12px; color: #1B517E; font-family: "Courier New", Courier, monospace; font-weight: bold; }
-->

a{text-decoration:none}a:hover{text-decoration:underline}
</style>

</head>

<body >

<%  String goUrl=request.getParameter("goto");
%>
<form name="form1" method="post" action="MyJsp.jsp">
<div class="mainDiv">
	<div class="top">
    	<ul>
        	<li class="login logo"><a width="444px" href="#"></a></li>
        	<li class="setindex"></li>
        </ul>
    </div>
    <div class="login_middle">
    	<ul>
        	<li class="leftpicture"></li>
            <li class="logininfo">
            	<ul>
                	<li class="l"></li>
                	<li class="m">
                    	<ul>
                        	<li class="info"></li>
                        	<li class="txt">用户名：<input type="text" name="username" size="16"   id="username" ></li>
                        	<li class="txt">密　码：<input type="password" name="password" size="16" id="password"  >  </li><li><input type="hidden" name="goto" value=<%=goUrl%> ><font color="#FF0000"></font></li>
                            <li class="btn">
                                <input type="submit" name="btn"  tabindex="4"  class="login" value="登　录" />　
                                <input class="reset" tabindex="5" type="reset" value="重　置" /></li>
                            <li>
                               
                            </li>
                        </ul>
                    </li>
                	<li class="r"></li>
                </ul>
            </li>
        </ul>
        <ul class="schoolinfo">
        	<li class="idea">
              <p>办学理念：<br />
              高素质为本　高技能为重<br />
              高就业导向　创新促发展</p>
            </li>
        	<li class="thought">
            	<p>办学思想：<br />
                植根岭南文化，传承职教精髓<br />
                锻造技能英才，创建高职名校</p>
            </li>
        	<li class="explain">
            	<p><font color="#FF0000">*</font>用户名和密码与数字化校园信息门户的相同。 <br/>
					<font color="#FF0000">*</font>教工用户名为10位的教工编号，学生用户名为学号。<br />
                <font color="#FF0000">*</font>初始密码为15位身份证的后6位或18位身份证的后6位（包含X的为大写）<br />
					
                <!--<font color="#FF0000">*</font> 若无法找回密码,请持有效证件修改统一身份认证密码。--></p>
            </li>
        </ul>
    <div class="login_bottom">版权所有：广东轻工职业技术学院 联系地址：广州市新港西路152号 邮编：510300</div>
    </div>
</div>
</form>

</body>
</html>




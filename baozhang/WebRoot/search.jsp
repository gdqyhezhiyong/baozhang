<%@page 
	language="java"
	contentType="text/html; charset=GB2312"
	pageEncoding="GB2312"
	import="com.wiscom.is.*, java.net.*,java.util.*"
%>

<%
        String user_name="";
        String group="";
        String  gId="";
        String  attr="";
        List gList=null;
	String is_config = request.getRealPath("/client.properties");
    Cookie all_cookies[] = request.getCookies();
    Cookie myCookie;
    String decodedCookieValue = null;
    if (all_cookies != null) {
        for(int i=0; i< all_cookies.length; i++) {
            myCookie = all_cookies[i];

            if( myCookie.getName().equals("iPlanetDirectoryPro") ) {
                decodedCookieValue = URLDecoder.decode(myCookie.getValue(),"GB2312");
            }
        }
    }
	IdentityFactory factory = IdentityFactory.createFactory( is_config );
	IdentityManager im = factory.getIdentityManager();
	String curUser = "";
	if (decodedCookieValue != null ) {
    	curUser = im.getCurrentUser( decodedCookieValue );
        user_name = im.getUserNameByID(curUser);
        group = im.getUserGroup(curUser ).toString();
        gId = im.getGroupByID(curUser).toString();
        gList = im.getGroups();
for(int i=0;i<gList .size();i++){
String g1=gList.get(i).toString();
%>
<p> 用户组:<%= g1%></p>

<%
}
attr = im.getUserAttribute(curUser , null).toString();
%>

<p> 用户属性:<%= attr %></p>
<%


    }
	
	if ( curUser.length()==0 ){
%>
	<jsp:forward page="index.jsp"/>		
<%	
		return;
	}


%>
<html>
<body>
<div align="center">
<p> 帐号:<%= curUser %></p>
<p> 姓名:<%=user_name %></p>
<p> 用户组名:<%=group%></p>
<p> 用户组id:<%=gId%></p>


</div>
</body>
</html>
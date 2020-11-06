<%@page 
	language="java"
	contentType="text/html; charset=GB2312"
	pageEncoding="GB2312"
	import="com.wiscom.is.*, java.net.*, java.util.*"
%>

<%
	String is_config = request.getRealPath("/client.properties");
	System.out.println(is_config);
	 System.out.println("AAAA:");
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
    System.out.println("AAAA:"+decodedCookieValue);
	IdentityFactory factory = IdentityFactory.createFactory( is_config );
	IdentityManager im = factory.getIdentityManager();
	
	String curUser = "";
        String username= "";
	if (decodedCookieValue != null ) {
    	curUser = im.getCurrentUser(decodedCookieValue);   
        username=im.getUserNameByID(curUser); 
     
    }
   
%>
<html>
<body>

<%
	if ( curUser.length()==0 ){
		String gotoURL = HttpUtils.getRequestURL(request).toString();
		String loginURL = "http://data.gdqy.edu.cn:8080/sub_talents2012/index2.jsp?goto=" +java.net.URLEncoder.encode(gotoURL);
                 response.sendRedirect(loginURL);
		
	}else{%>

<div align="center">
  <p>当前用户:<%= curUser%> <P><%=username%> </div>
		
<%
	 }
%>
</body>
</html>
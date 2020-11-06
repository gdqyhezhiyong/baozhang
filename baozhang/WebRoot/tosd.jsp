<%@page 
	language="java"
	contentType="text/html; charset=GB2312"
	import="com.wiscom.is.*, java.net.*, java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
    pageEncoding="UTF-8"
%>


<%
       String path = request.getContextPath();
       String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String is_config = request.getRealPath("/client.properties");
	//System.out.println(is_config);
	// System.out.println("AAAA:");
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
   // System.out.println("AAAA:"+decodedCookieValue);
	IdentityFactory factory = IdentityFactory.createFactory( is_config );
	IdentityManager im = factory.getIdentityManager();
	
     	String user_name = "";
        String name= "";
	if (decodedCookieValue != null ) {
    	user_name = im.getCurrentUser(decodedCookieValue);   
        name=im.getUserNameByID(user_name); 
     
    }
   
%>
<html>
<body>

<%
	if ( user_name.length()==0 ){
		 //String gotoURL = HttpUtils.getRequestURL(request).toString();
                 //String loginURL = "indexbz.jsp?goto="+java.net.URLEncoder.encode(gotoURL);
                 response.sendRedirect("http://my.gdqy.edu.cn");
                
                
                 }else{
	request.getSession().setAttribute("client_id",user_name);
	request.getSession().setAttribute("client_name",name);
	
	response.sendRedirect("sf_df/sfdf.jsp");
	
	
	 }
%>
</body>
</html>
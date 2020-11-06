<%@page 
	language="java"
	contentType="text/html; charset=GB2312"
	pageEncoding="GB2312"
	import="com.wiscom.is.*, java.net.*,com.wiscom.util.servlet.CookieUtil"
%>

<%
	String goUrl=request.getParameter("goto");
       String is_config = request.getRealPath("/client.properties");
	IdentityFactory factory = IdentityFactory.createFactory( is_config );
	IdentityManager im = factory.getIdentityManager();
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	SSOToken token = null;

   try {
      token =im.createStoken(username,password);
    } catch (Exception ex) {
    System.out.println(ex.toString());
    }
    String value = token.getTokenValue();
    String encodeCookieValue = URLEncoder.encode(value);
    CookieUtil.setCookie(response, "iPlanetDirectoryPro", encodeCookieValue, CookieUtil.getDefaultCookieDomain(request), -1, "/");
  // System.out.println(value);
   System.out.println(CookieUtil.getDefaultCookieDomain(request));
    
     // String curUser ="" ;//用户名
     //  String myname="";//姓名
  if (value=="") {
             // out.print("帐号或密码不正确！");
             response.sendRedirect(goUrl);
        }
 else{
   if (goUrl.equals("null")) {
    	//curUser= im.getCurrentUser(value);  
       // myname=im.getUserNameByID(curUser); }
      
       out.print("当前用户:"+im.getCurrentUser(value));
      // goUrl="http://cms.gdqy.edu.cn/viscms/visadmin/viscms/login.do";
      //response.sendRedirect(goUrl);
     }
	else{   
    response.sendRedirect("index.jsp");
}
        //  out.print(goUrl+"2");
  }	 
%>



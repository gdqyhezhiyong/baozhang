<%@page 
	language="java"
	contentType="text/html; charset=GB2312"
	import="com.wiscom.is.*, java.net.*, java.util.*,java.sql.*,gdqy.edu.cn.DBhelper.*"
    pageEncoding="UTF-8"
%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String role_id="";
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
		String gotoURL = HttpUtils.getRequestURL(request).toString();
               String loginURL = "indexbz.jsp?goto="+java.net.URLEncoder.encode(gotoURL);
                 response.sendRedirect(loginURL);
		
	}else{
	String sql ="select * from t_user where user_name='"+user_name+"'";
	ResultSet rs = DBHelper.getConnection().createStatement().executeQuery(sql);
	String inside="no";
	if(rs.next()){
	inside="yes";
	role_id = rs.getString("role_id");
	
	if("1".equals(role_id)||"7".equals(role_id)){
			  // System.out.println("**************1");
			            request.getSession().setAttribute("name", rs.getString("name"));
						request.getSession().setAttribute("username", user_name);
						request.getSession().setAttribute("role_id", role_id);
						request.getSession().setAttribute("area", rs.getString("area1"));
						request.getSession().setAttribute("sys", "0");
			            response.sendRedirect(basePath+"admin/admin.jsp");
		   }else if("2".equals(role_id)){
		                                request.getSession().setAttribute("name", rs.getString("name"));
						request.getSession().setAttribute("username", user_name);
						request.getSession().setAttribute("role_id", role_id);
						request.getSession().setAttribute("area", rs.getString("area1"));
						request.getSession().setAttribute("sys", "0");
			            response.sendRedirect(basePath+"admin/pdy.jsp");
			  // System.out.println("**************2");
		   }
		   else if("3".equals(role_id)){
			  // System.out.println("**************3");
			            request.getSession().setAttribute("name", rs.getString("name"));
						request.getSession().setAttribute("username", user_name);
						request.getSession().setAttribute("role_id", role_id);
						request.getSession().setAttribute("area", rs.getString("area1"));
						request.getSession().setAttribute("sys", "0");
			            response.sendRedirect(basePath+"admin/weixiu.jsp");
		   }
		   else if("5".equals(role_id)){
			 //  System.out.println("**************5");
			           request.getSession().setAttribute("name", rs.getString("name"));
						request.getSession().setAttribute("username", user_name);
						request.getSession().setAttribute("role_id", role_id);
						request.getSession().setAttribute("area", rs.getString("area1"));
						request.getSession().setAttribute("sys", "0");
			            response.sendRedirect(basePath+"admin/leader.jsp");
		   }
		   else if("6".equals(role_id)){
				 //  System.out.println("**************5");
				        request.getSession().setAttribute("name", rs.getString("name"));
						request.getSession().setAttribute("username", user_name);
						request.getSession().setAttribute("role_id", role_id);
						request.getSession().setAttribute("area", rs.getString("area1"));
						request.getSession().setAttribute("sys", "0");
				        response.sendRedirect(basePath+"admin/suguan.jsp");
			   }   
	else
	{
	request.getSession().setAttribute("client_role_id","4");
	request.getSession().setAttribute("client_id",user_name);
	request.getSession().setAttribute("client_name",name);
	request.getSession().setAttribute("inside",inside);
	response.sendRedirect("client/client.jsp");
	}
	}
	else{
	request.getSession().setAttribute("client_role_id","4");
	request.getSession().setAttribute("client_id",user_name);
	request.getSession().setAttribute("client_name",name);
	request.getSession().setAttribute("inside",inside);
	response.sendRedirect("client/client.jsp");
	}
	
	
	
	 }
%>
</body>
</html>
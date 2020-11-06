package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.serviceImp.AdminService;
import gdqy.edu.cn.serviceImp.ClientService2;
import gdqy.edu.cn.util.getRemortIP;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public LoginServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");
response.setCharacterEncoding("UTF-8");
PrintWriter out = response.getWriter();
String password = request.getParameter("password");
String username = request.getParameter("code");
String name="";
String role_id="";
String area="";


String sql= "select * from t_user where user_name='"+username+"' and sys=0";
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ClientService2 client =new ClientService2();
ResultSet rs=null;	
String  result=client.login(username, password,"0");

if(("11".equals(result)||"12".equals(result))){
	response.sendRedirect(basePath+"login.jsp?result="+result);
	
}

else

{
	
	try {
		rs = DBHelper.getConnection().createStatement().executeQuery(sql);
		if(rs.next()){
			
			System.out.println(rs.getString("name")+" - "+username+" - "+rs.getString("role_id")+" - "+rs.getString("area1"));
			name =rs.getString("name");
			role_id=rs.getString("role_id");
			area =  rs.getString("area1");
			//request.getSession().setAttribute("name", );
			//request.getSession().setAttribute("username", username);
			//request.getSession().setAttribute("role_id", );
			//request.getSession().setAttribute("area",);
			//request.getSession().setAttribute("sys", "0");
		
			
			//request.getSession().setAttribute("role_id", rs.getString("role_id"));
			//request.getSession().setAttribute("sys", "0");
		  // if("1".equals(rs.getString("role_id"))||"2".equals(rs.getString("role_id"))||"3".equals(rs.getString("role_id"))||"5".equals(rs.getString("role_id"))){
			 //  (new AdminService()).log(rs.getString("user_name"),rs.getString("name"),"��½",(new getRemortIP()).getRemoteAddress(request)); 
		   //}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
		if("1".equals(result)){
			   System.out.println("**************1");
			   
				request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("role_id", role_id);
				request.getSession().setAttribute("area",area);
				request.getSession().setAttribute("sys", "0");
			
			   response.sendRedirect(basePath+"admin/admin.jsp");
		   }
		else if("2".equals(result)){
			 System.out.println("**************2");
			request.getSession().setAttribute("name", name);
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("role_id", role_id);
			request.getSession().setAttribute("area",area);
			request.getSession().setAttribute("sys", "0");
			   response.sendRedirect(basePath+"admin/pdy.jsp");
			  
		   }
		else if("3".equals(result)){
			   System.out.println("**************3");
			   request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("role_id", role_id);
				request.getSession().setAttribute("area",area);
				request.getSession().setAttribute("sys", "0");
			   response.sendRedirect(basePath+"admin/weixiu.jsp");
		   }
		else if("5".equals(result)){
			   System.out.println("**************5");
			   request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("role_id", role_id);
				request.getSession().setAttribute("area",area);
				request.getSession().setAttribute("sys", "0");
			   response.sendRedirect(basePath+"admin/leader.jsp");
		   }
		else if("6".equals(result)){
			   System.out.println("**************5");
			   request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("role_id", role_id);
				request.getSession().setAttribute("area",area);
				request.getSession().setAttribute("sys", "0");
			   response.sendRedirect(basePath+"admin/suguan.jsp");
		   }
		   
		   else{
			   request.getSession().setAttribute("client_role_id","4");
				request.getSession().setAttribute("client_id",username);
				request.getSession().setAttribute("client_name",name);
				request.getSession().setAttribute("inside","yes");
			    response.sendRedirect(basePath+"client/client.jsp");
		   }
				
	
	

}
	
out.flush();
out.close();
}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}

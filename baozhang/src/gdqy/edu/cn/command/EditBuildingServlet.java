package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import gdqy.edu.cn.util.getRemortIP;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditBuildingServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public EditBuildingServlet() {
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

		response.setContentType("text/html");     
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		
		//记录日志
		String user_name=(String)request.getSession().getAttribute("username");
		String name1=(String)request.getSession().getAttribute("name");
		 (new AdminService()).log(user_name,name1,"楼栋信息修改",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));
		
		
		 String id= request.getParameter("id");
		 String building_name= request.getParameter("building_name");
		 String area1_id= request.getParameter("area1_id");
		 String area2_id= request.getParameter("area2_id");
		 String weixiu_id= request.getParameter("weixiu_id");
		
		 boolean rs=false;
		 int rs1=0;
    
    	 rs1 = (new AdminService()).editBuilding(id,building_name,area1_id,area2_id,weixiu_id,(String)request.getSession().getAttribute("sys"));
    
        
		if(rs1==1)
			  out.write("succ");
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

package gdqy.edu.cn.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminLogoutServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AdminLogoutServlet() {
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
		
		String sys = (String)request.getSession().getAttribute("sys");
		System.out.println("退出系统！"+sys);
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("name");
		request.getSession().removeAttribute("inside");
		request.getSession().removeAttribute("role_id");
		request.getSession().removeAttribute("sys");
		request.getSession().invalidate();
		if("0".equals(sys))
		response.sendRedirect("../login.jsp");
		else if ("1".equals(sys))
			response.sendRedirect("../net.jsp");
		
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
		PrintWriter out = response.getWriter();
		//System.out.println("退出系统！");
		
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("name");
		request.getSession().removeAttribute("inside");
		request.getSession().removeAttribute("role_id");
		request.getSession().invalidate();
		response.sendRedirect("../login.jsp");
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

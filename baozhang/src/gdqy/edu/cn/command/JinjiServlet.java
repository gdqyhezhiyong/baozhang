package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import gdqy.edu.cn.util.getRemortIP;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JinjiServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public JinjiServlet() {
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
		 (new AdminService()).log(user_name,name1,"报修单紧急情况设置",(new getRemortIP()).getRemoteAddress(request),(String)request.getSession().getAttribute("sys"));
		
		 String ids= request.getParameter("ids");
		 String level= request.getParameter("level");
        System.out.println("bill id："+ids);
        String [] id=ids.split(",");
        int count=0;
        for(int i=0;i<id.length;i++){
       int rs = (new AdminService()).Jinjidan(id[i],level);
       count++;
        }
			out.write(""+count);
			
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

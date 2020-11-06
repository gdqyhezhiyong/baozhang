package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.ClientService2;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditRegServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public EditRegServlet() {
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
		
		 String name= request.getParameter("name");
		 String phone= request.getParameter("phone");
		 
		 String project1= request.getParameter("project1");
		 String project2= request.getParameter("project2");
		 String project3= request.getParameter("project3");
		 String project1_id= request.getParameter("project1_id");
		 String project2_id= request.getParameter("project2_id");
		 String project3_id= request.getParameter("project3_id");
		 String description= request.getParameter("description");
		 String order_time= request.getParameter("order_time");
		 String order_date= request.getParameter("order_date");
		 String bz_id= request.getParameter("bz_id");
		 String id= request.getParameter("id");
		 String building= request.getParameter("building");
		 String building_id= request.getParameter("building_id").trim();
		 String area1= request.getParameter("area1");
		 String area2= request.getParameter("area2");
		 String area1_id= request.getParameter("area1_id");
		 String area2_id= request.getParameter("area2_id");
		 String floor= request.getParameter("floor");
		 String room= request.getParameter("room");
		 
		// System.out.println("传过来id:"+id);
        // System.out.println("name:"+name+"phone:"+phone+"project2:"+project2+"description:"+description+"order_time:"+order_time+"address:"+address);
		
    	int rs1 = (new ClientService2()).editBill(id,bz_id,name,phone,description,order_time,building,building_id,area2,area1, project1,project2,project3,project1_id,project2_id,project3_id,floor,room,area1_id,area2_id);
   
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

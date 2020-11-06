package gdqy.edu.cn.command;

import gdqy.edu.cn.modle.Category;
import gdqy.edu.cn.serviceImp.ClientService2;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class CategoryServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CategoryServlet() {
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
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String p_id = request.getParameter("p_id");
		String sys = (String) request.getSession().getAttribute("sys");
		if (sys == null || "".equals(sys))
			sys = request.getParameter("sys");
		// System.out.println("request --- sys:"+request.getParameter("sys"));
		List<Category> list = null;

		list = (new ClientService2()).getCategory(p_id, sys);

		// System.out.println("list:"+list);
		JSONArray ja = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			ja.add(list.get(i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("project", ja);
		String output = jb.toString();
		// System.out.println(output);
		out.write(output);
		out.close();

	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String p_id = request.getParameter("p_id");
		String sys = (String) request.getSession().getAttribute("sys");
		if (sys == null || "".equals(sys))
			sys = request.getParameter("sys");
		// System.out.println("request --- sys:"+request.getParameter("sys"));
		List<Category> list = null;

		list = (new ClientService2()).getCategory(p_id, sys);

		// System.out.println("list:"+list);
		JSONArray ja = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			ja.add(list.get(i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("project", ja);
		String output = jb.toString();
		// System.out.println(output);
		out.write(output);
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}

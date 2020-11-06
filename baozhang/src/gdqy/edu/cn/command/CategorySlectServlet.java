package gdqy.edu.cn.command;

import gdqy.edu.cn.modle.Category;
import gdqy.edu.cn.serviceImp.AdminService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class CategorySlectServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CategorySlectServlet() {
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
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		int start = Integer.parseInt(request.getParameter("start"));
    	int limit = Integer.parseInt(request.getParameter("limit"));
    	String p_id = request.getParameter("p_id");
    	String pp_id = request.getParameter("pp_id");
		//System.out.println("start:"+start);
		//System.out.println("limit:"+limit);
		List<Category> list=null;
		if(p_id==null||"".equals(p_id)){
			list = list = (new AdminService()).getCategory((String)request.getSession().getAttribute("sys"));
		}else{
			list = list = (new AdminService()).getCategory(p_id,pp_id,(String)request.getSession().getAttribute("sys"));
		}
            
       
		
		JSONArray ja = new JSONArray();
		for(int i=0;i<limit;i++){
			if(start+i==list.size())break;
			ja.add(list.get(start+i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("category", ja);
		String output = jb.toString();
		//System.out.println(output);
		out.write(output);
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
		
		int start = Integer.parseInt(request.getParameter("start"));
    	int limit = Integer.parseInt(request.getParameter("limit"));
    	String p_id = request.getParameter("p_id");
    	String pp_id = request.getParameter("pp_id");
		//System.out.println("start:"+start);
		//System.out.println("limit:"+limit);
		List<Category> list=null;
		if(p_id==null||"".equals(p_id)){
			list = list = (new AdminService()).getCategory((String)request.getSession().getAttribute("sys"));
		}else{
			list = list = (new AdminService()).getCategory(p_id,pp_id,(String)request.getSession().getAttribute("sys"));
		}
            
       
		
		JSONArray ja = new JSONArray();
		for(int i=0;i<limit;i++){
			if(start+i==list.size())break;
			ja.add(list.get(start+i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("category", ja);
		String output = jb.toString();
		//System.out.println(output);
		out.write(output);
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

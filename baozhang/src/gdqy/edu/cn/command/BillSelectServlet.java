package gdqy.edu.cn.command;

import gdqy.edu.cn.modle.Bill;
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

public class BillSelectServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public BillSelectServlet() {
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
		System.out.println("进入servlet get方法！");
		response.setContentType("text/html");     
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String user_name = request.getParameter("user_name");
		String weixiu_id = request.getParameter("weixiu_id");
		String project1 = request.getParameter("project1");
		String sort = request.getParameter("sort");
		String area = request.getParameter("area");
		if("area2".equals(sort.trim())){
			sort="area2_name";
		}
		String dir = request.getParameter("dir");
		int start = Integer.parseInt(request.getParameter("start"));
    	int limit = Integer.parseInt(request.getParameter("limit"));
    	System.out.println("user_name:"+user_name);
    	System.out.println("sys:"+request.getParameter("sys"));
    	//System.out.println("area:"+area);
		List<Bill> list=null;
           if(user_name==null){
        	   if((weixiu_id==null||"".equals(weixiu_id.trim()))&&(project1==null||"".equals(project1.trim())))
        		list = (new ClientService2()).getAllBills(area,sort,dir,(String)request.getSession().getAttribute("sys"));
        	   else list = (new ClientService2()).getAllBills(area,weixiu_id,sort,dir,project1,(String)request.getSession().getAttribute("sys"));
           }
           else list = (new ClientService2()).getMyBill(user_name,sort,dir,request.getParameter("sys"));
       
		
		JSONArray ja = new JSONArray();
		for(int i=0;i<limit;i++){
			if(start+i==list.size())break;
			ja.add(list.get(start+i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("bill", ja);
		String output = jb.toString();
	
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
		//System.out.println("进入servlet post方法！");
		response.setContentType("text/html");     
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String user_name = request.getParameter("user_name");
		String weixiu_id = request.getParameter("weixiu_id");
		String project1 = request.getParameter("project1");
		String sort = request.getParameter("sort");
		String area = request.getParameter("area");
		if("area2".equals(sort.trim())){
			sort="area2_name";
		}
		String dir = request.getParameter("dir");
		int start = Integer.parseInt(request.getParameter("start"));
    	int limit = Integer.parseInt(request.getParameter("limit"));
    	System.out.println("user_name:"+user_name);
    	System.out.println("sys:"+request.getParameter("sys"));
    	//System.out.println("area:"+area);
		List<Bill> list=null;
           if(user_name==null){
        	   if((weixiu_id==null||"".equals(weixiu_id.trim()))&&(project1==null||"".equals(project1.trim())))
        		list = (new ClientService2()).getAllBills(area,sort,dir,(String)request.getSession().getAttribute("sys"));
        	   else list = (new ClientService2()).getAllBills(area,weixiu_id,sort,dir,project1,(String)request.getSession().getAttribute("sys"));
           }
           else list = (new ClientService2()).getMyBill(user_name,sort,dir,request.getParameter("sys"));
       
		
		JSONArray ja = new JSONArray();
		for(int i=0;i<limit;i++){
			if(start+i==list.size())break;
			ja.add(list.get(start+i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("bill", ja);
		String output = jb.toString();
	
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

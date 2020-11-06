package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.modle.Logs;
import gdqy.edu.cn.modle.Tousu;
import gdqy.edu.cn.serviceImp.AdminService;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TousuSelectServlet extends HttpServlet {
	public List<Tousu> getTousu( String start_time, String end_time, String sort, String dir)
	  {
	    List lists = new ArrayList();
	    String sql = "select * from t_complaint where";
	   
	    if ((start_time != null) && (!("".equals(start_time)))) {
	      sql = sql + " CONVERT(char(10),create_time,120)>='" + start_time + "'  and";
	    }
	    if ((end_time != null) && (!("".equals(end_time)))) {
	      sql = sql + " CONVERT(char(10),create_time,120)<='" + end_time + "'  and";
	    }
	    sql = sql.substring(0, sql.length() - 5);
	    sql = sql + " order by " + sort + " " + dir;
	    try
	    {
	      ResultSet rs = DBHelper.getConnection().createStatement()
	        .executeQuery(sql);

	      while (rs.next()) {
	    	  Tousu l = new Tousu();
	    	  l.setId(rs.getString("id"));
	        l.setBz_id(rs.getString("bz_id"));
	        l.setName(rs.getString("name"));
	        l.setPhone(rs.getString("phone").trim());
	        l.setCreate_time(rs.getString("create_time").trim());
	        l.setDescription(rs.getString("description").trim());
	        l.setAddr(rs.getString("area1").trim()+"-"+rs.getString("area2").trim()+"-"+rs.getString("building").trim()+"-"+rs.getString("floor").trim()+rs.getString("room").trim());
	        lists.add(l);
	      }
	    }
	    catch (SQLException e) {
	      e.printStackTrace();
	    }

	    return lists;
	  }

	/**
	 * Constructor of the object.
	 */
	public TousuSelectServlet() {
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
		String user_name = request.getParameter("user_name");
		String start_time= request.getParameter("start_time");
		String end_time= request.getParameter("end_time");
		
		
		String sort= request.getParameter("sort");
		if("username".equals(sort)){
			sort="user_name";
		}
		if("time".equals(sort)){
			sort="op_time";
		}
		String dir= request.getParameter("dir");
		//System.out.println("sort:"+sort);
		//System.out.println("dir:"+dir);
		
		int start = Integer.parseInt(request.getParameter("start"));
    	int limit = Integer.parseInt(request.getParameter("limit"));
    	
		List<Tousu> list=null;
           list = getTousu(start_time,end_time,sort,dir);
		JSONArray ja = new JSONArray();
		for(int i=0;i<limit;i++){
			if(start+i==list.size())break;
			ja.add(list.get(start+i));
		}
		JSONObject jb = new JSONObject();
		jb.put("result", list.size());
		jb.put("tousus", ja);
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
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
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

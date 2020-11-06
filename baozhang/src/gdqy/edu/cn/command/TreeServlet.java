package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TreeServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TreeServlet() {
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
		JSONArray category1 = new JSONArray();
		JSONObject category2 = new JSONObject();
		category2.put("id", "1");
		category2.put("text", "根目录");
		category2.put("leaf", true);
		category1.add(category2);
		//System.out.println(category1.toString());
		out.write(category2.toString());
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
		String sys = (String)request.getSession().getAttribute("sys");
		//System.out.println("获得编辑树："+sys);
		String sql=null;
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String id="";
		String name="";
		String p_id="";
		String c_level="";
		JSONArray category1 = new JSONArray();
		
		sql="select * from t_category where p_id=0 and sys="+sys;
		try {
			rs = DBHelper.getConnection().createStatement().executeQuery(sql);
			while(rs.next()){
				id = rs.getString("id");
				name = rs.getString("name");
				c_level = rs.getString("c_level");
				JSONObject c = new JSONObject();
				c.put("id", id);
				c.put("text", name);
				c.put("c_level", c_level);
				JSONArray category2 = new JSONArray();
				sql="select * from t_category where p_id="+id+" and sys = "+sys;
				rs1 = DBHelper.getConnection().createStatement().executeQuery(sql);
				while(rs1.next()){
					String id1 = rs1.getString("id");
					String name1 = rs1.getString("name");
					String c_level1 = rs1.getString("c_level");
					JSONObject c1 = new JSONObject();
					c1.put("id", id1);
					c1.put("text", name1);
					c1.put("c_level", c_level1);
					
					JSONArray category3 = new JSONArray();
					sql="select * from t_category where p_id="+id1+" and sys = "+sys;
					rs2 = DBHelper.getConnection().createStatement().executeQuery(sql);
					while(rs2.next()){
						String id2 = rs2.getString("id");
						String name2 = rs2.getString("name");
						String c_level2 = rs2.getString("c_level");
						String jinji = rs2.getString("jinji");
						JSONObject c2 = new JSONObject();
						c2.put("id", id2);
						c2.put("text", name2);
						c2.put("c_level", c_level2);
						c2.put("leaf", true);
						c2.put("jinji", jinji);
						category3.add(c2);
					}
					c1.put("children", category3);
					category2.add(c1);
				}
				c.put("children", category2);
				category1.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		out.write(category1.toString());
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

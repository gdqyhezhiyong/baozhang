package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.serviceImp.ClientService2;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Complaint extends HttpServlet {
	
	public boolean checkTousu(String bz_id,String addr,String descriptions)
	{
		boolean r = false;
		String sql = "select * from t_complaint where bz_id='"+bz_id+"' and "+
		"ltrim(rtrim(area1))+ ltrim(rtrim(area2))+ltrim(rtrim(building))+ltrim(rtrim(floor))+ltrim(rtrim(room))='"+
		addr+"' and description='"+descriptions+"'";
		try {
			ResultSet rs = DBHelper.getConnection().createStatement().executeQuery(sql);
			if(rs.next()) r=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return r;
	}

	/**
	 * Constructor of the object.
	 */
	public Complaint() {
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
	    
	   // name:name,
       // phone:phone,
        //description:description,
        //bz_id:bz_id,
        //area1:area1,
        //area1_id:area1_id,
       // area2:area2,
       // area2_id:area2_id,
        //building:building,
       // building_id:building_id,
        //floor:floor,
        //room:room,
       // sys:"1"
	    
	    //广州
	   // 西校区
	   // 1
	    //西校区
	   // 西校37号楼
	    String name = request.getParameter("name").trim();
	    String phone = request.getParameter("phone").trim();
	    String description = request.getParameter("description").trim();
	    String bz_id = request.getParameter("bz_id").trim();
	    String area1 = request.getParameter("area1").trim();
	    //System.out.println(area1);
	    String area2 = request.getParameter("area2").trim();
	   // System.out.println(area2);
	    String area1_id = request.getParameter("area1_id").trim();
	   // System.out.println(area1_id);
	    String area2_id = request.getParameter("area2_id").trim();
	    //System.out.println(area2_id);
	    String building = request.getParameter("building").trim();
	   // System.out.println(building);
	    String building_id = request.getParameter("building_id").trim();
	    String floor = request.getParameter("floor").trim();
	    String room = request.getParameter("room").trim();
	    String sys = request.getParameter("sys").trim();
	    String addr = area1+area2+building+floor+room;
	    if ("1".equals(sys))
	      sys = "网络报障系统";
	    else
	    	sys="后勤报障系统";
	    int rs1 = 0;
	    String sql = "INSERT INTO t_complaint (bz_id, name,phone,area1,area2,building_id,building,floor,room,sys,create_time,description)"+
	                 " VALUES ('"+bz_id+"','"+ name+"','"+phone+"','"+area1+"','"+area2+"',"+building_id+",'"+building+"','"+floor+"','"+room+"','"+sys+"',getdate(),'"+description+"')";
	    
	    //System.out.println(sql);
	    if(!checkTousu(bz_id,addr,description))
    	{
	    try {
	    	
	    	 DBHelper.getConnection().createStatement().execute(sql);
	    	 rs1 = 1;
	    	
		} catch (SQLException e) {
			e.printStackTrace();
			rs1 = 0; 
		}
    	}else{
    		rs1 = 2;
    	}

	    
	    if (rs1 == 1)
	      out.write("s");
	    else if (rs1 == 2)
		      out.write("r");
	    else 
		      out.write("f");
	    
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

package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.ClientService2;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegServlet extends HttpServlet
{
  public void destroy()
  {
    super.destroy();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    
	  response.setContentType("text/html");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();

	    String name = request.getParameter("name");
	    String phone = request.getParameter("phone");

	    String project1 = request.getParameter("project1");
	    String project2 = request.getParameter("project2");
	    String project3 = request.getParameter("project3");
	    String project1_id = request.getParameter("project1_id");
	    String project2_id = request.getParameter("project2_id");
	    String project3_id = request.getParameter("project3_id");

	    String description = request.getParameter("description");
	    String order_time = request.getParameter("order_time");
	    if (order_time == null) {
	      int n = new Date().getHours();
	      if (n < 10)
	        order_time = "0" + n + ":00" + "-" + "0" + n + ":00";
	      else {
	        order_time = n + ":00" + "-" + n + ":00";
	      }
	    }
	    String weixiu_date = request.getParameter("weixiu_date");
	    if ((weixiu_date != null) && (weixiu_date.length() > 10)) {
	      weixiu_date = request.getParameter("weixiu_date").substring(0, 10);
	    }
	    else {
	      weixiu_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	    }

	    String bz_id = request.getParameter("bz_id");
	    String logins = request.getParameter("logins");

	    String building = request.getParameter("building");
	    String building_id = request.getParameter("building_id").trim();
	    String area1 = request.getParameter("area1");
	    String area2 = request.getParameter("area2");
	    String area1_id = request.getParameter("area1_id");
	    String area2_id = request.getParameter("area2_id");
	    String floor = request.getParameter("floor");
	    String room = request.getParameter("room");
	    String inside = request.getParameter("inside");
	    String sys = request.getParameter("sys");
	    if ((sys == null) || ("".equals(sys)))
	      sys = (String)request.getSession().getAttribute("sys");
	    boolean rs = false;
	    int rs1 = 0;
	    if ("no".equals(inside))
	    {
	      new ClientService2().addUser(bz_id, name, phone, area1, area2, building, building_id, floor, room, area1_id, area2_id);
	      rs1 = new ClientService2().saveBill(bz_id, name, phone, description, order_time, building, building_id, area2, area1, project1, project2, project3, project1_id, project2_id, project3_id, floor, room, area1_id, area2_id, sys, weixiu_date);
	    }
	    else if (logins.equals("once"))
	    {
	      rs = new ClientService2().updateUser(bz_id, name, phone, area1, area2, building, building_id, floor, room, area1_id, area2_id);
	      if (rs) rs1 = new ClientService2().saveBill(bz_id, name, phone, description, order_time, building, building_id, area2, area1, project1, project2, project3, project1_id, project2_id, project3_id, floor, room, area1_id, area2_id, sys, weixiu_date);
	    }
	    else {
	      rs1 = new ClientService2().saveBill(bz_id, name, phone, description, order_time, building, building_id, area2, area1, project1, project2, project3, project1_id, project2_id, project3_id, floor, room, area1_id, area2_id, sys, weixiu_date);
	    }

	    if (rs1 == 0)
	      out.write("rereg");
	    if (rs1 == 1)
	      out.write("succ");
	    out.close();
    
   
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();

    String name = request.getParameter("name");
    String phone = request.getParameter("phone");

    String project1 = request.getParameter("project1");
    String project2 = request.getParameter("project2");
    String project3 = request.getParameter("project3");
    String project1_id = request.getParameter("project1_id");
    String project2_id = request.getParameter("project2_id");
    String project3_id = request.getParameter("project3_id");

    String description = request.getParameter("description");
    String order_time = request.getParameter("order_time");
    if (order_time == null) {
      int n = new Date().getHours();
      if (n < 10)
        order_time = "0" + n + ":00" + "-" + "0" + n + ":00";
      else {
        order_time = n + ":00" + "-" + n + ":00";
      }
    }
    String weixiu_date = request.getParameter("weixiu_date");
    if ((weixiu_date != null) && (weixiu_date.length() > 10)) {
      weixiu_date = request.getParameter("weixiu_date").substring(0, 10);
    }
    else {
      weixiu_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    }

    String bz_id = request.getParameter("bz_id");
    String logins = request.getParameter("logins");

    String building = request.getParameter("building");
    String building_id = request.getParameter("building_id").trim();
    String area1 = request.getParameter("area1");
    String area2 = request.getParameter("area2");
    String area1_id = request.getParameter("area1_id");
    String area2_id = request.getParameter("area2_id");
    String floor = request.getParameter("floor");
    String room = request.getParameter("room");
    String inside = request.getParameter("inside");
    String sys = request.getParameter("sys");
    if ((sys == null) || ("".equals(sys)))
      sys = (String)request.getSession().getAttribute("sys");
    boolean rs = false;
    int rs1 = 0;
    if ("no".equals(inside))
    {
      new ClientService2().addUser(bz_id, name, phone, area1, area2, building, building_id, floor, room, area1_id, area2_id);
      rs1 = new ClientService2().saveBill(bz_id, name, phone, description, order_time, building, building_id, area2, area1, project1, project2, project3, project1_id, project2_id, project3_id, floor, room, area1_id, area2_id, sys, weixiu_date);
    }
    else if (logins.equals("once"))
    {
      rs = new ClientService2().updateUser(bz_id, name, phone, area1, area2, building, building_id, floor, room, area1_id, area2_id);
      if (rs) rs1 = new ClientService2().saveBill(bz_id, name, phone, description, order_time, building, building_id, area2, area1, project1, project2, project3, project1_id, project2_id, project3_id, floor, room, area1_id, area2_id, sys, weixiu_date);
    }
    else {
      rs1 = new ClientService2().saveBill(bz_id, name, phone, description, order_time, building, building_id, area2, area1, project1, project2, project3, project1_id, project2_id, project3_id, floor, room, area1_id, area2_id, sys, weixiu_date);
    }

    if (rs1 == 0)
      out.write("rereg");
    if (rs1 == 1)
      out.write("succ");
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
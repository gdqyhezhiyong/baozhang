package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateRegServlet extends HttpServlet
{
  public void destroy()
  {
    super.destroy();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out
      .println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
    out.println("<HTML>");
    out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
    out.println("  <BODY>");
    out.print("    This is ");
    out.print(super.getClass());
    out.println(", using the GET method");
    out.println("  </BODY>");
    out.println("</HTML>");
    out.flush();
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
    String bz_id = request.getParameter("bz_id");
    String id = request.getParameter("id");
    String sys = request.getParameter("sys");
    if ((sys == null) || ("".equals(sys)))
      sys = (String)request.getSession().getAttribute("sys");
    String project1 = request.getParameter("project1");
    String project2 = request.getParameter("project2");
    String project3 = request.getParameter("project3");
    String descriptions = request.getParameter("descriptions");
    String time = request.getParameter("time");
    String weixiu_date = request.getParameter("weixiu_date");
    if ((weixiu_date != null) && (!("".equals(weixiu_date))) && (weixiu_date.length() > 10)) {
      weixiu_date = request.getParameter("weixiu_date").substring(0, 10);
    }
    String building = request.getParameter("building");
    String building_id = request.getParameter("building_id").trim();

    String area1 = request.getParameter("area1");
    if ("1".equals(area1)) area1 = "广州";
    else area1 = "南海";
    String area2 = request.getParameter("area2");
    String floor = request.getParameter("floor");
    String room = request.getParameter("room");
    String project3_id = request.getParameter("project3_id");

    int rs1 = new AdminService().editBill(id, bz_id, name, phone, descriptions, time, building, building_id, area2, project1, project2, project3, floor, room, project3_id, weixiu_date, area1, sys);

    if (rs1 == 1)
      out.write("succ");
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
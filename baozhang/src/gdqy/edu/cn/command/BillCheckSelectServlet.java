package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class BillCheckSelectServlet extends HttpServlet
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
    String weixiu_id = request.getParameter("weixiu_id");

    String area2 = request.getParameter("area2");
    String print = request.getParameter("print");

    String project1_name = request.getParameter("project1_name");
    String area1 = request.getParameter("area1");
    String building = request.getParameter("building");
    String start_time = request.getParameter("start_time");
    String end_time = request.getParameter("end_time");
    String sort = request.getParameter("sort");
    String bill_number = request.getParameter("bill_number");
    if ("area2".equals(sort)) {
      sort = "area2_name";
    }

    if ("area1".equals(sort)) {
      sort = "area1_name";
    }
    String dir = request.getParameter("dir");

    List list = null;

    if ((weixiu_id == null) && (area2 == null) && (project1_name == null))
      list = new AdminService().getAllBills(sort, dir, print, (String)request.getSession().getAttribute("sys"), area1);
    else list = new AdminService().getAllBills(weixiu_id, area1, area2, building, start_time, end_time, sort, dir, bill_number, print, project1_name, (String)request.getSession().getAttribute("sys"));

    int start = Integer.parseInt(request.getParameter("start"));
    int limit = Integer.parseInt(request.getParameter("limit"));

    JSONArray ja = new JSONArray();
    for (int i = 0; i < limit; ++i) {
      if (start + i == list.size()) break;
      ja.add(list.get(start + i));
    }

    JSONObject jb = new JSONObject();
    jb.put("result", Integer.valueOf(list.size()));
    jb.put("bill", ja);
    String output = jb.toString();

    out.write(output);
    out.close();
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
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
    out.println(", using the POST method");
    out.println("  </BODY>");
    out.println("</HTML>");
    out.flush();
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
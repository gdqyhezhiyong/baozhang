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

public class MyBillSelectServlet extends HttpServlet
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

    String start_time = request.getParameter("start_time");
    String end_time = request.getParameter("end_time");
    String sort = request.getParameter("sort");
    String dir = request.getParameter("dir");

    List list = null;

    list = new AdminService().findBills("", "", "", "", weixiu_id, "", start_time, end_time, sort, dir, "", (String)request.getSession().getAttribute("sys"));

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
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

public class CateServlet  extends HttpServlet
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
    String star_time = request.getParameter("start");
    String end_time = request.getParameter("end");
    String weixiu_id = request.getParameter("weixiu_id");
    String area = request.getParameter("area");
    if ("1".equals(area)) area = "广州";
    else if ("2".equals(area)) area = "南海";
    else area = "";

    List list = null;
    if ((star_time == null) && (end_time == null) && (weixiu_id == null) && (((area == null) || ("".equals(area)))))
    {
      list = new AdminService().getCountCategory((String)request.getSession().getAttribute("sys"));
    }
    else list = new AdminService().getCountCategory(star_time, end_time, weixiu_id, (String)request.getSession().getAttribute("sys"), area);

    JSONArray ja = new JSONArray();
    for (int i = 0; i < list.size(); ++i) {
      ja.add(list.get(i));
    }
    JSONObject jb = new JSONObject();
    jb.put("result", Integer.valueOf(list.size()));
    jb.put("category", ja);
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
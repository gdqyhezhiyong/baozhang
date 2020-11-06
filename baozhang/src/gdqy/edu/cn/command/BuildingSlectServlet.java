package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class BuildingSlectServlet extends HttpServlet
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
    int start = Integer.parseInt(request.getParameter("start"));
    Map conditions = new HashMap();
    String area_id = request.getParameter("area_id");
    String weixiu = request.getParameter("weixiu");
    String area = request.getParameter("area");
    if ("广州".equals(area)) area = "1";
    if ("南海".equals(area)) area = "2";
    String role_id = request.getParameter("role_id");
    int limit = Integer.parseInt(request.getParameter("limit"));
    System.out.println("role_id: " + role_id);
    System.out.println("area: " + area);

    List list = null;
    if ((request.getParameter("area_id") == null) && (request.getParameter("weixiu") == null))
    {
      list = new AdminService().findAllBuilding((String)request.getSession().getAttribute("sys"), area, role_id);
    }
    else list = new AdminService().findAllByAttributs(area_id, weixiu, (String)request.getSession().getAttribute("sys"));

    JSONArray ja = new JSONArray();
    for (int i = 0; i < limit; ++i) {
      if (start + i == list.size()) break;
      ja.add(list.get(start + i));
    }
    JSONObject jb = new JSONObject();
    jb.put("result", Integer.valueOf(list.size()));
    jb.put("building", ja);
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
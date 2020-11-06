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

public class SatisfyServlet extends HttpServlet
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
      list = new AdminService().getSatisfy((String)request.getSession().getAttribute("sys"));
    }
    else list = new AdminService().getSatisfy(star_time, end_time, weixiu_id, (String)request.getSession().getAttribute("sys"), area);

    JSONArray ja = new JSONArray();
    for (int i = 0; i < list.size(); ++i) {
      ja.add(list.get(i));
    }
    JSONObject jb = new JSONObject();

    JSONObject jb1 = new JSONObject();
    jb1.put("caption", "满意度情况统计");
    jb1.put("formatNumberScale", "0");
    jb1.put("numberSuffix ", "件");
    jb1.put("baseFontSize ", "12");
    jb1.put("showLegend", "1");
    jb1.put("legendPosition", "0");
    jb1.put("showLabels", "1");
    jb1.put("showValues", "1");
    jb1.put("pieRadius", "200");
    jb.put("chart", jb1);
    jb.put("data", ja);
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
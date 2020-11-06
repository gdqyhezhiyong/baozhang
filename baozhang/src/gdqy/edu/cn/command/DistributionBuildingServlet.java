package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import gdqy.edu.cn.util.getRemortIP;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DistributionBuildingServlet extends HttpServlet
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

    String user_name = (String)request.getSession().getAttribute("username");
    String name1 = (String)request.getSession().getAttribute("name");
    new AdminService().log(user_name, name1, "楼栋分配", new getRemortIP().getRemoteAddress(request), (String)request.getSession().getAttribute("sys"));

    String ids = request.getParameter("ids");
    String weixiu_id = request.getParameter("weixiu_id");

    String[] id = ids.split(",");
    int count = 0;
    for (int i = 0; i < id.length; ++i) {
      int rs = new AdminService().distributionBuilding(id[i], weixiu_id);
      ++count;
    }

    out.write(count);

    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
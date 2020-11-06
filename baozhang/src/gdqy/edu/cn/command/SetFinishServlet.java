package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import gdqy.edu.cn.util.getRemortIP;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SetFinishServlet extends HttpServlet
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
    String sys = (String)request.getSession().getAttribute("sys");

    String user_name = (String)request.getSession().getAttribute("username");
    String name1 = (String)request.getSession().getAttribute("name");
    new AdminService().log(user_name, name1, "报修单为完成状态确认", new getRemortIP().getRemoteAddress(request), sys);

    String ids = request.getParameter("ids");
    String finish_time = request.getParameter("finish_time");
    String work_hours = request.getParameter("work_hours");
    String weixiu_id = request.getParameter("weixiu_id");
    //System.out.println("完成时间" + finish_time);
   // System.out.println("完成工时" + work_hours);
    //System.out.println("完成维修人" + weixiu_id);
    int count = 0;
    if ("1".equals(sys)) {
      String project1 = request.getParameter("project1");
      if ("1".equals(project1))
        project1 = "交换机故障";
      else if ("2".equals(project1))
      {
        project1 = "宽带帐号故障";
      } else if ("3".equals(project1))
        project1 = "病毒感染";
      else if ("4".equals(project1))
        project1 = "电脑故障";
      else if ("5".equals(project1))
        project1 = "信息口故障";
      else if ("6".equals(project1))
        project1 = "线路故障";
      else {
        project1 = "其他故障";
      }
      String solution = request.getParameter("solution");

      String[] id = ids.split(",");

      for (int i = 0; i < id.length; ++i) {
        int rs = new AdminService().setFinish1(id[i], finish_time, project1, solution);
        ++count;
      }
    }
    else {
      String[] id = ids.split(",");

      for (int i = 0; i < id.length; ++i) {
        int rs = new AdminService().setFinish(id[i], finish_time, weixiu_id, work_hours);
        ++count;
      }

    }

    out.write(count);

    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.ClientService2;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NetInfoChangeServlet extends HttpServlet
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
    String grade = request.getParameter("grade");
    String departments = request.getParameter("departments");
    String classes = request.getParameter("classes");
    String user_name = request.getParameter("user_name");
    String sex = request.getParameter("sex");
    String sys = (String)request.getSession().getAttribute("sys");
    if (sys == null) {
      sys = request.getParameter("sys");
    }

    boolean rs = false;

    rs = new ClientService2().net_changeInfo(user_name, name, phone, sex, grade, departments, classes, sys);
    if (rs) {
      out.write("succ");
    }
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
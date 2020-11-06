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

public class ChangeUserServlet extends HttpServlet
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

    String username = request.getParameter("username");
    String name = request.getParameter("name_new");
    String phone = request.getParameter("phone_new");
    String role = request.getParameter("role_new");
    String area = request.getParameter("area");
    String sys = (String)request.getSession().getAttribute("sys");
    System.out.println(sys);

    String user_name = (String)request.getSession().getAttribute("username");
    String name1 = (String)request.getSession().getAttribute("name");
    new AdminService().log(user_name, name1, "用户信息修改", new getRemortIP().getRemoteAddress(request), (String)request.getSession().getAttribute("sys"));
    boolean rs = false;
    int rs1 = 0;
    rs1 = new AdminService().ChangeUser(username, name, phone, role, sys, area);

    if (rs1 == 1)
      out.write("succ");
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.AdminService;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CategoryCRUDServlet extends HttpServlet
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
    String id = request.getParameter("id");
    String operation = request.getParameter("operation");
    String level = request.getParameter("level");
    String c_name = request.getParameter("c_name");
    String jinji = request.getParameter("jinji");
    String weixiu_id = request.getParameter("weixiu_id");
    System.out.println("等级level:" + level);
    System.out.println("jinji:" + jinji);
    System.out.println("c_name:" + c_name);
    System.out.println("weixiu_id:" + weixiu_id);
    int rs = 0;
    if ("C".equals(operation)) {
      rs = new AdminService().addCategory(c_name, id, jinji, (String)request.getSession().getAttribute("sys"), weixiu_id);

      out.write("succ");
    }

    if ("D".equals(operation)) {
      rs = new AdminService().delteCategory(id, level);

      out.write("succ");
    }
    if ("U".equals(operation)) {
      rs = new AdminService().updateCategory(c_name, id, jinji, weixiu_id, level);

      out.write("succ");
    }
    out.flush();
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetBuild extends HttpServlet
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
    String area = request.getParameter("area");
    String sql = "";
    ResultSet rs = null;
   // System.out.println("area:" + area);

    sql = "select buildname from build where area='" + area + "'";

    String output = "";
    try {
      rs = DBHelper.getConnection().createStatement().executeQuery(sql);
      while (rs.next())
      {
        output = output + rs.getString("buildname") + "| - |";
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    out.write(output);
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
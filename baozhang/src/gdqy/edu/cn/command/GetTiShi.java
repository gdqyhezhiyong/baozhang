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

public class GetTiShi extends HttpServlet
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
    String xm = request.getParameter("xm");
    String area = request.getParameter("area");
    String item = request.getParameter("item");
    String sql = "";
    ResultSet rs = null;
    if ("df".equals(xm)) {
      sql = "select startdate,enddate from df_import where status='开启' and area='" + area + "' and feename = '" + item + "'";
    }
    else {
      sql = "select startdate,enddate from sf_import where status='开启' and area='" + area + "' and feename='" + item + "'";
    }
    String output = "";
    System.out.println(sql);
    try {
      rs = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rs.next())
      {
        output = "该名目费用产生于 " + rs.getString("startdate").substring(0, 10) + "   至   " + rs.getString("enddate").substring(0, 10);
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
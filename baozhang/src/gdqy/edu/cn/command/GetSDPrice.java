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

public class GetSDPrice extends HttpServlet
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
    String sql = "";
    ResultSet rs = null;

    sql = "select detail,price from sysreg where sysname= '" + xm + "' and area='" + area + "'";
    String output = "";
    try {
      rs = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rs.next())
      {
        String price = rs.getString("price");
        if (price.indexOf(".") + 3 < price.length())
        {
          price = price.substring(0, price.indexOf(".") + 3);
        }
        output = rs.getString("detail") + "单价:" + price + "元";
      }
    } catch (SQLException e) {
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
package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class NetTreeServlet extends HttpServlet
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
    System.out.println("获得编辑树：" + sys);
    String sql = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    String id = "";
    String name = "";
    String p_id = "";
    String c_level = "";
    JSONArray category1 = new JSONArray();

    sql = "select * from t_category where p_id=0 and sys=" + sys;
    try {
      rs = DBHelper.getConnection().createStatement().executeQuery(sql);
      while (rs.next()) {
        id = rs.getString("id");
        name = rs.getString("name");
        c_level = rs.getString("c_level");
        JSONObject c = new JSONObject();
        c.put("id", id);
        c.put("text", name);
        c.put("c_level", c_level);
        c.put("leaf", Boolean.valueOf(true));
        category1.add(c);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    System.out.println(category1.toString());
    out.write(category1.toString());
    out.flush();
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
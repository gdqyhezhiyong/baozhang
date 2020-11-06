package gdqy.edu.cn.command;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.serviceImp.ClientService2;
import java.io.IOException;
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

public class NetLoginServlet extends HttpServlet
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
    response.setContentType("text/html;charset=UTF-8");
    response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    String password = request.getParameter("password");
    String username = request.getParameter("code");
    String sql = "select * from t_user where user_name='" + username + "' and sys=1";
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    ClientService2 client = new ClientService2();
    ResultSet rs = null;
    String result = client.login(username, password, "1");

    if (("11".equals(result)) || ("12".equals(result))) {
      response.sendRedirect(basePath + "net.jsp?result=" + result);
    }
    else
    {
      if ("4".equals(result))
        response.sendRedirect(basePath + "client/client.jsp");
      else if ("1".equals(result))
      {
        response.sendRedirect(basePath + "net/net_admin.jsp");
      }
      else if ("3".equals(result))
      {
        response.sendRedirect(basePath + "net/net_weixiu.jsp");
      }
      else if ("5".equals(result))
      {
        response.sendRedirect(basePath + "net/net_leader.jsp");
      }
      try {
        rs = DBHelper.getConnection().createStatement().executeQuery(sql);
        if (rs.next()) {
          request.getSession().setAttribute("name", rs.getString("name"));
          request.getSession().setAttribute("username", username);
          request.getSession().setAttribute("role_id", rs.getString("role_id"));
          request.getSession().setAttribute("sys", "1");
        }

      }
      catch (SQLException e)
      {
        e.printStackTrace();
      }

    }

    out.flush();
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
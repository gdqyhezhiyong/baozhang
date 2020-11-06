package gdqy.edu.cn.command;

import gdqy.edu.cn.serviceImp.ClientService2;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PinjiaServlet extends HttpServlet
{
  public void destroy()
  {
    super.destroy();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
	  response.setContentType("text/html");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();
	    String satisfy = request.getParameter("satisfy");
	    String suggestion = request.getParameter("suggestion");
	    String bz_id = request.getParameter("bz_id");
	    String bill_id = request.getParameter("bill_id");

	    int rs = new ClientService2().pinJia(bz_id, satisfy, suggestion, bill_id);
	    if (rs == 1)
	      out.write("1");
	    else
	      out.write("0");
	    out.close();
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    String satisfy = request.getParameter("satisfy");
    String suggestion = request.getParameter("suggestion");
    String bz_id = request.getParameter("bz_id");
    String bill_id = request.getParameter("bill_id");

    int rs = new ClientService2().pinJia(bz_id, satisfy, suggestion, bill_id);
    if (rs == 1)
      out.write("1");
    else
      out.write("0");
    out.close();
  }

  public void init()
    throws ServletException
  {
  }
}
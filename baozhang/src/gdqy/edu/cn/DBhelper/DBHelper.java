package gdqy.edu.cn.DBhelper;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBHelper {
	private static Connection conn = null;
	private DBHelper() {
		try {
			
			Properties pro = new Properties();
			InputStream is = this.getClass().getClassLoader().getResourceAsStream("dbconfig.properties");
			pro.load(is);
			String classDriver = pro.getProperty("classDriver");
			String connurl = pro.getProperty("connUrl");
		    String user = pro.getProperty("user");
			String password = pro.getProperty("password");
			//System.out.println(classDriver+"-"+connurl+"-"+dbname+"-"+password);
			Class.forName(classDriver).newInstance();
		
			conn = DriverManager.getConnection(connurl,user,password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	//if(conn!=null)System.out.print("连接成功");
		 
	}
	public static Connection getConnection(){
		if(conn==null){
		System.out.print("连接为空！");
			new DBHelper();
		} else
			try {
				if(conn.isClosed()){
					System.out.print("连接已经关闭！");
					new DBHelper();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return conn;
	}
	
	public static void close(){
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			conn=null;
		}
	}
	
}

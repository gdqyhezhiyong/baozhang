package gdqy.edu.cn.test;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.util.Tool;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;


public class Test {

	/**
	 * @param args
	 * @throws SQLException 
	 * @throws ParseException 
	 */
	public static void main(String[] args) throws SQLException, ParseException {
	
		//ClientService client =new ClientService();
		//System.out.println(client.login("hezhyong", "password"));
		//Date date1 = new SimpleDateFormat("yyyy-mm-dd HH:MM:SS").parse("2005-06-08 10:47:54");
	    // Date date2 = new SimpleDateFormat("yyyy-mm-dd HH:MM:SS").parse("2006-06-08 09:45:54");
		//System.out.print(date1.getMinutes()-date2.getMinutes());
		/*System.out.println(Tool.get_two_decimal_number("2.14444"));
		
		
		
		String sql= "select top 1 bz_name from t_bill";
    	ResultSet rs = DBHelper.getConnection().createStatement().executeQuery(sql);
    	while (rs.next()){
    		
    		System.out.println(rs.getString("bz_name"));
    	}*/
	//1001	& 1000 111      01
		int n=8;
		System.out.println(numberof1(n));
		
		System.out.println(n&(n-1));
		 
	}
	
	
	public static int numberof1(int n){
		int count =0;
		int k=0;
		while(n!=0){
			count++;
			n=n&(n-1);
		}
		return count;
	}

}

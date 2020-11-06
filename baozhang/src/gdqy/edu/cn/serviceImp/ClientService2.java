package gdqy.edu.cn.serviceImp;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.modle.Area;
import gdqy.edu.cn.modle.Bill;
import gdqy.edu.cn.modle.Building;
import gdqy.edu.cn.modle.Category;
import gdqy.edu.cn.modle.Floor;
import gdqy.edu.cn.service.UserServices;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClientService2 implements UserServices {

	//修改密码
	public boolean chang_password(String username, String password) {
		return false;
	}

	//获取楼栋数据
	public List<Building> getBuildings(String area_id){
			
	  List<Building> l= new ArrayList<Building>();
		String  sql="select * from t_building where area2_id ="+area_id;
		
		////System.out.println(sql);
		try {
			ResultSet rs = DBHelper.getConnection().createStatement()
					.executeQuery(sql);
			
			while (rs.next()) {
				Building b= new Building();
			    b.setId(rs.getString("id"));
			    b.setArea2_id(rs.getInt("area2_id"));
			    b.setName(rs.getString("name"));
				l.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return l;
	}

	//获取楼层数据
	public List<Floor> getFloors(String p_id){
		
		  List<Floor> l= new ArrayList<Floor>();
			String  sql="select * from t_floor where building_id ="+p_id;
			try {
				ResultSet rs = DBHelper.getConnection().createStatement().executeQuery(sql);
				while (rs.next()) {
					Floor f= new Floor();
				    f.setId(rs.getString("id"));
				    f.setBuilding_id(rs.getString("building_id"));
				    f.setCell(rs.getString("cell"));
					l.add(f);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return l;
		}
	
	//获取故障类别
	public List<Category> getCategory(String p_id,String sys){
			List<Category> l= new ArrayList<Category>();
			String  sql="select * from t_category where p_id ="+p_id+" and sys="+sys;
			////System.out.println("sql:"+sql);
			try {
				ResultSet rs = DBHelper.getConnection().createStatement().executeQuery(sql);
				while (rs.next()) {
					Category c= new Category();
				    c.setId(rs.getString("id"));
				    c.setLevel(rs.getString("c_level"));
				    c.setName(rs.getString("name"));
				    c.setP_id(rs.getString("p_id"));
				    c.setJinji(rs.getString("jinji"));
					l.add(c);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return l;
		}
	
	//登录
	public String login(String username, String password,String sys) {
		String flag="";
		ResultSet rs =null; 
		String sql="select * from t_user where user_name='"+username+"' and sys="+sys;
		////System.out.println("login function:"+sql);
		try {
			rs = DBHelper.getConnection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
			int i=0;
			
			while(rs.next()){
				i++;
			}
			
		if(i==0){
			flag = "11";
		} else{
			rs.beforeFirst();
			if(rs.next()){
				String psd=rs.getString("password");
				if(!password.equals(psd)){
					flag ="12";
				}
				else{
					flag=rs.getString("role_id");
				}
			}		
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBHelper.close();
		return flag;
	}

	//报修登记-网络故障
	public int saveBill(String bz_id,String name, String phone, String project2,
			String description, String order_date,String order_time, String address,String building_id) {
		     ResultSet rsset=null;
		     int rs=0;
		     String sql="";
		try {
			sql="select * from t_bill where status =0 and address='"+address+"'";
			rsset=DBHelper.getConnection().createStatement().executeQuery(sql);
			if(rsset.next())return 0;
			else{
				sql="insert into  t_bill(bz_id,bz_name,bz_phone,project_name,descriptions,order_date,order_time,address,building_id,status) values('"+bz_id+"','"+name+"','"+phone+"','"+project2+"','"+description+"','"+order_date+"','"+order_time+"','"+address+"','"+building_id+"', 0)";
					DBHelper.getConnection().createStatement().execute(sql);
					sql="select u.name as name,u.phon_number as phone,u.user_name as user_name from t_user u inner join t_building b on u.user_name=b.weixiu_id where b.id="+building_id;
					rsset= DBHelper.getConnection().createStatement().executeQuery(sql);
					if(rsset.next()){
						String weixiu_name=rsset.getString("name");
						String weixiu_phone =rsset.getString("phone");
						String weixiu_id= rsset.getString("user_name");
						sql="update t_bill set weixiu_name='"+weixiu_name+"', weixiu_id='"+weixiu_id+"',weixiu_phone='"+weixiu_phone+"' where bz_id='"+bz_id+"' and status=0";
						DBHelper.getConnection().createStatement().execute(sql);
					}
					rs=1;
			}
		} catch (SQLException e) {
		rs=2;
			e.printStackTrace();
		}
		return rs;
	}
	

	//获取我的故障单
	public List<Bill> getMyBill(String user_name,String sort,String dir,String sys) {
		 List<Bill> l= new ArrayList<Bill>();
			String  sql="select * from t_bill where bz_id ='"+user_name+"' and sys = "+sys+" order by "+sort+" "+dir;
			System.out.println("用户getMyBill"+sql);
			
			try {
				ResultSet rs = DBHelper.getConnection().createStatement()
						.executeQuery(sql);
				
				while (rs.next()) {
					Bill b= new Bill();
				       b.setId(rs.getString("id"));
				       b.setBz_id(rs.getString("bz_id"));
				       b.setBz_name(rs.getString("bz_name"));
				       b.setWeixiu_id(rs.getString("weixiu_id"));
				       b.setWeixiu_name(rs.getString("weixiu_name"));
				       b.setPhnone_number(rs.getString("bz_phone"));
				       b.setSatisfy(rs.getString("satisfy"));
				       b.setSuggestion(rs.getString("suggestion"));
				       b.setStatus(rs.getString("status"));
				       b.setOrder_time(rs.getString("order_time"));
				       b.setWeixiu_date(rs.getString("weixiu_date"));
				       b.setOrder_date(rs.getString("order_date"));
				       b.setFinish_time(rs.getString("finish_time"));
				       b.setDescriptions(rs.getString("descriptions"));
				       b.setWeixiu_phone(rs.getString("weixiu_phone"));
				       b.setArea1(rs.getString("area1_name"));
				       b.setArea2(rs.getString("area2_name"));
				       b.setBuilding(rs.getString("building_name"));
				       b.setBuilding_id(rs.getString("building_id"));
				       b.setFloor(rs.getString("floor"));
				       b.setRoom(rs.getString("room"));
				       b.setProject(rs.getString("project1_name")+"-"+rs.getString("project2_name")+"-"+rs.getString("project3_name"));
					   b.setProject1(rs.getString("project1_name"));
					   b.setProject2(rs.getString("project2_name"));
					   b.setProject3(rs.getString("project3_name"));
					   b.setProject1_id(rs.getString("project1_id"));
				       b.setProject2_id(rs.getString("project2_id"));
				       b.setProject3_id(rs.getString("project3_id"));
					   b.setSolution(rs.getString("solution"));
					   b.setJinji(rs.getString("jinji"));
					  
				       l.add(b);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

			return l;
	}

	
	//撤单
	public int chedan(String id) {
		 int rs=0;
			String  sql="update t_bill set status=3 where status=0 and id ="+id;
			//System.out.println("撤单"+sql);
			try {
				DBHelper.getConnection().createStatement().execute(sql);
				rs=1;
			} catch (SQLException e) {
				e.printStackTrace();
				rs=0;
			}
			return rs;
	}

	//评价
	public int pinJia(String bzId, String satisfy, String suggestion,String bill_id) {
		 int rs=0;
			String  sql="update t_bill set status=4, satisfy = "+satisfy+",suggestion='"+suggestion+"' where id="+bill_id;
			System.out.println(sql);
			try {
				DBHelper.getConnection().createStatement().execute(sql);
				rs=1;
			} catch (SQLException e) {
				e.printStackTrace();
				rs=0;
			}
			return rs;
	}

	//用户信息更新
	public boolean updateUser(String bz_id, String name, String phone,String area1,String area2,
			                  String building,String building_id,String floor,String room,String area1_id,
			                  String area2_id) {
		boolean rs=false;
		String sql="update t_user set name='"+name+"',phon_number='"+phone+"', area1_id="+area1_id+",area1='"+area1+"',area2='"+area2+"', area2_id="+area2_id+",building_id="+building_id+",floor='"+floor+"',room='"+room+"',building='"+building+"',isonce=1 where user_name='"+bz_id+"'";
		////System.out.println(sql);
		try {
			DBHelper.getConnection().createStatement().execute(sql);
			rs=true;
		} catch (SQLException e) {
		rs=false;
			e.printStackTrace();
		}
		return rs;
	}

	
	//修改密码
	public int changPassword(String username,String password) {
		 int rs=0;
			String  sql="update t_user set password ='"+password+"' where user_name='"+username+"'";
			try {
				DBHelper.getConnection().createStatement().execute(sql);
				rs=1;
			} catch (SQLException e) {
				e.printStackTrace();
				rs=0;
			}
			return rs;
	}

	//用户填单时系统自动跟新用户信息
	public boolean changeInfo(String user_name, String name, String phone,String area1,String area1_id,
			                  String area2,String area2_id,String sex,String building,String building_id,
			                  String floor,String room) {
		 boolean rs = false;
		    ResultSet result = null;
		    String sql = "select * from t_user where user_name='" + user_name + "'";
		    try {
		      result = DBHelper.getConnection().createStatement().executeQuery(sql);
		    } catch (SQLException e1) {
		      e1.printStackTrace();
		      rs = false;
		    }
		    try {
		      if (result.next()) {
		        sql = "update t_user set name ='" + name + "',area1='" + area1 + "',area1_id=" + area1_id + ",area2='" + area2 + 
		              "',area2_id=" + area2_id + ",building='" + building + "',building_id=" + building_id + ",floor='" + floor + "',sex='" + 
		              sex + "',room='" + room + "',phon_number='" + phone + "' where user_name='" + user_name + "'";
		        try
		        {
		          DBHelper.getConnection().createStatement().execute(sql);
		          rs = true;
		        } catch (SQLException e) {
		          e.printStackTrace();
		          rs = false; 
		          } 
		      }

		      sql = "insert into t_user(user_name,name,sex,phon_number,area1,area2,area1_id,area2_id,building,building_id,floor,room,role_id,password,isonce) values('" + 
		             user_name + "','" + name + "','" + sex + "','" + phone + "','" + area1 + "','" + area2 + "'," + area1_id + "," + 
		             area2_id + ",'" +  building + "'," + building_id + ",'" + floor + "','" + room + "',4,'" + user_name + "',1)";
		        DBHelper.getConnection().createStatement().execute(sql);
		         rs = true;
		    }
		    catch (SQLException e)
		    {
		      e.printStackTrace();
		      rs = false;
		    }
		    return rs;
	}

	
	//获取区域信息
	public List<Area> getAreas(String p_id) {
		// TODO Auto-generated method stub
		 List<Area> l= new ArrayList<Area>();
			String  sql="select * from t_area where p_id ="+p_id;
			
			////System.out.println(sql);
			try {
				ResultSet rs = DBHelper.getConnection().createStatement()
						.executeQuery(sql);
				
				while (rs.next()) {
					Area b= new Area();
				    b.setId(rs.getString("id"));
				    b.setName(rs.getString("name"));
					l.add(b);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

			return l;
	}
	
	//报修登记-后勤故障
	public int saveBill(String bz_id,String name,String phone,String description,String order_time,String building,
			            String building_id,String area2,String area1, String project1,String project2, String project3,
			            String project1_id,String project2_id,String project3_id,String floor,String room,String area1_id,
			            String area2_id,String sys,String weixiu_date) {
		
		ResultSet rsset=null;
		int rs=0;
		String sql="";
		try {
			if("0".equals(sys)){
				sql="select * from t_bill where status <2 and area1_name='"+area1+"' and area2_name='"+area2+"' and building_name='"+building+"' and floor='"+floor+"' and room='"+room+"' and project1_name='"+project1+"' and project2_name='"+project2+"' and project3_name='"+project3+"' and sys="+sys;
			}else{
				sql="select * from t_bill where status <2 and area1_name='"+area1+"' and area2_name='"+area2+"' and building_name='"+building+"' and floor='"+floor+"' and room='"+room+"' and project1_name='"+project1+"' and bz_id='"+bz_id+"' and sys="+sys;
			}
			
			////System.out.println(sql);
			rsset=DBHelper.getConnection().createStatement().executeQuery(sql);
			if(rsset.next())return 0;
			else{
				sql="insert into  t_bill(bz_id,bz_name,bz_phone,descriptions,order_date,weixiu_date,order_time,building_id,project1_name,project2_name,project3_name,area1_name,area2_name,building_name,floor,room,sys,status,jinji,satisfy) values('"
					+bz_id+"','"+name+"','"+phone+"','"+description+"',getdate(),'"+weixiu_date+"','"+order_time+"','"+building_id+"','"+project1+"','"+project2+"','"+project3+"','"+area1+"','"+area2+"','"+building+"','"+floor+"','"+room+"',"+sys+", 0,0,0)";
				//System.out.println("插入数据sql："+sql);
					DBHelper.getConnection().createStatement().execute(sql);
					if("0".equals(sys))
					sql="select u.name as name,u.phon_number as phone,u.user_name as user_name from t_user u inner join t_building b on u.user_name=b.weixiu_id where b.id="+building_id;
					if("1".equals(sys))
						sql="select u.name as name,u.phon_number as phone,u.user_name as user_name from t_user u inner join t_building b on u.user_name=b.net_weixiu where b.id="+building_id;
					System.out.println(sql);
					rsset= DBHelper.getConnection().createStatement().executeQuery(sql);
					if(rsset.next()){
						String weixiu_name=rsset.getString("name");
						String weixiu_phone =rsset.getString("phone");
						String weixiu_id= rsset.getString("user_name");
						//System.out.println(weixiu_name+"----"+weixiu_phone);
						  //更新故障单维修员信息
						sql="update t_bill set weixiu_name='"+weixiu_name+"', weixiu_id='"+weixiu_id+"',weixiu_phone='"+weixiu_phone+"' where  id =( select max(id) from t_bill where bz_id='"+bz_id+"' and status=0)";
						System.out.println(sql);
						DBHelper.getConnection().createStatement().execute(sql);
					}
					sql="select jinji from t_category where id="+project3_id;
					rsset= DBHelper.getConnection().createStatement().executeQuery(sql);
					if(rsset.next()){
						
						sql="update t_bill set jinji="+rsset.getString("jinji")+" where bz_id= '"+bz_id+"' and project3_name='"+project3+"'";
						//////System.out.println(sql);
						DBHelper.getConnection().createStatement().execute(sql);
					}
					rs=1;
			}
			
		} catch (SQLException e) {
		      rs=2;
			e.printStackTrace();
		}
		
		return rs;
		
	}

	
	  //管理员
	public List<Bill> getAllBills(String area,String sort,String dir,String sys) {
		 List<Bill> l= new ArrayList<Bill>();
			
		 String sql = "select * from t_bill where status=0 and sys = " + sys + "   and ";
		    if ((area != null) && (!("".equals(area))))
		    {
		      sql = sql + " area1_name='" + area + "'   and ";
		    }

		    sql = sql.substring(0, sql.length() - 5);
		    sql = sql + " order by " + sort + " " + dir;
		 
			System.out.println("管理员getAllBills:"+sql);
			try {
				ResultSet rs = DBHelper.getConnection().createStatement()
						.executeQuery(sql);
				
				while (rs.next()) {
					Bill b= new Bill();
				       b.setId(rs.getString("id"));
				       b.setBz_id(rs.getString("bz_id"));
				       b.setBz_name(rs.getString("bz_name"));
				       b.setWeixiu_id(rs.getString("weixiu_id"));
				       b.setWeixiu_name(rs.getString("weixiu_name"));
				       b.setPhnone_number(rs.getString("bz_phone"));
				       b.setSatisfy(rs.getString("satisfy"));
				       b.setSuggestion(rs.getString("suggestion"));
				       b.setStatus(rs.getString("status"));
				       b.setOrder_time(rs.getString("order_time"));
				       b.setOrder_date(rs.getString("order_date"));
				       b.setWeixiu_date(rs.getString("weixiu_date"));
				       b.setFinish_time(rs.getString("finish_time"));
				       b.setDescriptions(rs.getString("descriptions"));
				       b.setWeixiu_phone(rs.getString("weixiu_phone"));
				       b.setArea1(rs.getString("area1_name"));
				       b.setArea2(rs.getString("area2_name"));
				       b.setBuilding(rs.getString("building_name"));
				       b.setBuilding_id(rs.getString("building_id"));
				       b.setFloor(rs.getString("floor"));
				       b.setRoom(rs.getString("room"));
				       b.setProject(rs.getString("project1_name")+"-"+rs.getString("project2_name")+"-"+rs.getString("project3_name"));
				       b.setProject1(rs.getString("project1_name"));
				       b.setProject2(rs.getString("project2_name"));
				       b.setProject3(rs.getString("project3_name"));
				       b.setProject1_id(rs.getString("project1_id"));
				       b.setProject2_id(rs.getString("project2_id"));
				       b.setProject3_id(rs.getString("project3_id"));
				       b.setSolution(rs.getString("solution"));
				       b.setJinji(rs.getString("jinji"));
				       l.add(b);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

			return l;
	}


	
	//维修员
public List<Bill> getAllBills(String area,String weixiu_id,String sort,String dir,String project1,String sys) {
	 List<Bill> l= new ArrayList<Bill>();
		String  sql="select * from t_bill where status=0 and sys="+sys;
		if(project1!=null&&!"".equals(project1)){
			sql=sql+" and project1_name='"+project1+"'";
		}
		
		if(area!=null&&!"".equals(area)){
			sql=sql+" and area1_name='"+area+"'";
		}
		if(weixiu_id!=null&&!"".equals(weixiu_id)){
			sql=sql+" and weixiu_id='"+weixiu_id+"'";
		}
		
		sql=sql+" order by "+sort+" "+dir;
		System.out.println("维修员getAllBills:"+sql);
		try {
			ResultSet rs = DBHelper.getConnection().createStatement()
					.executeQuery(sql);
			
			while (rs.next()) {
				Bill b= new Bill();
			       b.setId(rs.getString("id"));
			       b.setBz_id(rs.getString("bz_id"));
			       b.setBz_name(rs.getString("bz_name"));
			       b.setWeixiu_id(rs.getString("weixiu_id"));
			       b.setWeixiu_name(rs.getString("weixiu_name"));
			       b.setPhnone_number(rs.getString("bz_phone"));
			       b.setSatisfy(rs.getString("satisfy"));
			       b.setSuggestion(rs.getString("suggestion"));
			       b.setStatus(rs.getString("status"));
			       b.setOrder_time(rs.getString("order_time"));
			       b.setWeixiu_date(rs.getString("weixiu_date"));
			       b.setOrder_date(rs.getString("order_date"));
			       b.setFinish_time(rs.getString("finish_time"));
			       b.setDescriptions(rs.getString("descriptions"));
			       b.setWeixiu_phone(rs.getString("weixiu_phone"));
			       b.setArea1(rs.getString("area1_name"));
			       b.setArea2(rs.getString("area2_name"));
			       b.setBuilding(rs.getString("building_name"));
			       b.setBuilding_id(rs.getString("building_id"));
			       b.setFloor(rs.getString("floor"));
			       b.setRoom(rs.getString("room"));
			       b.setProject(rs.getString("project1_name")+"-"+rs.getString("project2_name")+"-"+rs.getString("project3_name"));
				   b.setProject1(rs.getString("project1_name"));
				   b.setProject2(rs.getString("project2_name"));
				   b.setProject3(rs.getString("project3_name"));
				   b.setProject1_id(rs.getString("project1_id"));
			       b.setProject2_id(rs.getString("project2_id"));
			       b.setProject3_id(rs.getString("project3_id"));
				   b.setJinji(rs.getString("jinji"));
				   b.setSolution(rs.getString("solution"));
			       l.add(b);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return l;
}


//修改故障单
public int editBill(String id,String bz_id, String name, String phone,String description, String order_time, 
		            String building,String building_id, String area2, String area1, String project1,String project2, 
		            String project3, String project1_id,String project2_id, String project3_id, String floor, String room,
		            String area1_id, String area2_id) {
	ResultSet rsset=null;
	int rs=0;
	String sql="";
	try {
		sql="update t_bill set bz_phone='"+phone+"',area1_name='"+area1+"',area2_name='"+
		area2.trim()+"', building_name='"+building.trim()+"', building_id ="+building_id.trim()+
		", floor='"+floor+"', room='"+room+"',project1_name='"+project1+"', project2_name='"+
		project2.trim()+"',project3_name='"+project3.trim()+"', descriptions='"+description.trim()+"', order_time='"+order_time+"' where id="+id;
			//////System.out.println(sql);
				DBHelper.getConnection().createStatement().execute(sql);
				
				rs=1;
	} catch (SQLException e) {
	rs=2;
		e.printStackTrace();
	}
	
	return rs;
}

//添加账户
public boolean addUser(String bzId, String name, String phone, String area1,String area2, String building, 
		               String buildingId, String floor,String room, String area1Id, String area2Id) {
	boolean rs=false;
	String sql="insert into t_user(user_name,name,phon_number,area1,area2,area1_id,area2_id,building,building_id,floor,room,role_id,password,isonce) values('"+
	bzId+"','"+name+"','"+phone+"','"+area1+"','"+area2+"',"+area1Id+","+area2Id+",'"+
	building+"',"+buildingId+",'"+floor+"','"+room+"',4,'"+bzId+"',1)";
	////System.out.println(sql);
	try {
		DBHelper.getConnection().createStatement().execute(sql);
		rs=true;
	} catch (SQLException e) {
	rs=false;
		e.printStackTrace();
	}
	
	return rs;
}


//登录
public String login(String username, String password) {
	return null;
}


//修改用户信息-网络
public boolean net_changeInfo(String user_name, String name, String phone,String sex, String grade, 
		                      String departments, String classes,String sys) {
	    boolean rs=false;
		String  sql="update t_user set name ='"+name+"',grade='"+grade+"',departments='"+departments+"',classes='"+classes+"',sex='"+sex+"',phon_number='"+ phone+ "' where sys="+sys+" and user_name='"+user_name+"'";
		//System.out.println("update user:"+sql);
		try {
			DBHelper.getConnection().createStatement().execute(sql);
			rs=true;
		} catch (SQLException e) {
			e.printStackTrace();
			rs=false;
		}
		return rs;
}

}

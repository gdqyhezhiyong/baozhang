package gdqy.edu.cn.serviceImp;

import gdqy.edu.cn.DBhelper.DBHelper;
import gdqy.edu.cn.modle.AreaCount;
import gdqy.edu.cn.modle.Bill;
import gdqy.edu.cn.modle.Building;
import gdqy.edu.cn.modle.Category;
import gdqy.edu.cn.modle.CountCategory;
import gdqy.edu.cn.modle.Logs;
import gdqy.edu.cn.modle.Material;
import gdqy.edu.cn.modle.MonthCount;
import gdqy.edu.cn.modle.Satisfy;
import gdqy.edu.cn.modle.Supplies;
import gdqy.edu.cn.modle.Today;
import gdqy.edu.cn.modle.User;
import gdqy.edu.cn.modle.Weixiu;
import gdqy.edu.cn.modle.Work;
import gdqy.edu.cn.service.UserServices;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminService
  implements UserServices
{
  public boolean chang_password(String username, String password)
  {
    return false;
  }

  public String login(String username, String password)
  {
    return null;
  }

  public List<User> findUsers(String sys, String role_id, String area) {
    List lists = new ArrayList();
    String sql = "";
    if ("7".equals(role_id)) {
      sql = "select * from t_user where role_id<>4 and sys = " + sys + " order by role_id,user_name";
    }
    else if ((area != null) && (!("".equals(area))) && (!("null".equals(area))))
      sql = "select * from t_user where role_id<>4 and sys = " + sys + " and area1='" + area + "' order by role_id,user_name";
    else {
      sql = "select * from t_user where role_id<>4 and sys = " + sys + " order by role_id,user_name";
    }
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        User user = new User();
        user.setUsername(rs.getString("user_name"));
        user.setName(rs.getString("name"));
        user.setClass_id(rs.getInt("class_id"));
        user.setPassword(rs.getString("password"));
        user.setRole_id(rs.getInt("role_id"));
        user.setPhone_number(rs.getString("phon_number"));
        user.setClasses(rs.getString("classes"));
        user.setDepartments(rs.getString("departments"));
        user.setGrade(rs.getString("grade"));
        user.setArea(rs.getString("area1"));
        lists.add(user);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<User> findUsersByAttributs(String name, String role_id, String sys, String role, String area) {
    List lists = new ArrayList();
    String sql = "";
    if ("7".equals(role)) {
      sql = "select * from t_user where role_id<>4 and sys =" + sys + "   and";
      if ((name != null) && (!("".equals(name))))
        sql = sql + " name like '%" + name + "%'   and";
      if ((role_id != null) && (!("".equals(role_id))))
        sql = sql + " role_id =" + role_id + "      ";
      sql = sql.substring(0, sql.length() - 5);
    }
    else {
      sql = "select * from t_user where role_id<>4 and sys =" + sys + "   and";
      if ((name != null) && (!("".equals(name))))
        sql = sql + " name like '%" + name + "%'   and";
      if ((role_id != null) && (!("".equals(role_id)))) {
        sql = sql + " role_id =" + role_id + "     and";
      }
      if ((area != null) && (!("".equals(area)))) {
        sql = sql + " area1 ='" + area + "'   and";
      }
      sql = sql.substring(0, sql.length() - 5);
    }

    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        User user = new User();
        user.setUsername(rs.getString("user_name"));
        user.setName(rs.getString("name"));
        user.setClass_id(rs.getInt("class_id"));
        user.setPassword(rs.getString("password"));
        user.setRole_id(rs.getInt("role_id"));
        user.setPhone_number(rs.getString("phon_number"));
        user.setId(rs.getString("id"));
        user.setClasses(rs.getString("classes"));
        user.setDepartments(rs.getString("departments"));
        user.setGrade(rs.getString("grade"));
        user.setArea(rs.getString("area1"));
        lists.add(user);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public int delteUser(String user_name, String sys) {
    int rs = 0;
    String sql = "delete from t_user where user_name='" + user_name + "' and sys=" + sys;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      rs = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      rs = 0;
    }
    return rs;
  }

  public int addUser(String username, String name, String phone, String role, String sys, String area)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    try
    {
      sql = "select * from t_user where user_name='" + username + "' and sys=" + sys;
      rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rsset.next()) return 0;

      sql = "insert into t_user(user_name,name,phon_number,role_id,sys,area1,password) values('" + 
        username + "','" + name + "','" + phone + "'," + role + "," + sys + ",'" + area + "','password')";

      DBHelper.getConnection().createStatement().execute(sql);
      sql = "update t_user set password=user_name where user_name='" + username + "'";

      DBHelper.getConnection().createStatement().execute(sql);
      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    return rs;
  }

  public List<Building> findAllBuilding(String sys, String area, String role_id)
  {
    List lists = new ArrayList();
    String sql;
    ResultSet rs=null;
    Building b;
    if ("0".equals(sys)) {
      sql = "select b.net_weixiu,b.id as id,b.name as name,b.area1_id as area1_id,b.area2_id as area2_id, ar.name as area2_name, a.name as weixiu,a.phon_number as phone  from t_building b left join t_user a on b.weixiu_id=a.user_name  left join t_area ar on b.area2_id=ar.id where";

      if ((!("7".equals(role_id))) && (area != null) && (!("".equals(area)))) {
        sql = sql + " b.area1_id ='" + area + "'       ";
      }
      sql = sql.substring(0, sql.length() - 5);
      sql = sql + " order by area1_id,area2_id";

      System.out.println("building_sql" + sql);
      try {
        rs = DBHelper.getConnection().createStatement()
          .executeQuery(sql);

        while (rs.next()) {
          b = new Building();
          b.setId(rs.getString("id"));
          b.setName(rs.getString("name"));
          b.setArea1_id(rs.getInt("area1_id"));
          b.setArea2_id(rs.getInt("area2_id"));
          b.setArea2_name(rs.getString("area2_name"));
          b.setWeixiu(rs.getString("weixiu"));
          b.setPhone(rs.getString("phone"));
          lists.add(b);
        }
      }
      catch (SQLException e) {
        e.printStackTrace();
      }

    }
    else if ("1".equals(sys)) {
      sql = "select b.net_weixiu,b.id as id,b.name as name,b.area1_id as area1_id,b.area2_id as area2_id, ar.name as area2_name, a.name as weixiu,a.phon_number as phone  from t_building b left join t_user a on b.net_weixiu=a.user_name  left join t_area ar on b.area2_id=ar.id  order by area1_id,area2_id";
      try
      {
    	  rs = DBHelper.getConnection().createStatement()
          .executeQuery(sql);

        while (rs.next()) {
          b = new Building();
          b.setId(rs.getString("id"));
          b.setName(rs.getString("name"));
          b.setArea1_id(rs.getInt("area1_id"));
          b.setArea2_id(rs.getInt("area2_id"));
          b.setArea2_name(rs.getString("area2_name"));
          b.setNet_weixiu(rs.getString("weixiu"));
          b.setNet_phone(rs.getString("phone"));
          lists.add(b);
        }
      }
      catch (SQLException e) {
        e.printStackTrace();
      }

    }

    return lists;
  }

  public List<Building> findAllByAttributs(String areaId, String weixiu, String sys)
  {
    List lists = new ArrayList();
    String sql;
    ResultSet rs=null;
    Building b;
    if ("0".equals(sys)) {
      sql = "select b.net_weixiu, b.id as id,b.name as name,b.area1_id as area1_id,b.area2_id as area2_id, ar.name as area2_name, a.name as weixiu,a.phon_number as phone from t_building b left join t_user a on b.weixiu_id=a.user_name  left join t_area ar on b.area2_id=ar.id where";

      if ((areaId != null) && (!("".equals(areaId))))
      {
        sql = sql + " b.area1_id=" + areaId + "   and";
      }
      if ((weixiu != null) && (!("".equals(weixiu))))
      {
        sql = sql + " a.name like'%" + weixiu + "%'     ";
      }

      sql = sql.substring(0, sql.length() - 5);
      try
      {
        rs = DBHelper.getConnection().createStatement()
          .executeQuery(sql);

        while (rs.next()) {
          b = new Building();
          b.setId(rs.getString("id"));
          b.setName(rs.getString("name"));
          b.setArea1_id(rs.getInt("area1_id"));
          b.setArea2_id(rs.getInt("area2_id"));
          b.setArea2_name(rs.getString("area2_name"));
          b.setWeixiu(rs.getString("weixiu"));
          b.setPhone(rs.getString("phone"));

          lists.add(b);
        }
      }
      catch (SQLException e) {
        e.printStackTrace();
      }

    }
    else if ("1".equals(sys)) {
      sql = "select b.net_weixiu, b.id as id,b.name as name,b.area1_id as area1_id,b.area2_id as area2_id, ar.name as area2_name, a.name as weixiu,a.phon_number as phone from t_building b left join t_user a on b.net_weixiu=a.user_name  left join t_area ar on b.area2_id=ar.id where";

      if ((areaId != null) && (!("".equals(areaId))))
      {
        sql = sql + " b.area1_id=" + areaId + "   and";
      }
      if ((weixiu != null) && (!("".equals(weixiu))))
      {
        sql = sql + " a.name like'%" + weixiu + "%'     ";
      }

      sql = sql.substring(0, sql.length() - 5);
      try
      {
        rs = DBHelper.getConnection().createStatement()
          .executeQuery(sql);

        while (rs.next()) {
          b = new Building();
          b.setId(rs.getString("id"));
          b.setName(rs.getString("name"));
          b.setArea1_id(rs.getInt("area1_id"));
          b.setArea2_id(rs.getInt("area2_id"));
          b.setArea2_name(rs.getString("area2_name"));

          b.setNet_weixiu(rs.getString("weixiu"));
          b.setNet_phone(rs.getString("phone"));
          lists.add(b);
        }
      }
      catch (SQLException e) {
        e.printStackTrace();
      }

    }

    return lists;
  }

  public List<Weixiu> getWeixius(String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select * from t_user where role_id=3 and sys=" + sys;
    if ((area != null) && (!("".equals(area))))
      sql = sql + " and area1='" + area + "'";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Weixiu b = new Weixiu();
        b.setId(rs.getString("user_name"));
        b.setName(rs.getString("name"));

        lists.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public int addBuilding(String buildingName, String areaId, String weixiuId, String min, String max, String sys)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    int building_id = 0;
    try
    {
      sql = "select * from t_building where name='" + buildingName + "'and area_id=" + areaId + "  and sys=" + sys;

      rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rsset.next()) return 0;

      sql = "insert into t_building(name,area_id,weixiu_id,sys) values('" + 
        buildingName + "'," + areaId + ",'" + weixiuId + "'," + sys + ")";

      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    return rs;
  }

  public int delteBuilding(String id)
  {
    int rs = 0;
    String sql = "delete from t_building where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      sql = "update t_user set building=null,building_id=null,isonce=0 where building_id=" + id;

      DBHelper.getConnection().createStatement().execute(sql);
      rs = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      rs = 0;
    }
    return rs;
  }

  public int editBuilding(String id, String building_name, String area1_id, String area2_id, String weixiu_id, String sys)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = null;

    if ("0".equals(sys)) {
      sql = "update t_building set name='" + building_name + "',area1_id=" + area1_id + ",area2_id=" + area2_id + ",weixiu_id='" + weixiu_id + "' where id=" + id;
    }
    if ("1".equals(sys)) {
      sql = "update t_building set name='" + building_name + "',area1_id=" + area1_id + ",area2_id=" + area2_id + ",net_weixiu='" + weixiu_id + "' where id=" + id;
    }

    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    sql = "update t_bill set weixiu_id=(select weixiu_id from t_building where t_building.id=t_bill.building_id), building_name=(select name from t_building where t_building.id=t_bill.building_id ), weixiu_name=(select t_user.name from t_user inner join t_building on t_user.user_name=t_building.weixiu_id where t_bill.building_id=t_building.id), weixiu_phone=(select phon_number from t_user inner join t_building on t_user.user_name=t_building.weixiu_id where t_bill.building_id=t_building.id) where sys=0 and status =0";
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    return rs;
  }

  public int addCategory(String inputproject, String p_id, String jinji, String sys, String weixiu_id)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    try
    {
      if ("root".equals(p_id)) {
        sql = "select * from t_category where p_id=0 and name='" + inputproject + "'";

        rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
        if (rsset.next()) return 0;
        sql = "insert into t_category(name,p_id,c_level,jinji,sys) values('" + inputproject + "',0,0," + jinji + "," + sys + ")";

        DBHelper.getConnection().createStatement().execute(sql);
      }
      sql = "select * from t_category where p_id=" + p_id + " and name='" + inputproject + "'";

      rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rsset.next()) return 0;

      sql = "insert into t_category(name,p_id,jinji,sys) values('" + 
        inputproject + "'," + p_id + "," + jinji + "," + sys + ")";

      DBHelper.getConnection().createStatement().execute(sql);
      sql = "select * from t_category where id=" + p_id;
      rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rsset.next())
      {
        String level = rsset.getString("c_level");
        sql = "update t_category set c_level=" + (Integer.parseInt(level) + 1) + " where id= (select max(id) from t_category)";
        DBHelper.getConnection().createStatement().execute(sql);
        if ("1".equals(level)) {
          sql = "update t_category set weixiu_id='" + weixiu_id + "' where id= (select max(id) from t_category)";
          DBHelper.getConnection().createStatement().execute(sql);
        }
      }

      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    label443: return rs;
  }

  public int delteCategory(String id, String level)
  {
    int r = 0;
    ResultSet rs = null;

    String sql = "";

    if ("0".equals(level)) {
      sql = "delete from t_category where id=" + id;
      try
      {
        DBHelper.getConnection().createStatement().execute(sql);
        sql = "select * from t_category where p_id=" + id;

        rs = DBHelper.getConnection().createStatement().executeQuery(sql);
        while (rs.next()) {
          String p_id = rs.getString("id");
          sql = "delete from t_category where p_id=" + p_id;

          DBHelper.getConnection().createStatement().execute(sql);
        }
        sql = "delete from t_category where p_id=" + id;

        DBHelper.getConnection().createStatement().execute(sql);
        r = 1;
      } catch (SQLException e) {
        e.printStackTrace();
        r = 0;
      }
    }

    if ("2".equals(level)) {
      sql = "delete from t_category where id=" + id;
      try
      {
        DBHelper.getConnection().createStatement().execute(sql);
        r = 1;
      } catch (SQLException e) {
        e.printStackTrace();
        r = 0;
      }
    }
    if ("1".equals(level)) {
      try {
        sql = "delete from t_category where id=" + id;

        DBHelper.getConnection().createStatement().execute(sql);
        sql = "delete from t_category where p_id=" + id;

        DBHelper.getConnection().createStatement().execute(sql);
        r = 1;
      } catch (SQLException e) {
        e.printStackTrace();
        r = 0;
      }

    }

    return r;
  }

  public int ChangeUser(String username, String name, String phone, String role, String sys, String user_gruop)
  {
    int r = 0;
    String sql = "update t_user set name='" + name + "',phon_number='" + phone + "',area1='" + user_gruop + "',role_id=" + role + " where user_name='" + username + "' and sys=" + sys;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public int addBuilding1(String building_name, String area1_id, String area2_id, String weixiu_id, String sys)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    int building_id = 0;
    try
    {
      sql = "select * from t_building where name='" + building_name + "'and area1_id=" + area1_id + " and area2_id=" + area2_id;

      rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rsset.next()) return 0;

      if ("0".equals(sys)) {
        sql = "insert into t_building(name,area1_id,area2_id,weixiu_id) values('" + 
          building_name + "'," + area1_id + "," + area2_id + ",'" + weixiu_id + "')";
      }
      if ("1".equals(sys)) {
        sql = "insert into t_building(name,area1_id,area2_id,net_weixiu) values('" + 
          building_name + "'," + area1_id + "," + area2_id + ",'" + weixiu_id + "')";
      }
      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    return rs;
  }

  public int Paidan(String id)
  {
    int r = 0;
    String sql = "update t_bill set status =1 where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public int RePaidan(String id, String weixiu_id)
  {
    int r = 0;
    String sql = null;

    sql = "update t_bill set status =1,weixiu_id='" + weixiu_id + "',weixiu_name=(select name from t_user where role_id=3 and user_name='" + weixiu_id + "'), weixiu_phone=(select phon_number from t_user where role_id=3 and user_name='" + weixiu_id + "')where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public int Jinjidan(String id, String level)
  {
    int r = 0;
    String sql = "update t_bill set jinji =" + level + " where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public List<Bill> getAllBills(String sort, String dir, String print, String sys, String area)
  {
    List l = new ArrayList();
    String sql = "select * from t_bill where status=1 and sys=" + sys;
    if ((print != null) && (!("".equals(print)))) {
      sql = sql + " and is_print=" + print;
    }
    if ((area != null) && (!("".equals(area)))) {
      sql = sql + " and area1_name='" + area + "'";
    }

    sql = sql + " order by " + sort + " " + dir;
    System.out.println(sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
        b.setId(rs.getString("id"));
        b.setBz_id(rs.getString("bz_id"));
        b.setBz_name(rs.getString("bz_name"));
        b.setWeixiu_id(rs.getString("weixiu_id"));
        b.setWeixiu_name(rs.getString("weixiu_name"));
        b.setPhnone_number(rs.getString("bz_phone"));
        b.setSatisfy(rs.getString("satisfy"));
        b.setSuggestion(rs.getString("suggestion"));
        b.setStatus(rs.getString("status"));
        b.setWeixiu_date(rs.getString("weixiu_date"));
        b.setOrder_time(rs.getString("order_time"));
        b.setOrder_date(rs.getString("order_date"));
        b.setFinish_time(rs.getString("finish_time"));
        b.setDescriptions(rs.getString("descriptions"));
        b.setWeixiu_phone(rs.getString("weixiu_phone"));
        b.setArea1(rs.getString("area1_name"));
        b.setArea2(rs.getString("area2_name"));
        b.setBuilding(rs.getString("building_name"));
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        b.setProject(rs.getString("project1_name").trim() + "-" + rs.getString("project2_name").trim() + "-" + rs.getString("project3_name").trim());
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<Bill> getAllBills(String weixiu_id, String area1_name, String area2_name, String building, String start_time, String end_time, String sort, String dir, String bill_number, String print, String project1_name, String sys)
  {
    List l = new ArrayList();
    String sql = "select * from t_bill where status=1  and sys=" + sys + " and ";
    if ((weixiu_id != null) && (!("".equals(weixiu_id)))) {
      sql = sql + " weixiu_id='" + weixiu_id + "'  and ";
    }

    if ((!("".equals(area1_name))) && (area1_name != null)) {
      sql = sql + " area1_name='" + area1_name + "'  and ";
    }
    if ((area2_name != null) && (!("".equals(area2_name)))) {
      sql = sql + " area2_name='" + area2_name + "'  and ";
    }

    if ((!("".equals(building))) && (building != null)) {
      sql = sql + " building_name='" + building + "'  and ";
    }

    if ((print != null) && (!("".equals(print)))) {
      sql = sql + " is_print=" + print + "  and ";
    }

    if ((project1_name != null) && (!("".equals(project1_name)))) {
      sql = sql + " project1_name='" + project1_name + "'  and ";
    }

    if ((!("".equals(bill_number))) && (bill_number != null)) {
      sql = sql + " id like '" + bill_number + "%'  and ";
    }

    if ((!("".equals(start_time))) && (start_time != null)) {
      sql = sql + " CONVERT(char(10),weixiu_date,120)>='" + start_time + "'   and ";
    }
    if ((!("".equals(end_time))) && (end_time != null)) {
      sql = sql + " CONVERT(char(10),weixiu_date,120)<='" + end_time + "'   and ";
    }

    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " order by " + sort + " " + dir;
    System.out.println(sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
        b.setId(rs.getString("id"));
        b.setBz_id(rs.getString("bz_id"));
        b.setBz_name(rs.getString("bz_name"));
        b.setWeixiu_id(rs.getString("weixiu_id"));
        b.setWeixiu_name(rs.getString("weixiu_name"));
        b.setPhnone_number(rs.getString("bz_phone"));
        b.setSatisfy(rs.getString("satisfy"));
        b.setSuggestion(rs.getString("suggestion"));
        b.setStatus(rs.getString("status"));
        b.setWeixiu_date(rs.getString("weixiu_date"));
        b.setOrder_time(rs.getString("order_time"));
        b.setOrder_date(rs.getString("order_date"));
        b.setWeixiu_date(rs.getString("weixiu_date"));
        b.setFinish_time(rs.getString("finish_time"));
        b.setDescriptions(rs.getString("descriptions"));
        b.setWeixiu_phone(rs.getString("weixiu_phone"));
        b.setArea1(rs.getString("area1_name"));
        b.setArea2(rs.getString("area2_name"));
        b.setBuilding(rs.getString("building_name"));
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        b.setProject(rs.getString("project1_name").trim() + "-" + rs.getString("project2_name").trim() + "-" + rs.getString("project3_name").trim());
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<Satisfy> getSatisfy(String sys)
  {
    List lists = new ArrayList();
    String sql = "select new.satisfy ,sum(new.number) as number from (select (case satisfy when 1 then '很满意' when 3 then '不满意' when 4 then '很不满意' else '基本满意' end) as satisfy,count(satisfy) as number from t_bill where status>1 and status<>3 and sys = " + 
      sys + " group by satisfy) as new group by satisfy ";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Satisfy satisfy = new Satisfy();
        satisfy.setValue(rs.getString("number"));
        satisfy.setLabel(rs.getString("satisfy"));
        lists.add(satisfy);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Satisfy> getSatisfy(String starTime, String endTime, String weixiu_id, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select new.satisfy ,sum(new.number)as number from (select (case satisfy when 1 then '很满意' when 3 then '不满意' when 4 then '很不满意' else '基本满意' end) as satisfy,count(satisfy) as number from t_bill where status>1 and status<>3  and sys=" + 
      sys + "    and";
    if ((starTime != null) && (!("".equals(starTime.trim())))) {
      sql = sql + " CONVERT(char(10),order_date,120)>='" + starTime + "'  and ";
    }

    if ((endTime != null) && (!("".equals(endTime.trim())))) {
      sql = sql + " CONVERT(char(10),order_date,120)<='" + endTime + "'  and ";
    }

    if ((weixiu_id != null) && (!("".equals(weixiu_id.trim())))) {
      sql = sql + " weixiu_id='" + weixiu_id + "'   and";
    }
    if ((area != null) && (!("".equals(area.trim())))) {
      sql = sql + " area1_name='" + area + "'   and";
    }

    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by satisfy) as new group by new.satisfy";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Satisfy satisfy = new Satisfy();
        satisfy.setValue(rs.getString("number"));
        satisfy.setLabel(rs.getString("satisfy"));
        lists.add(satisfy);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public String checkUser(String user_name)
  {
    ResultSet rs = null;
    String returnstr = "";
    String name = "";
    String phon_number = "";
    String area1 = "";
    String area2 = "";
    String building_id = "";
    String building = "";
    String floor = "";
    String room = "";
    String once = "";

    String sql = "select * from t_user where role_id=4 and user_name='" + user_name + "'";
    try
    {
      rs = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rs.next()) {
        if (rs.getString("name") != null)
          name = rs.getString("name").trim();
        if (rs.getString("phon_number") != null)
          phon_number = rs.getString("phon_number").trim();
        if (rs.getString("area1") != null)
          area1 = rs.getString("area1").trim();
        if (rs.getString("area2") != null)
          area2 = rs.getString("area2").trim();
        if (rs.getString("building_id") != null)
          building_id = rs.getString("building_id").trim();
        if (rs.getString("building") != null)
          building = rs.getString("building").trim();
        if (rs.getString("floor") != null)
          floor = rs.getString("floor").trim();
        if (rs.getString("room") != null)
          room = rs.getString("room").trim();
        once = rs.getString("isonce").trim();
        returnstr = name + "," + phon_number + "," + area1 + "," + area2 + 
          "," + building_id + "," + building + "," + floor + "," + room + "," + once;
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    return returnstr;
  }

  public List<Category> getCategory(String sys)
  {
    List l = new ArrayList();
    String sql = "select a.id as id, a.name as name, a.c_level as level,b.id as p_id,b.name as p_name,c.id as pp_id,c.name as pp_name from  t_category a left join t_category b on a.p_id=b.id left join t_category c on b.p_id=c.id where a.sys = " + 
      sys + " order by a.c_level,a.id";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Category c = new Category();
        c.setId(rs.getString("id"));
        c.setName(rs.getString("name"));
        c.setLevel(rs.getString("level"));
        c.setP_id(rs.getString("p_id"));
        c.setP_name(rs.getString("p_name"));
        c.setPp_id(rs.getString("pp_name"));
        c.setPp_name(rs.getString("pp_name"));
        l.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<Category> getCategory(String p_id, String pp_id, String sys)
  {
    List l = new ArrayList();
    String sql = "select a.id as id, a.name as name, a.c_level as level,b.id as p_id,b.name as p_name,c.id as pp_id,c.name as pp_name from  t_category a left join t_category b on a.p_id=b.id left join t_category c on b.p_id=c.id  where a.sys=" + 
      sys + "   and";
    if ((p_id != null) && (!("".equals(p_id))))
      sql = sql + "  b.id=" + p_id + "  and";
    if ((pp_id != null) && (!("".equals(pp_id))))
      sql = sql + "  c.id=" + pp_id + "      ";
    sql = sql.substring(0, sql.length() - 5);
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Category c = new Category();
        c.setId(rs.getString("id"));
        c.setName(rs.getString("name"));
        c.setLevel(rs.getString("level"));
        c.setP_id(rs.getString("p_id"));
        c.setP_name(rs.getString("p_name"));
        c.setPp_id(rs.getString("pp_name"));
        c.setPp_name(rs.getString("pp_name"));
        l.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<Bill> findAllBills(String sort, String dir, String sys)
  {
    List l = new ArrayList();
    String sql = "select * from t_bill where sys=" + sys + " order by " + sort + " " + dir;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
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
        b.setFinish_time(rs.getString("finish_time"));
        b.setDescriptions(rs.getString("descriptions"));
        b.setWeixiu_phone(rs.getString("weixiu_phone"));
        b.setArea1(rs.getString("area1_name"));
        b.setArea2(rs.getString("area2_name"));
        b.setBuilding(rs.getString("building_name"));
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        b.setProject(rs.getString("project1_name") + "-" + rs.getString("project2_name") + "-" + rs.getString("project3_name"));
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        b.setSolution(rs.getString("solution"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<Bill> findBills(String area1, String area2, String building, String floor, String weixiuId, String status, String startTime, String endTime, String sort, String dir, String bill_number, String sys)
  {
    List l = new ArrayList();
    String sql = "select * from t_bill where sys=" + sys + "   and";
    if ((!("".equals(area1))) && (area1 != null)) {
      sql = sql + " area1_name='" + area1 + "'  and ";
    }
    if ((!("".equals(area2))) && (area2 != null)) {
      sql = sql + " area2_name='" + area2 + "'  and ";
    }
    if ((!("".equals(building))) && (building != null)) {
      sql = sql + " building_name='" + building + "'  and ";
    }

    if ((!("".equals(floor))) && (floor != null)) {
      sql = sql + " floor='" + floor + "'  and ";
    }
    if ((!("".equals(weixiuId))) && (weixiuId != null)) {
      sql = sql + " weixiu_id='" + weixiuId + "'  and ";
    }
    if ((!("".equals(bill_number))) && (bill_number != null)) {
      sql = sql + " id like '" + bill_number + "%'  and ";
    }
    if ((!("".equals(status))) && (status != null)) {
      sql = sql + " status=" + status + "   and ";
    }
    if ((!("".equals(startTime))) && (startTime != null)) {
      sql = sql + " CONVERT(char(10),order_date,120)>='" + startTime + "'   and ";
    }
    if ((!("".equals(endTime))) && (endTime != null)) {
      sql = sql + " CONVERT(char(10),order_date,120)<='" + endTime + "'   and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + "  order by " + sort + " " + dir;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
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
        b.setFinish_time(rs.getString("finish_time"));
        b.setDescriptions(rs.getString("descriptions"));
        b.setWeixiu_phone(rs.getString("weixiu_phone"));
        b.setArea1(rs.getString("area1_name"));
        b.setArea2(rs.getString("area2_name"));
        b.setBuilding(rs.getString("building_name"));
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        b.setProject(rs.getString("project1_name") + "-" + rs.getString("project2_name") + "-" + rs.getString("project3_name"));
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        b.setSolution(rs.getString("solution"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<CountCategory> getCountCategory(String sys)
  {
    List lists = new ArrayList();
    String sql = "select project1_name as category ,count(project1_name) as number  from t_bill where status>1 and  status<>3  and sys=" + sys + " group by project1_name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        CountCategory c = new CountCategory();
        c.setCategory(rs.getString("category"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<CountCategory> getCountCategory(String star_time, String end_time, String weixiu_id, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select project1_name as category ,count(project1_name) as number from t_bill  where status>1 and  status<>3  and sys=" + sys + "   and";

    if ((star_time != null) && (!("".equals(star_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)>='" + star_time + "'   and ";
    }

    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)<='" + end_time + "'   and ";
    }

    if ((weixiu_id != null) && (!("".equals(weixiu_id)))) {
      sql = sql + " weixiu_id='" + weixiu_id + "'   and ";
    }

    if ((area != null) && (!("".equals(area)))) {
      sql = sql + " area1_name='" + area + "'   and ";
    }

    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by project1_name ";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        CountCategory c = new CountCategory();
        c.setCategory(rs.getString("category"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<MonthCount> getMonthCount(String sys)
  {
    List lists = new ArrayList();
    String sql = "select CONVERT(char(7),order_date,120) as name ,count(CONVERT(char(7),order_date,120)) as number from t_bill where order_date >=dateadd(mm,-11,getdate()) and  status<>3  and sys=" + sys + " group by CONVERT(char(7), order_date, 120 ) order by  CONVERT(char(7),order_date,120)";
    System.out.print(sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        MonthCount c = new MonthCount();
        c.setName(rs.getString("name"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<MonthCount> getMonthCount(String starTime, String endTime, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select CONVERT(char(7),order_date,120) as name,count(CONVERT(char(7),order_date,120)) as number from t_bill  where   status<>3   and sys=" + sys + "   and";

    if ((((starTime == null) || ("".equals(starTime)))) && (((endTime == null) || ("".equals(endTime)))))
    {
      sql = sql + " order_date >=dateadd(mm,-11,getdate())    and";
    }
    else {
      if ((!("".equals(starTime))) && (starTime != null)) {
        sql = sql + " CONVERT(char(10),order_date,120)>='" + starTime + "'  and ";
      }
      if ((!("".equals(endTime))) && (endTime != null)) {
        sql = sql + " CONVERT(char(10),order_date,120)<='" + endTime + "'  and ";
      }
    }

    if ((!("".equals(area))) && (area != null)) {
      sql = sql + " area1_name='" + area + "'  and ";
    }
    sql = sql.substring(0, sql.length() - 5);

    sql = sql + "group by CONVERT(char(7),order_date,120) order by  CONVERT(char(7),order_date,120)";
    System.out.println(sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        MonthCount c = new MonthCount();
        c.setName(rs.getString("name"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Bill> getAllDelayBills(String sort, String dir, String sys)
  {
    List l = new ArrayList();
    String sql = "select  (case jinji when 0 then (DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())-24) when 1 then (DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())-4) else 0 end ) as delay_time ,* from t_bill where  sys=" + 
      sys + " and ((DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())>4" + 
      " and status<2 and jinji=1)or" + 
      " (DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())>24 and status<2 and jinji=0 )) order by " + sort + " " + dir;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
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
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        b.setProject(rs.getString("project1_name") + "-" + rs.getString("project2_name") + "-" + rs.getString("project3_name"));
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        b.setDelay_time(rs.getString("delay_time"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l; }

  public List<Bill> getDelayBills(String weixiuId, String sort, String dir, String sys, String area) {
    List l = new ArrayList();
    String sql = "select  (case jinji when 0 then (DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())-24) when 1 then (DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())-4) else 0 end ) as delay_time ,* from t_bill where  sys=" + 
      sys + " and ( ((DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())>4" + 
      " and status<2 and jinji=1)or" + 
      " (DATEDIFF(hour,weixiu_date+' '+substring(order_time,7,5),getdate())>24 and status<2 and jinji=0 )))";
    if ((weixiuId != null) && (!("".equals(weixiuId)))) {
      sql = sql + " and weixiu_id='" + weixiuId + "'";
    }

    if ((area != null) && (!("".equals(area.trim())))) {
      sql = sql + " and area1_name='" + area + "'";
    }
    sql = sql + " order by " + sort + " " + dir;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
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
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        b.setProject(rs.getString("project1_name") + "-" + rs.getString("project2_name") + "-" + rs.getString("project3_name"));
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        b.setDelay_time(rs.getString("delay_time"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public List<Today> getToday(String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select (case status when 0 then '未处理' when 1 then '已受理' when 2 then '已完成' when 4 then '已评价' else '已撤单' end)  as label,count(status) as value  from t_bill  where CONVERT(char(10),getdate(),120)=CONVERT(char(10),order_date,120) and area1_name='" + 
      area + "' and sys=" + sys + 
      " group by status";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Today t = new Today();
        t.setLabel(rs.getString("label"));
        t.setValue(rs.getString("value"));
        lists.add(t);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Today> getWeek(String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select (case status when 0 then '未处理' when 1 then '已受理' when 2 then '已完成' when 4 then '已评价' else  '已撤单' end) as label,count(status) as value  from t_bill where  sys=" + 
      sys + " and area1_name='" + area + "'" + 
      " and CONVERT(char(10), DATEADD(Day,1-(DATEPART(Weekday,getdate())+@@DATEFIRST-2)%7-1,getdate()),120)" + 
      "<=CONVERT(char(10),order_date,120) " + 
      " and CONVERT(char(10),order_date,120) <= CONVERT(char(10),getdate(),120)" + 
      " group by status";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Today t = new Today();
        t.setLabel(rs.getString("label"));
        t.setValue(rs.getString("value"));
        lists.add(t);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public void log(String user_name, String name, String operation, String ip, String sys)
  {
    ResultSet rs = null;
    String sql = "select * from t_log where datediff(minute,op_time,getdate())<1 and user_name='" + user_name + "' and operation='" + operation + "' and sys=" + sys;
    try {
      rs = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (!(rs.next())) return;
    } catch (SQLException e) {
      e.printStackTrace();

      sql = "insert into t_log(user_name,name,op_time,operation,ip,sys) values('" + user_name + "','" + name + "', getdate(),'" + operation + "','" + ip + "'," + sys + ")";
      try
      {
        DBHelper.getConnection().createStatement().execute(sql);
      } catch (SQLException e1) {
        e1.printStackTrace();
      }
    }
  }

  public List<Weixiu> getPeople(String sys)
  {
    List lists = new ArrayList();
    String sql = "select * from t_user where role_id<>4 and sys=" + sys;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Weixiu b = new Weixiu();
        b.setId(rs.getString("user_name"));
        b.setName(rs.getString("name"));

        lists.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Logs> getLogs(String sort, String dir, String sys)
  {
    List lists = new ArrayList();
    String sql = "select * from t_log where sys = " + sys + " order by " + sort + " " + dir;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Logs l = new Logs();
        l.setId(rs.getString("id"));
        l.setName(rs.getString("name"));
        l.setUsername(rs.getString("user_name"));
        l.setOperation(rs.getString("operation"));
        l.setTime(rs.getString("op_time"));
        l.setIp(rs.getString("ip"));
        l.setType(rs.getString("type"));
        lists.add(l);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Logs> getLogs(String user_name, String start_time, String end_time, String sort, String dir, String sys)
  {
    List lists = new ArrayList();
    String sql = "select * from t_log where sys = " + sys + "   and";
    if ((user_name != null) && (!("".equals(user_name)))) {
      sql = sql + " user_name='" + user_name + "'  and ";
    }
    if ((start_time != null) && (!("".equals(start_time)))) {
      sql = sql + " CONVERT(char(10),op_time,120)>='" + start_time + "'  and";
    }
    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),op_time,120)<='" + end_time + "'  and";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " order by " + sort + " " + dir;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Logs l = new Logs();
        l.setId(rs.getString("id"));
        l.setName(rs.getString("name"));
        l.setUsername(rs.getString("user_name"));
        l.setOperation(rs.getString("operation"));
        l.setTime(rs.getString("op_time"));
        l.setIp(rs.getString("ip"));
        l.setType(rs.getString("type"));
        lists.add(l);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getWork(String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select weixiu_name as label ,count(weixiu_name) as value from t_bill where  status>1 and  status<>3 and area1_name = '" + area + "' sys=" + sys + " and weixiu_name is not null and  finish_time is not null group by weixiu_name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));
        c.setNumber(rs.getString("value"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getWork(String star_time, String end_time, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select weixiu_name as label ,count(weixiu_name) as value from t_bill  where area1_name = '" + area + "' and  status>1 and  status<>3 and sys = " + sys + " and weixiu_name is not null and finish_time is not null and ";

    if ((star_time != null) && (!("".equals(star_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)>='" + star_time + "'   and ";
    }

    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)<='" + end_time + "'   and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by weixiu_name ";
    System.out.println("统计：" + sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));
        c.setNumber(rs.getString("value"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public String get_month_category(String month, String sys)
  {
    String category = "";
    String sql = "select project1_name as category ,count(project1_name) as number from t_bill  where  status<>3  and sys = " + sys + "   and";

    if ((month != null) && (!("".equals(month)))) {
      sql = sql + " CONVERT(char(7),order_date,120)='" + month + "'  and";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by project1_name ";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        category = category + rs.getString("category") + ":" + rs.getString("number") + ",";
      }
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    if (category.length() > 2) {
      return category.substring(0, category.length() - 1);
    }
    return "";
  }

  public String get_month_satisfy(String month, String sys)
  {
    String manyidu = "";
    String sql = "select (case satisfy when 1 then '很满意'when 2 then '基本满意' when 3 then '不满意' when 4 then '很不满意' else '未评价' end) as satisfy,count(satisfy)  as number from t_bill where   status<>3 and sys = " + 
      sys;
    if ((month != null) && (!("".equals(month.trim())))) {
      sql = sql + " and CONVERT(char(7),order_date,120)='" + month + "'";
    }
    sql = sql + "group by satisfy";
    System.out.println(sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next())
        manyidu = manyidu + rs.getString("satisfy") + ":" + rs.getString("number") + ",";
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    if (manyidu.trim().length() > 2) {
      return manyidu.trim().substring(0, manyidu.length() - 1);
    }
    return "";
  }

  public List<AreaCount> getAreaCount(String sys)
  {
    List lists = new ArrayList();
    String sql = "select area1_name+'-'+area2_name as area ,count(area1_name+'-'+area2_name) as number  from t_bill where status>1 and status<>3 and sys = " + sys + " group by area1_name+'-'+area2_name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        AreaCount c = new AreaCount();
        c.setArea(rs.getString("area"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<AreaCount> getAreaCount(String star_time, String end_time, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select area1_name+'-'+area2_name as area ,count(area1_name+'-'+area2_name) as number from t_bill  where status>1 and status<>3  and  sys = " + sys + "   and";

    if ((star_time != null) && (!("".equals(star_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)>='" + star_time + "'   and ";
    }

    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)<='" + end_time + "'   and ";
    }

    if ((area != null) && (!("".equals(area)))) {
      sql = sql + " area1_name='" + area + "'   and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by area1_name+'-'+area2_name ";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        AreaCount c = new AreaCount();
        c.setArea(rs.getString("area"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<CountCategory> getYear(String sys)
  {
    List lists = new ArrayList();
    String sql = "select project1_name as category ,count(project1_name) as number  from t_bill where status>1 and status<>3 and sys = " + sys + " and CONVERT(char(4),order_date,120)=CONVERT(char(4),getdate(),120)  group by project1_name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        CountCategory c = new CountCategory();
        c.setCategory(rs.getString("category"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<CountCategory> getYear(String year, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select project1_name as category ,count(project1_name) as number  from t_bill where status>1 and status<>3 and sys=" + sys + "     and";

    if ((!("".equals(year))) && (year != null))
      sql = sql + " CONVERT(char(4),order_date,120) = '" + year + "'   and ";
    else {
      sql = sql + " CONVERT(char(4),order_date,120 ) =  CONVERT(char(4),getdate(),120)    and ";
    }

    if ((!("".equals(area))) && (area != null)) {
      sql = sql + " area1_name='" + area + "'    and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by project1_name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        CountCategory c = new CountCategory();
        c.setCategory(rs.getString("category"));
        c.setNumber(rs.getString("number"));
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public int updateCategory(String c_name, String id, String jinji, String weixiu_id, String level)
  {
    int r = 0;
    ResultSet rs = null;
    String sql = "";
    if (("2".equals(level)) && (weixiu_id != null))
      sql = "update t_category set name='" + c_name + "',weixiu_id='" + weixiu_id + "',jinji=" + jinji + " where id=" + id;
    else
      sql = "update t_category set name='" + c_name + "' where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement()
        .execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    try
    {
      sql = "update t_bill set weixiu_id=(select weixiu_id from t_category where t_category.id=t_bill.project3_id), project3_name=(select name from t_category where t_category.id=t_bill.project3_id), weixiu_name=(select t_user.name from t_user inner join t_category on t_user.user_name=t_category.weixiu_id where t_bill.project3_id=t_category.id), weixiu_phone=(select phon_number from t_user inner join t_category on t_user.user_name=t_category.weixiu_id where t_bill.project3_id=t_category.id) where sys=0 and status =0 and area1_name='南海' and project3_id in (select id from t_category where t_bill.project3_id =t_category.id and t_category.weixiu_id is not null and t_category.weixiu_id<>' ') ";

      DBHelper.getConnection().createStatement().execute(sql);
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    return r;
  }

  public int editBill(String id, String bz_id, String name, String phone, String descriptions, String time, String building, String building_id, String area2, String project1, String project2, String project3, String floor, String room, String project3_id, String weixiu_date, String area1, String sys)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    try {
      if ("1".equals(sys))
      {
        sql = "update t_bill set bz_phone='" + phone + "',area2_name='" + 
          area2.trim() + "', building_name='" + building.trim() + "', building_id =" + building_id.trim() + ",project3_id=" + project3_id + 
          ", floor='" + floor + "', room='" + room + "',project1_name='" + project1 + "', project2_name='" + 
          project2 + "',project3_name='" + project3 + "', descriptions='" + descriptions.trim() + "', area1_name='" + area1 + "',order_date=getdate(),order_time=substring(convert(varchar(16),getdate(),120),12,2)+':'+'00'+'-'+substring(convert(varchar(16),getdate(),120),12,2)+':'+'00' where id=" + id;
      }
      else if ((project3_id == null) || ("".equals(project3_id))) {
        sql = "update t_bill set bz_phone='" + phone + "',area2_name='" + 
          area2.trim() + "', building_name='" + building.trim() + "', building_id =" + building_id.trim() + 
          ", floor='" + floor + "', room='" + room + "',project1_name='" + project1 + "', project2_name='" + 
          project2.trim() + "',project3_name='" + project3.trim() + "', descriptions='" + descriptions.trim() + "', area1_name='" + area1 + "', order_time='" + time + "',weixiu_date='" + weixiu_date + "' where id=" + id;
      }
      else
      {
        String sql1 = "select jinji from t_category where id=" + project3_id;

        rsset = DBHelper.getConnection().createStatement().executeQuery(sql1);
        if (rsset.next()) {
          sql = "update t_bill set bz_phone='" + phone + "',area2_name='" + 
            area2.trim() + "', building_name='" + building.trim() + "', building_id =" + building_id.trim() + ",project3_id=" + project3_id + 
            ", floor='" + floor + "', room='" + room + "',project1_name='" + project1 + "', project2_name='" + 
            project2.trim() + "',project3_name='" + project3.trim() + "', descriptions='" + descriptions.trim() + "', area1_name='" + area1 + "', order_time='" + time + "',weixiu_date='" + weixiu_date + "',jinji=" + rsset.getString("jinji") + " where id=" + id;
        }
        else {
          sql = "update t_bill set bz_phone='" + phone + "',area2_name='" + 
            area2.trim() + "', building_name='" + building.trim() + "', building_id =" + building_id.trim() + ",project3_id=" + project3_id + 
            ", floor='" + floor + "', room='" + room + "',project1_name='" + project1 + "', project2_name='" + 
            project2.trim() + "',project3_name='" + project3.trim() + "', descriptions='" +descriptions.trim() + "', area1_name='" + area1 + "', order_time='" + time + "',weixiu_date='" + weixiu_date + "' where id=" + id;
        }
      }
      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    } catch (SQLException e) {
      rs = 2;
      e.printStackTrace();
    }

    if ("1".equals(sys))
    {
      sql = "update t_bill set weixiu_id=(select net_weixiu from t_building where t_building.id=t_bill.building_id), building_name=(select name from t_building where t_building.id=t_bill.building_id ), weixiu_name=(select t_user.name from t_user inner join t_building on t_user.user_name=t_building.net_weixiu where t_bill.building_id=t_building.id), weixiu_phone=(select phon_number from t_user inner join t_building on t_user.user_name=t_building.net_weixiu where t_bill.building_id=t_building.id) where sys=1 and status =0 and id=" + 
        id;
      try {
        DBHelper.getConnection().createStatement().execute(sql);
      }
      catch (SQLException e) {
        e.printStackTrace();
      }
      rs = 1;
    }
    if ("0".equals(sys))
    {
      sql = "update t_bill set weixiu_id=(select weixiu_id from t_building where t_building.id=t_bill.building_id), building_name=(select name from t_building where t_building.id=t_bill.building_id ), weixiu_name=(select t_user.name from t_user inner join t_building on t_user.user_name=t_building.weixiu_id where t_bill.building_id=t_building.id), weixiu_phone=(select phon_number from t_user inner join t_building on t_user.user_name=t_building.weixiu_id where t_bill.building_id=t_building.id) where sys=0 and status =0 and id=" + 
        id;
      try {
        DBHelper.getConnection().createStatement().execute(sql);
      }
      catch (SQLException e) {
        e.printStackTrace();
      }

      sql = "update t_bill set weixiu_id=(select weixiu_id from t_category where t_category.id=t_bill.project3_id), weixiu_name=(select t_user.name from t_user inner join t_category on t_user.user_name=t_category.weixiu_id where t_bill.project3_id=t_category.id), weixiu_phone=(select phon_number from t_user inner join t_category on t_user.user_name=t_category.weixiu_id where t_bill.project3_id=t_category.id) where sys=0 and status =0 and area1_name='南海' and project3_id in (select id from t_category where t_bill.project3_id =t_category.id and t_category.weixiu_id is not null and t_category.weixiu_id<>' ') ";
      try
      {
        DBHelper.getConnection().createStatement().execute(sql);
      }
      catch (SQLException e) {
        e.printStackTrace();
      }
      rs = 1;
    }

    return rs;
  }

  public int deleteBill(String id)
  {
    int r = 0;
    String sql = "delete from t_bill where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public List<Bill> findNewtasks(String weixiu_id, String sys, String sort, String dir)
  {
    List l = new ArrayList();
    String sql = "select * from t_bill where sys =" + sys + "  and status<=1 and weixiu_id='" + weixiu_id + "'";
    sql = sql + "  order by " + sort + " " + dir;
    System.out.println(sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Bill b = new Bill();
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
        b.setFinish_time(rs.getString("finish_time"));
        b.setDescriptions(rs.getString("descriptions"));
        b.setWeixiu_phone(rs.getString("weixiu_phone"));
        b.setArea1(rs.getString("area1_name"));
        b.setArea2(rs.getString("area2_name"));
        b.setBuilding(rs.getString("building_name"));
        b.setFloor(rs.getString("floor"));
        b.setRoom(rs.getString("room"));
        String project = "";
        if (rs.getString("project1_name") != null)
          project = project + rs.getString("project1_name").trim();
        if (rs.getString("project2_name") != null)
          project = project + "-" + rs.getString("project2_name").trim();
        if (rs.getString("project3_name") != null)
          project = project + "-" + rs.getString("project3_name").trim();
        b.setProject(project);
        b.setProject1(rs.getString("project1_name"));
        b.setProject2(rs.getString("project2_name"));
        b.setProject3(rs.getString("project3_name"));
        b.setJinji(rs.getString("jinji"));
        l.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return l;
  }

  public int delteLogs(String id)
  {
    int rs = 0;
    String sql = "delete from t_log where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      rs = 0;
    }
    return rs;
  }

  public List<Material> getMaterial(String category_id)
  {
    List lists = new ArrayList();
    String sql = "select a.id as id,a.name as name,a.provider as provider,a.remark as remark,a.standard as standard, a.unit as unit,a.unit_price as unit_price,b.id as category_id,b.name as category_name from t_material a left join t_category b on b.id=a.category_id ";
    if ((category_id != null) && (!("".equals(category_id))))
      sql = "select a.id as id,a.name as name,a.provider as provider,a.remark as remark,a.standard as standard, a.unit as unit,a.unit_price as unit_price,b.id as category_id,b.name as category_name from t_material a left join t_category b on b.id=a.category_id where category_id=" + category_id;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Material b = new Material();
        b.setId(rs.getString("id"));
        b.setName(rs.getString("name"));
        b.setProvider(rs.getString("provider"));
        b.setStandard(rs.getString("standard"));
        b.setUnit(rs.getString("unit"));
        b.setUnit_price(rs.getString("unit_price"));
        b.setCategory_id(rs.getString("category_id"));
        b.setCategory_name(rs.getString("category_name"));
        b.setRemark(rs.getString("remark"));
        lists.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public int addMaterial(String name, String provider, String standard, String unit_price, String unit, String category_id, String remark)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    int material_id = 0;
    try
    {
      sql = "select * from t_material where name='" + name + "'and standard='" + standard + "' and provider='" + provider + "'";

      rsset = DBHelper.getConnection().createStatement().executeQuery(sql);
      if (rsset.next()) return 0;

      sql = "insert into t_material(name,provider,standard,unit_price,category_id,unit,remark) values('" + 
        name + "','" + provider + "','" + standard + "'," + unit_price + "," + category_id + ",'" + unit + "','" + remark + "')";

      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    return rs;
  }

  public int delteMaterial(String id)
  {
    int rs = 0;
    String sql = "delete from t_material where id=" + id;
    try {
      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      rs = 0;
    }
    return rs;
  }

  public int setFinish1(String id, String finishTime, String project1, String solution)
  {
    int r = 0;
    String sql = "update t_bill set status=2,finish_time ='" + finishTime + "',project1_name='" + project1 + "',solution='" + solution + "' where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public int setFinish(String id, String finish_time, String weixiu_id, String work_hours)
  {
    int r = 0;
    String sql = "update t_bill set status=2,finish_time ='" + finish_time + "',working_hours=" + work_hours + ",weixiu_id='" + weixiu_id + "',weixiu_name=(select max(name) from t_user where role_id=3 and user_name='" + weixiu_id + "') where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public int changePSD(String user_name, String password, String sys)
  {
    int r = 0;
    String sql = "update t_user set password='" + password + "' where user_name='" + user_name + "' and sys =" + sys;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      r = 0;
    }
    return r;
  }

  public int setPrinted(String id)
  {
    int r = 0;
    String sql = "update t_bill set is_print= 1 where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      r = 0;
      e.printStackTrace();
    }
    return r;
  }

  public String getcountBills(String select_time, String attribute, String area)
  {
    String list = "";
    String sql = "select order_time,count(*) as bill_count from t_bill where status in(0,1) and weixiu_date='" + select_time + "' group by order_time order by order_time";
    if ((area != null) && (!("".equals(area)))) {
      sql = "select order_time,count(*) as bill_count from t_bill where status in(0,1) and weixiu_date='" + select_time + "' and area1_name='" + area + "' group by order_time order by order_time";
    }
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next())
      {
        list = list + rs.getString("order_time") + "," + rs.getString("bill_count") + "|";
      }
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return list;
  }

  public int editMaterial(String id, String name, String provider, String standard, String unit_price, String unit, String category_id, String remark)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    int material_id = 0;
    try
    {
      sql = "update  t_material set name='" + 
        name + "', provider='" + provider + "',standard='" + standard + "',unit_price=" + unit_price + ",category_id=" + category_id + ",unit='" + unit + "', remark='" + remark + "' where id=" + id;

      DBHelper.getConnection().createStatement().execute(sql);
      rs = 1;
    } catch (SQLException e) {
      rs = 2;
      e.printStackTrace();
    }

    return rs;
  }

  public List<Supplies> getSupplies(String bill_id)
  {
    List lists = new ArrayList();
    String sql = "select a.id as id,b.unit as unit,a.number as number,b.name as name,b.provider as provider,b.standard as standard, b.unit_price as unit_price,c.name as category_name,b.remark as remark,b.id as material_id  from supplies a left join t_material b on b.id=a.material_id left join t_category c on b.category_id=c.id where a.bill_id=" + 
      bill_id;
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Supplies b = new Supplies();
        b.setId(rs.getString("id"));
        b.setName(rs.getString("name"));
        b.setProvider(rs.getString("provider"));
        b.setStandard(rs.getString("standard"));
        b.setUnit_price(rs.getString("unit_price"));
        b.setCategory_name(rs.getString("category_name"));
        b.setRemark(rs.getString("remark"));
        b.setMaterial_id(rs.getString("material_id"));
        String number = rs.getString("number");

        if (".0".equals(number.substring(number.length() - 2, number.length())))
          number = number.substring(0, number.length() - 2);
        b.setNumber(number);
        float total = Float.parseFloat(rs.getString("unit_price")) * Float.parseFloat(rs.getString("number"));
        b.setTotal(total);
        b.setBill_id(bill_id);
        b.setUnit(rs.getString("unit"));
        lists.add(b);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public int delteSupplies(String id)
  {
    int rs = 0;
    String sql = "delete from supplies where id=" + id;
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    } catch (SQLException e) {
      e.printStackTrace();
      rs = 0;
    }
    return rs;
  }

  public int addSupplies(String material_id, String number, String bill_id)
  {
    ResultSet rsset = null;
    int rs = 0;
    String sql = "";
    try
    {
      sql = "insert into supplies (number,material_id,bill_id) values('" + 
        number + "','" + material_id + "','" + bill_id + "')";

      DBHelper.getConnection().createStatement().execute(sql);

      rs = 1;
    }
    catch (SQLException e)
    {
      rs = 2;
      e.printStackTrace();
    }

    return rs;
  }

  public List<Work> getWorkHours(String star_time, String end_time, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select weixiu_name as label ,sum(working_hours) as value from t_bill  where  status>1 and  status<>3 and sys = " + sys + " and weixiu_name is not null and finish_time is not null and area1_name ='" + area + "'   and ";

    if ((star_time != null) && (!("".equals(star_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)>='" + star_time + "'   and ";
    }

    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),order_date,120)<='" + end_time + "'   and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by weixiu_name ";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));
        String number = rs.getString("value");
        if (number.indexOf(".")!=-1) {
          number = number.substring(0, number.indexOf(".") + 2);
        }
        c.setNumber(number);
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getWorkHours(String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select weixiu_name as label ,sum(working_hours) as value from t_bill where  status>1 and  status<>3 and sys=" + sys + " and weixiu_name is not null and  finish_time is not null and area1_name = '" + area + "' group by weixiu_name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));
        String number = rs.getString("value");

        if (number.indexOf(".")!=-1) {
          number = number.substring(0, number.indexOf(".") + 2);
        }

        c.setNumber(number);
        lists.add(c);
      }
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getCountSupplies(String sys)
  {
    List lists = new ArrayList();
    String sql = "select c.name+'-'+b.name+'('+b.unit+')' as label,sum(a.number) as value from supplies a left join t_material b on a.material_id=b.id left join t_category c on b.category_id=c.id group by c.name+'-'+b.name+'('+b.unit+')'";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));

        String number = rs.getString("value");
        if (".0".equals(number.substring(number.length() - 2, number.length())))
          number = number.substring(0, number.length() - 2);
        c.setNumber(number);
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getCountSupplies(String star_time, String end_time, String sys, String area)
  {
    List lists = new ArrayList();
    String sql = "select c.name+'-'+b.name+'('+b.unit+')' as label,sum(a.number) as value from supplies a left join t_material b on a.material_id=b.id left join t_category c on b.category_id=c.id left join t_bill d on a.bill_id=d.id  where area1_name = '" + area + "'   and ";

    if ((star_time != null) && (!("".equals(star_time)))) {
      sql = sql + " CONVERT(char(10),d.order_date,120)>='" + star_time + "'   and ";
    }

    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),d.order_date,120)<='" + end_time + "'   and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by c.name+'-'+b.name+'('+b.unit+')' ";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));

        String number = rs.getString("value");
        if (".0".equals(number.substring(number.length() - 2, number.length())))
          number = number.substring(0, number.length() - 2);
        c.setNumber(number);
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getmoney(String attribute)
  {
    List lists = new ArrayList();
    String sql = "select b.name as label,sum(a.number*b.unit_price) as value from supplies a left join t_material b on a.material_id=b.id left join t_category c on b.category_id=c.id group by b.name";
    try
    {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));
        String value = rs.getString("value");
        if (value.indexOf(".")!=-1) {
          value = value.substring(0, value.indexOf(".") + 2);
        }
        c.setNumber(value);
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public List<Work> getmoney(String star_time, String end_time, String attribute, String area)
  {
    List lists = new ArrayList();
    String sql = "select b.name as label,sum(a.number*b.unit_price) as value from supplies a left join t_material b on a.material_id=b.id left join t_category c on b.category_id=c.id left join t_bill d on a.bill_id=d.id  where b.name is not null and d.area1_name= '" + area + "'   and ";

    if ((star_time != null) && (!("".equals(star_time)))) {
      sql = sql + " CONVERT(char(10),d.order_date,120)>='" + star_time + "'   and ";
    }

    if ((end_time != null) && (!("".equals(end_time)))) {
      sql = sql + " CONVERT(char(10),d.order_date,120)<='" + end_time + "'   and ";
    }
    sql = sql.substring(0, sql.length() - 5);
    sql = sql + " group by b.name order by label";
    System.out.println("统计：" + sql);
    try {
      ResultSet rs = DBHelper.getConnection().createStatement()
        .executeQuery(sql);

      while (rs.next()) {
        Work c = new Work();
        c.setWork(rs.getString("label"));
        String value = rs.getString("value");
        if (value.indexOf(".")!=-1) {
          value = value.substring(0, value.indexOf(".") + 2);
        }
        c.setNumber(value);
        lists.add(c);
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return lists;
  }

  public int distributionBuilding(String id, String weixiu_id)
  {
    int r = 0;
    String sql = "update t_building  set net_weixiu='" + weixiu_id + "' where id=" + id;
    try {
      DBHelper.getConnection().createStatement().execute(sql);
      r = 1;
    } catch (SQLException e) {
      r = 0;
      e.printStackTrace();
    }

    sql = "update t_bill set weixiu_id=(select net_weixiu from t_building where t_building.id=t_bill.building_id), building_name=(select name from t_building where t_building.id=t_bill.building_id ), weixiu_name=(select t_user.name from t_user inner join t_building on t_user.user_name=t_building.net_weixiu where t_bill.building_id=t_building.id), weixiu_phone=(select phon_number from t_user inner join t_building on t_user.user_name=t_building.net_weixiu where t_bill.building_id=t_building.id) where sys=1 and status =0";
    try
    {
      DBHelper.getConnection().createStatement().execute(sql);
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    return r;
  }
}
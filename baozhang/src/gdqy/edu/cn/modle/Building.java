package gdqy.edu.cn.modle;

public class Building {
private String id;
private String name;
private int area1_id;
private int area2_id;
private String area2_name;
private String weixiu;
private String phone;
private String net_weixiu;
private String net_phone;

public String getNet_phone() {
	return net_phone;
}
public void setNet_phone(String net_phone) {
	this.net_phone = net_phone;
}
public String getNet_weixiu() {
	return net_weixiu;
}
public void setNet_weixiu(String net_weixiu) {
	this.net_weixiu = net_weixiu;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getWeixiu() {
	return weixiu;
}
public void setWeixiu(String weixiu) {
	this.weixiu = weixiu;
}
public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}


public Building() {
	
}
public int getArea1_id() {
	return area1_id;
}
public void setArea1_id(int area1_id) {
	this.area1_id = area1_id;
}
public int getArea2_id() {
	return area2_id;
}
public void setArea2_id(int area2_id) {
	this.area2_id = area2_id;
}
public String getArea2_name() {
	return area2_name;
}
public void setArea2_name(String area2_name) {
	this.area2_name = area2_name;
}

}

package gdqy.edu.cn.modle;

public class Category {
	private String id;
	private String name;
	private String level;
	private String p_id;
	private String p_name;
	private String pp_id;
	private String pp_name;
	private String jinji;
	
	
	public String getJinji() {
		return jinji;
	}
	public void setJinji(String jinji) {
		this.jinji = jinji;
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
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String pId) {
		p_id = pId;
	}
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getPp_id() {
		return pp_id;
	}
	public void setPp_id(String pp_id) {
		this.pp_id = pp_id;
	}
	public String getPp_name() {
		return pp_name;
	}
	public void setPp_name(String pp_name) {
		this.pp_name = pp_name;
	}
	

}

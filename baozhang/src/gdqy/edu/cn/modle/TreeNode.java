package gdqy.edu.cn.modle;

import java.util.List;

public class TreeNode {
	private String name;
	private String id;
	private List<TreeNode> chilldrens;
	private boolean isleaf;
	public TreeNode() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<TreeNode> getChilldrens() {
		return chilldrens;
	}
	public void setChilldrens(List<TreeNode> chilldrens) {
		this.chilldrens = chilldrens;
	}
	public boolean isIsleaf() {
		return isleaf;
	}
	public void setIsleaf(boolean isleaf) {
		this.isleaf = isleaf;
	}

}

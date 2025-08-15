package com.dayuan.model.data;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.dayuan.util.StringUtil;

/**
 * 树节点模型
 * @author Dz
 *
 */
public class TreeNode implements Serializable {
	private String id;                  //要显示的子节点的ID  
    private String text;                //要显示的子节点的 Text  
    private String state;
    private String iconCls;             //节点的图标  
    private String parentId;            //父节点的ID  
    private List<TreeNode>  children;   //孩子节点的List
    private boolean checked = false;
    private Map<String, Object>  attributes;
    
	public TreeNode() {
		super();
	}
	
	public TreeNode(String id, String text, String state, String iconCls,
			String parentId, List<TreeNode> children, boolean checked,
			Map<String, Object> attributes) {
		super();
		this.id = id;
		this.text = text;
		this.state = state;
		this.iconCls = iconCls;
		this.parentId = parentId;
		this.children = children;
		this.checked = checked;
		this.attributes = attributes;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public List<TreeNode> getChildren() {
		return children;
	}
	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public Map<String, Object> getAttributes() {
		return attributes;
	}
	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
}

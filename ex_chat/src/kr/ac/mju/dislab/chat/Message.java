package kr.ac.mju.dislab.chat;
import java.util.*;

import org.json.simple.JSONObject;

public class Message implements java.io.Serializable{
	private String name;
	private String content;
	private int id;
	private Date time;
	
	public Message()
	{
		
	}
	public Message(int id, String name, String message)
	{
		super();
		this.id=id;
		this.name = name;
		this.setContent(message);
		
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getTime()
	{
		return this.time;
	}
	public String getTimeString()
	{
		return time.toString();
	}
	public void setTime(Date time)
	{
		this.time=time;
	}
	//json 형태로 출력
	public JSONObject toJSON(String current_name)
	{
	
		JSONObject jobj = new JSONObject();
		jobj.put("name",getName());
		jobj.put("message", getContent());
		jobj.put("time",getTimeString());
		jobj.put("id", getId());
		jobj.put("mine",  (current_name != null && current_name.equals(getName())) ? "mine":"");
		
		return jobj;
	}

}

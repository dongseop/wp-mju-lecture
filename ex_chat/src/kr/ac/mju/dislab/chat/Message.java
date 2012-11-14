package kr.ac.mju.dislab.chat;

import java.sql.Timestamp;
import java.util.*;

import org.json.simple.JSONObject;

public class Message implements java.io.Serializable {
	private static final long serialVersionUID = 7116948049833402318L;
	private String name;
	private String content;
	private int id;
	private Date time;

	public Message(String name, String content) {
		this.name = name;
		this.content = content;
	}

	public Message(int id, String name, String content, Timestamp time) {
		this.id = id;
		this.name = name;
		this.content = content;
		this.time = time;
	}

	public String getName() {
		return name;
	}

	public int getId() {
		return id;
	}

	public String getContent() {
		return content;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	// json 형태로 출력
	public JSONObject toJSON(String current_name) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("name", getName());
		jsonObj.put("content", getContent());
		jsonObj.put("time", time.toString());
		jsonObj.put("id", getId());
		jsonObj.put("mine", (current_name != null && 
				current_name.equals(getName())) ? "mine" : "");

		return jsonObj;
	}

}

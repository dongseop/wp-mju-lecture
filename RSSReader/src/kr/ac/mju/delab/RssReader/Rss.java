package kr.ac.mju.delab.RssReader;

import java.io.IOException;
import java.util.*;

import org.jdom2.*;
import org.jdom2.input.SAXBuilder;

public class Rss implements java.io.Serializable{
	private static final long serialVersionUID = 1L;

	private String title;
	private String link;
	private String desc;
	private ArrayList<Feed> feedlist;
		
	public Rss(){ }
	
	public Rss(String rssurl) throws JDOMException, IOException{
		SAXBuilder saxBuilder = new SAXBuilder();
		Document jdomDocument = saxBuilder.build(rssurl);
		Element root = jdomDocument.getRootElement();
		Element channel = root.getChild("channel");
		
		this.title = channel.getChildText("title");
		this.desc = channel.getChildText("description");
		this.link = channel.getChildText("link");
		
		List<Element> children = channel.getChildren("item");
		Iterator<Element> iter = children.iterator();
		
		feedlist = new ArrayList<Feed>();
		
		while(iter.hasNext()){			
			Object obj = iter.next();
			Element item = ((Element)obj);
			Feed feed = new Feed(item.getChildTextTrim("title"), item.getChildTextTrim("link"), item.getChildText("pubDate"));
			feedlist.add(feed);
		}
	}
	
	public String getTitle() { return this.title; }
	public void setTitle(String title) { this.title = title; }	
	
	public String getDesc() { return this.desc; }
	public void setDesc(String desc) { this.desc = desc; }
	
	public ArrayList<Feed> getFeedlist() { return feedlist; }
	public void setFeedlist(ArrayList<Feed> feedlist) { this.feedlist = feedlist; }

	public String getLink() { return link; }
	public void setLink(String link) { this.link = link;}
}

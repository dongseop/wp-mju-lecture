package kr.ac.mju.delab.RssReader;

import java.io.IOException;
import java.util.*;

import org.jdom2.*;
import org.jdom2.input.SAXBuilder;

public class Rss implements java.io.Serializable{
	private static final long serialVersionUID = 1L;

	private ArrayList<Feed> feedlist;
		
	public Rss(){ }
	
	public Rss(String[] rssurl) throws JDOMException, IOException{
		feedlist = new ArrayList<Feed>();
			
		for(int i=0; i < rssurl.length; i++){
			SAXBuilder saxBuilder = new SAXBuilder();
			Element root = saxBuilder.build(rssurl[i]).getRootElement();
			Element channel = root.getChild("channel");
			
			List<Element> children = channel.getChildren("item");
			Iterator<Element> iter = children.iterator();
			
			while(iter.hasNext()){			
				Object obj = iter.next();
				Element item = ((Element)obj);
				Feed feed = new Feed(item.getChildTextTrim("title"), item.getChildTextTrim("link"), item.getChildText("pubDate"));
				feedlist.add(feed);
			}
		}
	}
	
	public ArrayList<Feed> getFeedlist() { return feedlist; }
	public void setFeedlist(ArrayList<Feed> feedlist) { this.feedlist = feedlist; }
}

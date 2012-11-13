package kr.ac.mju.delab.RssReader;

public class Feed implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String title;
	private String link;
	private String pubDate;
	
	Feed(){	}
	
	Feed(String title, String link, String pubDate){
		this.title = title;
		this.link = link;
		this.pubDate = pubDate;
	}
	
	public String getTitle() { return title; }
	public void setTitle(String title) { this.title = title; }
	
	public String getLink() { return link; }
	public void setLink(String link) { this.link = link; }
	
	public String getPubDate() { return pubDate; }
	public void setPubDate(String pubDate) { this.pubDate = pubDate; }
}

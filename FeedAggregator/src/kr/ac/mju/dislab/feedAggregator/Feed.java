package kr.ac.mju.dislab.feedAggregator;

import java.io.IOException;
import java.util.List;
import org.jdom2.input.SAXBuilder;
import org.jdom2.*;

public class Feed implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private String url;

	public Feed(String url) {
		this.url = url;
	}

	public List<News> getNews(List<News> resultList) throws JDOMException, IOException {
		SAXBuilder saxBuilder = new SAXBuilder();
		Element root = saxBuilder.build(url).getRootElement();
		Element channel = root.getChild("channel");
		List<Element> children = channel.getChildren("item");

		for(Element e : children) {
			resultList.add(new News(e.getChildTextTrim("title"), e.getChildTextTrim("link"), e.getChildTextTrim("pubDate")));
		}		

		return resultList;		
	}
}

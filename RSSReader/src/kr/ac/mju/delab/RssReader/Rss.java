package kr.ac.mju.delab.RssReader;

import java.io.IOException;
import java.util.*;

import org.jdom2.*;
import org.jdom2.input.SAXBuilder;

public class Feed {
	public Feed(url) throws JDOMException, IOException{
		this.url = url;
	}
	
	public getNews(List<News> resultList) {
		feedlist = new ArrayList<Feed>();
			
			SAXBuilder saxBuilder = new SAXBuilder();
			Element root = saxBuilder.build(url).getRootElement();
			Element channel = root.getChild("channel");
			
			List<Element> children = channel.getChildren("item");

			for(Element e : children) {
				resultList.add(new News(e.getChildTextTrim("title")...));
			}

	}
}

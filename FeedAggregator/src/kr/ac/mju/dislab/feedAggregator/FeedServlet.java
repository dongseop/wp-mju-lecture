package kr.ac.mju.dislab.feedAggregator;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom2.JDOMException;

@WebServlet("/FeedServlet")
public class FeedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FeedServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String[] urlList = {"http://hani.co.kr/rss/lead/", "http://rss.ohmynews.com/rss/top.xml", "http://myhome.chosun.com/rss/www_section_rss.xml"};
		List<News> newsList = new ArrayList<News>();
		
		for(String url : urlList) {
			Feed feed = new Feed(url);
			try {
				newsList = feed.getNews(newsList);				
			} catch (JDOMException e) {
				e.printStackTrace();
			}			
		}		
		request.setAttribute("news", newsList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("feed.jsp");
		dispatcher.forward(request, response);
	}
}

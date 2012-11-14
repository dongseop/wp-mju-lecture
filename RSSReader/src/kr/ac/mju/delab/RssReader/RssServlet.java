package kr.ac.mju.delab.RssReader;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom2.JDOMException;


@WebServlet("/RssServelet")
public class RssServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RssServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String[] urlList = {"xxxxx", "xxxx", "xxxx"};
		List<News> newsList = new ArrayList<News>)();
		for(String url : urlList) {
			Feed feed = new Feed(url);
			feed.getNews(newsList);
		}
		
		request.setAttribute("news", newsList);

		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request, response);
	}
}

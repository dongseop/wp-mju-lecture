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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String url = request.getParameter("url");
		String actionUrl = "";
		
		Rss rss;
		try {
			rss = new Rss(url);
			request.setAttribute("title", rss.getTitle());
			request.setAttribute("desc", rss.getDesc());
			request.setAttribute("link", rss.getLink());
			request.setAttribute("feedlist", rss.getFeedlist());
			actionUrl = "rss.jsp";
			
		} catch (JDOMException e) {
			actionUrl = "rssError.jsp";
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request, response);
	}
}

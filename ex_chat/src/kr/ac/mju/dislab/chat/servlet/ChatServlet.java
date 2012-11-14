package kr.ac.mju.dislab.chat.servlet;


import java.io.IOException;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.*;

import kr.ac.mju.dislab.chat.*;

/**
 * Servlet implementation class messageSender
 */
@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChatServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//메세지 수신 
		HttpSession session = request.getSession(true);
		String current_name = "";

		if(session != null && session.getAttribute("name") != null) {
			current_name = session.getAttribute("name").toString();
		}
		
		int last = -1;
		
		try {
			last = Integer.parseInt(request.getParameter("last"));
		} catch(NumberFormatException e) {}

		JSONObject resultObj = new JSONObject();

		//Chat 내역을 JSON 형태로 변환하여 나타냄.
		try {
			List<Message> chatList = ChatDAO.getChatList(last);
			JSONArray jsonList = new JSONArray();
			for(Message chat : chatList) {
				jsonList.add(chat.toJSON(current_name));
			}
			if (chatList.size() > 0) {
				last = chatList.get(chatList.size() - 1).getId();
			}
			resultObj.put("size", chatList.size());
			resultObj.put("msgs", jsonList);
			resultObj.put("last", last);
		} catch (Exception e) {
			e.printStackTrace();
			resultObj.put("ERROR", e.getMessage());
		} 
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(resultObj.toJSONString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//메세지 전송 
		boolean ret = false;
		
		request.setCharacterEncoding("UTF-8");

		String name = request.getParameter("name");
		String content = request.getParameter("content");

		//세션을 생성하여 name 에 현재 작성한 사람의 이름을 저장함.
		HttpSession session=request.getSession(true);
		session.setAttribute("name", name.toString());

		try {
			//message를 저장.
			if (ChatDAO.sendMessage(new Message(name, content))) {					
				response.getWriter().write("ok");
			} else {
				response.getWriter().write("메세지 전송에 실패했습니다..");
			}
		} catch (Exception e) {
			response.getWriter().write(e.getMessage());

		} 
	}

}

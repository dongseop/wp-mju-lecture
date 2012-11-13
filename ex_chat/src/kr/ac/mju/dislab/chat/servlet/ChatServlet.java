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
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//메세지 수신 
		HttpSession session=request.getSession(true);
		String current_name="";

		//session에서 name 값 읽어옴 
		if(session != null && session.getAttribute("name") != null)
			current_name=(String) session.getAttribute("name").toString();

		int last = Integer.parseInt(request.getParameter("last"));

		JSONObject resultObj = new JSONObject();

		//Chat 내역을 JSON 형태로 변환하여 나타냄.
		try {
			List<Message> chatList = ChatDAO.getChatList(last);
			JSONArray jsonList=new JSONArray();
			for(Message chat : chatList)
			{
				jsonList.add(chat.toJSON(current_name));
				last=chat.getId();
			}

			resultObj.put("size", (int)chatList.size());
			resultObj.put("msgs", jsonList);
			resultObj.put("last", last);

		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		// TODO Auto-generated method stub
		//메세지 전송 
		boolean ret = false;
		Message msg = new Message();

		request.setCharacterEncoding("UTF-8");

		String name = request.getParameter("name");
		String message = request.getParameter("message");


		//세션을 생성하여 name 에 현재 작성한 사람의 이름을 저장함.
		HttpSession session=request.getSession(true);
		session.setAttribute("name", name.toString());

		if (name != "")
		{
			msg.setName(name);
		}
		if (message != "")
		{
			msg.setContent(message);
		}

		try 
		{
			//message를 저장.
			ret=ChatDAO.sendMessage(msg);

			if (ret != true) 
			{					
				response.getWriter().write("메세지 전송에 실패했습니다..");
			}
			else
			{
				response.getWriter().write("ok");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block				
			response.getWriter().write(e.getMessage());

		} catch (NamingException e) {
			// TODO Auto-generated catch block
			response.getWriter().write(e.getMessage());	
		}

	}

}

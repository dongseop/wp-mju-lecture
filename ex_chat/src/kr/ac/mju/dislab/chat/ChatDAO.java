package kr.ac.mju.dislab.chat;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.*;

public class ChatDAO {
	public static DataSource getDataSource() throws NamingException {
		Context initCtx = null;
		Context envCtx = null;

		// Obtain our environment naming context
		initCtx = new InitialContext();
		envCtx = (Context) initCtx.lookup("java:comp/env");

		// Look up our data source
		return (DataSource) envCtx.lookup("jdbc/WebDB");
	}
	
	public static List<Message> getChatList(int last) throws SQLException, NamingException {
		
		List<Message> msgList = new ArrayList<Message>();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();
			
			// 질의 준비
			if (last >= 0) {
				// last 이후의 모든 메시지
				stmt = conn.prepareStatement("SELECT * FROM chats WHERE id > ? ;");
				stmt.setInt(1,  last);
			} else {
				// 마지막 10개의 메시지만..
				stmt = conn.prepareStatement("SELECT * FROM "
						+"(SELECT * FROM chats ORDER BY id DESC LIMIT 100 ) t " 
						+"ORDER BY id ;");
			}

			
			// 수행
			rs = stmt.executeQuery();

			while (rs.next()) {
				Message msg = new Message(rs.getInt("id"), rs.getString("name"), 
								rs.getString("message"), rs.getTimestamp("created_at"));
				msgList.add(msg);		
			}	
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return msgList;
		
	
	}
	public static boolean sendMessage(Message msg) throws SQLException, NamingException
	{
		int result;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			
			stmt = conn.prepareStatement("INSERT INTO chats(name, message) VALUES (?, ?);");
			stmt.setString(1, msg.getName());
			stmt.setString(2, msg.getContent());
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);
	}
	

}

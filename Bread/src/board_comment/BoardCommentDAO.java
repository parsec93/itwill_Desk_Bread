package board_comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class BoardCommentDAO {

	
	public Connection getConnection() throws Exception{
		Context init = new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB"); //위치/이름
		Connection con=ds.getConnection();
		return con;
		
	}
	
	//insertBoardComment(bcb) 메서드
	public void insertBoardComment(BoardCommentBean bcb) {
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int num=0;
		
		try {
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			 //3단계 sql
			 String sql="select max(comment_num) from board_comment";
			 pstmt=con.prepareStatement(sql);
			 //4단계 
			 rs=pstmt.executeQuery();
			 //5단계
			 if(rs.next()) {
				 num=rs.getInt("max(comment_num)")+1;
			 }
			//3단계 sql (insert) now()
			 sql="insert into board_comment(comment_num, comment_board, comment_id, comment_date,comment_content) values(?, ?, ?, now(), ?)";
			 pstmt=con.prepareStatement(sql);
			 pstmt.setInt(1, num); //첫번째 물음표,값
			 pstmt.setInt(2, bcb.getComment_board());//두번째물음표,값
			 pstmt.setString(3, bcb.getComment_id());//세번째물음표,값
			 pstmt.setString(4, bcb.getComment_content());
			//4단계 실행
			 pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리작업 // 기억장소  con pstmt  rs 정리
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
	}
	
	//getBoard(num)
		public List<BoardCommentBean> getBoardComment(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			BoardCommentBean bcb=null;
			List<BoardCommentBean> commentList = new ArrayList<BoardCommentBean>();
			try {
				//1단계 드라이버 로더			//2단계 디비연결
				con=getConnection();
				// 3단계 sql(select) 만들고 실행할 객체 생성
				String sql="select * from board_comment where comment_board=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				// 4단계 : 결과저장 <= sql  구문 실행 select
				rs=pstmt.executeQuery();
				//5단계 : select 결과를 화면출력
				 // rs위치 다음행 이동
				while(rs.next()) {
					bcb=new BoardCommentBean();
					bcb.setComment_num(rs.getInt("comment_num"));
					bcb.setComment_content(rs.getString("comment_content"));
					bcb.setComment_id(rs.getString("comment_id"));
					bcb.setDate(rs.getDate("comment_date"));
					commentList.add(bcb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
			return commentList;
		}
	
	
	
	
	
}

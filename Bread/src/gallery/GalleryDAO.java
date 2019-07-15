package gallery;

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

public class GalleryDAO {

	// 디비 연결 메서드.
	public Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB"); // 위치/이름
		Connection con = ds.getConnection();
		return con;
	}

	// insertGallery(bb) 메서드
	public void insertGallery(GalleryBean gb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql
			String sql = "select max(num) from gallery";
			pstmt = con.prepareStatement(sql);
			// 4단계
			rs = pstmt.executeQuery();
			// 5단계
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			// 3단계 sql (insert) now()
			sql = "insert into gallery(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 첫번째 물음표,값
			pstmt.setString(2, gb.getName());// 두번째물음표,값
			pstmt.setString(3, gb.getPass());// 세번째물음표,값
			pstmt.setString(4, gb.getSubject());
			pstmt.setString(5, gb.getContent());
			pstmt.setInt(6, 0); // readcount
			pstmt.setString(7, gb.getFile());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리작업 // 기억장소 con pstmt rs 정리
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
	}

	// getGalleryList()
	public List<GalleryBean> getGalleryList(int startRow, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
//				 String sql="select * from board order by num desc";
			String sql = "select * from gallery order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 rs -> 첫행이동 => 한개의 글 정보를 저장할 공간
			// BoardBean mb 객체생성 id변수 에 rs에서 가져온 id열 데이터저장
			// boardList 한칸에 한사람의 정보를 저장
			while (rs.next()) {
				// 한개의 글 정보를 저장할 객체생성
				GalleryBean gb = new GalleryBean();
				// 한개의 글 객체생성한 기억장소에 저장
				gb.setNum(rs.getInt("num"));
				gb.setSubject(rs.getString("subject"));
				gb.setName(rs.getString("name"));
				gb.setDate(rs.getDate("date"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setFile(rs.getString("file"));
				// 한개의 글 정보를 배열 한칸에 저장
				galleryList.add(gb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return galleryList;
	}

	// getGalleryList() - search 용 getGallerydList .
	public List<GalleryBean> getGalleryList(int startRow, int pageSize, String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
//						 String sql="select * from board order by num desc";
			String sql = "select * from gallery where subject like ? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 rs -> 첫행이동 => 한개의 글 정보를 저장할 공간
			// BoardBean mb 객체생성 id변수 에 rs에서 가져온 id열 데이터저장
			// boardList 한칸에 한사람의 정보를 저장
			while (rs.next()) {
				// 한개의 글 정보를 저장할 객체생성
				GalleryBean gb = new GalleryBean();
				// 한개의 글 객체생성한 기억장소에 저장
				gb.setNum(rs.getInt("num"));
				gb.setSubject(rs.getString("subject"));
				gb.setName(rs.getString("name"));
				gb.setDate(rs.getDate("date"));
				gb.setReadcount(rs.getInt("readcount"));
				// 한개의 글 정보를 배열 한칸에 저장
				galleryList.add(gb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return galleryList;
	}

	//getGallery(num)
		public GalleryBean getGallery(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			GalleryBean gb=null;
			try {
				//1단계 드라이버 로더			//2단계 디비연결
				con=getConnection();
				// 3단계 sql(select) 만들고 실행할 객체 생성
				String sql="select * from gallery where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				// 4단계 : 결과저장 <= sql  구문 실행 select
				rs=pstmt.executeQuery();
				//5단계 : select 결과를 화면출력
				 // rs위치 다음행 이동
				if(rs.next()) {
					gb=new GalleryBean();
					gb.setNum(rs.getInt("num"));
					 gb.setSubject(rs.getString("subject"));
					 gb.setName(rs.getString("name"));
					 gb.setDate(rs.getDate("date"));
					 gb.setReadcount(rs.getInt("readcount"));
					 gb.setContent(rs.getString("content"));
					 gb.setFile(rs.getString("file"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
			return gb;
		}
	
		//updateReadcount(num)
		public void updateReadcount(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1단계 드라이버 로더			//2단계 디비연결
				con=getConnection();
				// 3단계 sql update   set  readcount=readcount+1
				String sql="update gallery set readcount=readcount+1 where num=?";
		 		pstmt=con.prepareStatement(sql);
		 		pstmt.setInt(1, num);
				//4단계 실행
		 		pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
		}
		
		//numCheck(num,pass)
		public int numCheck(int num,String pass) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			// num 비밀번호 일치 1,비밀번호틀림 0, num없음 -1
			int check=-1;
			try {
				//1단계 드라이버 로더			//2단계 디비연결
				con=getConnection();
				// 3단계 sql(select 조건 id=?) 만들고 실행할 객체 생성
				String sql="select * from gallery where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				// 4단계 : 결과저장 <= sql  구문 실행 select
				rs=pstmt.executeQuery();
				// 5단계 : select 결과를 비교 해서 일치여부 확인
				if(rs.next()){ //true이면 
					//다음행 이동시 데이터가 있으면, num가 있으면
					if(pass.equals(rs.getString("pass"))){
						// 비밀번호 일치하면  
						check=1;
					}else{
						// "비밀번호 틀림" 뒤로이동
						check=0;
					}
				}else{
					// "num없음"  뒤로이동
					check=-1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외발생 상관없이 처리되는 문장
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
			return check;
		}
	
		//updateGallery(gb)
		public void updateGallery(GalleryBean gb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1단계 드라이버 로더			//2단계 디비연결
				con=getConnection();
				//3단계 sql update
				
				if(gb.getFile()==null) {
					String sql="update gallery set subject=?,content=? where num=?";
			 		pstmt=con.prepareStatement(sql);
			 		pstmt.setString(1, gb.getSubject());
			 		pstmt.setString(2, gb.getContent());
			 		pstmt.setInt(3, gb.getNum());
			 		//4단계 실행
			 		pstmt.executeUpdate();
				}else {
				String sql="update board set subject=?,content=?, file=? where num=?";
		 		pstmt=con.prepareStatement(sql);
		 		pstmt.setString(1, gb.getSubject());
		 		pstmt.setString(2, gb.getContent());
		 		pstmt.setString(3, gb.getFile());
		 		pstmt.setInt(4, gb.getNum());
		 		//4단계 실행
		 		pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리작업
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
		}
	
		//getGalleryCount()
		public int getGalleryCount() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				//1,2 디비연결메서드 호출
				con=getConnection();
				//3 sql select 객체생성
				String sql="select count(*) from gallery";
				pstmt=con.prepareStatement(sql);
				//4 rs = 실행
				rs=pstmt.executeQuery();
				//5  rs 첫행이동  count = rs count(*) 가져와서 저장
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
			return count;
		}
	
		//getGalleryCount() 0- search 용
		public int getGalleryCount(String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				//1,2 디비연결메서드 호출
				con=getConnection();
				//3 sql select 객체생성
				//String sql="select count(*) from board where subject like '%검색어%'";
				String sql="select count(*) from gallery where subject like ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				//4 rs = 실행
				rs=pstmt.executeQuery();
				//5  rs 첫행이동  count = rs count(*) 가져와서 저장
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
			return count;
		}
	
	
		public void deleteContent(GalleryBean gb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				con = getConnection();
				
				String sql = "delete from gallery where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, gb.getNum());
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try { rs.close();} catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
				if(con!=null) try{con.close();} catch(SQLException ex) {}
			}
			
		}
	
	
	
	
	
	
	
	
}

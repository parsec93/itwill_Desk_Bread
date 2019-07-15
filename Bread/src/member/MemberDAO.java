package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	public Connection getConnection() throws Exception{
		
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	
	
	public void insertMember(MemberBean mb) {
		
			Connection con = null;
			PreparedStatement pstmt = null;
			
		try {
			con = getConnection();


			 String sql = "insert into member(id, pass, name, reg_date, email, address, mobile, postcode, add1, add2, add3) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, mb.getId()); //첫번째 물음표, 값 
			 pstmt.setString(2, mb.getPass()); //두번째 물음표, 값
			 pstmt.setString(3, mb.getName());
			 pstmt.setTimestamp(4, mb.getReg_date());
			 pstmt.setString(5, mb.getEmail());
			 pstmt.setString(6, mb.getAddress());
			 pstmt.setString(7, mb.getMobile());
			 pstmt.setInt(8, mb.getPostcode());
			 pstmt.setString(9, mb.getAdd1());
			 pstmt.setString(10, mb.getAdd2());
			 pstmt.setString(11, mb.getAdd3());
			 
			 pstmt.executeUpdate();
			 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
	}
	
	public int idCheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=-1;
		
		try {
			con = getConnection();
			
			String sql = "select * from member where id =? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(id.equals(rs.getString("id"))) {
						check= 1;
					}else {
						check = -1;
					}
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
		}
		return check;
	}
	
	public int emailCheck(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=-1;
		
		try {
			con = getConnection();
			
			String sql = "select * from member where email =? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(email.equals(rs.getString("email"))) {
						check= 1;
					}else {
						check = -1;
					}
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
		}
		return check;
	}
	
	public int userCheck(String id, String pass) {
		int check = -1;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(id.equals(rs.getString("id"))) {
					if(pass.equals(rs.getString("pass"))) {
						check=1;
					}else {
						check=0;
					}
				}
			}else {
				check = -1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
		}
		return check;
	}
	
	public void updateMember(MemberBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
	try {
		con = getConnection();


		 String sql = "update member set pass=?, name=?, email=?, address=?, mobile=? where id=?";
		 pstmt = con.prepareStatement(sql);
		 pstmt.setString(1, mb.getPass()); //첫번째 물음표, 값 
		 pstmt.setString(2, mb.getName()); //두번째 물음표, 값
		 pstmt.setString(3, mb.getEmail());
		 pstmt.setString(4, mb.getAddress());
		 pstmt.setString(5, mb.getMobile());
		 pstmt.setString(6,mb.getId());

		 pstmt.executeUpdate();
		 
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
		if(con!=null) try{con.close();} catch(SQLException ex) {}
	}
}
	
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean mb;
		
		try {
			con = getConnection();
			
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			mb = new MemberBean();
			mb.setName(rs.getString("name"));
			mb.setEmail(rs.getString("email"));
			mb.setMobile(rs.getString("mobile"));
			mb.setAdd1(rs.getString("add1"));
			mb.setAdd2(rs.getString("add2"));
			mb.setAdd3(rs.getString("add3"));
			mb.setPostcode(rs.getInt("postcode"));
			return mb;
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
		}
		return null;
	}
	
	public String authNum() { //난수 생성.
		StringBuffer authNum = new StringBuffer();

		for (int i = 0; i < 6; ++i) {
			int randNum = (int) (Math.random() * 10.0D);
			authNum.append(randNum);
		}

		return authNum.toString();
	}
	
	
	/* 인증메일 전송 메서드 */
	public boolean sendEmail(String email, String authNum) {
		boolean result = false;
		String sender = "rootLake12@gmail.com";
		String subject = "Bread _ 인증번호입니다.";
		String content = "안녕하세요 " + email + "님, <br>" + "귀하의 인증번호는    [<b>" + authNum + "</b>]   입니다.";

		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			Authenticator auth = new GoogleAuthentication();
			Session session = Session.getDefaultInstance(properties, auth);
			Message message = new MimeMessage(session);
			Address senderAd = new InternetAddress(sender);
			Address receiverAd = new InternetAddress(email);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(senderAd);
			message.addRecipient(RecipientType.TO, receiverAd);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new Date());
			Transport.send(message);
			result = true;
		} catch (Exception var13) {
			result = false;
			System.out.println("Error in SendEmail()");
			var13.printStackTrace();
		} finally {
		}

		return result;
	}
	
	
	
	
	
}

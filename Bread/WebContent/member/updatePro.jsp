 <%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//회원가입 하는 곳.
//request에 요청정보가 담김. request  한글처리
request.setCharacterEncoding("utf-8");

//파라미터 id pass name email addressd phone mobile
String id = request.getParameter("id");
String pass = request.getParameter("pass");

String  name = request.getParameter("name");
String  email = request.getParameter("email");
String address = request.getParameter("ad1")+request.getParameter(" ad2")+request.getParameter(" ad3");
String mobile = request.getParameter("mobile");

MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setMobile(mobile);

MemberDAO mdao = new MemberDAO();
//패키지 member 파일이름 MemberDAO
// MemberDAO mdao 객체 생성
mdao.updateMember(mb);
//insertMember(mb) 
//login.jsp로 이동.
session.invalidate();
%>

<script type="text/javascript">
alert ("회원정보 수정완료");
location.href = "login.jsp";

</script>
</body>
</html>
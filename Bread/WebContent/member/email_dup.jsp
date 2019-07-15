<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");
	
	String email = request.getParameter("email");
	
   	MemberDAO mdao = new MemberDAO();
	int dupEmail = mdao.emailCheck(email);   	
	
 	if(dupEmail==1){
%>	<script type="text/javascript">
		alert("이미 사용중인 메일주소입니다.");
		window.close();
	</script>
<%	}else{
		response.sendRedirect("email_auth.jsp?email="+email);
	}
%>
<%@page import="member.MemberDAO"%>
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
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO mdao = new MemberDAO();

int check = mdao.userCheck(id,pass);

if(check>=0){
	if(check==1){
		session.setAttribute("id", id);
		%>
		<script type="text/javascript">
			location.href = "../main/main.jsp";
		</script>
		<%
	}else{
		%>
		<script type = "text/javascript">
			alert("비밀번호 틀림");
			history.back();
		</script>
		<%
	}
}else{
	%>
	<script type = "text/javascript">
		alert("아이디 틀림");
		history.back();
	</script>
	<%
}

%>
</body>
</html>
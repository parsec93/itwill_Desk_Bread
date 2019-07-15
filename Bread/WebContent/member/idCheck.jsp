<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type = "text/javascript">
	function ok(){
		opener.document.fr.id.value = document.wfr.fid.value;
		opener.document.fr.idboolean.value = true;
		window.close();
	}
</script>
</head>
<body>
<%
String id = request.getParameter("fid");

MemberDAO mdao = new MemberDAO();
int check = mdao.idCheck(id);

if(check == 1){
	%>
	<script type="text/javascript">
		alert("id 중복");
	</script>
	<%
}else {
	%>
	<script type="text/javascript">
		alert("id 사용가능");
	</script>
	<%
}



%>
<form action="idCheck.jsp" name="wfr" method = "get">
아이디 : <input type = "text" name = "fid" value="<%=id %>">
<input type = "submit" value="아이디 중복확인">
<% if(check!=1){%>
<input type = "button" value="id 사용하기" onclick="ok()"><%} %>
</form>
</body>
</html>
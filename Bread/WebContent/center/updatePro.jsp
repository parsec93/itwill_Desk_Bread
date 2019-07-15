<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
request.setCharacterEncoding("utf-8");

int maxSize = 5*1024*1024;
String uploadPath = request.getRealPath("/upload");
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

String pass = multi.getParameter("pass");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");
int num = Integer.parseInt(multi.getParameter("num"));
int pageNum = Integer.parseInt(multi.getParameter("pageNum"));


BoardBean bb = new BoardBean();

bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);
bb.setNum(num);

BoardDAO bdao = new BoardDAO();

int check = bdao.numCheck(num, pass);

if(check == 1){
	bdao.updateBoard(bb);
	%>
	<script type="text/javascript">
		alert("수정 완료");
		location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>
	<% 
	
}else{
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
	
	<%
}



%>
</body>
</html>







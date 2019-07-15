<%@page import="board_comment.BoardCommentDAO"%>
<%@page import="board_comment.BoardCommentBean"%>
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
request.setCharacterEncoding("utf-8"); //한글 처리 

String comment_id = request.getParameter("comment_id"); //댓글 작성자의 아이디
String comment_content = request.getParameter("comment_content"); // 작성한 댓글의 내용 
int comment_board = Integer.parseInt(request.getParameter("comment_board")); //게시글의 번호
String pageNum = request.getParameter("pageNum");

BoardCommentBean bcb =  new BoardCommentBean();
bcb.setComment_id(comment_id);
bcb.setComment_content(comment_content);
bcb.setComment_board(comment_board);

BoardCommentDAO bcdao = new BoardCommentDAO();

bcdao.insertBoardComment(bcb);

response.sendRedirect("content.jsp?num="+comment_board+"&pageNum="+pageNum);

%>
</body>
</html>
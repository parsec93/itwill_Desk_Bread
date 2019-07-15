<%@page import="java.util.List"%>
<%@page import="board_comment.BoardCommentBean"%>
<%@page import="board_comment.BoardCommentDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Arvo&display=swap" rel="stylesheet">

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Board</a></li>
<li><a href="../center/gallery.jsp">Gallery</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<%
// num , pageNum 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");
//BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// 조회수 증가
// updateReadcount(num)
bdao.updateReadcount(num);
//BoardBean bb  =  getBoard(num) 메서드호출
BoardBean bb=bdao.getBoard(num);
String content=bb.getContent();
String id = (String)session.getAttribute("id");

if(content!=null){
	//   \r\n => <br> 바꾸기   문자열.replace("old문자열","new문자열")
	content=content.replace("\r\n", "<br>");
}


//--------------------------------댓글 기능 구현부-------------------

//-------------해당 글에 해당하는 댓글들을 가져오기.

BoardCommentDAO bcdao = new BoardCommentDAO();
List<BoardCommentBean> bcbList = bcdao.getBoardComment(num);

%>
<article>
<h1>Board Content</h1>
<table id="notice">
<tr><td class="twrite">글번호</td><td><%=bb.getNum() %></td>
<td class="twrite">조회수</td><td><%=bb.getReadcount() %></td></tr>
<tr><td class="twrite">작성자</td><td><%=bb.getName() %></td>
<td class="twrite">작성일</td><td><%=bb.getDate() %></td></tr>
<tr><td class="twrite">제목</td><td colspan="3"><%=bb.getSubject() %></td></tr>

<%if(bb.getFile() == null){
	%>
	<tr><td class="twrite">첨부파일</td><td colspan="3">첨부파일 없음</td></tr>
	<%
}else {
	%>
	<tr><td class="twrite">첨부파일</td><td colspan="3"><a href="file_down.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile() %></a></td></tr>
    <tr><td></td><td colspan="3"><img src="../upload/<%= bb.getFile() %>" width = "300" height="300"></td></tr>
	
	<%
}
%>

<tr><td class="twrite">내용</td><td colspan="3"><%=content %> </td></tr>
</table>
<div id="table_search">
<input type="button" value="글수정" class="btn" 
 onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
 <input type="button" value="글삭제" class="btn" 
 onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
<input type="button" value="글목록" class="btn" 
 onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
</div>
<div class="clear"></div>
<div id="page_control"></div>
<hr>
<div class = "comment">
<table id="notice">
<tr><td class="tno">No.</td><td class="twrite">내용</td><td class="twrite">아이디</td><td class="twrite">작성일</td></tr>
<%
for(int i=0; i < bcbList.size()  ;i++){
	BoardCommentBean bcb = bcbList.get(i);
	%>
	<tr><td><%=bcb.getComment_num() %></td><td><%=bcb.getComment_content() %></td><td><%=bcb.getComment_id() %></td><td><%=bcb.getDate() %></td></tr>
<% }
	

%>
</table>
</div>
<div class="comment">댓글</div>
			<div class="w3-border w3-padding">
				<%if (id == null){
					%>
					<textarea rows="5" cols="90" class="comment" readonly>로그인 후 댓글 달기</textarea><%
					} else {
					%>
					<form action="commentWritePro.jsp" method="get" name = "cm"> 
						<input type = "hidden" name = "comment_board" value = "<%=bb.getNum()%>"> 
						<input type = "hidden" name = "comment_id" value="<%=id%>">
						<input type = "hidden" name = "pageNum" value ="<%=pageNum%>">
						<textarea rows="5" cols="90" class="w3-input w3-border" placeholder="댓글 작성" name="comment_content" id="comment_content"></textarea>
						<input type="submit" class="w3-button w3-border" id="reply_btn" value="댓글 등록">
					</form>
					<%}%>
			</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
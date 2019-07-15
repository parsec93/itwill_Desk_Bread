<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Arvo&display=swap" rel="stylesheet">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
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
GalleryDAO gdao=new GalleryDAO();
// 조회수 증가
// updateReadcount(num)
gdao.updateReadcount(num);
//BoardBean bb  =  getBoard(num) 메서드호출
GalleryBean gb=gdao.getGallery(num);
String content=gb.getContent();
if(content!=null){
	//   \r\n => <br> 바꾸기   문자열.replace("old문자열","new문자열")
	content=content.replace("\r\n", "<br>");
}
%>
<article>
<h1>Gallery Content</h1>
<table id="notice">
<tr><td class="twrite">글번호</td><td><%=gb.getNum() %></td>
<td class="twrite">조회수</td><td><%=gb.getReadcount() %></td></tr>
<tr><td class="twrite">작성자</td><td><%=gb.getName() %></td>
<td class="twrite">작성일</td><td><%=gb.getDate() %></td></tr>
<tr><td class="twrite">제목</td><td colspan="3"><%=gb.getSubject() %></td></tr>

<%if(gb.getFile() == null){
	%>
	<tr><td class="twrite">첨부파일</td><td colspan="3">첨부파일 없음</td></tr>
	<%
}else {
	%>
	<tr><td class="twrite">첨부파일</td><td colspan="3"><a href="file_down.jsp?file_name=<%=gb.getFile()%>"><%=gb.getFile() %></a></td></tr>
    <tr><td></td><td colspan="3"><img src="../upload/<%= gb.getFile() %>" width = "300" height="300"></td></tr>
	
	<%
}
%>

<tr><td class="twrite">내용</td><td colspan="3"><%=content %> </td></tr>
</table>
<div id="table_search">
<%
// 세션값 가져오기
// 세션값이 있으면 
// 세션값과 글의 작성자와 비교  일치하면 글수정 글삭제 버튼이 보이기
%>
<input type="button" value="글수정" class="btn" 
 onclick="location.href='gupdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
 <input type="button" value="글삭제" class="btn" 
 onclick="location.href='gdeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
<input type="button" value="글목록" class="btn" 
 onclick="location.href='gallery.jsp?pageNum=<%=pageNum%>'">
</div>
<div class="clear"></div>
<div id="page_control">
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
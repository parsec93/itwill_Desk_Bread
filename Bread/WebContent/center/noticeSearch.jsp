<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
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
<%
// noticeSearch.jsp
// 한글처리
request.setCharacterEncoding("utf-8");

//search 파라미터 가져오기
String search=request.getParameter("search");

// 전체 글 개수 
// BoardDAO bdao 
BoardDAO bdao=new BoardDAO();
// int count=getBoardCount()
// 검색어를 포함하는 게시판 글개수
int count=bdao.getBoardCount(search);

// 현페이지 글 가져오기
// 한페이지에 가져올 글개수
int pageSize = 15;
// String pageNum 가져오기
// pageNum이 없으면 "1" 설정
String pageNum=request.getParameter("pageNum");
// 페이지번호가 없으면  "1" 설정
if(pageNum==null){
	pageNum="1";
}
// int currentPage= pageNum 정수형 변경
int currentPage=Integer.parseInt(pageNum);
// int startRow= 구하기 
int startRow=(currentPage-1)*pageSize+1 ;  
// int endRow = 구하기
int endRow=currentPage*pageSize;

List<BoardBean> boardList =null;
// 게시판 글있으면
//boardList = getBoardList(시작행,가져올 글개수)
// 검색어를 포함하는 게시판 글가져오기
if(count!=0){
	boardList=bdao.getBoardList(startRow, pageSize, search);
}
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
//화면에 보여지는 글번호 구하기 
// 전체 글개수 20
// count  currentPage(pageNum)  pageSize
//   20        1                 10   => 20-0  =>20-(1-1)*10 => 20 
//   20        2                 10   => 20-10 =>20-(2-1)*10 => 10

int num=count-(currentPage-1)*pageSize;
%>
<!-- 게시판 -->
<article>
<h1>Board [Total : <%=count %> ]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
    <%
    for(int i=0;i<boardList.size();i++){
    	//BoardBean bb=(BoardBean)boardList.get(i);
    	BoardBean bb=boardList.get(i);
    	%>
<tr onclick="location.href='content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'"><td><%=num-- %></td>
    <td class="left"><%=bb.getSubject() %></td>
    <td><%=bb.getName() %></td>
    <td><%=sdf.format(bb.getDate()) %></td>
    <td><%=bb.getReadcount() %></td></tr>   	
    	<%
    }
    %>
</table>
<%
//String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
// 세션값이 있으면 글쓰기 버튼 보이기
if(id!=null){
	%>
	<div id="table_search">
<input type="button" value="글쓰기" class="btn" 
  onclick="location.href='writeForm.jsp'">
</div>
	<%
}
%>
<div id="table_search">
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
// 게시판에 글이 있으면
if(count!=0){
//전체 페이지 수 구하기   
//	int pageCount=전체글개수/한화면에 보여줄글개수+(조건?참:거짓);
	int pageCount=count/pageSize+(count%pageSize==0?0:1);
  //한화면에 보여줄 페이지 개수 설정
  	int pageBlock=10;
   // 한화면에 보여줄 시작페이지번호 구하기   -  /  *  +
	//  현페이지 번호 1~10 -> 1   11~20 -> 11
	int startPage=(currentPage-1)/pageBlock*pageBlock+1;
	// 한화면에 보여줄 끝페이지번호 구하기  + -
	int endPage=startPage+pageBlock-1;
	if(endPage > pageCount){
		endPage=pageCount;
	}
	//[이전]  -10  시작페이지번호   한화면에 보여줄 페이지수 비교
	if(startPage > pageBlock){
		%><a href="noticeSearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>">Prev</a><%
	}
	// 1 2 3 4 ...10
	for(int i=startPage;i<=endPage;i++){
		%><a href="noticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i %></a><%
	}
	// [다음] +10  끝페이지번호   전체페이지개수 비교
	if(endPage < pageCount){
		%><a href="noticeSearch.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">Next</a><%
	}
}
%>
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
<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
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
<link href="../css/front.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_Bread.jpg"
 width="971" height="330" style="image-size : cover;"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div>
<p>										
</p>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Recent Gallery</span> </h3>
<%
int startRow=1;
GalleryDAO gdao = new GalleryDAO();

int gcount = gdao.getGalleryCount();
int gpageSize=2;

List<GalleryBean> galleryList = null;

if(gcount !=0){
	galleryList=gdao.getGalleryList(startRow, gpageSize);
	for(int i=0; i<galleryList.size();i++){
		GalleryBean gb = galleryList.get(i);
		%>
		<a href="../center/gcontent.jsp?num=<%=gb.getNum()%>&pageNum=1"><img width = "200" height="190" src='../upload/<%=gb.getFile() %>'></a> 
		<%
	}
}
%>


</div>
<div id="news_notice">
<h3 class="brown">Recent Boards</h3>
<table>
<%
// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// int count=getBoardCount() 메서드호출 
int count=bdao.getBoardCount();
int pageSize=7;

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
List<BoardBean> boardList =null;
// 게시판 글있으면
//boardList = getBoardList(시작행,가져올 글개수)
if(count!=0){
	boardList=bdao.getBoardList(startRow, pageSize);
	for(int i=0;i<boardList.size();i++){
		BoardBean bb=boardList.get(i);
		%>
	<tr><td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>&pageNum=1"><%=bb.getSubject() %></a></td>
    <td><%=sdf.format(bb.getDate()) %></td></tr>	
		<%
	}
}


%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
String id=(String)session.getAttribute("id");
if(id==null){
	%><div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div><%
}else{
	%><div id="login"><a href="../member/update.jsp?id=<%=id%>"><%=id %>님</a> | <a href="../member/logout.jsp">logout</a></div><%
}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo" class="topLogo"><img src="../images/Jo's Bread-logo.png" width="250" height="120" alt="Fun Web" margin=-30px; onclick="location.href='../main/main.jsp'"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">BAKERY</a></li>
	<li><a href="../center/notice.jsp">BOARD</a></li>
</ul>
</nav>
</header>
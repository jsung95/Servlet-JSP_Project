<%@ page import="kr.ac.woosuk.computereng.models.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	UserDTO user = (UserDTO)session.getAttribute("user");
%>
<header id="header">
	<h1 id="logo"><a href="/Woosuk/controller/indexBoard">Web Programming</a></h1>
	<nav id="nav">
		<ul>
			<li><a href="/Woosuk/controller/indexBoard">Home</a></li>
			<li>
				<a href="/Woosuk/controller/ListBoard">Board</a>
			</li>
<%
	if(user != null) {			
%>
			<li><%=user.getId() %>��</li>
			<li><a href="/Woosuk/controller/modifyUser" class="button primary">ȸ����������</a>
			<li><a href="/Woosuk/controller/signout" class="button">�α׾ƿ�</a></li>
<%
	} else {
%> 
			<li><a href="/Woosuk/signin.jsp" class="button primary">�α���</a></li>
			<li><a href="/Woosuk/signup.jsp" class="button primary">ȸ������</a></li>
<%
	}
%>			
		</ul>
	</nav>
</header>
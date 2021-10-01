<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.woosuk.computereng.models.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE HTML>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<%@ include file="./common/title.jsp" %>
		<%
			ArrayList<BoardDTO> boards = (ArrayList<BoardDTO>) request.getAttribute("boards");			
		%>
	</head>
	<body class="is-preload landing">
		<div id="page-wrapper">

			<!-- Header -->
				<%@ include file="./common/header.jsp" %>

			<!-- Banner -->
				<section id="banner">
					<div class="content">
						<header>
							<h2>120140989 이진성</h2>
							<p>웹 프로그래밍 프로젝트</p>
							<h5>웹 프로젝트입니다.</h5>
						</header>
						<span class="image"><img src="/Woosuk/controller/load_img?id=<%=boards.get(boards.size()-1).getId() %>" alt="" /></span>
					</div>
					<a href="#one" class="goto-next scrolly">Next</a>
				</section>

			<!-- One -->
				<section id="one" class="spotlight style1 bottom">
					<span class="image fit main"><img src="/Woosuk/controller/load_img?id=<%=boards.get(boards.size()-1).getId() %>" alt=""/></span>
					<div class="content">
						<div class="container">
							<div class="row">
								<div class="col-4 col-12-medium">
									<header>
										<h2><%=boards.get(boards.size()-1).getTitle() %></h2>
										<p><%=boards.get(boards.size()-1).getSubTitle() %></p>
										<h3><%=boards.get(boards.size()-1).getWriter()%> | <%=boards.get(boards.size()-1).getFormatCreateDate() %></h3>
									</header>
								</div>
								<div class="col-4 col-12-medium">
									<p><%=boards.get(boards.size()-1).getContents() %></p>
								</div>
								<ul class="actions">
									<li><a href="/Woosuk/controller/boardmore?info=<%=boards.get(boards.size()-1).getId() %>" class="button">Learn More</a></li>
								</ul>
							</div>
						</div>
					</div>
					<a href="#two" class="goto-next scrolly">Next</a>
				</section>

			<!-- Two -->
				<section id="two" class="spotlight style2 right">
					<span class="image fit main"><img src="/Woosuk/controller/load_img?id=<%=boards.get(boards.size()-2).getId() %>" alt=""/></span>
					<div class="content">
						<header>
							<h2><%=boards.get(boards.size()-2).getTitle() %></h2>
							<h3><%=boards.get(boards.size()-2).getWriter()%> | <%=boards.get(boards.size()-2).getFormatCreateDate() %></h3>
							<p><%=boards.get(boards.size()-2).getSubTitle() %></p>
						</header>
						<p><%=boards.get(boards.size()-2).getContents() %></p>
						<ul class="actions">
							<li><a href="/Woosuk/controller/boardmore?info=<%=boards.get(boards.size()-2).getId() %>" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#three" class="goto-next scrolly">Next</a>
				</section>

			<!-- Three -->
				<section id="three" class="spotlight style3 left">
					<span class="image fit main"><img src="/Woosuk/controller/load_img?id=<%=boards.get(boards.size()-3).getId() %>" alt=""/></span>
					<div class="content">
						<header>
							<h2><%=boards.get(boards.size()-3).getTitle() %></h2>
							<h3><%=boards.get(boards.size()-3).getWriter()%> | <%=boards.get(boards.size()-3).getFormatCreateDate() %></h3>
							<p><%=boards.get(boards.size()-3).getSubTitle() %></p>
						</header>
						<p><%=boards.get(boards.size()-3).getContents() %></p>
						<ul class="actions">
							<li><a href="/Woosuk/controller/boardmore?info=<%=boards.get(boards.size()-3).getId() %>" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#four" class="goto-next scrolly">Next</a>
				</section>
				
				<section id="five" class="wrapper style2 special fade">
					<div class="container">
					</div>
				</section>


			<!-- Footer -->
				<%@ include file="./common/footer.jsp" %>

		</div>

		<!-- Scripts -->
			<%@ include file="./common/script.jsp" %>
	</body>
</html>
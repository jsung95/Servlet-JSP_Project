<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.woosuk.computereng.models.BoardDTO"%>
<%@page import="dao.BoardDao"%>
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
	<body class="is-preload">
		<div id="page-wrapper">

			<!-- Header -->
				<%@ include file="./common/header.jsp" %>

			<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
						<header class="major">
							<h2>게시판</h2>
							<p>이미지 게시판입니다.</p>
						</header>
						<div class="row gtr-150">
							<div class="col-8 col-12-medium">

								<!-- Content -->
									<section id="content">
										<%
				
										BoardDao boardDao = new BoardDao();
										String ID = request.getParameter("info");
										BoardDTO board = boardDao.selectBoardByID(ID);
									
										%>
										<h5><%=board.getWriter() %>|<%=board.getFormatCreateDate() %></h5>
										<a href="#" class="image fit"><img src="/Woosuk/controller/load_img?id=<%=board.getId() %>" alt=""/></a>
										<h3><%=board.getTitle() %></h3>
										<h4><%=board.getSubTitle() %></h4>
										<p><%=board.getContents() %></p>
										
										<section id="editdel">
											<span> 
												<a href="/Woosuk/controller/modifyBoard?id=<%=board.getId() %>" class="button primary">수정</a> 
											</span>
											<span>
												<a id="del_btn" href="/Woosuk/controller/deleteBoard?id=<%=board.getId() %>"class="button primary">삭제</a>
											</span>
											<div id="error" class="error"></div>
										</section>
									</section>
							<hr />
							</div>
							<div class="col-4 col-12-medium">

								<!-- Sidebar -->
									<section id="sidebar">
									
									<%
										for(int i=boards.size()-1; i>=0; i--){
									%>
										<section>
											
											<a href="#" class="image fit"><img src="/Woosuk/controller/load_img?id=<%=boards.get(i).getId() %>" alt=""/></a>
											<h3><%=boards.get(i).getTitle() %></h3>
											<h5><%=boards.get(i).getWriter()%> | <%=boards.get(i).getFormatCreateDate() %></h5>
											<p><%=boards.get(i).getContents() %></p>
											<footer>
												<ul class="actions">
													<li><a href="/Woosuk/controller/boardmore?info=<%=boards.get(i).getId() %>" class="button">Learn More</a></li>
												</ul>
											</footer>
										</section>
										<hr />
									<%
										}
									%>
									</section>

							<div style="text-align: center">
								<a href="#">&lt;</a>&nbsp;&nbsp;&nbsp;
								1&nbsp;&nbsp;&nbsp;
								<a href="#">2</a>&nbsp;&nbsp;&nbsp;
								<a href="#">3</a>&nbsp;&nbsp;&nbsp;
								<a href="#">4</a>&nbsp;&nbsp;&nbsp;
								<a href="#">5</a>&nbsp;&nbsp;&nbsp;
								<a href="#">&gt;</a>
							</div>
							</div>
							<section>
							<%
								if(user != null) {
							%>
								<ul class="actions">
									<li><a href="/Woosuk/write_board.jsp" class="button primary">작성하기</a></li>
								</ul>
							<%
								}
							%>
							</section>
						</div>
					</div>
				</div>

			<!-- Footer -->
				<%@ include file="./common/footer.jsp" %>

		</div>

		<!-- Scripts -->
			<%@ include file="./common/script.jsp" %>
			<script type="text/javascript">
			window.addEventListener("DOMContentLoaded", function(){ 
				<%
					if(request.getParameter("message")!= null && request.getParameter("message").equals("FAILURE")){
				%>
						setErrorMessage("error", "권한이 없습니다.");
				<%
					}
				%>
				
				<%
					if(user == null ) {
				%>
						document.getElementById("editdel").style.display ="none";
				<%
					} else if(!user.getId().equals(board.getWriter())) {
				%>
						document.getElementById("editdel").style.display ="none";
				<%
					} else {
				%>
						document.getElementById("editdel").style.display ="";
				<%
					}
				%>
				
			});
		</script>
	</body>
</html>
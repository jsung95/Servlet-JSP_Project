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
							<h2>�Խ���</h2>
							<p>�̹��� �Խ����Դϴ�.</p>
						</header>
						<div class="row gtr-150">
							<div class="col-8 col-12-medium">

								<!-- Content -->
									<section id="content">
										<h5><%=boards.get(boards.size()-1).getWriter()%> | <%=boards.get(boards.size()-1).getFormatCreateDate() %></h5>
										<a href="#" class="image fit"><img src="/Woosuk/controller/load_img?id=<%=boards.get(boards.size()-1).getId() %>" alt=""/></a>
										<h3><%=boards.get(boards.size()-1).getTitle() %></h3>
										<h4><%=boards.get(boards.size()-1).getSubTitle() %></h4>
										<p><%=boards.get(boards.size()-1).getContents() %></p>
										
										<section id="editdel">
											<span> 
												<a href="/Woosuk/controller/modifyBoard?id=<%=boards.get(boards.size()-1).getId() %>" class="button primary">����</a> 
											</span>
											<span>
												<a href="/Woosuk/controller/deleteBoard?id=<%=boards.get(boards.size()-1).getId() %>"class="button primary">����</a>
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
									<li><a href="/Woosuk/write_board.jsp" class="button primary">�ۼ��ϱ�</a></li>
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
						setErrorMessage("error", "������ �����ϴ�.");
				<%
					}
				%>
				
				<%
					if(user == null ) {
				%>
						document.getElementById("editdel").style.display ="none";
				<%
					} else if(!user.getId().equals(boards.get(boards.size()-1).getWriter())) {
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
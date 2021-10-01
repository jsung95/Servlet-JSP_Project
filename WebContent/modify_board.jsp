<%@ page import="dao.BoardDao" %>
<%@ page import="kr.ac.woosuk.computereng.models.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<!DOCTYPE HTML>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head><%@ include file="./common/title.jsp" %>
		<%
			String ID = request.getParameter("id");
			BoardDTO board = (BoardDTO) request.getAttribute("board");
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
							<h2>�Խù� ����</h2>
						</header>

						<!-- Form -->
							<section>
								<form id="formid" method="post" action="/Woosuk/controller/updateBoard?boardid=<%=ID %>" enctype="multipart/form-data">
									<div class="row gtr-uniform gtr-50">
										<div class="col-12">
											<input type="text" name="title" id="title" value="<%=board.getTitle() %>" placeholder="����" />
											<div id="title_error" class="error"></div>
										</div>
										<div class="col-12">
											<input type="text" name="subtitle" id="subtitle" value="<%=board.getSubTitle() %>" placeholder="������" />
										</div>
										<div class="col-12">
											<textarea name="contents" id="contents" placeholder="������ �Է��ϼ���." rows="6"><%=board.getContents() %></textarea>
											<div id="contents_error" class="error"></div>
										</div>
										<div class="col-12">
											<ul class="actions">
												<li><a href="/Woosuk/controller/ListBoard" class="button primary">���</a></li>
												<li></li>
												<li></li>
												<li><input id="save_btn" type="submit" value="����" class="primary" /></li>
												<li><input id="cancel_btn" name ="cancel_btn" type="reset" value="�������" /></li>
											</ul>
										</div>
									</div>
								</form>
							</section>

					</div>
				</div>

			<!-- Footer -->
				<%@ include file="./common/footer.jsp" %>

		</div>

		<!-- Scripts -->
			<%@ include file="./common/script.jsp" %>
		<script type="text/javascript">
			window.addEventListener("DOMContentLoaded", function(){
				
				
				var title = document.getElementById("title");
				var file = document.getElementById("file");
				var contents = document.getElementById("contents");
				var cancel_btn = document.getElementById("cancel_btn");
				
				cancel_btn.addEventListener("click", function(evt){
					evt.preventDefault(evt);
					history.back(-1);
				});
				
				title.addEventListener("keyup", function(){
					if(title.value == "" || title.value.length == 0) {
						setErrorMessage("title_error", "������ �Է����ּ���.");
					} else {
						removeErrorMessage("title_error");
					}
				});
				
				file.addEventListener("change", function(){
					if(file.value == "" || file.value.length == 0) {
						setErrorMessage("file_error", "������ ���ε����ּ���.");
					} else {
						var fileext = file.value;
						fileext = fileext.slice(fileext.lastIndexOf(".")+1).toLowerCase();
						if(fileext != "jpg" && fileext != "jpeg" && fileext != "gif" && fileext != "bmp" && fileext != "png") {
							setErrorMessage("file_error", "�̹��� ���ϸ� ���ε� �� �� �ֽ��ϴ�.");
						} else {
							removeErrorMessage("file_error");	
						}
					}
				});
				
				contents.addEventListener("keyup", function(){
					if(contents.value == "" || contents.value.length == 0) {
						setErrorMessage("contents_error", "������ �ۼ����ּ���.");
					} else {
						removeErrorMessage("contents_error");
					}
				});
				
				document.getElementById("save_btn").addEventListener("click", function(evt){
					if(title.value == "" || title.value.length == 0) {
						evt.preventDefault();
						setErrorMessage("title_error", "������ �Է����ּ���.");
					}
					
					if(file.value == "" || file.value.length == 0) {
						evt.preventDefault();
						setErrorMessage("file_error", "������ ���ε����ּ���.");
					} else {
						var fileext = file.value;
						fileext = fileext.slice(fileext.lastIndexOf(".")+1).toLowerCase();
						if(fileext != "jpg" && fileext != "jpeg" && fileext != "gif" && fileext != "bmp" && fileext != "png") {
							evt.preventDefault();
							setErrorMessage("file_error", "�̹��� ���ϸ� ���ε� �� �� �ֽ��ϴ�.");
						}
					}
					
					if(contents.value == "" || contents.value.length == 0) {
						evt.preventDefault();
						setErrorMessage("contents_error", "������ �ۼ����ּ���.");
					}
				});
			});
		</script>
	</body>
</html>
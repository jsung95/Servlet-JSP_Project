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
		<script type="text/javascript">
			window.addEventListener("DOMContentLoaded", function(){
				<% 
				if(request.getParameter("message")!= null && request.getParameter("message").equals("FAILUREID")){
				%>
					setErrorMessage("name_error", "���̵� ã�� �� �����ϴ�.");
				<%
				} else if(request.getParameter("message")!= null && request.getParameter("message").equals("FAILUREPASS")){
				%>
					setErrorMessage("password_error", "��й�ȣ�� Ȯ�����ּ���.");
				<%
				}
				%>
				
				var id = document.getElementById("name");
				var pass = document.getElementById("pass");
				
				id.addEventListener("keyup", function(){
					if(id.value == "" || id.value.length == 0) {
						setErrorMessage("name_error", "���̵� �Է����ּ���.")
					} else {
						removeErrorMessage("name_error");
					}
				});
				
				pass.addEventListener("keyup", function(){
					if(pass.value == "" || pass.value.length == 0) {
						setErrorMessage("password_error", "��й�ȣ�� �Է����ּ���.");
					} else {
						removeErrorMessage("password_error");
					}
				});
				
				document.getElementById("login_btn").addEventListener("click", function(evt){
					if(id.value == "" || id.value.length == 0) {
						evt.preventDefault();
						setErrorMessage("name_error", "���̵� �Է����ּ���.")
					} else {
						removeErrorMessage("name_error");
					}
					
					if(pass.value == "" || pass.value.length == 0) {
						evt.preventDefault();
						setErrorMessage("password_error", "��й�ȣ�� �Է����ּ���.");
					} else {
						removeErrorMessage("password_error");
					}
				});
				
				document.getElementById("reset_btn").addEventListener("click", function(evt){
					evt.preventDefault();
					document.location="/Woosuk/controller/indexBoard";
				});
			});
		</script>
	</head>
	<body class="is-preload">
		<div id="page-wrapper">

			<!-- Header -->
				<%@ include file="./common/header.jsp" %>

			<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
						<header class="major">
							<h2>Log in</h2>
							<p>Ipsum dolor feugiat aliquam tempus sed magna lorem consequat accumsan</p>
						</header>
						<!-- Form -->
							<section>
								<form method="post" action="/Woosuk/controller/LoginCheck">
									<div class="row gtr-uniform gtr-50">
										<div class="col-6 col-6-xsmall">
											<input type="text" name="name" id="name" value="" placeholder="���̵�" />
											<div id="name_error" class="error"></div>
										</div>
										<div class="col-6 col-6-xsmall">
											<input type="password" name="pass" id="pass" value="" placeholder="��й�ȣ" />
											<div id="password_error" class="error"></div>
										</div>
										<div class="col-12">
											<ul class="actions">
												<li><input id="login_btn" type="submit" value="Sign In" class="primary" /></li>
												<li><input id="reset_btn" type="reset" value="Cancel" /></li>
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
	</body>
</html>
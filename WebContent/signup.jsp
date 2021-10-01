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
	</head>
	<body class="is-preload">
		<div id="page-wrapper">

			<!-- Header -->
				<%@ include file="./common/header.jsp" %>

			<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
						<header class="major">
							<h2>Join</h2>
							<p>Ipsum dolor feugiat aliquam tempus sed magna lorem consequat accumsan</p>
						</header>
						<!-- Form -->
							<section>
								<form id="formid" method="post" action="/Woosuk/controller/SignUp">
									<div class="row gtr-uniform gtr-50">
										<div class="col-6 col-12-xsmall">
											<input type="text" name="name" id="name" value="" placeholder="���̵�" />
											<div id="name_error" class="error"></div>
										</div>
										<div class="col-6 col-12-xsmall">
											<input type="email" name="email" id="email" value="" placeholder="�̸���" />
											<div id="email_error" class="error"></div>
										</div>
										<div class="col-6 col-12-xsmall">
											<input type="password" name="pass1" id="pass1" value="" placeholder="��й�ȣ" />
											<div id="pass1_error" class="error"></div>
										</div>
										<div class="col-6 col-12-xsmall">
											<input type="password" name="pass2" id="pass2" value="" placeholder="��й�ȣ Ȯ��" />
											<div id="pass2_error" class="error"></div>
										</div>
										<div class="col-12">
											<select name="job" id="job">
												<option value="">- ���� -</option>
												<option value="1">�л�</option>
												<option value="2">���α׷���</option>
												<option value="3">���������Ͼ�</option>
												<option value="4">�����̳�</option>
											</select>
											<div id="job_error" class="error"></div>
										</div>
										<div class="col-4 col-12-medium">
											<input type="radio" id="priority-low" name="priority" value="MAN" checked>
											<label for="priority-low">��</label>
										</div>
										<div class="col-4 col-12-medium">
											<input type="radio" id="priority-normal" name="priority" value="WOMAN">
											<label for="priority-normal">��</label>
										</div>
										<div class="col-12">
											<textarea name="message" id="message" placeholder="�ڱ�Ұ�" rows="6"></textarea>
										</div>
										<%
											if(user == null) {
										%>
										<div class="col-6 col-12-medium">
											<input type="checkbox" id="copy" name="copy">
											<label for="copy">�������������� �����մϴ�.</label>
											<a href="javascript:popup('/Woosuk/agree.jsp');">(������������ �� �̿�)</a>
											<div id="copy_error" class="error"></div>
										</div>
										<%
											}
										%>
										<div class="col-12">
											<ul class="actions">
												<li><input id="signup_btn" type="submit" value="����" class="primary" /></li>
												<li><input id="cancel_btn" type="reset" value="���" /></li>
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
				<%
				if(user != null) {
				%>
				document.getElementById("name").value="<%=user.getId()%>";
				document.getElementById("name").readOnly = true;
				document.getElementById("email").value="<%=user.getEmail()%>";
				document.getElementById("job").value=<%=user.getJob()%>;
				<%
					if(user.getGender().equals("MAN")) {
				%>
					document.getElementById("priority-low").checked=true;
				<%
					} else {
				%>
				document.getElementById("priority-normal").checked=true;
				<%
					}
				%>
				document.getElementById("message").value="<%=user.getIntroduction()%>";
				document.getElementById("signup_btn").value="����";
				document.getElementById("formid").action = "/Woosuk/controller/updateUser";
				document.getElementById("cancel_btn").addEventListener("click", function(evt){
					evt.preventDefault();
					history.back(-1);
				});
				<%
					}
				%>
				
				
				var name = document.getElementById("name");
				var email = document.getElementById("email");
				var pass1 = document.getElementById("pass1");
				var pass2 = document.getElementById("pass2");
				var job = document.getElementById("job");
				var cancel_btn = document.getElementById("cancel_btn");
				
				cancel_btn.addEventListener("click", function(evt){
					evt.preventDefault(evt);
					history.back(-1);
				});
				
				<% 
					if(user == null) {
				%>
				var copy = document.getElementById("copy");		
				<%
					}
				%>
				
				name.addEventListener("keyup", function(){
					if(name.value == "" || name.value.length == 0) {
						setErrorMessage("name_error", "���̵� �Է����ּ���.");
					} else {
						var pattern = /[^a-zA-Z0-9]/;
						if(pattern.test(name.value)) {
							setErrorMessage("name_error", "���̵�� ����� ���� ���ո� �����մϴ�.");
						} else {
							removeErrorMessage("name_error");
						}
					}
				});
				email.addEventListener("keyup", function(){
					var pattern = /^[a-zA-Z0-9]+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]+$/;
					if(!pattern.test(email.value)) {
						setErrorMessage("email_error", "�̸��� �������� �Է����ּ���.");
					} else {
						removeErrorMessage("email_error");
					}
				});
				pass1.addEventListener("keyup", function(){
					document.getElementById("pass1_error").className = "error";
					var level = passwordLevel(pass1.value);
					if(level == 0) {
						setErrorMessage("pass1_error", "��й�ȣ�� �Է����ּ���.");
					} else if(level == 1) {
						setErrorMessage("pass1_error", "��й�ȣ�� ����,����,Ư������(~!@#$%^&*()_+|<>?:{})�� �����մϴ�.");
					} else if(level == 2) {
						setErrorMessage("pass1_error", "�ʹ� ���� ��ȣ�Դϴ�.");
					} else if(level == 3) {
						setErrorMessage("pass1_error", "�� ������ ������ �ʿ��մϴ�.");
					} else if(level == 4) {
						document.getElementById("pass1_error").className = "non_error";
						setErrorMessage("pass1_error", "������ ��ȣ�Դϴ�.");
					}
					
					if(pass1.value != pass2.value) {
						setErrorMessage("pass2_error", "��й�ȣ�� Ȯ���� �ּ���.")
					} else {
						removeErrorMessage("pass2_error");
					}
				});
				pass2.addEventListener("keyup", function(){
					if(pass1.value != pass2.value) {
						setErrorMessage("pass2_error", "��й�ȣ�� Ȯ���� �ּ���.")
					} else {
						removeErrorMessage("pass2_error");
					}
				});
				job.addEventListener("change", function(){
					if(job.value == "") {
						setErrorMessage("job_error", "������ �����ϼ���.");
					} else {
						removeErrorMessage("job_error");
					}
				});
				<%
					if(user == null) {
				%>
				copy.addEventListener("change", function(){
					if(!copy.checked) {
						setErrorMessage("copy_error", "�������������� �����ؾ� ȸ�������� �����մϴ�.");
					} else {
						removeErrorMessage("copy_error");
					}
				});
				<%
					}
				%>
				
				document.getElementById("signup_btn").addEventListener("click", function(evt){
					if(name.value == "" || name.value.length == 0) {
						evt.preventDefault();
						setErrorMessage("name_error", "���̵� �Է����ּ���.");
					} else {
						var pattern = /[a-zA-Z0-9]/;
						if(!pattern.test(name.value)) {
							evt.preventDefault();
							setErrorMessage("name_error", "���̵�� ����� ���� ���ո� �����մϴ�.");
						}
					}
					
					var pattern = /^[a-zA-Z0-9]+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]+$/;
					if(!pattern.test(email.value)) {
						evt.preventDefault();
						setErrorMessage("email_error", "�̸��� �������� �Է����ּ���.");
					}
					
					document.getElementById("pass1_error").className = "error";
					var level = passwordLevel(pass1.value);
					if(level == 0) {
						evt.preventDefault();
						setErrorMessage("pass1_error", "��й�ȣ�� �Է����ּ���.");
					} else if(level == 1) {
						evt.preventDefault();
						setErrorMessage("pass1_error", "��й�ȣ�� ����,����,Ư������(~!@#$%^&*()_+|<>?:{})�� �����մϴ�.");
					} else if(level == 2) {
						evt.preventDefault();
						setErrorMessage("pass1_error", "�ʹ� ���� ��ȣ�Դϴ�.");
					} else if(level == 3) {
						evt.preventDefault();
						setErrorMessage("pass1_error", "�� ������ ������ �ʿ��մϴ�.");
					} else if(level == 4) {
						document.getElementById("pass1_error").className = "non_error";
						setErrorMessage("pass1_error", "������ ��ȣ�Դϴ�.");
					}
					
					if(pass1.value != pass2.value) {
						evt.preventDefault();
						setErrorMessage("pass2_error", "��й�ȣ�� Ȯ���� �ּ���.")
					}
					
					if(job.value == "") {
						evt.preventDefault();
						setErrorMessage("job_error", "������ �����ϼ���.");
					}
					<%
						if(user == null) {
					%>
					if(!copy.checked) {
						evt.preventDefault();
						setErrorMessage("copy_error", "�������������� �����ؾ� ȸ�������� �����մϴ�.");
					}
					<%
						}
					%>
				});
			});
		</script>

	</body>
</html>
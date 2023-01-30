<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberJoin</title>
<style>
h4 {
	text-align: center;
}

fieldset{
	width:550px;
	margin:0px auto;
}
 
fieldset label{
	width: 150px;
	float:left;
}

fieldset ul{
	/*text-align:center;*/
	/*margin:0;*/
	/*padding:0;*/
}

fieldset li{
	list-style-type:none;	
}

fieldset span{
	font-size:12px;
}

fieldset div{
	text-align:center;
}

.button{
	width:300px;
	
}
</style>

<script>
	function idcheck() {
		window.open('idCheck.jsp', 'idcheck','width:300, height:100', 'margin:0px auto');
	}
</script>
</head>
<body>
<%@include file="/header.jsp"%>
	<section>
		<article>
				<h4>회원가입</h4>
				<fieldset>
				<ul>
					<form name="memJoin" action="memberJoin_ok.jsp" method="post">
						<li><label>아이디</label></br>
							<input type="text" name="id" readonly>
							<input type="button" onclick="idcheck();" value="ID 중복 검사"></li>
							<span>5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.</span>
							
						<li><label>비밀번호</label></br> 
							<input type="password" name="pwd1" id="pwd1"></li>
							<span>8~16자 영문 대/소문자, 특수문자를 사용하세요</span>
						
						<li><label>비밀번호 재확인</label></br> 
							<input type="password" name="pwd2" id="pwd2" ondblclick="checkPwd()">
							</li>
							
						<!-- 	<script>
							function checkPwd(){
								var pwd1=document.getElementById("pwd1").value;
								var pwd2=document.getElementBuId("pwd2").value;
							if(pwd1!=pwd2){
								window.alert('오류');
									}
							}
							</script> -->
							
						<li><label>이름</label></br> 
							<input type="text" name="name"></li>
							
						<li><label>본인 확인 이메일</label></br> 
							<input type="text" name="email"></li>
							
						<li><label>나이</label></br>	
						<select name="age">
						<%for(int i=1;i<=100;i++){ %>
							<option value="<%=i%>"><%=i%></option>
							<%}%>
						</select></li>
						
						
						<li><label>지역</label></br> 
							<select name="local">
								<option value="서울" selected>서울</option>
								<option value="경기">경기</option>
								<option value="인천">인천</option>
								<option value="강원">강원</option>
								<option value="충북">충북</option>
								<option value="충남">충남</option>
								<option value="대전">대전</option>
								<option value="세종">세종</option>
								<option value="전북">전북</option>
								<option value="전남">전남</option>
								<option value="광주">광주</option>
								<option value="경북">경북</option>
								<option value="경남">경남</option>
								<option value="대구">대구</option>
								<option value="울산">울산</option>
								<option value="부산">부산</option>
								<option value="제주">제주</option>
						</select></li>
						
						<li><label>관심사</label></br> 
							<select name="hobby">
								<option value="운동" selected>운동</option>
								<option value="게임">게임</option>
								<option value="여행">여행</option>
								<option value="공연">공연</option>
								<option value="요리">요리</option>
								<option value="음악">음악</option>
								<option value="봉사">봉사</option>
								<option value="댄스">댄스</option>
						</select></li>
						
						<!-- <li><label>생년월일</label></br> 
							<input type="date" name="age"></li>-->
							
						<div>
							<input type="submit" value="회원가입" class="button">
						</div>
					</form>
				</ul>
				</fieldset>
		</article>
	</section>
<%@include file="/footer.jsp"%>
</body>
</html>
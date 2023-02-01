<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section{
	width:800px;
	margin:0 auto;
}
section h2{
	text-align:center;
}
section .moimcontent{
	display:flex;
	margin:0 auto;
	width:800px;
	height:260px;
	padding:10px 0 30px 0;
}
section .write{
	width:500px;
}
section .write table th{
	text-align:left;
	font-size:18px;
	padding-right:10px;
}
section .write table td{
	padding:4px 0;
}
section .imgupload{
	width:300px;
	text-align:center;
}
section .img{
	background:#eeeeee;
	width:160px;
	height:160px;
	margin:0 auto 10px auto;
}
.button{
	text-align: right;
	padding:0 40px 20px 0;
	
}
.button input{
	border:0;
	outline:none;
	width:100px;
	height:30px;
	cursor: pointer;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article>
	<h2>모임 만들기</h2>
	<div class="moimcontent">
		<div class="contents write">
		<form name="moimWrite">
			<table>
				<tr>
					<th>카테고리</th>
					<td>
						<select name="category">
							<option value="운동">운동</option>
							<option value="게임">게임</option>
							<option value="여행">여행</option>
							<option value="공연">공연</option>
							<option value="요리">요리</option>
							<option value="음악">음악</option>
							<option value="봉사">봉사</option>
							<option value="댄스">댄스</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>모임이름</th>
					<td>
						<input type="text" name="moimname" size="52">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="content" rows="10" cols="50">내용을 입력해주세요.</textarea>
					</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>
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
						</select>
					</td>
				</tr>
				<tr>
					<th>정원</th>
					<td>
						<select name="maxmem">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		</div>
		<div class="contents imgupload">
			<div class="img"></div>
			<div><input type="button" value="이미지 업로드"></div>
		</div>
	</div>
	<div class="button">
		<input type="submit" value="모임 만들기">
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>
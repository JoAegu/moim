<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style>
td{

	padding:5px;
}

.button{
	width: 50px;
	height:50px;
}

</style>

</head>
<body>

<form="login" action="login_ok.jsp">
<table class="input">
	<tr>
	<td><input type="text" name="id" placeholder="아이디" maxlength="45"></td>
	<td rowspan="2"><input type="submit" value="로그인" class="button">
	</tr>
	<td><input type="password" name="pwd" placeholder="비밀번호" maxlength="45">
	</td>
	</tr>
</table>
<div>
<input type="checkbox" value="on">아이디 저장
</div>
</form>


</body>
</html>
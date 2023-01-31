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
<%
String saveid="";
Cookie cks[]=request.getCookies();
if(cks!=null){
	for(int i=0;i<cks.length;i++){
		if(cks[i].getName().equals("saveid")){
			saveid=cks[i].getValue();
		}
	}
}
%>

<form name="login" action="login_ok.jsp" method="post">
<table class="input">
	<tr>
	<td><input type="text" name="id" placeholder="아이디" maxlength="45" value="<%=saveid%>"></td>
	<td rowspan="2"><input type="submit" value="로그인" class="button"></td>
	</tr>
	<tr>
	<td><input type="password" name="pwd" placeholder="비밀번호" maxlength="45">
	</td>
	</tr>
</table>
<div>
<input type="checkbox"  name="saveid" value="on" <%=saveid.equals("")?(""):"checked"%>>아이디 저장
</div>
</form>


</body>
</html>
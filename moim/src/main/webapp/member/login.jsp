<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>


.main{
	width:380px;
	height:300px;
	display:flex;
	justify-content: center;
	align-items:center;
	flex-direction: column;
	border: 1px solid gray;
	border-radius:5px;
}

.logo Img{
	width:80px;
	height:35px;
	object-fit:cover;
	margin: 0 0 10px 0;

}

.account{
	display:block;
	margin-top:3px;
	padding:3px;
	border: 1px solid gray;
	border-radius:5px;
}

.button{
	text-align: center;
	padding:10px 0 30px 0;
}

.button input{
	border:0;
	outline:none;
	width:100%;
	height:10px;
	cursor: pointer;
	background:#999999;
	color:white;
}
.button input[type="submit"]{
	background:#333333;
}
.button input:hover{
	background: #00cdac;
	transition: 0.3s;
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


<div class="main">
	<div class="logo"><img src="/moim/img/logo.png"></div> 
	<div class="container">
	<form name="login" action="login_ok.jsp" method="post" enctype="UTF-8">
	<input type="text" name="id" placeholder="아이디" maxlength="45" value="<%=saveid%>" class="account">
	<input type="password" name="pwd" placeholder="비밀번호" maxlength="45" class="account">
	<div class="button">
	<input type="submit" value="로그인" class="button"></div>
	<input type="checkbox" name="saveid" value="on" <%=saveid.equals("")?"":"checked" %> >아이디 저장하기
</div>
</div>

</body>
</html>
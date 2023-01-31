<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company</title>
<style>
body{
	width:1280px;
	margin:0px auto;
}

span img{
	size:contain;
}

.ib{
	position:relative;
}

.ib_img{
	veritcal-align:middle;
}
.ib_text{
	position:absolute;
	text-align:left;
	top:5%;
	left:5%;
	/*transform: translate(-50%,-50%);*/
	font-size: 25px;
	color:white;
}
</style>
</head>

<body>
<%@include file="header.jsp" %>
<div class="ib">
<div class="ib_img"><img src="/moim/img/intro.jpg"></div>
<div class="ib_text">
<h1>취향이 만나는 순간</br>
MOIM</h1></div>
</div>
<div class="info">
<h3>카피카피카피카피</h3>
<h5>설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명1</br>
설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명2</br>
설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명3</br>
설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명4</h5></div>
<%@include file="footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menu</title>
<style>

body{
	margin:0;
	padding:0;
	background: #f9f9f9;
}
section{
	width:1280;
	margin:0 auto;
}
.id_bg{
	background: #2DC6A2;
	width:100vw;
	height:30px;
	padding:8px 0 1px;
}
.id{
	width:1220px;
	margin:0px auto;
	text-align:right;
	font-size:14px;
	color:white;
}
.id a{
	color:white;
	text-decoration:none;
}
.id a:hover{
	color:white;
	font-weight: 600;
}

.navbar{
	width:100vw;
	border-bottom: 1px solid #A6A6A6;
	background:#ffffff;
}

.navbar_ul{
	width:1280px;
	margin:0 auto;
	display:flex;
	justify-content: space-around;
	align-items:center;
	height: 70px;
}

.navbar_ul li { 
	list-style-type:none;
	width: 192px;
	text-align:center;
	display:inline-block;
	font-weight:600;
	color:#0D0D0D;
	font-size: 17px;
}

.navbar_ul .logo{

}
.navbar_ul Img{
	width:110px;
	height:51px;
	padding-top:4px;
}

.navbar_ul a{	
	color:inherit;
	text-decoration:none;
	position:relative;
	padding: 4px;
}
.navbar_ul a:hover{
	color:#2DC6A2;
}
.navbar_ul a::after{
	content:"";
	position:absolute;
	bottom:0;
	left:50%;
	transform:translateX(-50%);
	width: 0%;
	height:3px;	
	background:#2DC6A2;
	transition:all 0.3s ease-out;
}
.navbar_ul a:hover::after{
	width: 100%;
	color:#2DC6A2;
}
.logo a:hover::after{
	width: 0%;
}
</style>


<script>

//로그인 팝업창
function login_popup(){
	var w='450';
	var h='350';

	var l=Math.ceil((window.screen.width-w)/2);
	var t=Math.ceil((window.screen.height-h)/2);
	window.open('/moim/member/login.jsp','loginPopup', 'width='+w+',height='+h+',left='+l+',top='+t);
}

</script>


</head>




<body>
<div class="id_bg">
<%
String name=(String)session.getAttribute("name");
if(name!=null){
%>
<div class="id"><%=name%>님&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/moim/board/myMoim.jsp">마이페이지&nbsp;&nbsp;&nbsp;&nbsp;</a>
<a href="/moim/member/logout.jsp">로그아웃</a></div>
<%}else{ %>
<div class="id"><a href="javascript:login_popup()">로그인</a>&nbsp;&nbsp;
<a href="/moim/member/memberJoin.jsp">회원가입</a></div>
<%} %>
</div>

<nav class="navbar">
<ul class="navbar_ul">
<li class="logo"><a href="/moim/index.jsp"><img src="/moim/img/logo.png" alt="로고"></a></li>
<li><a href="/moim/company.jsp">회사소개</a></li>
<li><a href="/moim/info/infoList.jsp">모임하기</a></li>
<li><a href="/moim/review/reviewList.jsp">후기보기</a></li>
<li><a href="/moim/noimg/notiList.jsp?idx_info=<%="0"%>&category=<%="1"%>">공지사항</a></li>
</ul>

</nav>
</body>
</html>
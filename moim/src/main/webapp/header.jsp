<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menu</title>
<style>

body{
	width:1280px;
	margin:0px auto;
}

.id{
	text-align:right;
	font-weight:bold;
	margin:20px 30px;
}

.navbar{
	height: 80px;
	border-top: 2px solid gray;
	border-bottom: 2px solid gray;
	display:flex;
	align-items:center;
	/*padding:5px 12px;*/
}


.navbar_ul{
	display:flex;
	align-items:center;
	/*text-align:center;*/
}

.navbar_ul li { 
	list-style-type:none;
	width: 240px;
	text-align:center;
	display: inline;
	font-weight:bold;
	padding:2px 8px;
	/*margin-left:10px;*/
}

.navbar_ul Img{
	width:81px;
	height:62px;
	float:left;
	margin-left:20px;
}

a{	
	color:inherit;
	text-decoration:none;
}

a:hover{
	color:gray;
	text-decoration:underline;
}
</style>


<script>

//로그인 팝업창
function login_popup(){
	var w='500';
	var h='300';

	var l=Math.ceil((window.screen.width-w)/2);
	var t=Math.ceil((window.screen.height-h)/2);
	window.open('/moim/member/login.jsp','loginPopup', 'width='+w+',height='+h+',left='+l+',top='+t);
}

</script>


</head>




<body>
<%
String name=(String)session.getAttribute("name");
if(name!=null){
%>
<div class="id"><%=name%>님&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/moim/board/myMoim.jsp">마이페이지&nbsp;&nbsp;&nbsp;&nbsp;</a>
<a href="/moim/member/logout.jsp">로그아웃</a></div>
<%}else{ %>
<div class="id"><a href="javascript:login_popup()">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/moim/member/memberJoin.jsp">회원가입</a></div>
<%} %>

<nav class="navbar">
<ul class="navbar_ul">
<li><a href="/moim/index.jsp"><img src="/moim/img/logo.png" alt="로고"></a></li>
<li><a href="/moim/company.jsp">회사소개</a></li>
<li><a href="/moim/info/infoList.jsp">모임하기</a></li>
<li><a href="/moim/review/reviewList.jsp">후기보기</a></li>
<li><a href="/moim/noimg/notiList.jsp?idx_info=<%="0"%>&category=<%="1"%>">공지사항</a></li>
</ul>

</nav>
</body>
</html>
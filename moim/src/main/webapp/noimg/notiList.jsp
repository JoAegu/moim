<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.*" %>
<%@page import="com.moim.noimg.*" %>
<jsp:useBean id="ndao" class="com.moim.noimg.NoimgDAO" scope="session"></jsp:useBean>

<%
//ndao.getList 매개변수 1)idx_info 
String sidx_info=request.getParameter("idx_info");
if(sidx_info==null||sidx_info==""){
	sidx_info="0";
}
int idx_info=Integer.parseInt(sidx_info);

//ndao.getList 매개변수 2)category 
String scategory=request.getParameter("category");
if(scategory==null||scategory.equals("")){
	scategory="0";
}
int category=Integer.parseInt(scategory);

String keyword = "";
if (request.getParameter("keyword") != null) {
	keyword = request.getParameter("keyword");
}

//1)2) 값 추후 활용을 위해 세션에 저장
session.setAttribute("idx_info", idx_info);
session.setAttribute("category", category);

//ndao.getList 매개변수 3)ls
int totalContent=ndao.getNotiTotalCnt( keyword);
int listsize=5;
int pageSize=5;
	
//ndao.getList 매개변수 4)cp
String scp=request.getParameter("cp");
if(scp==null||scp.equals("")){
	scp="1";
}
int cp=Integer.parseInt(scp);

//총 페이지 수 
int totalPage=totalContent/listsize+1;
if(totalContent%listsize==0){
	totalPage--;
}

//사용자 그룹 구하기
int userGroup=cp/pageSize;
if(cp%pageSize==0){
	userGroup--;
}
//member 테이블의 manager 값 가져오기(0:사용자/1:관리자)
Integer manager=(Integer)session.getAttribute("manager");
//로그인 안한 경우, manager값 -1로 지정
if(manager==null){
	manager=-1;
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">

<style>
section{
	width:1280px;
	margin:0px auto;
	padding:50px 0;
}

h2{
	font-size:45px;
	width: 85%;
	margin:0 auto;	
	font-family: 'Black Han Sans', sans-serif;
	font-weight: normal;
	text-align: center;
}


/* 검색창 */
form{
	width: 85%;
	margin:10px auto 20px auto;
	text-align: right;
}
form input[type="text"] {
	border: 2px solid #00cdac; 
	border-radius: 0px; 
	padding:8px;
}
form input[type="submit"] {
	border:0; 
	background-color:transparent;
	background-image:url("/moim/img/search.png");
	background-position:center;
	background-repeat:no-repeat;
	width:30px;
	height:40px;
	cursor: pointer;
	margin:-16px 0;
}

/* 게시판 리스트 */
table {
	width: 85%;
	margin:0 auto 0px auto;
	text-align: center;
	border-collapse: collapse;
}

table a:link, table a:visited{
	text-decoration: none;
	color:#333333;
}
.subject_r a:hover{
	font-weight: 800;
	color:black;
}

.num{
	width:10%;
}
.title{
	width:70%;
}
.date{
	width:20%;
}
#subject{
	text-align: left;
	padding-left: 30px;
}
table th {
	height: 46px;
	border-top: 2px solid #4C7C77; 
	border-bottom: 1px solid #4C7C77;
	text-align: center;
	vertical-align: inherit;
	background: #f3f3f3;
}

table td {
	border-bottom: 1px solid #e5e5e5;
	height: 46px;	
}

/*글쓰기 버튼*/
#b {
	text-align: center;
	
}

.button {
	width:85%;
	margin:0 auto;
	text-align: right;
	padding: 0px 0 20px 0;
}

.button input{
	border: 0;
	outline: none;
	width: 160px;
	height: 40px;
	cursor: pointer;
	background: #999999;
	color: white;
}

.button input[type="button"] {
	background: #00cdac;
}

.button input:hover {
	background:#333333;
	transition: 0.3s;
}

/* 페이징 */
.paging{
	width: 85%;
	margin: 20px auto;
	text-align: center;
}
.paging a{
	display: inline-block;
	width: 34px;
	height: 34px;
	line-height: 34px;
	transition:0.2s;
}
.paging a:link,a:visited{
	text-decoration: none;
	color:#333333;
}
.paging a:hover{	
	font-weight: 800;
	color:#ffffff;
	background:#00cdac;
	border-radius: 100%;
}

</style>

<script>
/*manager 값이 1이면 버튼(#b) 노출 <-> 0일 경우, 숨기기*/
function write_button(){
	var manager=<%=manager%>;
	if(manager==1){
		document.getElementById("b").style.display="inline-block";
	}else{
		document.getElementById("b").style.display="none";
	}
	
} 
</script>

</head>
<body  onload="write_button();">
<%@include file="/header.jsp"%>
	<section >
		<article>
		<h2>공지사항</h2>
		<form name="search" action="notiList.jsp">
		<div class ="search2">
		<input type="text" name="keyword" size="30"> <input type="submit" value="">
		</div>
		</form>
							
			<table>
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="date">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%ArrayList<NoimgDTO> arr=ndao.getList2(listsize, cp, keyword);
						
							if(arr==null||arr.size()==0){
					%>
					<tr>
					<td colspan="3">등록된 게시글이 없습니다</td>
					</tr>
					<%}else{ 
					for(int i=0;i<arr.size();i++){	%>
					<tr>
						<td id="idx" class="num"><%=arr.get(i).getIdx()%></td>
						<td id="subject" class="title"><a href="notiContent.jsp?idx=<%=arr.get(i).getIdx()%>"><%=arr.get(i).getSubject() %></a></td>
						<td id="writedate" class="date"><%=arr.get(i).getWritedate() %></td>
					</tr>
					<%}
					}%>
				</tbody>
			</table>
		<div class ="bottom">
		<div class ="paging">
				<%if(userGroup!=0){
				%>
					<a href="notiList.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>&keyword=<%=keyword%>"> &lt;&lt;</a>
				<%
				}
				%>
				<%
				for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize;i++){
				%>
				&nbsp;&nbsp;
				<a href="notiList.jsp?cp=<%=i%>&keyword=<%=keyword%>"><%=i%></a>&nbsp;&nbsp;
				<%
					if(i==totalPage) break;
				}%>
				<%
				if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
				%>
					<a href="notiList.jsp?cp=<%=(userGroup+1)*pageSize+1%>&keyword=<%=keyword%>">&gt;&gt;</a>
				<%
				}
				%>
				</div>	
			<div class="button">
					<input type="button" value="글쓰기" id="b" onclick="javascript:location.href='notiWrite.jsp'">
			</div>
			</div>
		</article>
	</section>
<%@include file="/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.moim.info.*" %>
<jsp:useBean id="idao" class="com.moim.info.InfoDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임게시판</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<style>
section{
	width: 1280px;
	padding: 20px;
	margin:0 auto;
}
section article{
	width: 85%;
	margin:0 auto;
}
article h3{
	font-size: 32px;
	margin:30px 0 0 0;
	font-family: 'Black Han Sans', sans-serif;
	font-weight: normal;
	color: #333333;
}

/* 검색창 */
.search-bar{
	vertical-align: middle;
	margin: 30px 0;
	text-align: center;
}
.search-bar input[type="text"]{
	border: 2px solid #00cdac; 
	border-radius: 0px; 
}
.search-bar input[type="submit"]{
	border:0; 
	background-color:transparent;
	background-image:url("/moim/img/search.png");
	background-position:center;
	background-repeat:no-repeat;
	width:30px;
	height:40px;
	cursor: pointer;
	margin:-10px 20px -14px 2px;
}

/*세부사항 내 관심사*/
input[type="checkbox"] {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    border: 1px solid #999;
    appearance: none;
    cursor: pointer;
  }

  input[type="checkbox"]:checked {
    background: black;
    border: none;
  }
  
/*세부사항 토글관련*/
label.detail{
	background: #00cdac;
	color:white;
	display:inline-block; 
	width:100px;
	line-height: 32px;
	padding:2px 0;
	cursor:pointer;
	text-align: center;
	font-size:14px;
}
label:hover, label:active, input:hover+label, input:active+label {
    background:#00cdac;
	transition: 0.3s;
}
#detaildiv{
	height:100px;
	margin-top:10px;
	border-radius:12px;
	border:2px solid #DDDDDF;
	background:white;
}
#detaildiv fieldset{
	border:0;
	padding:20px 0;
}
#detaildiv table{
	margin:0 auto;
}
input#detail{
	display:none;
}
div#detaildiv{
	display: none;
}
input#detail:checked + div#detaildiv{
	display: block;
}
#detaildiv select{
	padding: 4px 10px; 
	border: 1px solid #999999; 
	border-radius: 0px; 
	margin-left:10px;
}
input[type="text"]{
	padding:0 10px;
	height:30px;
}

/*추천 모임*/
.infodiv1{
	display: flex;
	justify-content:space-between;
	padding: 10px 0;
	border-bottom: 1px solid #A6A6A6;
}
.moim-info a{
	display: flex;
	padding: 12px 10px;
	width: 506px;
	align-items: center;
	border-radius: 14px;
	border:2px solid #ebedee;
	transition:0.4s;
	margin:10px 0 40px 0;
	background:white;
}
.moim-info a:hover{
	border-radius: 14px;
	border:2px solid #00cdac;
}
.info1 h3{
	border-top: 1px solid #A6A6A6;
	padding-top:30px;
	padding-bottom:0;
}
.moim-con ul{
	list-style: none;
	padding:0;
	margin-left:10px;
}
.thumb1{
	width: 260px;
	height: 160px;
	overflow: hidden;
	position: relative;	
	border-radius: 12px;
}
.thumb1 img{
	position:absolute;
	height:100%;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%) scale(1.1);
	transition:all 0.5s;
	
}
.thumb1 img:hover{
	transform: translate(-50%, -50%) scale(1.2);
}

/*현재 모집중인 모임*/
.info2{
	list-style: none;
	width:100%;
	padding:0;
}
.info2 li{
	display: inline-block;
	width:49.5%;
}
.li2{
	text-align: right;
}
.more-btn{
	display: inline-block;
	width:100px;
	height:30px;
	cursor: pointer;
	background:#999999;
	color:white;
	text-align: center;
	font-size: 14px;
}
.more-btn a{
	text-decoration:none;
	line-height: 30px;
}
.more-btn a:link, .more-btn a:visited{
	color:white;
}
.infodiv2{
	display:flex;
	justify-content: space-between;
	margin-bottom:30px;
}
.infodiv1 a, .infodiv2 a{
	text-decoration: none;
	color: #333333;
}
.infodiv1 a:link, .infodiv2 a:visited, .infodiv1 a:link, .infodiv2 a:visited{
	color: #333333;
}
.infotable{
	width:240px;
	border-radius: 14px;
	border:2px solid #ebedee;
	transition:0.4s;
	background:white;
}
.infotable:hover{
	border-radius: 14px;
	border:2px solid #00cdac;
}
.info_top{
	font-size: 14px;
	color:#666666;
	margin:8px 0 4px 10px;
}
.thumb2{
	width: 240px;
	height: 240px;
	overflow: hidden;
	position: relative;	
	border-radius: 12px;
	margin-bottom: 10px;
}
.thumb2 img{
	position:absolute;
	height:100%;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	transition:all 0.5s;
}
.thumb2 img:hover{
	transform: translate(-50%, -50%) scale(1.1);
}
.title{
	font-size: 20px;
	font-weight: 600;
	margin:4px 0 0 10px;
	/*말줄임표*/
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.title:hover{
	color: #00cdac;
}
.mem{
	margin:4px 0 10px 14px;
	color: #f09819;
	font-weight: bold;
}

/*모임만들기 버튼*/
#buttondiv{
	text-align: right;

}
.button{
	border: 0;
	outline: none;
	width: 160px;
	height: 40px;
	cursor: pointer;
	background: #00cdac;
	color: white;
	margin-bottom:40px;
	font-size: 14px;
}
.button:hover {
	transition: 0.3s;
	background:#333333;
}
</style>
</head>
<%
String detail="";
if(request.getParameter("detail")!=null){
detail=request.getParameter("detail");
}
String hobby="total";
if(session.getAttribute("hobby")!=null&&!session.getAttribute("hobby").equals("")){
	hobby=(String)session.getAttribute("hobby");
}
%>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<form name="infoSearch" action="infoSearch.jsp">
			<div class="search-bar">
				<input type="text" name="keyword" placeholder="검색어를 입력하세요" size="60">
				<input type="submit" value="">
			<label class="detail" for="detail">세부검색</label>
			<input type="checkbox" id="detail">
				<div id="detaildiv">
				<fieldset>
				<table>
					<tr>
					<th>
					관심사
					</th>
						<td><input type="checkbox" name="hobby" value="운동">운동&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="게임">게임&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="여행">여행&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="공연">공연&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="요리">요리&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="음악">음악&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="봉사">봉사&nbsp;</td>
						<td><input type="checkbox" name="hobby" value="댄스">댄스</td>
					</tr>
					<tr>
					<th>지역</th>
					<td>
						<select name="local">
							<option value="전체" selected>전체</option>
							<option value="서울">서울</option>
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
				</table>
				</fieldset>
				</div>
				</div>
		</form>				
	</article>

	
	<article class="info1">
	<h3>이런 모임은 어때요?</h3>
		<div class="infodiv1">
		<%
		ArrayList<InfoDTO> fitarr=idao.getList(hobby);
		if(fitarr!=null){
		for(int i=0;i<fitarr.size()&&i<=1;i++){ %>
			<div class="moim-info">
			<a href="moimContent.jsp?idx=<%=fitarr.get(i).getIdx()%>">
			<div class="thumb1">
				<%if(fitarr.get(i).getImg()!=null&&!fitarr.get(i).getImg().equals("")){ %>
				<img alt="img<%=i %>" src="/moim/userimg/<%=fitarr.get(i).getImg()%>">
			<%}else{ %>	
				<img alt="noimg<%=i %>" src="/moim/img/noimg.png">
			<%} %>
			</div>
			<div class="moim-con">
				<ul>
					<li class="info_top"><%=fitarr.get(i).getHobby() %>&nbsp;/&nbsp;<%=fitarr.get(i).getLocal() %></li>
					<li class="title"><%=fitarr.get(i).getMoimname() %></li>
					<li class="mem"><%=fitarr.get(i).getNowmem() %>/<%=fitarr.get(i).getMaxmem() %></li>
				</ul>
			</div>
			</a>
			</div>

			<%
		}
		}else{%>
			<h3>모임이 없습니다.</h3>
		<%} %>
		</div>
	</article>
	
	
	<article>
		<ul class="info2">
			<li><h3>현재 모집중인 모임</h3></li>
			<li class="li2"><div class="more-btn"><a href="infoSearch.jsp">더보기 +</a></div></li>
		</ul>
			<div class="infodiv2">
			<%
			ArrayList<InfoDTO> needarr=idao.getList("total");
			if(needarr==null||needarr.size()==0){
				%><h2>현재 모집중인 모임이 없습니다</h2><%
			}else{
				for (int i=0;i<needarr.size()&&i<4;i++){ %>
				<div class="infotable" id="infotab">
				<a href="moimContent.jsp?idx=<%=needarr.get(i).getIdx()%>">
					<div class="thumb2">
					<%if(needarr.get(i).getImg()!=null&&!needarr.get(i).getImg().equals("")){ %>
				<img alt="img<%=i %>" src="/moim/userimg/<%=needarr.get(i).getImg()%>">
			<%}else{ %>	
				<img alt="noimg<%=i %>" src="/moim/img/noimg.png">
			<%} %>
					</div>
					<div class="info_top"><%=needarr.get(i).getHobby() %>&nbsp;/&nbsp;<%=needarr.get(i).getLocal() %></div>
					<div class="title"><%=needarr.get(i).getMoimname() %></div>
					<div class="mem"><%=needarr.get(i).getNowmem() %>/<%=needarr.get(i).getMaxmem() %></div>
				</a>
				</div>
			<%}} %>
			
			</div>
	
		<div id="buttondiv">
		<input type="button" value="모임만들기" class="button" onclick="javascript:location.href='moimWrite.jsp'">
		</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>
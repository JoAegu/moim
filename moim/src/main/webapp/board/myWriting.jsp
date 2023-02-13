<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.moim.member.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.moim.noimg.*" %>
<%@ page import="com.moim.review.*" %>
<jsp:useBean id="mdao" class="com.moim.member.MemberDAO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.moim.review.ReviewDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">

<style>
section{
	width:1280px;
	margin:0px auto;
	padding:50px 0;
	min-height: 560px;
}

h3.my-title{
	font-size:32px;
	margin:0 auto;
	padding-bottom:10px;
	width: 54%;
	font-family: 'Black Han Sans', sans-serif;
	font-weight: normal;
	color: #333333;
}

/* 게시판 리스트 */
table {
	width: 74%;
	margin:0 auto 0px auto;
	text-align: center;
	border-collapse: collapse;
}



table th {
	height: 46px;
	border-top: 2px solid #4C7C77; 
	border-bottom: 1px solid #4C7C77;
	text-align: center;
	vertical-align: inherit;
}

table td {
	border-bottom: 1px solid #e5e5e5;
	height: 46px;	
}

.my-review input[type="button"]{
	outline: none;
	background:#999999;
	color:white;
	border:0;
	border-radius: 4px;
	padding:4px 10px;
	cursor:pointer;
}
.my-review input[type="button"]:hover{
	transition: 0.3s;
	background: #00cdac;
}
.my-write input[type="submit"]{
	outline: none;
	background:#999999;
	color:white;
	border:0;
	border-radius: 4px;
	padding:4px 10px;
	cursor:pointer;
}
.my-write input[type="submit"]:hover{
	transition: 0.3s;
	background: #00cdac;
}
.my-review table #hobby {
	width: 10%;
	text-align: center;
}
.my-review table #subject {
	width: 60%;
}
.my-review table td#subject {
	text-align: left;
	padding-left:20px;
	/*말줄임표*/
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.my-review table #writedate {
	width: 15%;
}

.my-review table #update{
	width:15%;
}

.my-review table #moimname {
	width: 18%;
	text-align: center;
	/*말줄임표*/
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.my-review a:hover{
	font-weight: bold;
}
.my-review a:link, .my-review a:visited{
	text-decoration: none;
	color:#333333;
}

.my-write table #subject {
	width: 55%;
}
.my-write table td#subject{
	text-align: left;
	padding-left:30px;
	/*말줄임표*/
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.my-write table #writedate {
	width: 15%;
}

.my-write table #update{
	width:10%;
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

.paging2{
	padding-left:140px;
}
</style>
</head>
<%
Integer idx=(Integer)session.getAttribute("idx");
if(idx==null){
	idx=0;
}

int listSize=5;
int pageSize=5;

String cp_s=request.getParameter("cp");
if(cp_s==null||cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);

String cp2_s=request.getParameter("cp2");
if(cp2_s==null||cp2_s.equals("")){
	cp2_s="1";
}
int cp2=Integer.parseInt(cp2_s);

int totalCnt=mdao.getTotal("moim_review", idx, 1);
int totalPage=totalCnt/listSize+1;
if(totalCnt%listSize==0)totalPage--;

int userGroup=cp/pageSize;
if(cp%pageSize==0)userGroup--;

int totalCnt2=mdao.getTotal("moim_noimg", idx, 2);

int totalPage2=totalCnt2/listSize+1;
if(totalCnt2%listSize==0)totalPage2--;
int userGroup2=cp2/pageSize;
if(cp2%pageSize==0)userGroup2--;


%>
<body>
<%@include file="/header.jsp" %>
<div class="container">
<section>
<%@include file = "sideBoard.jsp" %>
	<article>
	<div class="my-review">
		<h3 class="my-title">내가 쓴 후기</h3>
		<table>
			<thead>
				<tr>
					<th id="hobby">카테고리</th>
					<th id="subject">제목</th>
					<th id="writedate">등록일자</th>
					<th id="update">수정 &nbsp; 삭제</th>
				</tr>
			</thead>
			<tbody>
			<%
			ArrayList<ReviewDTO> dto1=mdao.getMyReview(idx,listSize,cp);
			if(dto1==null||dto1.size()==0){
				%>
				<tr id="id">
					<td colspan="5" align="center">
					등록된 후기가 없습니다.
					</td>
				</tr>
				<%
			}else{
				for(int i=0;i<dto1.size();i++){
					%>
					<tr>
						<td id="hobby"><%=dto1.get(i).getHobby() %></td>
						<td id="subject"><a href="/moim/review/reviewContent.jsp?idx=<%=dto1.get(i).getIdx()%>"><%=dto1.get(i).getSubject() %></a></td>
						<td id="writedate"><%=dto1.get(i).getWritedate() %></td>
						<td id="update">
						<input type="button" value="수정" onclick="javascript:location.href='/moim/review/updateReview.jsp?idx=<%=dto1.get(i).getIdx()%>'">
						<input type="button" value="삭제" onclick="javascript:location.href='myWritingDelReview_ok.jsp?idx=<%=dto1.get(i).getIdx()%>'">
						</td>
					</tr>
					<%
				}
			}
			%>
			</tbody>
		</table>
		<div class = "paging">
			<%
			if(userGroup!=0){
				%><a href="myWriting.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>&cp2=<%=cp2%>">&lt;&lt;</a><%
			}
			%>
			<%
			for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize;i++){
				%>&nbsp;&nbsp;<a href="myWriting.jsp?cp=<%=i%>&cp2=<%=cp2%>"><%=i %></a>&nbsp;&nbsp;<%
				if(i==totalPage)break;
			}
			%>
			<%
			if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
				%><a href="myWriting.jsp?cp=<%=(userGroup+1)*pageSize+1%>&cp2=<%=cp2%>">&gt;&gt;</a><%
			}
			%>
		</div>
	</div>
	</article>
	<article>
	<div class="my-write">
		<h3 class="my-title">내가 쓴 글(QnA)</h3>
		<table>
			<thead>
				<tr>
					<th id="moimname">모임이름</th>
					<th id="subject">제목</th>
					<th id="writedate">등록일자</th>
					<th id="update">삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
				HashMap<Integer,String> map1=mdao.moimName();
				ArrayList<NoimgDTO> dto2=mdao.getMyQna(2, idx,listSize,cp2);
				if(dto2==null||dto2.size()==0){
					%>
					<tr>
						<td colspan="5" align="center">
						등록된 댓글이 없습니다.
						</td>
					</tr>
					<%
				}else{
					for(int i=0;i<dto2.size();i++){
						%>
						<tr>
							<td id="moimname"><%=map1.get(dto2.get(i).getIdx_info())%></td>
							<td id="subject"><a href="/moim/info/moimContent.jsp?idx=<%=dto2.get(i).getIdx_info()%>"><%=dto2.get(i).getSubject() %></a></td>
							<td id="writedate"><%=dto2.get(i).getWritedate() %></td>
							<td id="update">
								<input type="submit" value="삭제" onclick="javascript:location.href='myWritingDelQna_ok.jsp?idx=<%=dto2.get(i).getIdx()%>'"></td>
							</tr>
						<%
					}
				}
				%>
			</tbody>	
			</table>
			<div class = "paging paging2">
				<%
				if(userGroup2!=0){
					%><a href="myWriting.jsp?cp2=<%=(userGroup2-1)*pageSize+pageSize%>&cp=<%=cp%>">&lt;&lt;</a><%
				}
				%>
				<%
				for(int i=userGroup2*pageSize+1;i<=userGroup2*pageSize+pageSize;i++){
					%>&nbsp;&nbsp;<a href="myWriting.jsp?cp2=<%=i%>&cp=<%=cp%>"><%=i %></a>&nbsp;&nbsp;<%
					if(i==totalPage2)break;
				}
				%>
				<%
				if(userGroup2!=(totalPage2/pageSize-(totalPage2%pageSize==0?1:0))){
					%><a href="myWriting.jsp?cp2=<%=(userGroup2+1)*pageSize+1%>&cp=<%=cp%>">&gt;&gt;</a><%
				}
				
				%>
			</div>
	</div>
	</article>
</section>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>

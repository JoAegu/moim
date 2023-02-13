<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.moim.noimg.*" %>
<jsp:useBean id="ndao" class="com.moim.noimg.NoimgDAO" scope="session"></jsp:useBean>
<%@ page import="com.moim.info.*" %>
<jsp:useBean id="idao" class="com.moim.info.InfoDAO"></jsp:useBean>

<%
//ndao.getList 매개변수 1)idx_info 
String sidx_info=request.getParameter("idx_info");
if(sidx_info==null||sidx_info==""){
   sidx_info="0";
}
int idx_info=Integer.parseInt(sidx_info);

//ndao.getList 매개변수 2)category 
String scategory=request.getParameter("category");
if(scategory==null||scategory==""){
   scategory="1";
}
int category=Integer.parseInt(scategory);

//1)2) 값 추후 활용을 위해 세션에 저장
session.setAttribute("idx_info", idx_info);
session.setAttribute("category", category);

//ndao.getList 매개변수 3)ls
int totalContent=ndao.getNotiTotalCnt("");
int listsize=5;
int pageSize=5;
   
//ndao.getList 매개변수 4)cp
String scp=request.getParameter("cp");
if(scp==null||scp.equals("")){
   scp="1";
}
int cp=Integer.parseInt(scp);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOIM</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">

<style>
*{
margin:0;
padding:0;
}
section{
   width: 1280px;
   margin:0 auto;
}
h3{
	font-size: 32px;
	padding:60px 0 30px 0;
	font-family: 'Black Han Sans', sans-serif;
	font-weight: normal;
	color: #333333;
	text-align: center;
}

/*배너 슬라이드*/
.slide_radio input[id*="slide"]{  /*radio 버튼*/
   display:none;
}
.slide_box{
   width: 1280px;
   height:360px;
   margin:0 auto;
   overflow:hidden;
}
.slide_list{
   white-space: nowrap;
}
.slide_list li{
   display: inline-block;
   vertical-align: middle;
   width: 100%;
   transition:all 0.6s;
   position: relative;
}
.slide_list li a img{
   width: 100%;
}
.slide_list label{
   position: absolute;
   z-index: 10;
   top:50%;
   transform:translateY(-50%);
   padding:60px;
   cursor:pointer;
   transition:0.3s;

}
.slide_list .left{
   left:4px;
   background-image:url('/moim/img/left_w.png');
   background-position: center center;
   background-repeat: no-repeat;
   opacity: 0.2;
}
.slide_list .right{
   right:4px;
   background-image:url('/moim/img/right_w.png');
   background-position: center center;
   background-repeat: no-repeat;
   opacity: 0.2;
}
.slide_list .left:hover, .slide_list .right:hover{
   opacity: 1;
}
.slide_radio [id="slide01"]:checked ~ .slide_box .slide_list>li{
   transform:translateX(0%);
}
.slide_radio [id="slide02"]:checked ~ .slide_box .slide_list>li{
   transform:translateX(-100%);
}
.slide_radio [id="slide03"]:checked ~ .slide_box .slide_list>li{
   transform:translateX(-200%);
}

/*현재 모집 중인 소모임*/

.slide-view{
	display:flex;
}
.current_moim{
   width:100vw;
   background: #F2F2F2;
}
.c_moim{
   width: 1280px;
   margin:0 auto;
   padding-bottom:50px;
}
.current_moim h2{
   margin:0;
   padding-top:50px;
}

.current_moim_box1{
   align-content: center;
   margin:0px auto;
   display:flex;
   justify-content:space-around;
   height:300px;
}

li{
	list-style:none;
}

#slide_wrapper{
	position:relative;
	width:960px;
	margin:0 auto;
	height:340px;
	overflow:hidden;
}

#slides{
	position:absolute;
	left:0; top:0;
	transition:left 0.5s ease-out;
	magin:0;
	padding:0; 
	width: 1950px; 
}

#slides .info{
	width: 300px;
} 

#slides li{
	display:flex;
}

#slides li:not(:last-child){
	float:left;
	margin-right:30px;
}

.info a{
	text-decoration: none;
	color: #333333;
}
.info a:link, .info a:visited{
	color: #333333;
}
.thumb{
	width: 260px;
	height: 260px;
	overflow: hidden;
	position: relative;	
	border-radius: 12px;
	margin-bottom: 10px;
}
.thumb img{
	position:absolute;
	height:100%;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	transition:all 0.5s;
}
.thumb img:hover{
	transform: translate(-50%, -50%) scale(1.1);
}
.title{
	font-size: 20px;
	font-weight: 600;
	margin:4px 0 4px 6px;
	/*말줄임표*/
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.title:hover{
	color: #00cdac;
}
.moim_info{
	font-size: 16px;
	color:#666666;
	margin:4px 0 4px 6px;
}
.controls{
	width:102px;
}
.controls span{
	display:inline-block;
	width:40px;
	height:40px;
	margin:0 4px;
	cursor: pointer;
}
.controls span img{
	width: 100%;
}
.mbutton{
	display: flex;
	flex-direction: column;
}

/*공지사항*/
.notice h3{
   padding-bottom:0px;
}
.notice .sbutton{
	margin:10px 0 30px 0;
}
.notice #notice_tb{
   justify-content:center;
   align-items:center;
   text-align:center;
   display:felx;
   width:70%;
   margin: 0 auto;
   padding: 10px 29px 10px 29px;
}
#notice_tb table{
	border-collapse: collapse;
	border-radius:20px;
	width:100%;
}
tr{
	display:inline-block;
	width:100%;
	padding:10px;
	border-radius: 20px;
	background:white;
	transition:0.4s;
	border:2px solid #ebedee;
}
tr:hover{
	border:2px solid #00cdac;
}
tr a{
	color:#333333;
	text-decoration: none;
}
tr a:visited, tr a:link{
	color:#333333;
	text-decoration: none;
}
.notice table #idx{
   width: 5%;
}

.notice table #subject{
   text-align: left;
  	padding: 0 40px 0 40px;
}

#subject:hover{
   font-weight:bold;
}

.notice table #writedate{
   width: 10%;
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

.button{
   text-align: right;
   padding:0 10px 20px 0;
}
.button input{
   border:0;
   outline:none;
   width:90px;
   height:30px;
   cursor: pointer;
   background:#999999;
   color:white;
}


.button input:hover{
   background: #00cdac;
   transition: 0.3s;
}
.sbutton{
   	text-align: right;
   	padding:0 10px 20px 0;
}
.sbutton input[type="button"]{
	border:0;
	outline:none;
	display: inline-block;
	width:100px;
	height:30px;
	cursor: pointer;
	background:#999999;
	color:white;
	text-align: center;
	font-size: 14px;
}
.sbutton input[type="button"]:hover{
	background: #00cdac;
	transition:0.3s;
}
</style>
</head>
<body>
<%@include file="header.jsp" %>
<section class="mainImg">
   <div class="slide_radio">
      <input type="radio" name="slide" id="slide01" checked>
      <input type="radio" name="slide" id="slide02">
      <input type="radio" name="slide" id="slide03">
   
   <div class="slide_box">
   <ul class="slide_list">
      <li>
         <div>
            <label for="slide03" class="left"></label>
            <a href="/moim/member/memberJoin.jsp">
            <img src="/moim/img/banner_main1.jpg" alt="매인 배너">
            </a>
            <label for="slide02" class="right"></label>
         </div>
      </li>
      <li>
         <div>
            <label for="slide01" class="left"></label>
            <a href="/moim/review/reviewList.jsp">
            <img src="/moim/img/banner_main.jpg" alt="매인 배너">
            </a>
            <label for="slide03" class="right"></label>
         </div>
      </li>
      <li>
         <div>
            <label for="slide02" class="left"></label>
            <a href="/moim/info/infoSearch.jsp?keyword=&hobby=공연&local=전체.jsp">
            <img src="/moim/img/banner_main2.jpg" alt="매인 배너">
            </a>
            <label for="slide01" class="right"></label>
         </div>
      </li>
   </ul>
   </div>
   </div>
</section>

<section class="current_moim">
<div class="c_moim">
<h3>현재 모집 중인 소모임</h3>

<div class="slide-view">
<div id="slide_wrapper">
<ul id="slides">
<%
		ArrayList<InfoDTO> needarr=idao.getList("total");
		if(needarr==null||needarr.size()==0){
			%><h2>현재 모집중인 모임이 없습니다</h2>
		<%
		}else{
		for(int i=0;i<needarr.size()&&i<6;i++){ %>

<li>
<div class="info">
<a href="/moim/info/moimContent.jsp?idx=<%=needarr.get(i).getIdx()%>">
	<div class="thumb"><img alt="needimg<%=i%>" src="/moim/userimg/<%=needarr.get(i).getImg()%>"></div>
	<div class="title"><%=needarr.get(i).getMoimname() %></div>
	<div class="moim_info"><%=needarr.get(i).getHobby() %>&nbsp;/&nbsp;<%=needarr.get(i).getLocal() %></div>
</a>
</div>
</li>
<%}} %>
</ul>
</div>
<div class="mbutton">
<div class="sbutton"><input type="button" value="전체보기 > " onclick="javascript:location.href='/moim/info/infoSearch.jsp'"></div>
<p class="controls">
<span class="prev" onclick="prevBtn()"><img src="/moim/img/previous.png"></span>
<span class="next" onclick="nextBtn()"><img src="/moim/img/next.png"></span>
</p>
</div>
<script>
var slides=document.getElementById('slides');
var slide=document.getElementById('slides li');
var currentId=0;
var slideCount=6;

function moveSlide(num){
	slides.style.left=(-num*330)+'px';
	currentId=num;
}

function prevBtn(){
	if(currentId > 0){
		moveSlide(currentId-1);	
	}else{
		moveSlide(slideCount-3);
	}
}

function nextBtn(){
	if(currentId<(slideCount-3)){
		moveSlide(currentId+1);	
	}else{
		moveSlide(0);
	}
}
</script>
</div>
</section>


<section class="notice">
<h3>공지사항</h3>
<div id="notice_tb"> 
<table>
   <tbody>
         <%ArrayList<NoimgDTO> arr=ndao.getList(idx_info,category,listsize, cp);
                  if(arr==null||arr.size()==0){
            %>
            <tr id="td">
            <div class="noti-list">
            <td colspan="3">등록된 게시글이 없습니다.</td>
            <%}else{ 
               for(int i=0;i<arr.size();i++){   
            %>
               <td id="idx"><%=arr.get(i).getIdx()%></td>
               <td id="subject"><a href="/moim/noimg/notiContent.jsp?idx=<%=arr.get(i).getIdx()%>"><%=arr.get(i).getSubject() %></a></td>
               <td id="writedate"><%=arr.get(i).getWritedate() %></td>
            </div>
            </tr>
            <%}
            }%>
   </tbody>
</table>
</div>
<div class="sbutton"><input type="button" value="더보기 >" onclick="javascript:location.href='/moim/noimg/notiList.jsp?idx_info=<%=session.getAttribute("idx_info")%>'"></div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="com.moim.review.* "%>

	<jsp:useBean id="rdao" class="com.moim.review.ReviewDAO" scope="session"></jsp:useBean>
	<%
String idx_s = request.getParameter("idx");
if (idx_s == null || idx_s.equals("")) {
	idx_s = "0";
}

int idx = Integer.parseInt(idx_s);
ReviewDTO dto = rdao.getContent(idx);
if (dto == null) {
%>
<script>
	window.alert('삭제된 게시글 또는 잘못된 접근입니다');
	location.href = 'reviewList.jsp';
</script>
<%
// 더이상 자바코드가 번역되지 않도록
return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
h2, h4 {
text-align: center;
	margin: 0px auto;
}

table {
	text-align: center;
	margin: 0px auto;
}
</style>
<body>
	<%@include file="/header.jsp"%>
	<form name="reviewupdateForm" action="updateReview.jsp">
	<h2>독서 모임 후기</h2>
	<h4>-모임명 : <%=dto.getMoimname()%>&nbsp;&nbsp;&nbsp;&nbsp;-지역 : <%=dto.getLocal() %></h4>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<section>
		<article>
			<table>
				<thead>
					<tr>
						<th>이미지</th>

						<th>이미지</th>

						<th>이미지</th>
					</tr>
				</thead>
				<tr height="150">
					<td colspan="3"><%=dto.getContent().replaceAll("\n", "\r")%>
					</td>
				</tr>
				<tfoot>
					<tr>
						<td colspan="3"><input type="button" value="목록"
							onclick="location.href='reviewList.jsp'"> <input
							type="submit" name="modify" value="수정" > <input
							type="button" name="delete" value="삭제"></td>
					</tr>
				</tfoot>
					
			</table>
		</article>
	</section>
	</form>
	<%@include file="/footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	
</script>
<style>
div {
	text-align: center;
	margin: 0px auto;
}

table {
	border-top: 3px;
	border-left: 3px double dark;
	border-right: 3px solid dark;
	border-bottom: 3px solid dark;
	text-align: center;
	margin: 0px auto;
	width: 600px;
}

thead {
	margin-bottom: 70px;
	margin: 0px auto;
	border-pacing: 70px;
}

tfoot {
	
}

div {
	margin: 0px auto;
	texxt-align: center;
}
</style>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<div>
				<select name="category">
					<option value="카테고리">카테고리</option>
					<option value="운동">운동</option>
					<option value="게임">게임</option>
					<option value="여행">여행</option>
					<option value="공연">공연</option>
					<option value="요리">요리</option>
					<option value="음악">음악</option>
					<option value="봉사활동">봉사활동</option>
					<option value="댄스">댄스</option>
				</select> <input type="text" name="search"> <input type="button"
					onclick="show()" value="검색">
			</div>
			<table>

				<tfoot>
					<tr>
						<td></td>
						<td></td>
						<td><input type="button"
							onclick="location.href='writeReview.jsp'" value="후기쓰러가기">
						</td>
					</tr>
				</tfoot>

				<thead>
					<tr>
						<th>카테고리</th>
						<th>모임이름</th>
						<th>제목</th>
					</tr>
				</thead>
				<tbody>
					<%-- 
					
					<%
					ArrayList<BbsDTO> arr = bdao.bbsList(listSize, cp);
					if (arr == null || arr.size() == 0) {
					%>

					<tr>
						<td colspan="5">등록된 글이 없습니다</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					%>

					<tr>
						<td><%=arr.get(i).getIdx()%></td>
						<td><a href="bbsContent.jsp?idx=<%=arr.get(i).getIdx()%>"><%=arr.get(i).getSubject()%></a>
						</td>
						<!-- ? 다음은 키와 값이다 -->
						<td><%=arr.get(i).getWriter()%></td>
						<td><%=arr.get(i).getWritedate()%></td>
						<td><%=arr.get(i).getReadnum()%></td>
					</tr>

					<%
					}
					}
					%>
 --%>
				</tbody>

			</table>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>

	
</script>
<style>
section div{
margin : 0px auto;
}
table{
	border-top: 3px;
	border-left: 3px double dark;
	border-right: 3px solid dark;
	border-bottom: 3px solid dark;
	
	text-align: center;
	margin : 0px auto;
	width : 600px;
}
thead{
	margin-bottom : 70px;
	margin : 0px auto;
	border-pacing : 70px;
}
tfoot{

}
div{
margin:0px auto;
texxt-align : center;
}
</style>
</head>
<body>
	<section>
		<article>
		<div>
				<select name="category" >
					<option value="ī�װ�">ī�װ�</option>
					<option value="�">�</option>
					<option value="����">����</option>
					<option value="����">����</option>
					<option value="����">����</option>
					<option value="�丮">�丮</option>
					<option value="����">����</option>
					<option value="����Ȱ��">����Ȱ��</option>
					<option value="��">��</option>
				</select>
				<input type="text" name="search">
				<input type="button" onclick="show()" value="�˻�">
			</div>	
		<table>

			<tfoot>
				<tr>
				<td></td>
				<td></td>
					<td>
						<input type="button" onclick="location.href='writeReview.jsp'" value="�ı⾲������">
					</td>
				</tr>
			</tfoot>

			<thead>			
				<tr>
					<th>ī�װ�</th>
					<th>�����̸�</th>
					<th>����</th>
				</tr>
			</thead>
			<tbody>
				<th>1</th>
				<th>2</th>
				<th>3</th>
			</tbody>

			</table>
		</article>
	</section>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.moim.member.MemberDAO"></jsp:useBean>

<%
String id=request.getParameter("id");
boolean result=mdao.checkId(id);
if(result){
%>
<script>
window.alert('중복된 아이디입니다.\n 다시 입력해주세요');
location.href='idCheck.jsp';
</script>
<%}else{%>
<script>
window.alert('사용할 수 있는 아이디입니다!');
window.opener.document.memJoin.id.value='<%=id%>';
window.self.close();
location.href='memberJoin.jsp';
</script>
<%}%>
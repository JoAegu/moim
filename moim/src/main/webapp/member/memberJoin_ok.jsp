<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.moim.member.MemberDAO"></jsp:useBean>
<jsp:useBean id="mdto" class="com.moim.member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>

<%
int result=mdao.joinMem(mdto);
String msg=result>0?"회원가입을 축하드립니다.":"다시 시도해주세요.";
%>
<script>
window.alert('<%=msg%>');
location.href='/webTest/imsi/Main.jsp';
</script>
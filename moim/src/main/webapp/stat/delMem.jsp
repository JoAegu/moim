<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Integer idx = (Integer) session.getAttribute("idx");
if (idx==null) {
%>
<script>
	window.alert('로그인 후 이용가능합니다');
	window.self.close();
</script>
<%
return;
}
%>    
    
<jsp:useBean id="mdto" class="com.moim.stat.StatDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>>
<jsp:useBean id="mdao" class="com.moim.stat.StatDAO"></jsp:useBean>
    
    
<%
int idx_d=mdto.getIdx();
int idx_info=15; //session에서 받아오기

int result=mdao.delMem(idx_d, idx_info);
String msg=result>0?"모임에서 탈퇴되었습니다.":"모임 탈퇴에 실패하였습니다.";
%>
<script>
window.alert('<%=msg%>');
opener.location.reload();
window.self.close();
</script>
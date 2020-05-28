<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>비밀번호찾기</title>
<style type="text/css">
input::placeholder {
	color: gray;
	font-style: italic;
	opacity: 0.5;	
	text-align: center;
}
select {
	width:53px;
	height: 26px;
}
.t1 {
	width:150px;
	text-align: right;	
}
.t2 {
	width: 175px;
}
.error {
	color: red;
}
</style>
<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
<table  align="center">
	<tr>
		<td align="left">
			<a href="${pageContext.request.contextPath }/board/boardList.do">List</a>
		</td>
		</td>
	</tr>
	<tr>
		<td>
		<form action="/board/sendpw.do" id="form" name="f" method="post" class="login" >
			<table id="boardTable" border = "0" style="border-collapse: separate; border-spacing: 5px;">
			<thead>
				<tr>
					<td height="40" width="80" align="center" colspan="3">
						비밀번호찾기
					</td>
				</tr>
			</thead>
			<tbody>	
				<tr>
					<td class="t1">
						Id
					</td>
					<td class="t2">
						<input name="userId" id="id" type="text" placeholder="아이디">
						<span id="msg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						email
					</td>
					<td class="t2">
						<input name="userCompany" id="email" type="text" placeholder="이메일">
					</td>
				</tr>
				
			</tbody>
			</table>
			<div>			
			<label style="text-align: right; padding-left: 230px">
			<button type="submit" class="submit">send</button>
			</label>
			</div>
		</form>
		<div style="color: red;">${message }</div>
		</td>
	</tr>
</table>
</body>
<script type="text/javascript">
</script>
</html>
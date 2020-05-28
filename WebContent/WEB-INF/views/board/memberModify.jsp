<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입정보</title>
<style type="text/css">
.th {
	text-align: center;
}
</style>
</head>
<body>
<div class="container">
  <h2>회원가입정보</h2>
  <p>[${userinfo.userName }] 님 환영합니다.</p>            
  <table class="table">
    <thead>
      <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>번호</th>
        <th>주소</th>
        <th>가입일</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>${userinfo.userId }</td>
        <td>${userinfo.userName }</td>
        <td>${userinfo.userPhone1 } - ${userinfo.userPhone2 } - ${userinfo.userPhone3 }</td>
        <td>우편번호[${userinfo.userAddr1 }] ${userinfo.userAddr2 }</td>
        <td>${userinfo.createTime }</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
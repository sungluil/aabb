<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
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
	text-align: center;	
}
.t2 {
	width: 400px;
}
.error {
	color: red;
}

</style>

</head>
<body>
<table  align="center">
	<tr>
		<td align="left">
			<a href="${pageContext.request.contextPath }/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
		<form name="f" method="post">
			<table id="boardTable" border = "1">
			<thead>
				<tr>
					<td height="40" width="80" align="center" colspan="3">
						회원가입
					</td>
				</tr>
			</thead>
			<tbody>	
				<tr>
					<td class="t1">
						Id
					</td>
					<td class="t2">
						<div><input name="userId" id="id" type="text" placeholder="아이디" onkeyup="" onmouseover="isSame()" value="${userinfo.userId }">
				  		&emsp;<input type="button" class="idCheck" value="중복확인"></div>
				  		<span id="idMsg" class="error"></span>
				  		<span class="result">
				  			<span class="msg">아이디를 확인해주세요.</span>
				  		</span>
				  		<input type="hidden" name="idDuplication" value="idUncheck">
					</td>
				</tr>
				<tr>
					<td class="t1">
						pw
					</td>
					<td class="t2">
						<div><input name="userPw" id="pw" type="password" placeholder="비밀번호" onkeyup="isSame()"></div>
						<span id="pwMsg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						pw check
					</td>
					<td class="t2">
						<div><input name="userPwChk" id="pwCheck" type="password" placeholder="비밀번호 확인" onkeyup="isSame()"></div>
						<span id="pwCheckMsg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						name
					</td>
					<td class="t2">
						<div><input name="userName" id="name" type="text" placeholder="이름" onkeyup="isSame()"></div>
						<span id="nameMsg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						phone
					</td>
					<td class="t2">
						<select name="userPhone1">
						<c:forEach var="list" items="${codeList1 }">
							<c:if test="${list.codeType eq 'phone' }">
							<option value="${list.codeName }">${list.codeName }</option>
							</c:if>
						</c:forEach>
						</select>
						- <input name="userPhone2" id="phone2" type="text" size="2.5" onkeyup="isSame()"> - <input name="userPhone3" id="phone3" type="text" size="2.5"onkeyup="isSame()">
						<span id="phoneMsg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						postNo
					</td>
					<td class="t2">
						<input name="userAddr1" id="post" type="text" placeholder="우편번호" onkeyup="isSame()">
						<span id="postMsg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						address
					</td>
					<td class="t2">
						<input name="userAddr2" id="address" type="text" placeholder="주소" onkeyup="isSame()">
						<span id="addMsg" class="error"></span>
					</td>
				</tr>
				<tr>
					<td class="t1">
						company
					</td>
					<td class="t2">
						<input name="userCompany"  id="company" type="text" placeholder="회사" onkeyup="isSame()">
						<span id="companyMsg" class="error"></span>
					</td>
				</tr>
			</tbody>
			</table>
			<div align="right">
			<button type="button" class="button" disabled="disabled" onclick="checkId()" >join</button>
			</div>
		</form>
		</td>
	</tr>
</table>
</body>
<script type="text/javascript">
$j(document).ready(function(){
	
	$j(".idCheck").click(function() {
		
	 	var idPattern = /^[a-z0-9]{4,12}$/g;
		var query = {userId : $j("#id").val()};
		$j.ajax({
			url:"/idcheck.do",
			type:"POST",
			data:query,
			success:function(data) {
				if(!idPattern.test($j("#id").val())) {
				    $j(".result .msg").text("사용 불가");
				    $j(".result .msg").attr("style", "color:#f00");
				    $j("#id").focus();
				} else if(data == 1) {
				    $j(".result .msg").text("사용 불가");
				    $j(".result .msg").attr("style", "color:#f00");
				    $j(".button").attr("disabled", "disabled");
				    $j("#id").focus();
				} else {
				    $j(".result .msg").text("사용 가능");
				    $j(".result .msg").attr("style", "color:#00f");
				    $j(".button").removeAttr("disabled");
			    }
			
			},
			error:function(req) {
				alert("에러"+req.status);
			}
		});
		
	});
});



function showSuccessMsg(obj, msg) {
    obj.attr("class", "error_next_box green");
    obj.html(msg);
    obj.show();
}
function showErrorMsg(obj, msg) {
    obj.attr("class", "error_next_box");
    obj.html(msg);
    obj.show();
}
function hideMsg(obj) {
    obj.hide();
}



function checkId() {

	$j(".error").text("");

	
	if($j("#id").val()=="") {
		$j("#idMsg").text("필수정보 입니다.");
		$j("#userId").focus();
		return false;
	}
	
 	var idPattern = /^[a-z0-9]{4,12}$/g;
 	if(!idPattern.test($j("#id").val())) {
 		$j("#idMsg").text("4~12자의 영문 소문자, 숫자만 사용 가능합니다.");
 		return false;
 	}
 	
	var pwPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{8,16}$/g;
	if(!pwPattern.test( $j("#pw").val())) {
		$j("#pwMsg").text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
		return false;
	}
	//비밀번호 확인체크
	if($j("#pwCheck").val()=="") {
 		$j("#pwCheckMsg").text("패스워드 한번더 입력해주세요");
 		return false;
	}
	if($j("#pwCheck").val()!=$j("#pw").val()) {
 		$j("#pwCheckMsg").text("패스워드가 일치하지 않습니다.");
 		return false;
	}
	//이름 확인
	if($j("#name").val()=="") {
 		$j("#nameMsg").text("이름을 입력해주세요");
 		return false;
	}
	var pwPattern = /^[가-힣]{2,10}$/g;
	if(!pwPattern.test( $j("#name").val())) {
		$j("#nameMsg").text("2~10자 한글만 사용 가능합니다.");
		return false;
	}
	//전화번호 확인
	if($j("#phone").val()=="") {
 		$j("#phoneMsg").text("숫자만 입력가능합니다.");

 		return false;
	}
	//var pPattern = /^[0-9]+\d{3,4}-\d{4}$/g;
	var pPattern = /^[0-9]+\d{3,4}$/g;
	if(!pPattern.test( $j("#phone2").val())) {
		$j("#phoneMsg").text("2번째 전화번호를 제대로 입력해주세요");
		return false;
	}
	var pPattern = /^[0-9]+\d{3,4}$/g;
	if(!pPattern.test( $j("#phone3").val())) {
		$j("#phoneMsg").text("전화번호를 제대로 입력해주세요");
		return false;
	}
	//우편번호 입력
	if($j("#post").val()=="") {
 		$j("#postMsg").text("우편번호 입력해주세요");
 		return false;
	}
	var postPattern = /^[0-9]+\d{2,3}-\d{3}/g;
	if(!postPattern.test( $j("#post").val())) {
		$j("#postMsg").text("숫자만 가능하며 xxx-xxx형식.");
		return false;
	}
	//주소 입력
	if($j("#address").val()=="") {
 		$j("#addMsg").text("주소를 입력해주세요");
 		return false;
	}
	//회사 입력
	if($j("#company").val()=="") {
 		$j("#companyMsg").text("회사명을 입력해주세요");
 		return false;
	}

	
	
	f.action = "${pageContext.request.contextPath }/board/memberWriteAction.do";
	f.submit();
}



function openIdChk() {
	
	var form = document.userinfo;
	
	if(f.userId.value == "") {
		alert("아이디를 입력하세요");
		f.userId.focus();
		return false;
	}
	
	if(form.idDuplication.value != "idCheck" ) {
		alert("아이디 중복체크를 해주세요.");
		return false;
	}

}

function openIdChk() {
	window.name = "parentForm";
	window.open("/board/IdCheckForm.do","chkForm", "width=500, height=300, resizable = no, scrollbars = no")
}




function isSame() {
	
	$j(".error").text("");
 	$j("#id").keyup(function() {
 		$j(this).val( $j(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	});
 	$j("#name").keyup(function() {
 		$j(this).val( $j(this).val().replace( /[a-zA-Z]/g, '' ) );
	});
 	$j("#phone2").keyup(function() {
 		$j(this).val( $j(this).val().replace( /[0-9].{4}/g, '' ) );
	});
 	$j("#phone3").keyup(function() {
 		$j(this).val( $j(this).val().replace( /[0-9].{4}/g, '' ) );
	});
	
	if($j("#id").val()=="") {
		$j("#idMsg").text("필수정보 입니다.");
 		$j("#id").focus();
		return false;
	}
	
 	var idPattern = /^[a-z0-9]{4,12}$/g;
 	if(!idPattern.test($j("#id").val())) {
 		$j("#idMsg").text("4~12자의 영문 소문자, 숫자만 사용 가능합니다.");
 		return false;
 	}
	var pwPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{8,16}$/g;
	if(!pwPattern.test( $j("#pw").val())) {
		$j("#pwMsg").text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
		//$j("#pw").focus();
		return false;
	}
	//비밀번호 확인체크
	if($j("#pwCheck").val()=="") {
 		$j("#pwCheckMsg").text("패스워드 한번더 입력해주세요");
 		return false;
	}
	if($j("#pwCheck").val()!=$j("#pw").val()) {
 		$j("#pwCheckMsg").text("패스워드가 일치하지 않습니다.");
 		return false;
	}
	//이름 확인
	if($j("#name").val()=="") {
 		$j("#nameMsg").text("이름을 입력해주세요");
 		return false;
	}
	var namePattern = /^[가-힣]{2,10}$/g;
	if(!namePattern.test( $j("#name").val())) {
		$j("#nameMsg").text("2~10자 한글만 사용 가능합니다.");
		return false;
	}
	//전화번호 확인
	if($j("#phone").val()=="") {
 		$j("#phoneMsg").text("숫자만 입력가능합니다.");
 		return false;
	}
	//var pPattern = /^[0-9]+\d{3,4}-\d{4}$/g;
	var pPattern = /^[0-9]+\d{3,4}$/g;
	if(!pPattern.test( $j("#phone2").val())) {
		$j("#phoneMsg").text("전화번호를 제대로 입력해주세요");
		return false;
	}
	var pPattern2 = /^[0-9]+\d{3,4}$/g;
	if(!pPattern2.test( $j("#phone3").val())) {
		$j("#phoneMsg").text("전화번호를 제대로 입력해주세요");
		return false;
	}
	//우편번호 입력
	if($j("#post").val()=="") {
 		$j("#postMsg").text("우편번호 입력해주세요");
 		return false;
	}
	var postPattern = /^[0-9]+\d{2}-\d{3}/g;
	//var postPattern = /^[0-9]+\d{2,3}-\d{3}/g;
	if(!postPattern.test( $j("#post").val())) {
		$j("#postMsg").text("숫자만 가능하며 xxx-xxx형식.");
		return false;
	}
	//주소 입력
	if($j("#address").val()=="") {
 		$j("#addMsg").text("주소를 입력해주세요");
 		return false;
	}
	//회사 입력
	if($j("#company").val()=="") {
 		$j("#companyMsg").text("회사명을 입력해주세요");
 		return false;
	}
}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>
</html>
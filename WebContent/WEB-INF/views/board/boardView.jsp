<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
<style type="text/css">
.text {
	padding-left: 5px;
}
body {
	font-size:14px;
    font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
    color: #676663;
}
</style>
<script type="text/javascript">
$j(document).ready(function() {
	
	/**
	 * byte를 KB,MB로 변환하는 jQuery
	 * each함수 호출로 $(this)로 구별
	 * 용량의 크기에 따라 MB, KB, byte 단위로 환산함
	**/
// 	if (true) {
// 		$j(".fileSize").each(function(i) {
// 			var fileSize = $j(this).html();
// 			isSize = (Math.round(((fileSize / 1024) / 1024) * 100) / 100.0);
// 			$j(this).html(isSize+" MB")
// 			console.log(i+"번째"+isSize);
// 		});
// 	}
// 	$j(".fileSize").each(function(i) {
// 		if (fileSize >= 1024 * 1024) {
// 			isSize = (Math.round(((fileSize / 1024) / 1024) * 100) / 100.0)		
// 			$j(".fileSize").html(isSize+" MB")
// 			console.log("["+i+"번째]: "+isSize);
// 		} else if(fileSize >= 1024) {
// 			isSize = (Math.round((fileSize / 1024) * 100) / 100)
// 			$j(".fileSize").html(isSize+" KB")
// 			console.log("["+i+"번째]: "+isSize);
// 		}
// 	});
	$j(".fileSize").each(function(){//클래스 아이디로 반복문
		var fileSize = $j(this).html();//this로 각각값을 fileSize에 담는다
		console.log("fileSize = " +fileSize);//콘솔로 출력해서 확인

		if (fileSize >= 1024 * 1024) {
			isSize = (Math.round(((fileSize / 1024) / 1024) * 100) / 100.0)		
			$j(this).html(isSize+" MB")
		} else if(fileSize >= 1024) {
			isSize = (Math.round((fileSize / 1024) * 100) / 100)
			$j(this).html(isSize+" KB")
		}
	});
	
});
	//form function
	function fn_fileDown(fileNum) {
		var formObj = $j("form[name='readForm']");
		$j("#FILE_NUM").attr("value", fileNum);
		formObj.attr("action", "/board/fileDown.do");
		formObj.submit();
	}



</script>
</head>
<body>
<form class="boardDelete" name="readForm">
<table align="center">
	<br>
	<tr>
		<td>
			<table border="1" bordercolor="#CFDBE2" width="650px;">
				<tr>
					<td width="120" align="center" style="background-color: #F2F5F6;">
					Type
					</td>
					<td class="text" height="30">
					<input name="boardType" type="hidden" value="${board.boardType}">${board.comcodeVo.codeName}
					<input name="fileGroup" type="hidden" value="${board.boardType}">
					</td>
				</tr>
				<tr>
					<td width="120" align="center" style="background-color: #F2F5F6;">
					Title
					</td>
					<td class="text" height="30">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center" style="background-color: #F2F5F6;">
					Comment
					</td>
					<td class="text" >
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center" style="background-color: #F2F5F6;">
					Writer
					</td>
					<td class="text" height="30">
					${board.creator }
					<input name="boardNum" type="hidden" value="${board.boardNum}">
					<input name="boardStep" type="hidden" value="${board.boardStep}">
					<input name="boardLev" type="hidden" value="${board.boardLev}">
					<input name="fileNum" type="hidden" value="" id="FILE_NUM">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="1" bordercolor="#CFDBE2" style="margin-top: 5px;">
				<tbody>
					<tr>
						<td width="120" style="background-color: #F2F5F6; color: #666666">
							<div style="font-size: 12px" align="center">파일첨부</div>
							<div style="margin: 5px 0px 0px 10px; font-size: 12px">[파일최대]60MB</div>
						</td>
						<td align="center" style="padding: 5px;">
							<table border="1" bordercolor="#CFDBE2" style="border-collapse: collapse; width: 100%">
							<tbody>
								<tr style="background-color: #F2F5F6;">
									<td align="center">이름</td>
									<td align="center">등록일</td>
									<td align="center">파일명</td>
									<td align="center">파일크기</td>
								</tr>
									<c:choose>
										<c:when test="${empty file }">
											<tr>
												<td align="center" colspan="4">등록된 파일이 없습니다.</td> 
											</tr>
										</c:when>
										<c:otherwise>
										<c:forEach items="${file }" var="list">
											<tr>
												<td align="center">${list.fileWriter }</td>
												<td align="center"><c:out value="${fn:substring(list.fileRegDttm,0,8)}"/></td>
												<td align="center"><input type="hidden" value="${list.fileId }" id="fileId">
												<a href="#" onclick="javascript:fn_fileDown('${list.fileNum}'); return false;">${list.fileOrgName }</a></td>
												<td align="center" class="fileSize" onclick="isSize('i','${list.fileSize}')">${list.fileSize}</td>
											</tr>
										</c:forEach>
										</c:otherwise>
									</c:choose>
								
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
	<tr align="right" style="font-size: 15px;">
		<td>
			<a href = "${pageContext.request.contextPath }/board/boardList.do">List</a>
			
			<!-- 본인글이 아닌경우 삭제와 수정불가 -->
			<c:if test="${sessionScope.userinfo.userName == board.creator }">
				<a href = "${pageContext.request.contextPath }/board/${board.boardType}/${board.boardNum}/boardUpdate.do?pageNo=${pageNo }">Update</a>
				<a href = "" id="delete">Delete</a>
			</c:if>
			
			<a href = "${pageContext.request.contextPath }/board/${board.boardType}/${board.boardNum}/boardRefWrite.do?pageNo=${pageNo }">답글</a>
			
		</td>
		<td>
		</td>
	</tr>
</table>
</form>
</body>
<script type="text/javascript">
$j(document).ready(function(){
	
	$j("#delete").on("click",function(){
		var $frm = $j('.boardDelete :input');
		var param = $frm.serialize();
		//alert(param);
		
		$j.ajax({
		    url : "/booard/boardDeleteAction.do",
		    dataType: "TEXT",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
				//alert("작성완료");
				
				//alert("메세지:"+data.success);
				
				//location.href = "/board/boardList.do";
				
				//window.location = "/board/boardList.do";
				location.replace("/board/boardList.do");
				
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패"+jqXHR);
		    }
		});
	});	
});

</script>
</html>
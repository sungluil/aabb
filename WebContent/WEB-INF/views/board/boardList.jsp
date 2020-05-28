<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardList</title>
<style type="text/css">
body {
	font-size:14px;
    font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
    color: #676663;
}
span#total1 {
	padding-left: 350px;
}
#searchTable td {
	height: 30px;
}
</style>
</head>
<script id="entry-template" type="text/x-handlebars-template">
{{#boardList}}
<tr>
	<td align="center">
		{{comcodeVo.codeName}}
	</td>
	<td align="center">
		{{boardNum}}
	</td>
	<td style="padding-left: 10px;">
		<a href = "/board/{{boardType}}/{{boardNum}}/boardView.do?pageNo={{pageNo}}">{{boardTitle}}</a>
	</td>
	<td align="center">
		{{createTime}}
	</td>
	<td align="center">
		{{boardHits}}
	</td>
	<td align="center">
		{{creator}}
	</td>
</tr>
{{/boardList}}	
</script>
<script type="text/javascript">
//키워드 서치
// $j(document).ready(function() {
// 	$j("#search").on("keyup", function() {
// 		var value = $j(this).val().toLowerCase();
// 		$j("#searchTable tr").filter(function() {
// 			$j(this).toggle($j(this).text().toLowerCase().indexOf(value) > -1)
// 		});
// 	});
// });
$j(document).ready(function() {		
	check();
});
	
function check() {
	//event.preventDefault(); // event 중단 함수
	//체크박스 4개체크시에 전체버튼체크
	$j("input:checkbox[name=board2]").click(function() {
		//alert("누름");
		if($j("input:checkbox[name=board2]:checked").length == 4) {
			$j("input:checkbox[name=board1]").prop("checked", true);
		} else {
			$j("input:checkbox[name=board1]").prop("checked", false);
		}
	});
	//전체버튼 체크시 전부체크 전부해제
	$j("input:checkbox[name=board1]").click(function() {
		if ($j(this).prop('checked')) {
			$j("input:checkbox[name=board2]").prop("checked", true);			
		} else {
			$j("input:checkbox[name=board2]").prop("checked", false);
		}
	});
	console.log("==========================================================")
	//모든 체크박스의 값
	$j('input[type="checkbox"]').each(function(){
		var checkboxValue = $j(this).val();
		console.log("checkboxValue = " +checkboxValue);
	});
		
		
	//조회버튼 클릭시 체크박스 값
	$j("#searchButton").click(function(){
		var arrVal = [];
		$j("input[name='board2']:checked").each(function(){
			arrVal.push($j(this).val());
		});
		console.log(arrVal);
		var boardType = arrVal.join(",");
		console.log(boardType);
		
		$j.ajax({
			type:"POST",
			url:"/board/boardSearch.do",
			data:{"boardType":boardType},
			dataType: "json",
			success:function(json) {
				var source = $j("#entry-template").html();
				var template = Handlebars.compile(source);
				$j("#searchTable").html(template(json))
				//alert("성공");
			},
			error:function(request,status,error) {
				//alert("에러 = "+req.status);
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});

	console.log("==========================================================")
	
	//조회버튼 클릭시 체크박스 갯수 알아내기
	$j("#searchButton").click(function(){
		var checkNo = $j('input[type="checkbox"]:checked').length;
		
		console.log("체크박스 갯수 = "+checkNo);
	});
	
}
</script>	
<body>
<table align="center" width="700">
	<tr>
		<td style="padding-top: 5px;">
			<a href="${pageContext.request.contextPath }/board/memberWrite.do">Join</a>
			<c:if test="${sessionScope.userinfo == null }">
			<a href="${pageContext.request.contextPath }/board/memberLogin.do">Login</a>
			</c:if>
			<c:if test="${sessionScope.userinfo != null }">
			<a href="${pageContext.request.contextPath }/board/memberLogout.do">logout</a>
			<c:out value="${userinfo.userName } 님 환영합니다."></c:out> 
			<a href="${pageContext.request.contextPath }/board/MemberModify.do">회원정보</a>
			</c:if>	
			<span id="total1">Total : ${totalCnt}</span>
			
		</td>
	</tr>
	<tr>
		<td style="padding-top: 5px;">
			<div id="searchTableDiv"></div>
			<table id="boardTable" border="1" bordercolor="#CFDBE2" width="100%;">
			<thead>
				<tr style="background-color: #F2F5F6;">
					<td width="80" height="40px;" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<%-- 
					<td width="40" align="center">
						Ref
					</td>
					<td width="40" align="center">
						Step
					</td>
					<td width="40" align="center">
						Lev
					</td>
					 --%>
					<td width="300" align="center">
						Title
					</td>
					<td width="150" align="center">
						Date
					</td>
					<td width="40" align="center">
						Hits
					</td>
					<td width="80" align="center">
						Writer
					</td>
				</tr>
			</thead>
			<tbody id="searchTable">
			<c:choose>
				<c:when test="${empty boardList }">
					<td colspan="6" align="center">
						게시글이 존재하지 않습니다.
					</td>
				</c:when>
			</c:choose>
			<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.comcodeVo.codeName}
						</td>
						<td align="center">
							${list.boardNum}
						</td>
						<%-- 
						<td align="center">
							${list.boardRef}
						</td>
						<td align="center">
							${list.boardStep}
						</td>
						<td align="center">
							${list.boardLev}
						</td>
						 --%>
						<td style="padding-left: 10px;">
						<c:choose>
							<c:when test="${list.boardLev eq 1 }">
								<a href = "${pageContext.request.contextPath }/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">└[Re] ${list.boardTitle}</a>
							</c:when>
							<c:when test="${list.boardLev eq 2 }">
								<a href = "${pageContext.request.contextPath }/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">&emsp;└[Re:Re] ${list.boardTitle}</a>
							</c:when>
							<c:when test="${list.boardLev eq 3 }">
								<a href = "${pageContext.request.contextPath }/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">&emsp;&emsp;└[Re:Re:Re] ${list.boardTitle}</a>
							</c:when>
							<c:otherwise>
								<a href = "${pageContext.request.contextPath }/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
							</c:otherwise>
						</c:choose>
						</td>
						<td align="center">
							${list.createTime}
						</td>
						<td align="center">
							${list.boardHits}
						</td>
						<td align="center">
							${list.creator}
						</td>
					</tr>	
				</c:forEach>
			</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td style="padding-top: 5px;">
		<form class="checkboxControl" id="checkboxArea">	
			<div class="custom-control custom-checkbox" id="checkboxArea">
				<input value="all" type="checkbox" name="board1" id="defaultInline1">전체
				<c:forEach var="list" items="${codeList}">
					<c:if test="${list.codeType eq 'menu' }"> 
						<input class="chk02" type="checkbox" name="board2"value="${list.codeId }">${list.codeName}
					</c:if>
				</c:forEach>
				<button id="searchButton" type="button" class="btn btn-primary btn-sm">조회</button>
				<a href='<c:url value='/board/excelDown.do' />'><button id="excelDownBtn" type="button" class="btn btn-primary btn-sm" >엑셀 다운로드</button></a>
				&nbsp;
				<div style="display: inline; padding-left: 190px;"><a class="btn btn-primary btn-sm" href ="${pageContext.request.contextPath }/board/boardWrite.do">글쓰기</a></div>
				
			</div>
		</form>
		<div align="center">
			<ul class="pagination">
				<li class="page-item">
				<a href="boardList.do?pageNo=1">처음</a>
				<c:if test="${pageVo.startPage>pageVo.blockSize }">
					<a href="boardList.do?pageNo=${pageVo.startPage-pageVo.blockSize}">이전</a>
				</c:if>
				<c:forEach var="i" begin="${pageVo.startPage}" end="${pageVo.endPage}">
		            <c:choose>
		                <c:when test="${i eq pageVo.pageNo}"><a style="font-weight: bold; color: red;">${i}</a></c:when>
		                <c:otherwise><a  class="page-link" href="boardList.do?pageNo=${i}">${i}</a></c:otherwise>
		            </c:choose>
		        </c:forEach>
		        <c:if test="${pageVo.endPage!= pageVo.totalPage}">
		        <a href="boardList.do?pageNo=${pageVo.nextPage }">다음</a>
		        </c:if>
		        <a href="boardList.do?pageNo=${pageVo.totalPage }">마지막</a>
		        </li>
			</ul>
		</div>		
		</td>
	</tr>
</table>
<%-- 검색 --%>
<!-- <div class="form-group row" > -->
<!-- 	<div class="col-sm-10" style="margin-left: 20%; padding-right: 60%"> -->
<!-- 		<input type="text" class="form-control form-control-lg" id="search" placeholder="search"> -->
<!-- 	</div> -->
<!-- </div> -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Member List</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>Member List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="container" style="clear: both; margin-top: 30px; font-size: 15px">

<div class="form-group float-right ml-3 ">
	<form action="/member/list" class="form-inline">
		<select class="form-control" id="range" name="range">
			<option value="total" <c:out value="${pghdl.pgvo.range eq 'total'?'selected':'' }"/>>전체</option>
			<option value="mID" <c:out value="${pghdl.pgvo.range eq 'mID'?'selected':'' }"/>>아이디</option>
			<option value="mN" <c:out value="${pghdl.pgvo.range eq 'mN'?'selected':'' }"/>>이름</option>
		</select>
      <input type="text" class="form-control" placeholder="검색어 입력" name="keyword"
      value='<c:out value="${pghdl.pgvo.keyword }"/>'>
		<button type="submit" class="site-btn" style="padding: 8.5px 20px;">검색</button>
	</form>
</div>
<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.auth" var="auth" />
<c:choose>
	<c:when test="${auth eq 'ADM' }">
	<table class="table table-hover">
	<thead>
		<tr>
			<th style="min-width: 80px;">회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th style="min-width: 60px;">성별</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>생년월일</th>
			<th style="min-width: 80px;">우편번호</th>
			<th style="min-width: 80px;">도로명주소</th>
			<th style="min-width: 80px;">상세주소</th>
			<th>삭제</th>
			<th style="min-width: 90px;">계정상태</th>
			
		</tr>
	</thead>
	<c:choose>
    	<c:when test="${m_list.size() ne 0 }">
	<tbody>
		<c:forEach items="${m_list }" var="mvo">
			<tr>
				<td>${mvo.mno }</td>
				<td>${mvo.memberID }</td>
				<td>${mvo.memberName }</td>
				<td>${mvo.memberGender }</td>
				<td>${mvo.memberEmail }</td>
				<td>${mvo.memberPhone }</td>
				<td>${mvo.memberBirth }</td>
				<td>${mvo.zipcode }</td>
				<td>${mvo.roadAddress }</td>
				<td>${mvo.addressDetail }</td>
				<%-- <c:when test="${mvo.enabled eq 0}">
				<button type="button" class="btn btn-danger">활성화</button>
				</c:when> --%>
				<td>
				<button type="button" class="btn btn-danger del-btn" style="font-size: 13px;">DEL</button>
				</td>
				<c:if test="${mvo.enabled eq 'false'}">
				<td>
				<button type="button" class="btn btn-primary able-btn" style="font-size: 13px;">활성화</button>
				</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
		</c:when>
    	<c:otherwise>
    		<tbody>
    			<tr>
    				<td colspan="5" class="text-center">
    					<h2>등록된 회원이 없습니다!</h2>
    				</td>
    			</tr>
    		</tbody>
    	</c:otherwise>
    </c:choose>
	<tfoot>
            <tr>
               <td colspan="10"><jsp:include page="pagingMem.jsp"></jsp:include></td>
               
            </tr>
         </tfoot>
</table>
<form action="/member/remove" method="post" id="rmForm">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="mno">
</form>
<script>
	$(function() {
	/* 	$(document).on("click", "mod-btn", function(){
			let email_val = $(this).closest("tr").find("td").eq(0).text();
			location.href="/member/modify?email="+email_val;
		}); */
		$(document).on("click", ".del-btn", function(e){
			e.preventDefault();
			let mno_val = $(this).closest("tr").find("td").eq(0).text();
			$("#rmForm > input[name=mno]").val(mno_val);
			$("#rmForm").submit();
		});
	});
</script>
<!-- 계정 활성화, 비활성화버튼 -->
<form action="/member/able" method="post" id="abForm">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="mno">
</form>
<script>
$(function() {
		$(document).on("click", ".able-btn", function(e){
			e.preventDefault();
			let mno_val = $(this).closest("tr").find("td").eq(0).text();
			$("#abForm > input[name=mno]").val(mno_val);
			$("#abForm").submit();
		});
	});
</script>

	</c:when>
	<c:otherwise>
		<script>
			alert("관리자 로그인이 필요한 페이지입니다.")
			location.replace("/");
		</script>
	</c:otherwise>
</c:choose>
</sec:authorize>
</div>
<jsp:include page="../common/footer.jsp" />

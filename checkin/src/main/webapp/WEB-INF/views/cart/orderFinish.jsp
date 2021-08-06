<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div style="text-align: center;" class="shoping__discount">
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
		<form action="/order/list" method="post">
			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }">
			<h2 style="margin: 150px 0 100px; font-family: 'EliceDigitalBaeum_Regular';">결제가 완료되었습니다.</h2>
			<input type="hidden" name="memberID" value="${ses_memberID }">
			<button type="button" class="site-btn"
				style="background-color: white; font-size:14px; border: 1px solid gray; color: gray;"
				onclick="location.href='/'">계속 쇼핑하기</button>
			<button type="submit" class="site-btn"
				style="border: 1px solid gray;  font-size:14px;">주문내역 확인</button>
		</form>
	</sec:authorize>
</div>
<script>
</script>
<jsp:include page="../common/footer.jsp" />
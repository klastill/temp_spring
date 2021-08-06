<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />
<style>
tr>td>img {
	width: 100px;
}
.qtyUp, .qtyDown{
	padding: 0 10px;
	background-color: #f0f0f0;
}
#cartList tr input{
	height: 30px;
}
</style>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberID" var="ses_memberID" />
	<sec:authentication property="principal.auth" var="auth" />
	<c:choose>
		<c:when test="${ses_memberID ne null && ses_memberID ne '' }">
		<c:choose>
			<c:when test="${ses_memberID eq avo.memberID }">
					<!-- Breadcrumb Section Begin -->
			<section class="breadcrumb-section set-bg"
				data-setbg="/resources/img/book-diary-bookmark.jpg"
				style="background-color: green;">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-center">
							<div class="breadcrumb__text">
								<h2>Check Alarms</h2>
								<div class="breadcrumb__option">
									<a href="/">Alarm</a> <span>�˸����� Ȯ���ϼ���.</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- Breadcrumb Section End -->
			<section class="shoping-cart spad">
				<div class="container" style="width: 50%;">
					<input type="hidden" id="nowUser" name="memberID"
						value="${ses_memberID }">
					<!-- ���� value�� ���̵� ������ �� -->
					<table class="table table-hover">
						<tbody>
							<c:forEach items="${alarmList }" var="avo">
							<c:choose>
									<c:when test="${avo.status eq '0' }">
										<tr data-rno="${avo.rnolink }" data-ano="${avo.ano }">
											<td>${avo.alarmdata }</td>
											<fmt:parseDate var="parsedDate" value="${avo.regdate }" pattern="yyyy-MM-dd HH:mm:ss" />
											<fmt:formatDate var="newFormattedDateString" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss "/>
											<td style="text-align: right;">${newFormattedDateString }</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr data-rno="${avo.rnolink }" data-ano="${avo.ano }" style="color: lightgray;">
											<td>${avo.alarmdata }</td>
										    <fmt:parseDate var="parsedDate" value="${avo.regdate }" pattern="yyyy-MM-dd HH:mm:ss" />
											<fmt:formatDate var="newFormattedDateString" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
											<td style="text-align: right;">${newFormattedDateString }</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
					<script>
						$(document).on("click","table tr",function(){
							let header = $("meta[name='_csrf_header']").attr("content");
							let token =  $("meta[name='_csrf']").attr("content");
							let rno_val = $(this).data("rno");
							let ano_val = $(this).data("ano");
							$.ajax({
								url:"/updateAlarm",
								type:"post",
								data:{ano:ano_val,
									rno:rno_val},
								beforeSend: function(xhr){
									xhr.setRequestHeader(header, token);
								}
							}).done(function(){
								location.replace("/review/detail?rno="+rno_val);
							});
						});
					</script>
				</div>
			</section>
			</c:when>
			<c:otherwise>
				<script>
				alert("������ �˶��� Ȯ�ΰ����մϴ�.")
				location.replace("/");
			</script>
			</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<script>
				alert("�α����� �ʿ��� �������Դϴ�.")
				location.replace("/");
			</script>
		</c:otherwise>
	</c:choose>
</sec:authorize>

	<jsp:include page="common/footer.jsp" />
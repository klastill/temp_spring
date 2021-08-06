<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<style>
tr > td > img{
	width: 150px;
}
tbody > tr > td > p{
	margin: 0;
}
</style>
<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />

<c:if test="${ses_memberID eq null || ses_memberID eq '' }">
	<script>
			alert("로그인이 필요한 페이지입니다.")
			location.replace("/");
		</script>
</c:if>
</sec:authorize>
<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: green; ">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Order Details</h2>
                        <div class="breadcrumb__option">
                            <a href="/">Home</a>
                            <span><c:out value="${list[0].regdate }"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
<section class="order-list spad" style="padding-top: 60px;">
<div class="container" >
 <h4>Books</h4>
  <table class="table table-hover" >
    <thead>
      <tr>
        <th style="width:12%;">주문번호</th>
        <th  style="width:20%;">도서정보</th>
        <th></th>
        <th style="width:18%;">금액(수량)</th>
        <th style="width:12%;"></th>
      </tr>
    </thead>
    <tbody>
   	 <c:forEach items="${list }" var="odto" varStatus="status">
   	 <form action="/review/register" method="get">
    	<tr>
        <td>${odto.infono }</td>
        <td><img src="${odto.cover }"></td>
        <td>${odto.bname }</td>
        <c:set var = "string1" value = "${odto.price }"/>
    	<c:set var = "length" value = "${fn:length(string1)}"/>
   		<c:set var = "string2" value = "${fn:substring(string1, 0, length-2)}" />
        <td>${string2 }원<p>(${odto.qty }개)</p></td>
        <td><button type="submit" class="btn-sm btn-secondary"  style="padding: 6px 8px;">리뷰 작성</button></td>
      </tr>
      <input type="hidden" name="title" value="${odto.bname}"> 
      <input type="hidden" name="link"  value=""> 
      <input type="hidden" name="coverImg" value="${odto.cover}"> 
      <input type="hidden" name="isbn" value="${odto.isbn}">
      </form>
    </c:forEach>
   </tbody>
  </table>
 <h4>Bills</h4>
	 <table class="table table-hover">
    <thead>
      <tr>
        <th>도서금액</th>
        <th>마일리지 사용</th>
        <th class="" style="background-color: #c2db9c;" >주문금액</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>${ovo.price }원
        <c:forEach items="${list }" var="odto" varStatus="status">
         <c:set var = "string1" value = "${odto.price }"/>
    	 <c:set var = "length" value = "${fn:length(string1)}"/>
   		 <c:set var = "string2" value = "${fn:substring(string1, 0, length-2)}" />
        	 <p> +${string2 }원X${odto.qty }</p>
        </c:forEach></td>
        <td>${ovo.mileage }원</td>
        <td style="font-weight: bolder; background-color: #c2db9c;" rowspan="4">${ovo.price - ovo.mileage}원</td>
      </tr>
      <tr>
      	<th>포인트 적립</th>
      	<th></th>
      </tr>
      <tr>
      	<th>구매 적립</th>
      	<th>리뷰 적립</th>
      </tr>
      <tr>
      	<td>
      	<c:set var="totalmile"/>
      		<c:forEach items="${list }" var="odto" varStatus="status">
      			<p>${odto.mileage }p</p>
      		</c:forEach>
      	</td>
      	<td><p>${list.size()*50 }p</p>
      		<p style="font-size: 12px;">동일 상품의 상품리뷰 적립은 </p>
      		<p style="font-size: 12px;">각각 1회로 제한됩니다.</p>
      	</td>
      </tr>
   </tbody>
  </table>
  <script>
  $(function () {
	  $('.example-popover').popover({
	    container: 'body'
	  })
	})
</script>
  
 <h4>Delivery</h4>
  <table class="table table-striped table-bordered" style="clear: both;">
    <tbody>
   		 <tr>
            <td>이름</td>
            <td>${ovo.memberName }</td>
        </tr>
   		<tr>
            <td>아이디</td>
            <td>${ovo.memberid }</td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>${ovo.memberemail }</td>
        </tr>
        <tr>
            <td>연락처</td>
            <td id="pnoVal">${ovo.phonenum}</td>
        </tr>
        <tr>
            <td rowspan="2">배송지</td>
            <td>${ovo.zipcode }
            </td>
        </tr>
        <tr>
            <td>${ovo.roadAddress }, 
            	${ovo.addressDetail }
            </td>
        </tr>
        <tr>
            <td>요청사항</td>
            <td>${ovo.demand }</td>
        </tr>
    </tbody>
 </table>
</div>
</section>
<jsp:include page="../common/footer.jsp" />
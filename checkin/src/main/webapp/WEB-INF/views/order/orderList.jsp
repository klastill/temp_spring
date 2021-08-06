<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<style>
tr > td > img{
	width: 100px;
}
</style>
<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
<c:choose>
<c:when test="${ses_memberID eq null || ses_memberID eq '' }">
	<script>
			alert("로그인이 필요한 페이지입니다.")
			location.replace("/");
		</script>
</c:when>
<c:when test="${ses_memberID eq olist[0].mid }">
<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: green; ">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Order List</h2>
                        <div class="breadcrumb__option">
                            <a href="/">Home</a>
                            <span>구매 내역</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
<section class="shoping-cart spad">
<div class="container" >
  <table class="table table-hover">
    <thead class="thead-light">
      <tr>
        <th style="width: 20%;">도서정보</th>
        <th></th>
        <th>수량</th>
        <th>가격</th>
      </tr>
    </thead>
    <tbody id="orderList">
     <c:set var="vs" value="0"/>
<c:forEach items="${olist }" var="odto" varStatus="status">
    <c:choose>
    <c:when test="${status.index==0}">
  	  <c:set var="vs" value="${odto.ono}"/>
  	  <c:set var="total" value="${odto.totalprice}"/>
  	  <c:set var="mile" value="${odto.mileage}"/>
  	  <tr >
        <td><img src="${odto.cover }" style="width: 70%;"></td>
        <td  style="vertical-align: middle;"><a href="/order/orderDetail?ono=${odto.ono }" style="color:#4f9446;">${odto.bname }</a>
        	<p>${odto.regdate }</p><p>구매 완료</p>
        </td>
         <c:set var = "string1" value = "${odto.price }"/>
 	  	 <c:set var = "length" value = "${fn:length(string1)}"/>
  		  <c:set var = "string2" value = "${fn:substring(string1, 0, length-2)}" />
        <td style="vertical-align: middle;">${odto.qty }</td>
        <td style="vertical-align: middle;">${string2 }원</td>
      </tr>
    </c:when>
    <c:when test="${vs eq odto.ono}"> 
     <tr>
        <td><img src="${odto.cover }" style="width: 70%;"></td>
        <td  style="vertical-align: middle;"><a href="/order/orderDetail?ono=${odto.ono }" style="color:#4f9446;">${odto.bname }</a>
        <p>${odto.regdate }</p><p>구매 완료</p></td>
       <c:set var = "string1" value = "${odto.price }"/>
 	  	 <c:set var = "length" value = "${fn:length(string1)}"/>
  		  <c:set var = "string2" value = "${fn:substring(string1, 0, length-2)}" />
        <td style="vertical-align: middle;">${odto.qty }</td>
        <td style="vertical-align: middle;">${string2 }원</td>
      </tr>
    </c:when> 
    <c:when test="${vs ne odto.ono}">
  	  <tr class="" style="background-color: #afd698;"><td></td><td></td><td style="font-weight: bold;">총 금액 : </td><td style="font-weight: bold;"><c:out value="${total -mile }"/>원</td></tr>
  	  <c:set var="vs" value="${odto.ono}"/>
  	  <c:set var="total" value="${odto.totalprice}"/>
  	   <c:set var="mile" value="${odto.mileage}"/>
  	  <tr >
        <td><img src="${odto.cover }"  style="width: 70%;"></td>
        <td  style="vertical-align: middle;"><a href="/order/orderDetail?ono=${odto.ono }" style="color:#4f9446;">${odto.bname }</a>
        	<p>${odto.regdate }</p><p>구매 완료</p>
        </td>
    	<c:set var = "string1" value = "${odto.price }"/>
 	  	 <c:set var = "length" value = "${fn:length(string1)}"/>
  		  <c:set var = "string2" value = "${fn:substring(string1, 0, length-2)}" />
        <td style="vertical-align: middle;">${odto.qty }</td>
        <td style="vertical-align: middle;">${string2}원</td>
      </tr>
    </c:when>
    </c:choose>
    <c:if test="${status.last }">
    	<tr class="" style="background-color: #afd698;"><td></td><td></td><td style="font-weight: bold;">총 금액 : </td><td style="font-weight: bold;">${odto.totalprice - odto.mileage}원</td></tr>
    </c:if>
</c:forEach>
   </tbody>
  </table>
</div>
</section>
</c:when>
<c:otherwise>
<section class="breadcrumb-section set-bg" data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: green; ">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Order List</h2>
                        <div class="breadcrumb__option">
                            <a href="/">Home</a>
                            <span>구매 내역</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="shoping-cart spad">
<div class="container" >
  <table class="table table-hover">
    <thead class="thead-light">
      <tr>
        <th style="width: 20%;">도서정보</th>
        <th></th>
        <th style="width: 10%;">수량</th>
        <th style="width: 10%;">가격</th>
      </tr>
    </thead>
    <tbody id="orderList">
		<tr style="text-align: center;">
    		<td colspan="4"><h3>주문내역이 없습니다.</h3></td>
    	</tr>
    	</tbody>
    	</table>
    </div>
    </section>
</c:otherwise>
</c:choose>
</sec:authorize>
<jsp:include page="../common/footer.jsp" />
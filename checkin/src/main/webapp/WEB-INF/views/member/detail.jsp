<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<style>
.mybox{
background-size: cover;
background-position: 50%;
}
.myicon{
	font-size: 36px;
	color:#7fad39;
}

.my-transparent-button {
    background-color: transparent !important;
    background-image: none !important;
    border-color: transparent;
    border: none;

    color: #FFFFFF;
}
</style>

<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>My Detail</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>내 정보</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberID" var="ses_memberID" />
	<sec:authentication property="principal.auth" var="auth" />
	<c:choose>
		<c:when test="${ses_memberID eq mvo.memberID }">
		 <!-- Contact Section Begin -->
		 
    <section class="contact spad">
        <div class="container" style="position:relative;">
        	 <button onclick="history.back()" class="my-transparent-button"
						style="color:#7fad39; position:absolute; top:-13%;left:90%;">뒤로가기</button>
        	<div class="row justify-content-center">
        	<div class="col-lg-4 col-md-4 col-sm-4">
        
						<c:choose>
							<c:when test="${fvo.ftype > 0 }">
							
								 <img src="/upload/${fvo.savedir}/${fvo.uuid}_${fvo.fname}"
									alt="이미지없음" 
									style="height:100%; object-fit: cover; object-position: 50% 50%; margin:auto; max-height: 350px;">
							</c:when>
							<c:otherwise>
							
								 <img src="/resources/images/member/person.png" alt="이미지 없음"
									
									style="height:100%; object-fit: cover; object-position: 50% 50%; margin:auto; max-height: 350px; "> 
							</c:otherwise>
						</c:choose>
						 
			</div>
			<div class="col-lg-8 col-md-8 col-sm-8">		
            <div class="row" >
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                        <i class="fa fa-user myicon"></i>
                        <h4>ID</h4>
                        <p>${mvo.memberID }</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                        <i class="fa fa-vcard-o myicon"></i>
                        <h4>Name</h4>
                        <p>${mvo.memberName }</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                    	<c:if test="${mvo.memberGender eq '남자' }">
												<i class="fa fa-male myicon" ></i>
						</c:if>
                        <c:if test="${mvo.memberGender eq '여자' }">
												<i class="fa fa-female myicon"></i>
						</c:if>
                        
                        <h4>성별</h4>
                        <p>${mvo.memberGender }</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                        <i class="far fa-envelope-open myicon"></i>
                        <h4>Email</h4>
                        <p>${mvo.memberEmail }</p>
                    </div>
                </div>
                
				<div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                        <i class="fas fa-mobile-alt myicon"></i>
                        <h4>Phone</h4>
                        <p>${mvo.memberPhone }</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                         <i class="fas fa-map-marker-alt myicon"></i>
                        <h4>Address</h4>
                        <p>우편번호:${mvo.zipcode } </p>
                        <p>${mvo.roadAddress }${mvo.addressDetail }</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                        <i class="fas fa-birthday-cake myicon"></i>
                        <h4>BirthDAY</h4>
                        <p>${mvo.memberBirth }</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                    <div class="contact__widget">
                        <i class="fa fa-money myicon"></i>
                        <h4>마일리지</h4>
                        <p>${mvo.mileage } </p>
                    </div>
                </div>
            </div>
            </div>
            	
                <div class="" style="text-align: center;">
               
					<a href="/member/modify?memberID=${mvo.memberID }&mno=${mvo.mno}"
						class="site-btn" style="text-align: center;">수정</a>
				</div>
					
        </div>
        </div>
    </section>
    </c:when>
    <c:otherwise>
	<script>
		alert("로그인이 필요한 페이지입니다.")
		location.replace("/");
	</script>
</c:otherwise>
    </c:choose>
    </sec:authorize>
    <!-- Contact Section End -->





<!--경계선  -->
<%-- <div class="container" style="clear: both; margin-top: 10px;">
	<!-- 로그인 된 경우 -->
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
		<sec:authentication property="principal.auth" var="auth" />
		<c:choose>
			<c:when test="${ses_memberID eq mvo.memberID }">
				<c:if test="${auth ne 'ADM' }">
					<div class="form-group">
						<label for="profile"></label> <img src="/upload/${fvo.savedir}/${fvo.uuid}_th_${fvo.fname}" alt="이미지없음" width="100" height="100" style="display: block; margin: 0px auto;">
					</div>
					<div class="form-group">
						<label for="memberID">아이디:</label> <input type="text"
							class="form-control" id="memberID" name="memberID"
							value="${mvo.memberID }" readonly>
					</div>
					<div class="form-group">
						<label for="memberName">이름:</label> <input type="text"
							class="form-control" id="memberName" name="memberName"
							value="${mvo.memberName }" readonly>
					</div>
					<div class="form-group">
						<label for="memberGender">성별:</label> <input type="text"
							class="form-control" id="memberGender" name="memberGender"
							value="${mvo.memberGender }" readonly>
					</div>
					<div class="form-group">
						<label for="memberEmail">이메일:</label> <input type="text"
							class="form-control" id="memberEmail" name="memberEmail"
							value="${mvo.memberEmail }" readonly>
					</div>
					<div class="form-group">
						<label for="memberPhone">전화번호:</label> <input type="text"
							class="form-control" id="memberPhone" name="memberPhone"
							value="${mvo.memberPhone }" readonly>
					</div>
					<div class="form-group">
						<label for="memberBirth">생일:</label> <input type="text"
							class="form-control" id="memberBirth" name="memberBirth"
							value="${mvo.memberBirth }" readonly>
					</div>
					<div class="form-group">
						<label for="zipcode">우편번호:</label> <input type="text"
							class="form-control" id="zipcode" name="zipcode"
							value="${mvo.zipcode }" readonly>
					</div>
					<div class="form-group">
						<label for="roadAddress">도로명주소:</label> <input type="text"
							class="form-control" id="roadAddress" name="roadAddress"
							value="${mvo.roadAddress }" readonly>
					</div>
					<div class="form-group">
						<label for="addressDetail">상세주소:</label> <input type="text"
							class="form-control" id="addressDetail" name="addressDetail"
							value="${mvo.addressDetail }" readonly>
					</div>
					<div class="form-group">
						<label for="mileage">마일리지:</label> <input type="text"
							class="form-control" id="mileage" name="mileage"
							value="${mvo.mileage }" readonly>
					</div> 

					
					<button onclick="history.back()" class="btn btn-primary"
						style="float: right; margin-left: 5px">취소</button>
					<a href="/member/modify?memberID=${mvo.memberID }&mno=${mvo.mno}"
						class="btn btn-outline-primary float-right">수정</a>


</c:if>
</c:when>

<c:otherwise>
	<script>
		alert("로그인이 필요한 페이지입니다.")
		location.replace("/");
	</script>
</c:otherwise>
</c:choose>
</sec:authorize>
</div>
--%>

<jsp:include page="../common/footer.jsp" />

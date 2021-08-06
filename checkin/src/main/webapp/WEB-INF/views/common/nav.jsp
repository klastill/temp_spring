<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>

    <!-- Humberger Begin -->
    <div class="humberger__menu__overlay"></div>
    <div class="humberger__menu__wrapper">
        <div class="humberger__menu__logo">
            <a href="#"><img src="/resources/img/logo.png" alt=""></a>
        </div>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
		<sec:authentication property="principal.mno" var="ses_mno" />
		<div class="humberger__menu__cart">
			<ul>
				<li><a href="/wish/wishList?mno=${ses_mno }" id="wishList"><i
						class="fa fa-heart"></i> <span class="wishCount"></span></a></li>
				<li><a href="/cart/list?memberID=${ses_memberID }"
					class="cartCheck"><i class="fa fa-shopping-bag"></i> <span
						class="cartCount"></span></a></li>
				<li><a href="#"><i	class="fa fa-bell"></i><span class="alarmCount"></span></a></li>
				<form action="/checkAlarm" method="post" class="caForm">
					<input type="hidden" name="mid" value="${ses_memberID }">
					  <input type="hidden" name="${_csrf.parameterName }"
                           value="${_csrf.token }">
				</form>
				<script>
					$(document).on("click",".fa-bell",function(e){
						e.preventDefault();
						$(".caForm").submit();
					});
				</script>
			</ul>
			<div class="header__cart__price">
				Mileage:<span style="float: right;">p</span><span class="nowMileage"
					style="float: right;"></span>
			</div>
		</div>
		</sec:authorize>
		<div class="humberger__menu__widget">
		 <sec:authorize access="isAuthenticated()">
                     <sec:authentication property="principal.memberID"
                        var="ses_memberID" />
                     <c:choose>
                        <c:when test="${ses_memberID ne null && ses_memberID ne '' }">
                           <div class="header__top__right__auth">
                           	<span class="nav-link logoutBtn" style="padding-left:0; " >${ses_memberID }님 반갑습니다.</span>
                              <a class="nav-link logoutBtn" href="" style="padding-left: 0;">로그아웃</a>
                           </div>
                        </c:when>
                     </c:choose>
                     <form action="/member/logout" method="post" class="lgForm">
                        <input type="hidden" name="${_csrf.parameterName }"
                           value="${_csrf.token }">
                     </form>
                     <script>
                        $(".logoutBtn").on("click", function(e) {
                           e.preventDefault();
                           $(".lgForm").submit();
                        });
                     </script>
        </sec:authorize>
		<!-- 로그인 되어 있지 않을 경우 -->
                  <sec:authorize access="isAnonymous()">
                     <div class="header__top__right__language">
                        <div>
                           <a href="/member/register">회원가입</a>
                        </div>
                     </div>
                     <div class="header__top__right__auth" style="margin-left: 10px;"> 
                        <a href="#" data-toggle="modal" data-target="#login-modal"> <i
                           class="fa fa-user"></i> Login</a>
                     </div>
                  </sec:authorize>
        </div>
       <div id="mobile-menu-wrap">
        </div>
        <!-- <div class="header__top__right__social">
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-linkedin"></i></a>
            <a href="#"><i class="fa fa-pinterest-p"></i></a>
        </div> -->
        <div class="humberger__menu__contact">
            <ul>
                <li><i class="fa fa-envelope"></i> admin@admin.com</li>
                <li><i class="fas fa-phone"></i> 010-1234-5678</li>
                <li>Q & A</li>
               
            </ul>
        </div>
    </div>
    <!-- Humberger End -->

<!-- Header Section Begin -->
<header class="header">
   <div class="header__top ">
      <div class="container">
         <div class="row">
            <div class="col-lg-6">
               <div class="header__top__left" style="padding: 16px 0;">
                  <ul>
                     <!-- 로그인 된 경우 -->
                     <sec:authorize access="isAuthenticated()">
                        <sec:authentication property="principal.memberID"
                           var="ses_memberID" />
                        <sec:authentication property="principal.memberName"
                           var="ses_memberName" />
                           <sec:authentication property="principal.mno"
                           var="ses_mno" />
                        <sec:authentication property="principal.auth" var="auth" />
                        <c:choose>
                           <c:when test="${ses_memberID ne null && ses_memberID ne '' }">
                              <li><i class="fa fa-user"></i>${ses_memberName }(${ses_memberID })
                              </li>
                           </c:when>
                           <c:otherwise>
                           </c:otherwise>
                        </c:choose>
                     </sec:authorize>
                  </ul>
               </div>
            </div>
            <div class="col-lg-6">
               <div class="header__top__right">
                  <sec:authorize access="isAuthenticated()">
                     <sec:authentication property="principal.memberID"
                        var="ses_memberID" />
                     <c:choose>
                        <c:when test="${ses_memberID ne null && ses_memberID ne '' }">
                           <div class="header__top__right__auth">
                              <a class="nav-link logoutBtn" href="" >로그아웃</a>
                           </div>
                        </c:when>
                     </c:choose>
                     <form action="/member/logout" method="post" class="lgForm">
                        <input type="hidden" name="${_csrf.parameterName }"
                           value="${_csrf.token }">
                     </form>
                     <script>
                        $(".logoutBtn").on("click", function(e) {
                           e.preventDefault();
                           $(".lgForm").submit();
                        });
                     </script>
                  </sec:authorize>

                  <!-- 로그인 되어 있지 않을 경우 -->
                  <sec:authorize access="isAnonymous()">
                     <div class="header__top__right__language">
                        <div>
                           <a href="/member/register">회원가입</a>
                        </div>
                     </div>
                     <div class="header__top__right__auth">
                        <a href="#" data-toggle="modal" data-target="#login-modal"><i
                           class="fa fa-user"></i> Login</a>
                     </div>
                  </sec:authorize>

               </div>
            </div>
         </div>
      </div>
   </div>
   
   <div class="container">
      <div class="row">
         <div class="col-lg-3">
            <div class="header__logo">
               <a href="/"><img src="/resources/img/logo.png" alt="logo"></a>
            </div>
         </div>
         <div class="col-lg-6">
            <nav class="header__menu mobile-menu">
               <ul>
                  <li><a href="/">Home</a></li>
                  <li><a href="#">Review</a>
                     <ul class="header__menu__dropdown">
                        <li><a href="/review/list">최신순</a></li>
                        <li><a href="/review/favorList">인기순</a></li>

                        <!-- 로그인 된 경우 -->
                        <sec:authorize access="isAuthenticated()">
                           <sec:authentication property="principal.memberID"
                              var="ses_memberID" />
                           <sec:authentication property="principal.memberName"
                              var="ses_memberName" />
                           <c:choose>
                              <c:when test="${ses_memberID ne null && ses_memberID ne '' }">
                                 <li><a href="/review/myList?memberID=${ses_memberID }">내가
                                       쓴글</a></li>
                              </c:when>
                           </c:choose>
                        </sec:authorize>

                     </ul></li>
                  <li><a href="#">Book</a>
                     <ul class="header__menu__dropdown">
                        <li><a href="/book/bestList?page=1">BESTLIST</a></li>
                        <li><a href="/book/newList?page=1">NEWLIST</a></li>
                     </ul></li>

                  <!-- 로그인 된 경우 -->
                  <sec:authorize access="isAuthenticated()">
                     <sec:authentication property="principal.memberID"
                        var="ses_memberID" />
                     <sec:authentication property="principal.memberName"
                        var="ses_memberName" />
                     <sec:authentication property="principal.auth" var="auth" />
                     <c:choose>
                        <c:when test="${ses_memberID ne null && ses_memberID ne '' }">
                           <li><a href="#">Follow</a>
                              <ul class="header__menu__dropdown">
                                 <li><a
                                    href="/member/followerList?memberID=${ses_memberID }">Follower List</a></li>
                                 <li><a
                                    href="/member/followingList?memberID=${ses_memberID }">Following List</a></li>
                              </ul></li>
                           <li><a href="#">MYPAGE</a>
                              <ul class="header__menu__dropdown">

                                 <c:choose>
                                    <c:when test="${auth eq 'ADM' }">
                                       <li><a href="/member/list">회원 정보 리스트</a></li>
                                    </c:when>
                                    <c:otherwise>
                                       <li><a href="/member/detail?memberID=${ses_memberID }&mno=${ses_mno }">내
                                             정보보기</a></li>
                                       <li><a href="/wish/wishList?mno=${ses_mno }"
                                          id="wishList">위시리스트</a></li>
                                       <li><a href="/cart/list?memberID=${ses_memberID }"
                                          id="cartCheck">장바구니</a></li>
                                       <li><a href="" id="orderCheck"">주문내역</a></li>
                                       <form action="/order/list" method="post" id="ocForm">
                                       <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                          <input type="hidden" name="memberID"
                                             value="${ses_memberID }">
                                       </form>

                                       <script>
                                          $("#orderCheck").on("click",function(e) {
                                             e.preventDefault();
                                             $("#ocForm").submit();
                                          });
                                       </script>
                                    </c:otherwise>
                                 </c:choose>
                              </ul></li>
                        </c:when>
                     </c:choose>
                  </sec:authorize>
               </ul>
            </nav>
         </div>
         <div class="col-lg-3 ">
            <sec:authorize access="isAuthenticated()">
               <sec:authentication property="principal.memberID"
                  var="ses_memberID" />
               <sec:authentication property="principal.mno"
                  var="ses_mno" />
               <div class="header__cart">
                  <ul>
                     <li><a href="/wish/wishList?mno=${ses_mno }" 
                     id="wishList"><i class="fa fa-heart"></i> <span class="wishCount"></span></a></li>
                     <li><a href="/cart/list?memberID=${ses_memberID }"
                        class="cartCheck"><i class="fa fa-shopping-bag"></i> <span
                           class="cartCount"></span></a></li>
                     <li><a href="/checkAlarm?mid=${ses_memberID }" ><i class="fa fa-bell"></i><span class="alarmCount"></span></a></li>
                  </ul>
                  <div class="header__cart__price">Mileage:<span style="float: right;">p</span><span class="nowMileage" style="float: right;"></span>
                  </div>
               </div>
            
            <script>
               $(function() {
                  nowMileage();
                  alarmCount();
                  cartCount();
                  wishCount();
               });
               function nowMileage() {
                  let header = $("meta[name='_csrf_header']").attr(
                        "content");
                  let token = $("meta[name='_csrf']").attr("content");
                  let memberID = '<c:out value="${ses_memberID }"/>';
                  if (memberID != null && memberID != '') {
                     $.ajax({
                        url : "/member/nowMileage",
                        type : "post",
                        data : {
                           memberID : memberID
                        },
                        beforeSend : function(xhr) {
                           xhr.setRequestHeader(header, token);
                        }
                     }).done(function(result) {
                        $(".nowMileage").text(result);
                        $(".nowMileage").css("display", "table");
                     });
                  } else {
                     $(".nowMileage").css("display", "none");
                  }
               }
               function cartCount() {
                  let header = $("meta[name='_csrf_header']").attr(
                        "content");
                  let token = $("meta[name='_csrf']").attr("content");
                  let mid = '<c:out value="${ses_memberID }"/>';
                  if (mid != null && mid != '') {
                     $.ajax({
                        url : "/cart/count",
                        type : "post",
                        data : {
                           memberID : mid
                        },
                        beforeSend : function(xhr) {
                           xhr.setRequestHeader(header, token);
                        }
                     }).done(function(result) {
                        $(".cartCount").text(result);
                        $(".cartCount").css("display", "table");
                     });
                  } else {
                     $(".cartCount").css("display", "none");
                  }
               }
               function wishCount() {
                  let header = $("meta[name='_csrf_header']").attr(
                        "content");
                  let token = $("meta[name='_csrf']").attr("content");
                  let mno = '<c:out value="${ses_mno }"/>';
                  console.info(mno);
                  if (mno != null && mno != '') {
                     $.ajax({
                        url : "/wish/count",
                        type : "post",
                        data : {
                           mno : mno
                        },
                        beforeSend : function(xhr) {
                           xhr.setRequestHeader(header, token);
                        }
                     }).done(function(result) {
                        $(".wishCount").text(result);
                        $(".wishCount").css("display", "table");
                        console.info("result:"+result);
                     });
                  } else {
                     $(".wishCount").css("display", "none");
                  }
               }
               function alarmCount() {
                  let header = $("meta[name='_csrf_header']").attr(
                        "content");
                  let token = $("meta[name='_csrf']").attr("content");
                  let mid = '<c:out value="${ses_memberID }"/>';
                  if (mid != null && mid != '') {
                     $.ajax({
                        url : "/alarmCount",
                        type : "post",
                        data : {
                           memberID : mid
                        },
                        beforeSend : function(xhr) {
                           xhr.setRequestHeader(header, token);
                        }
                     }).done(function(result) {
                        $(".alarmCount").text(result);
                        $(".alarmCount").css("display", "table");
                     });
                  } else {
                     $(".alarmCount").css("display", "none");
                  }
               } 
               
            </script>
            </sec:authorize>
         </div>
      </div>
      <div class="humberger__open">
         <i class="fa fa-bars"></i>
      </div>
   </div>
</header>
<!-- Header Section End -->

<!-- Hero Section Begin -->
<section class="hero hero-normal">
   <div class="container">
      <div class="row justify-content-center">
         <div class="col-lg-10">
               <div class="hero__search__form" >
                  <form name="search_bar" class="form-inline" action="/member/membersearch">
                     <select class="form-control hero__search__categories" id="range"
                        style="height: 48px; padding:0 10px;" name="range"
                        onchange="chanOpt(this.value);">
                        <option value="mID" selected>아이디</option>
                        <option value="mN">이름</option>
                        <option value="book">책 제목</option>
                        <option value="reviewTitle">리뷰 제목</option>
                     </select> <input class="form-control" type="text" placeholder="검색어 입력"
                        name="keyword" style="width: 70%;">
                     <button type="submit" class="site-btn">검색</button>
                  </form>
            </div>
         </div>

         <script>
            function chanOpt(opt) {
               if (opt == 'book') {
                  document.search_bar.action = '/book/searchedList';
               } else if(opt=='reviewTitle'){
                  document.search_bar.action='/review/reviewSearch';
                }else if(opt=='mID'){
                  document.search_bar.action='/member/membersearch'; 
                  console.info("mID" + opt);
               }else {
                  document.search_bar.action = '/member/membersearch';
               }
            }
         </script>
      </div>
   </div>
</section>
<!-- Hero Section End -->
<!--로그인 모달  -->
<div class="modal fade" id="login-modal" tabindex="-1" role="dialog"
   aria-labelledby="Login" aria-hidden="true">
   <div class="modal-dialog modal-sm">

      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"
               aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="Login">Login</h4>
         </div>

         <div class="modal-body">
            <form action="/member/login" method="post">

               <!-- 모든 post 에 인풋히든을 다 넣어야함 -->
               <input type="hidden" name="${_csrf.parameterName }"
                  value="${_csrf.token }"> <input type="hidden" name="sign"
                  value="login">
               <div class="form-group">
                  <input type="text" class="form-control" name="memberID"
                     placeholder="아이디" maxlength="20">
               </div>
               <div class="form-group">
                  <input type="password" class="form-control" name="memberPassword"
                     placeholder="비밀번호" maxlength="20">
               </div>

               <p class="text-center">
                  <button class="btn btn-primary" type="submit" value="로그인">
                     <i class="fa fa-sign-in"></i> Login
                  </button>
               </p>

            </form>

            <p class="text-center text-muted">Not registered yet?</p>
            <p class="text-center text-muted">
               <a href="/member/register"><strong>Register now</strong></a>! It is
               easy and done in 1&nbsp;minute and gives you access to special
               discounts and much more!
            </p>

         </div>
      </div>
   </div>
</div>
<c:if test="${not empty err_msg }">
	<c:choose>
		<c:when test="${err_msg eq 'Bad credentials1' }">
			<c:set var="errText" value="아이디 혹은 비밀번호가 일치하지 않습니다." />
			<script>
				alert("${errText }");
			</script>
		</c:when>
		<c:when test="${err_msg eq 'User is disabled1' }">
			<c:set var="errText" value="계정이 비활성화 되어 있습니다." />
			<script>
				alert("${errText }");
			</script>
		</c:when>
		<c:when test="${err_msg eq 'no id1' }">
			<c:set var="errText" value="존재하지 않는 아이디입니다." />
			<script>
				alert("${errText }");
			</script>
		</c:when>
		<c:otherwise>
			<c:set var="errText" value="관리자에게 문의하세요." />
			<script>
				alert("${errText }");
			</script>
		</c:otherwise>
	</c:choose>
</c:if>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<!-- CSRF : Cross Site Request Forgery (교차 (복제) 사이트 요청 공격(위협)) -->
<style>
div#login_side_left{
width: 300px;
height: 100px;

}
#login_center{
width: 300px;
height: 100px;

}
#login_side_right{
width: 300px;
height: 300px;
float:left;
}

</style>
<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Login</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>로그인</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="contact spad">
        <div class="container" style="display: flex; justify-content: center;">
        
<form action="/member/login" method="post">
               <!-- 모든 post 에 인풋히든을 다 넣어야함 -->
               <div id="login_side_left"><img src="/resources/img/logo.png" alt="logo"></div>
               <input type="hidden" name="${_csrf.parameterName }"
                  value="${_csrf.token }"> <input type="hidden" name="sign"
                  value="login">
               <div id ="login_center">
               <div>
                  <input type="text" class="form-control" name="memberID"
                     placeholder="아이디" maxlength="20">
               </div>
               <div style="margin-top: 5px;">
                  <input type="password" class="form-control" name="memberPassword"
                     placeholder="비밀번호" maxlength="20">
               </div>
               </div>

               <div id ="side_right">
                  <button type="button" class="site-btn" value="회원가입" onclick="location.href='/member/register'" style="width: 139px">
                     <i class="fa fa-sign-in"></i> register
                  </button>
                  <button class="site-btn" type="submit" value="로그인" style="width: 113px; margin-left: 43px">
                     <i class="fa fa-user"></i> Login
                  </button>
               </div>

            </form>
</div></section>
<jsp:include page="../common/footer.jsp" />
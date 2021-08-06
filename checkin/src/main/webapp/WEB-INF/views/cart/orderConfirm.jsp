<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<style>
tr > td > img{
	width: 100px;
}
</style>
<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: green;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Check Order</h2>
                        <div class="breadcrumb__option">
                            <a href="/">Home</a>
                            <span>구매 확인</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberID" var="ses_memberID" />
	<sec:authentication property="principal.memberName" var="ses_memberName" />
	<sec:authentication property="principal.memberEmail" var="ses_memberEmail" />
	<sec:authentication property="principal.memberPhone" var="ses_memberPhone" />
	<sec:authentication property="principal.zipcode" var="ses_zipcode" />
	<sec:authentication property="principal.roadAddress" var="ses_roadAddress" />
	<sec:authentication property="principal.addressDetail" var="ses_addressDetail" />
	<c:choose>
		<c:when test="${ses_memberID ne null && ses_memberID ne '' }">   
<section class="checkout spad">    
<div class="container">
  <div class="checkout__form">
   <h4 style="border-bottom: none;">Billing Details</h4>
  <table class="table table-hover">
    <thead>
      <tr>
        <th>도서정보</th>
        <th></th>
        <th style="width: 15%;">수량</th>
        <th style="width: 15%;">도서 금액</th>
      </tr>
    </thead>
    <tbody id="cartList">
   </tbody>
  </table>
  <hr>
	<form action="/cart/complete" method="post">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
  	<input type="hidden" class="form-control" id="tp" readonly required>
	 <div class="row">
	 <div class="col-lg-8 col-md-6">
	 	<div class="row">
		<div class="form-group checkout__input col-lg-6">
    		<label for="memberName">이름:</label>
    		<input type="text" class="form-control" name="memberName" value="${ses_memberName }"  required>
 		</div>
  		<div class="form-group checkout__input col-lg-6">
    		<label for="memberid">ID:</label>
    		<input type="text" class="form-control" id="mid" name="memberid" value="${ses_memberID }" readonly required>
 		</div>
 		<div class="form-group checkout__input col-lg-6">
   			 <label for="memberemail">Email:</label>
   		 	<input type="email" class="form-control" placeholder="Enter email" name="memberemail" value="${ses_memberEmail }" readonly required>
  		</div>
 		<div class="form-group checkout__input col-lg-6">
   			 <label for="phonenum">Phone:</label>
   		 	<input type="text" class="form-control" name="phonenum" value="${ses_memberPhone }">
  		</div>
  		<div class="form-group checkout__input col-lg-4">
   			 <label for="zipcode">우편번호:</label><button type="button" class="btn btn-default" onclick="execPostCode();">
							<i class="fa fa-search"></i> 우편번호 찾기</button>
   		 	<input type="text" class="form-control" name="zipcode" value="${ses_zipcode }" readonly required>
  		</div>
  		</div>
  		<div class="form-group checkout__input">
   			 <label for="roadAddress">주소:</label>
   		 	<input type="text" class="form-control" name="roadAddress" value="${ses_roadAddress }" readonly required>
  		</div>
  		<div class="form-group checkout__input">
   			 <label for="addressDetail">상세주소:</label>
   		 	<input type="text" class="form-control" name="addressDetail" value="${ses_addressDetail }">
  		</div>
  		<div class="form-group checkout__input">
   			 <label for="mileage">마일리지:</label>
   			  <input type="radio" id="usemile" name="mileageCheck" value="usemile"  style="width: 20px; height: 20px;">
  			  <label for="usemile">사용</label>
  			  <input type="radio" id="notmile" name="mileageCheck" value="notmile" style="width: 20px; height: 20px;" checked="checked" >
  			  <label for="notmile">사용안함</label>
   		 	<input type="number" class="form-control" name="mileage" min="0"  disabled="disabled" onchange="mileageShow();">
  		</div>
  		<div class="form-group checkout__input">
   			 <label for="demand">요청사항:</label>
   		 	<input type="text" class="form-control" name="demand">
  		</div>
  		<div class="form-group">
   		 	<input type="hidden" class="form-control" id="totalBookPrice" name="price" readonly>
  		</div>
		</div>
		<div class="col-lg-4 col-md-6">
			<div class="checkout__order">
				<h4>Your Order</h4>
                <div class="checkout__order__products">Products <span>Total</span></div>
                <ul class="orderchecklist"><li><span>${cvo.price }원</span></li></ul>
                <div class="checkout__order__subtotal" style="clear: both;">Mileage <span id="mileshow">0</span></div>
                <div class="checkout__order__total">Total <span id="showtotal"></span></div>
                <button type="submit" class="site-btn orderConfirm">PLACE ORDER</button>
			</div>
		</div>
		</div>
	</form>
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
<script>
$(function() {
	mileCheck();
	list_cart();
});
function mileageShow(){
	let mile=$("input[name='mileage']").val();
	$("#mileshow").text("-"+mile);
	let tp=$("#tp").val();
	console.log(tp);
	$("#showtotal").text((tp-mile)+"원");
}
$("input[name='mileageCheck']:radio").change(function () {
    var notice= this.value;
    if(notice =="notmile"){
    	$("input[name='mileage']").attr('disabled','disabled');
    	$("input[name='mileage']").val("");
    }else{
    	$("input[name='mileage']").attr("disabled",false);
    }
});
function mileCheck(){
    let mileage='<c:out value="${mvo.mileage }"/>';
    mileage*= 1;
    console.log(mileage);
	let discount='<c:out value="${price}"/>' ;
	discount *= 0.1;
	console.log(discount);
	if(discount>mileage){
		$("input[name='mileage']").attr("max",mileage);
		$("input[name='mileage']").attr("placeholder","최대 "+mileage+"원까지 사용가능");
	}else{
		$("input[name='mileage']").attr("max",discount);
		$("input[name='mileage']").attr("placeholder","최대 "+discount+"원까지 사용가능");
	}
}

function list_cart() {
	let header = $("meta[name='_csrf_header']").attr("content");
	let token =  $("meta[name='_csrf']").attr("content");
	let mid=$("#mid").val();
	$.ajax({
		url:"/cart/list",
		type:"post",
		data:{
			memberID:mid
		},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType:"json"
	}).done(function (result) {
		let inbody="";
		let inlistbody="";
		let totalPrice=0;
		if(result.length==0){
			inbody+='<tr><td colspan="4" class="text-center">장바구니에 담은 도서가 없습니다.</td></tr>'
		}else{
		for (var i = 0; i < result.length; i++) {
			inbody+='<tr>'
			inbody+='    <td><img src="'+result[i].cover+'"></td><td>'+result[i].bname+'</td>'
			inbody+='       <td><input type="text" name="qty'+result[i].cartno+'" value="'+result[i].qty+'" style="width:43px; border:none; padding-top:0;" readonly></td>'
			inbody+='        <td>'+result[i].price+'원</td>'
			inbody+='    </tr>'
			totalPrice+=Number(result[i].price)*Number(result[i].qty);
			inlistbody+='<li style="clear:both;">"'+result[i].bname+'" X '+result[i].qty+'<div style="float:right; font-weight:bold;">'+(Number(result[i].price)*Number(result[i].qty))+'원</div></li>';
		}
		}
		$("#cartList").html(inbody);
		$(".orderchecklist").html(inlistbody);
		console.log(inlistbody);
		$("#tp").val(totalPrice);
		$("#totalBookPrice").val(totalPrice);
		totalPrice+="원";
		$("#showtotal").text(totalPrice);
	});
}

</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=zipcode]").val(data.zonecode);
           $("[name=roadAddress]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}
</script>
<jsp:include page="../common/footer.jsp" />
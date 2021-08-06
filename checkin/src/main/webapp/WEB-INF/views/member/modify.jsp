<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<script>
function passwordCheckFunction() {
	var pw_passed = true; 
	var memberPassword = $('#memberPassword').val();
	var memberPassword2 = $('#memberPassword2').val();
	var pattern1 = /[0-9]/;
    var pattern2 = /[a-zA-Z]/;
    var pattern3 = /[~!@\#$%<>^&*]/;     // 원하는 특수문자 추가 제거
    var pw_msg = "";
	if (memberPassword != memberPassword2) {
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
		$("button[type=submit]").attr("disabled", true);
	} if(!pattern1.test(memberPassword)||!pattern2.test(memberPassword)||!pattern3.test(memberPassword)||memberPassword.length<8||memberPassword.length>50){
		 $('#passwordCheckMessage').html("영문+숫자+특수기호 8자리 이상으로 구성하여야 합니다.");
		 $("button[type=submit]").attr("disabled", true);
    } if(memberPassword == memberPassword2 && !(!pattern1.test(memberPassword)||!pattern2.test(memberPassword)||!pattern3.test(memberPassword)||memberPassword.length<8||memberPassword.length>50)) {
		$('#passwordCheckMessage').html('');
		 $("button[type=submit]").attr("disabled", false);
	}      
}
</script>

<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>My Detail</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>내 정보 수정</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="container" style="clear: both; margin-top: 10px;">
<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.memberID" var="ses_memberID" />
<c:choose>
	<c:when test="${ses_memberID eq mvo.memberID }">
		<c:if test="${auth ne 'ADM' }">
		<form action="/member/modify?mno=${mvo.mno }" method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<div class="form-group">
				<label for="memberID">아이디:</label> <input type="text"
					class="form-control" id="memberID" name="memberID" value="${mvo.memberID }"
					readonly>
			</div>
			<div class="form-group">
				<label for="memberPassword">비밀번호:</label> <input onkeyup="passwordCheckFunction();"
						type="password" class="form-control" placeholder="비밀번호"
						name="memberPassword" id="memberPassword" maxlength="20" required>
			</div>
			<div class="form-group">
				<label for="memberPassword2">비밀번호확인:</label> <input onkeyup="passwordCheckFunction();"
						type="password" class="form-control" placeholder="비밀번호"
						name="memberPassword2" id="memberPassword2" maxlength="20">
						<h5 style="color: red;" id="passwordCheckMessage" required></h5>
			</div>
			<div class="form-group">
				<label for="memberName">이름:</label> <input type="text"
					class="form-control" id="memberName" name="memberName"
					value="${mvo.memberName }">
			</div>
				<label for="memberGender">성별:</label> 
				<c:set var="gender" value="${mvo.memberGender }"/>
						<div class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn site-btn active"> 
								<input type="radio" data-toggle="radio" name="memberGender" autocomplete="off" value="남자" checked>남자</label> 
								<label class="btn site-btn"> 
								<input type="radio" data-toggle="radio" name="memberGender" autocomplete="off" value="여자">여자
								</label>
							</div>
						<script type="text/javascript">
							if ('${gender}'=="남자") {
								$("input[value='남자']").prop("checked",true);
							}else{
								$("input[value='여자']").prop("checked",true);
							}
						</script>
			</div>
				<div class="form-group">
				<label for="memberEmail">이메일:</label> <input type="text"
					class="form-control" id="memberEmail" name="memberEmail"
					value="${mvo.memberEmail }">
			</div>
				<div class="form-group">
				<label for="memberPhone">전화번호:</label> <input type="text"
					class="form-control" id="memberPhone" name="memberPhone"
					value="${mvo.memberPhone }">
			</div>
				<div class="form-group">
				<label for="memberBirth">생일:</label> <input type="text"
					class="form-control" id="memberBirth" name="memberBirth"
					value="${mvo.memberBirth }">
			</div>
				<div class="form-group">
				<label for="zipcode">우편번호:</label> <input type="text"
					class="form-control" id="zipcode" name="zipcode"
					value="${mvo.zipcode }" required readonly><button type="button" class="btn btn-default"
							onclick="execPostCode();" >
							<i class="fa fa-search"></i> 우편번호 찾기
						</button>
			</div>
				<div class="form-group">
				<label for="roadAddress">도로명주소:</label> <input type="text"
					class="form-control" id="roadAddress" name="roadAddress"
					value="${mvo.roadAddress }" readonly required>
			</div>
				<div class="form-group">
				<label for="addressDetail">상세주소:</label> <input type="text"
					class="form-control" id="addressDetail" name="addressDetail"
					value="${mvo.addressDetail }">
			</div>
			<div class="form-group">
						<label for="profile">프로필이미지:</label> <img src="/upload/${fvo.savedir}/${fvo.uuid}_th_${fvo.fname}" alt="기존 프로필 이미지가 없습니다." id="profileImg" style="max-width: 100; max-height: 100;" >
			</div>
			<table>
			<tr>
					<td colspan="2">
					<input type="file" class="form-control" id="files" name="files" style="display:none;"></tr>
					<c:choose>
							<c:when test="${fvo.uuid ne null }">
			<tr>
							<td>
					<button type="button" class="btn btn-outline-info btn-block" id="removeBtn" data-mno="${mvo.mno }">파일삭제</button></td></tr>
					</c:when>
					<c:when test="${fvo.uuid eq null }">
			<tr>
					<td id="imgViewArea" style="margin-top:10px; display:none;">
					<img id="imgArea" style="width:200px; height:100px;" onerror="imgAreaError()"/></td>
			</tr>
					<td>
					<button type="button" class="btn btn-outline-info btn-block" id="fileTrigger">File Upload</button></td>
					<td><ul class="list-group" id="fileZone"></ul></td>
					</c:when>
					</c:choose>
				
					<tr id="uploadBtn"></tr>
			
			</table>
			
			<button type="submit" class="site-btn" style="float: right; margin-right: 5px; margin-top: 20px;">수정 완료</button>
		</form>
			<button onclick="history.back()" class="site-btn" style="float: left; margin-top: 20px;">수정 취소</button>
		</c:if>
	</c:when>
	<c:otherwise>
		<script>
			alert("관리자 수정은 DB에서~.")
			location.replace("/");
		</script>
	</c:otherwise>
</c:choose>
</sec:authorize>
</div>
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
<script>
$(document).on("click", "#fileTrigger", function() {
	$("#files").click();
});

let regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$");
let maxSize = 1048576; // 1MB

function fileValidation(fname, fsize){
	if(regExp.test(fname)){
		alert(fname + "는 허용되지 않는 파일 형식입니다!");
		return false;
	}else if(fsize > maxSize){
		alert("1MB 이하의 파일만 허용됩니다!");
		return false;
	}else{
		return true;
	}
	
}
$(document).on("change", "#files", function() {
	$("button[type=submit]").attr("disabled", false);
	let formObj = $("#files");
	let fileObjs = formObj[0].files;
	let fileZone = $("#fileZone");
	fileZone.html("");
	
	for (let fobj of fileObjs) {
		let li = '<li class="list-group-item d-flex justify-content-between align-items-center">';
		if(fileValidation(fobj.name, fobj.size)){
			// 정상출력
			li += fobj.name + '<span class="badge badge-success badge-pill">';
		}else{
			// 경고출력 후 서브밋 버튼 비활성화
			li += '<i class="fa fa-times-rectangle" style="font-size:24px;color:red"></i>';
			li += fobj.name + '<span class="badge badge-danger badge-pill">';
			$("button[type=submit]").attr("disabled", true);
		}
		li += fobj.size +' Byte</span></li>';
		fileZone.append(li);
	}
});
</script>	
<script>
         function remove_file_li (i_obj) {
            $(i_obj).closest("li").remove();
         }
         $(function(){
            $(document).on("click", "#removeBtn", function(){
				let mno_obj = $(this);
				let mno_val = mno_obj.data("mno");
				let header = $("meta[name='_csrf_header']").attr("content");
				let token =  $("meta[name='_csrf']").attr("content");
               $.ajax({
                  url: "/member/delfile",
                  type: "post",
                  data: {mno: mno_val},
                  beforeSend: function(xhr){
  					xhr.setRequestHeader(header, token);
  				}
               }).done(function(result){
                  alert("파일삭제 성공~");
                  console.log(mno_obj);
                  let inbody="";
                  $("#removeBtn").hide();
                  $("#profileImg").hide();
          			inbody+='<button type="button" class="btn btn-outline-info btn-block" id="fileTrigger">File Upload</button>'
          			inbody+='<div id="imgViewArea" style="margin-top:10px; display:none;">'
    				inbody+='<img id="imgArea" style="width:200px; height:100px;" onerror="imgAreaError()"/></div>'
    				inbody+='<div><ul class="list-group" id="fileZone"></ul></div>'
          			$("#uploadBtn").html(inbody);
          			
               }).fail(function(err){
                  console.log(err);
                  alert("파일삭제 실패!");
               });
            });
         });
</script>

<script>
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#imgArea').attr('src', e.target.result); 
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$(":input[name='files']").change(function() {
	if( $(":input[name='files']").val() == '' ) {
		$('#imgArea').attr('src' , '');  
	}
	$('#imgViewArea').css({ 'display' : '' });
	readURL(this);
});


function imgAreaError(){
	$('#imgViewArea').css({ 'display' : 'none' });
}
</script>


<jsp:include page="../common/footer.jsp" />

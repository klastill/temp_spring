<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<!-- 파일업로드펑션 -->
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
//아이디에 특문못넣게 
var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi;
var replaceNotFullKorean = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;

$(document).ready(function(){
    
    $("#memberID").on("focusout", function() {
        var x = $(this).val();
        if (x.length > 0) {
            if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
                x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
            }
            $(this).val(x);
        }
        }).on("keyup", function() {
            $(this).val($(this).val().replace(replaceChar, ""));

   });

});       

</script>


<script type="text/javascript">
var id_ck=false;
	function memberIDCheck() {
		$('#memberID').change(function () {
		      $('.id_overlap_button').show();
		      $('.fa-check').hide();
		      $('#idCheckMessage').html('중복 체크를 해주세요');
		      $("button[type=submit]").attr("disabled", true);
		      id_ck=false;
		      return;
		    })
		var memberID_val = $('#memberID').val();
		let header = $("meta[name='_csrf_header']").attr("content");
		let token =  $("meta[name='_csrf']").attr("content");
		console.log(memberID);
		$.ajax({
			type : "POST",
			url : "/member/checkID",
			data : {memberID : memberID_val},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			}
		}).done(function(result) {
			if (parseInt(result) == 0 && memberID_val != '') {
				$("#memberPassword").val("");
				$("#memberPassword2").val("");
				$("#memberPassword").focus();
		   		 $('.fa-check').show();
		     	$('.id_overlap_button').hide();
		     	id_ck=true;
				alert("사용 가능한 아이디입니다");
				$('#idCheckMessage').html('');
			} else {
				$("#memberID").val("");
				$("#memberID").focus();
				id_ck=false;
				alert("사용할 수 없는 아이디입니다");
			}
		});
	}
	
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
			 $("button[type=submit]").attr("disabled", true);
		} if(id_ck == true){
			$('#idCheckMessage').html('');
			$("button[type=submit]").attr("disabled", true);
		}  if(memberPassword == memberPassword2 && !(!pattern1.test(memberPassword)||!pattern2.test(memberPassword)||!pattern3.test(memberPassword)||memberPassword.length<8||memberPassword.length>50) && id_ck==true) {
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
					<h2>Register</h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>회원 가입</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<div class="container" style="clear: both; margin-top: 10px;">
	<form method="post" action="/member/register?${_csrf.parameterName }=${_csrf.token }" enctype="multipart/form-data">
		<table class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="3"><h4>회원 등록 양식</h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 70px;"><h5>아이디</h5></td>
					<td>
					<input hidden="hidden"/>
					<input type="text" class="form-control"  id="memberID"  name="memberID" maxlength="20" placeholder="아이디를 입력하세요.(영문 또는 숫자만 입력 가능합니다.)"></td>
					<td style="width: 110px;"><button class="id_overlap_button"
							onclick="memberIDCheck();" type="button">중복체크</button><i class="fa fa-check" aria-hidden="true" style="display: none;"></i><h5 style="color: red;" id="idCheckMessage" required></h5></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>비밀번호</h5></td>
					<td colspan="2"><input onkeyup="passwordCheckFunction();"
						type="password" class="form-control" placeholder="비밀번호"
						name="memberPassword" id="memberPassword" maxlength="20" required></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
					<td colspan="2"><input onkeyup="passwordCheckFunction();"
						type="password" class="form-control" placeholder="비밀번호확인"
						name="memberPassword2" id="memberPassword2" maxlength="20" required>
						<h5 style="color: red;" id="passwordCheckMessage" required></h5></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>이름</h5></td>
					<td colspan="2"><input type="text" class="form-control"
						placeholder="이름" name="memberName" name="memberName"
						maxlength="20" required></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>성별</h5></td>
					<td colspan="2">
						<div class="form-group"
							style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn site-btn active"> <input
									type="radio" data-toggle="radio" name="memberGender"
									autocomplete="off" value="남자" checked>남자
								</label> <label class="btn site-btn"> <input type="radio"
									data-toggle="radio" name="memberGender" autocomplete="off"
									value="여자">여자
								</label>
							</div>
						</div>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>이메일</h5></td>
					<td colspan="2"><input type="email" class="form-control"
						placeholder="이메일" name="memberEmail" name="memberEmail"
						maxlength="45" required></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>전화번호</h5></td>
					<td colspan="2"><input type="text" class="form-control"
						placeholder="전화번호" name="memberPhone" name="memberPhone"
						maxlength="20" required></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>생년월일</h5></td>
					<td colspan="2"><input type="text" class="form-control"
						placeholder="생년월일" name="memberBirth" name="memberBirth"
						maxlength="20"></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>우편번호</h5></td>
					<td colspan="2"><input class="form-control"
						style="width: 40%; display: inline;" placeholder="우편번호"
						name="zipcode" id="zipcode" type="text" readonly="readonly"  required>
						<button type="button" class="btn btn-default"
							onclick="execPostCode();">
							<i class="fa fa-search"></i> 우편번호 찾기
						</button></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>도로명주소</h5></td>
					<td colspan="2"><input class="form-control" style="top: 5px;"
						placeholder="도로명 주소" name="roadAddress" id="roadAddress" type="text"
						readonly="readonly"  required/></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>상세주소</h5></td>
					<td colspan="2"><input class="form-control" placeholder="상세주소"
						name="addressDetail" id="addressDetail" type="text" /></td>
				</tr>
				<tr>
					<td style="width: 110px;"><h5>프로필이미지</h5></td>
					<td colspan="2">
					<input type="file" class="form-control" id="files" name="files" style="display:none;">
					<button type="button" class="btn btn-outline-info btn-block" id="fileTrigger">File Upload</button>
				</tr>
				<tr>
				<td></td>
					<td>
					<div id="imgViewArea" style="margin-top:10px; display:none;">
					<img id="imgArea" style="width:200px; height:100px;" onerror="imgAreaError()"/></div>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><ul class="list-group" id="fileZone"></ul>
				</td>
				<tr>
					<td style="text-align: left;" colspan="3">
					<button class="site-btn pull-right" type="submit">등록</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
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


<script type="text/javascript">

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
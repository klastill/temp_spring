<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<style>

.single_comment_area {
	margin: 20px;
}

hr {
	margin: 10px;
}
.my-transparent-button {
    background-color: transparent !important;
    background-image: none !important;
    border-color: transparent;
    border: none;

    color: #123123;
}
</style>
<section class="breadcrumb-section set-bg"
	data-setbg="/resources/img/book-diary-bookmark.jpg" style="background-color: #7fad39;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Bookly Detail </h2>
					<div class="breadcrumb__option">
						<a href="/">Home</a> <span>Review Detail</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberID" var="ses_memberID" />
	<sec:authentication property="principal.auth" var="auth" />
	<sec:authentication property="principal.mno" var="ses_mno" />
	<c:choose>
		<c:when test="${auth eq 'ADM'  || auth eq 'MEM'}">
			<script>
var abc;
 
	function isSubscribe(sendID,receiveID) {
		let header=$("meta[name='_csrf_header']").attr("content");
		let token=$("meta[name='_csrf']").attr("content");
		$.ajax({
			url : "/member/isSubscribe",
			type : "post",
			async:false,
			data : {
				smID : sendID,
				rmID : receiveID
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token);
			}
		}).done(function(result) {
			abc=result;
			
		});
		return abc;
	}
	
	$(document).on("click", ".subBtn", function() {	
		let rmID_val = $(this).data("mid");
		console.log("rmID_val 체크"+rmID_val);
		let rno_val = $("#rnoVal").text();
		let smID_val = '<c:out value="${ses_memberID}"/>';
		let review_title ='<c:out value="${rvo.title}"/>';
		console.log("smID_val 체크"+smID_val);
		let header=$("meta[name='_csrf_header']").attr("content");
		let token=$("meta[name='_csrf']").attr("content");
		$.ajax({
			url:"/member/subscribe",
			type: "post",
			data : {
				smID : smID_val,
				rmID : rmID_val
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token);
			}
		}).done(function(result){
			console.log("result" + result);
			if(parseInt(result)==1){
				$("#"+rmID_val).html("팔로잉 취소")
				$("#"+rmID_val).attr("class","site-btn float-right subBtn");
				$("#"+rmID_val).css("visibility","visible");
				socket.send("follow,"+smID_val+","+rmID_val+","+review_title+","+rno_val);
				 connectWs();
			}else if(parseInt(result)==2){
				$("#"+rmID_val).html("팔로잉")
				$("#"+rmID_val).attr("class","site-btn float-right subBtn");
				$("#"+rmID_val).css("visibility","visible");
			}else if(parseInt(abc)==3){
				
			}else{
				alert("팔로잉 오류");
			}
			print_btn();
		});
	});
	
	$(document).on("click", ".goIndex", function() {	
		location.href="/";
	});
</script>
			<section class="product-details spad">
				<div class="container">
					<div class="row">
						<div class="col-lg-6 col-md-6">
							<div class="product__details__pic">
								<div class="product__details__pic__item">
									<img class="product__details__pic__item--large"
										src="${rvo.cover }" alt=""  style="max-width: 400px ;  max-height: 560px; margin:50px auto; object-fit:contain;" >
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-md-6">
							<div class="product__details__text">
								<h3 style="font-family: 'EliceDigitalBaeum_Regular';">${rvo.title }</h3>
								<h5>${rvo.bname }</h5>
								<a href="javascript:history.back();" style="position: absolute; top: 5px; right: 16px;" id="backBtn">뒤로가기</a>
								<script>
								$(function(){
									var url=document.referrer;
									$("#urlVal").val(url);
									let urlFromMod= "${urlBeforeMod}";
									if(urlFromMod!=null && urlFromMod!=''){
										$("#backBtn").attr("href",urlFromMod);
									}else{
										if(url.includes('checkAlarm')){
											$("#backBtn").attr("href",url);
										}
									}
								});
								</script>
								<c:choose>
									<c:when test="${rvo.recommend eq 5 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 4 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 3 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 2 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 1 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 0 }">
										<div class="product__details__rating">
											<i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
								</c:choose>
								<div class="blog__details__author">
									<div class="blog__details__author__pic">
									<c:choose>
										<c:when test="${fvo.ftype > 0 }">
										<img src="/upload/${fvo.savedir}/${fvo.uuid}_th_${fvo.fname}"
											alt="">
										</c:when>
										<c:otherwise>
										<img src="/resources/images/member/person.png"
											alt="">
										</c:otherwise>
									</c:choose>
									
									</div>
									<div class="blog__details__author__text">
										<span style="font-size: 36px;" >${rvo.memberID }</span>
										<input type="hidden" value="${rvo.memberID }" id="review_rvmemberID"> 
										<button type="button" class="float-right"
											id="${rvo.memberID }" data-mid=${rvo.memberID }
											class="subBtn" style="visibility: hidden"></button>
									</div>
								</div>
								<script>

				function print_btn(){
					let smID_val = '<c:out value="${ses_memberID}"/>';
					console.log(smID_val);
					let rmID_val='';
					rmID_val='<c:out value="${rvo.memberID}"/>';
							console.log("rmID_val"+rmID_val);
							abc =isSubscribe(smID_val,rmID_val);
							console.log("abc "+ abc);
							console.log("abc type" + typeof abc);
							 if(parseInt(abc)==1){
									$("#"+rmID_val).html("팔로잉");
									$("#"+rmID_val).attr("class","site-btn float-right subBtn");
									$("#"+rmID_val).css("visibility","visible");
							}else if(parseInt(abc)==2){
									$("#"+rmID_val).html("팔로잉 취소")
									$("#"+rmID_val).attr("class","site-btn float-right subBtn");
									$("#"+rmID_val).css("visibility","visible");
							}else if(parseInt(abc)==3){
								
							}else{
								$("#"+rmID_val).html("로그인 필요")
								$("#"+rmID_val).attr("class","site-btn float-right goIndex");
								$("#"+rmID_val).css("visibility","visible");
							}
				}
				</script>
								<script> print_btn() </script>
								<br>
								<p>${rvo.content }${rvo.content2 }</p>
								
								<c:if test="${ses_memberID ne '' && ses_memberID ne null }">
									<div class="product__details__quantity">
										<c:if test="${ses_memberID eq rvo.memberID }">
											<a
												class="btn btn-outline-warning" id="reviewModBtn">수정</a>
											<button type="button" class="btn btn-outline-danger"
												id="delBtn">삭제</button>
												<form action="/review/modify" method="get" id="urlForm">
													<input type="hidden" value="" id="urlVal" name="url">
													<input type="hidden" value="${rvo.rno }"  name="rno">
													<input type="hidden" value="${pgvo.pageIndex }"  name="pageIndex">
													<input type="hidden" value="${pgvo.countPerPage }"  name="countPerPage">
													<input type="hidden" value="${pgvo.range }"  name="range">
													<input type="hidden" value="${pgvo.keyword }"  name="keyword">
												</form>
												<script type="text/javascript">
													$(document).on("click","#reviewModBtn",function(){
														$("#urlForm").submit();
													});
												</script>

											<form action="/review/remove" id="delForm" method="post">
											<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
												<input type="hidden" name="rno" value="${rvo.rno }">
												<input type="hidden" name="pageIndex"
													value="${pgvo.pageIndex }"> <input type="hidden"
													name="countPerPage" value="${pgvo.countPerPage }">
												<input type="hidden" name="range" value="${pgvo.range }">
												<input type="hidden" name="keyword" value="${pgvo.keyword }">
											</form>
											<script>
												$("#delBtn").on("click", function() {
														$("#delForm").submit();
												});
											</script>
										</c:if>
									</div>
									<button type="button" class="float-right" id="likeBtn"
										style="visibility: hidden">
										<i class="" style="color: red" id="likeIcon"></i>
									</button>
									<button type="button" class="float-right" id="likeList"
										data-toggle="modal" data-target="#likeModal"
										data-rno="${rvo.rno }">좋아요목록</button>
								</c:if>
								<ul>
									<li><b>조회수</b> <span>${rvo.readCount }</span></li>
									<li><b>좋아요 수</b> <span id="likeyNo">${rvo.likey } </span></li>
									<li><b>리뷰 번호</b> <span id="rnoVal">${rvo.rno }</span></li>
								</ul>
							</div>
						</div>
						<!-- 좋아요 리스트 -->
						<script>
	
	function print_list_like(likelist){
		if(likelist.length==0){
			let listZone = $("#likeModalList");
			listZone.empty();
			let card = '<tr><td colspan="2" style="padding-right:15px;text-align:center;">좋아요</td><td style="text-align:center;">목록없음</td></tr>';
		    listZone.append(card);
		}else{
			let listZone = $("#likeModalList");
			listZone.empty();
			let ses_memberID = '<c:out value="${ses_memberID}"/>';
			for (let lvo of likelist) {
				let card = '<tr><td style="padding-right:15px;text-align:center;">'+lvo.memberId+'</td><td style="padding-right:15px;"></td>';
				card += '<td style="text-align:center;">'+lvo.memberNickname+'</td></tr>';
			    listZone.append(card);
			}			
		}
	}
	function list_like (rno) {
		$.getJSON("/like/rno/"+ rno+ ".json", function(result) {
			console.log(result);
			print_list_like(result);
		}).fail(function(err) {
			console.log(err);
			alert("좋아요 리스트 로딩 실패!");
		});
	}
	
	$("#likeList").on("click",function(){
		list_like($("#rnoVal").text());
	});
	</script>
						<!-- 좋아요 리스트 Modal -->
						<div class="modal fade" id="likeModal">
							<div class="modal-dialog  modal-dialog-centered " style="width:230px;"
								id="likeModalSize">
								<div class="modal-content" style="border-radius: 25px;">
									<!-- Modal Header -->
									<div class="modal-header" style="background: #ffffff ;border-radius: 25px;">
										<h4 class="modal-title" style="font-weight: 800;">좋아요 리스트</h4>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>
									<!-- Modal body -->
									<div class="modal-body"
										style="overflow-y: scroll; max-height: 350px;">
										<table class="">
											<thead>
												<tr>
													<th style="text-align: center; padding-right:15px;font-weight:bold;">ID</th>
													<th style="padding-right:15px;"></th>
													<th style="text-align: center; font-weight:bold;">이름</th>
												</tr>
											</thead>
											<tbody id="likeModalList">

											</tbody>
										</table>

									</div>
									<!-- Modal footer -->
									<div class="modal-footer">
										<button type="button" class="site-btn" data-dismiss="modal" style="margin: auto;">확인</button>
									</div>
								</div>
							</div>
						</div>
						<!-- Modal End -->

						<!--좋아요 구현  -->
						<script>
  			$("#likeBtn").on("click",function(){
  				let rno_val = $("#rnoVal").text();
  				let memberID_val ='<c:out value="${ses_memberID}"/>';
  				let review_title ='<c:out value="${rvo.title}"/>';
  				let likeyNo_val =Number($("#likeyNo").text());
  				let header=$("meta[name='_csrf_header']").attr("content");
  				let token=$("meta[name='_csrf']").attr("content");
  				let review_writer=$("#review_rvmemberID").val();
  				$.ajax({
  					url: "/like/like",
  					type: "post",
  					data: {rno:rno_val, memberID:memberID_val},
  					beforeSend: function(xhr){
  						xhr.setRequestHeader(header,token);
  					}
  				}).done(function(result) {
  					if(parseInt(result)==1){
  						$("#likeyNo").text(1+likeyNo_val);
  						$("#likeIcon").attr("class","fa fa-heart");
  						$("#likeBtn").css("visibility","visible");
  						socket.send("like,"+memberID_val+","+review_writer+","+review_title+","+rno_val);
  						 connectWs();
  					}else if(parseInt(result)==2){
  						$("#likeyNo").text(likeyNo_val-1);
  						$("#likeIcon").attr("class","fa fa-heart-o");
  						$("#likeBtn").css("visibility","visible");
  					}else{
  						alert("좋아요 실패");
  					}
  				});
  			});
  			
  			function islike(){
  				let rno_val = $("#rnoVal").text();
  				let memberID_val ='<c:out value="${ses_memberID}"/>';
  				console.log(memberID_val);
  				console.log(rno_val);
  				let header=$("meta[name='_csrf_header']").attr("content");
  				let token=$("meta[name='_csrf']").attr("content");
  				$.ajax({
  					url: "/like/islike",
  					type: "post",
  					data: {rno:rno_val, memberID:memberID_val},
  					beforeSend: function(xhr){
  						xhr.setRequestHeader(header,token);
  					}
  				}).done(function(result) {
  					console.log(result);
  					console.log(typeof result);
  					if(parseInt(result)==1){
  						$("#likeIcon").attr("class","fa fa-heart-o");
  						$("#likeBtn").css("visibility","visible");
  					}else if(parseInt(result)==2){
  						$("#likeIcon").attr("class","fa fa-heart");
  						$("#likeBtn").css("visibility","visible");
  					}else{
  						alert("좋아요 실패");
  					}
  				})
  		}
  		</script>
						<!-- Ajax Comment Part -->
						<div class=" col-lg-11 col-md-11 m-5" id="list" >
							<h2 style="padding-bottom: 10px;">Comments</h2>
							<hr>
							<c:if test="${ses_memberID ne '' && ses_memberID ne null }">
								<div class="comment-form form-group">
									<form style="clear: both; padding: 4px 10px;">
										<label for="cmtInput" class="" id="cmtWriter">
											${ses_memberID }</label>
										<div class="input-group mb-1">
											<input type="text" class="form-control" id="cmtInput"
												placeholder="댓글 입력란" onkeypress="if( event.keyCode == 13 ){event.preventDefault();}">
											<div class="input-group-append">
												<button class="btn" type="button" id="cmtSubmit"
													style="background-color: #7fad39;">ADD</button>
											</div>
										</div>
									</form>
								</div>
								<hr>
							</c:if>
							<div id="accordion" style="clear: both;"></div>
							<ul class="pagination justify-content-center pagination-sm mt-2"
								id="pgn"></ul>

							<!-- 추가된 부분 The Modal -->
							<div class="modal fade" id="modModal">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<!-- Modal Header -->
										<div class="modal-header">
											<input class="modal-title" type="hidden"> <span
												class="modal-writer"></span>
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>
										<!-- Modal body -->
										<div class="modal-body">
											<textarea class="form-control" rows="5" id="cmtText"></textarea>
										</div>
										<!-- Modal footer -->
										<div class="modal-footer">
											<button type="button" class="btn btn-warning modBtn"
												style="background-color: #7fad39; border: none; color: white;">수정</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Modal End -->
						<script>

	function modify_comment(cmtObj){
		let rno_val = $("#rnoVal").text();
		let header=$("meta[name='_csrf_header']").attr("content");
		let token=$("meta[name='_csrf']").attr("content");
		$.ajax({
			url: "/comment/"+cmtObj.cno,
			type: "put",
			data: JSON.stringify(cmtObj),
			contentType: "application/json; charset=utf-8",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token);
			}
		}).done(function(result) {
			list_comment(rno_val,1);
		}).fail(function(err) {
			console.log(err);
			alert("댓글 수정 실패!");
		}).always(function() { // 추가
			$(document).find("button.close").click();
		});
	}
	function remove_comment(cno){
		let rno_val = $("#rnoVal").text();
		let header=$("meta[name='_csrf_header']").attr("content");
		let token=$("meta[name='_csrf']").attr("content");
		$.ajax({
			url: "/comment/"+cno,
			type: "delete",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token);
			}
		}).done(function(result) {
			list_comment(rno_val,1);
		}).fail(function(err) {
			alert("댓글 삭제 실패~");
			console.log(err);
		});
	}
	$(document).on("click", "#pgn li a", function(e){
		e.preventDefault();
		list_comment($("#rnoVal").text(), $(this).attr("href"),
				$("#cmtrange option:selected").val(), $("#cmtkeyword").val());
	});
	function print_pagination(prev, fpgi, pgi, lpgi, next){
		let pgn ='';
		if(prev){
			pgn += '<li class="page-item"><a class="page-link" href="'+(fpgi-1)+'">Prev</a></li>';
		}
		for (let i = fpgi; i <= lpgi; i++) {
			let classActive = pgi == i ? 'active' : '';
			pgn += '<li class="page-item '+classActive+'"><a class="page-link" href="'+i+'">'+i+'</a></li>';
		}
		if(next){
			pgn += '<li class="page-item"><a class="page-link" href="'+(lpgi+1)+'">Next</a></li>';
		}
		$("#pgn").html(pgn);
	}
	function make_paging(totalCount, pageIndex){
		let lastPageIndex = Math.ceil(pageIndex / 10.0) * 10;
		let firstPageIndex =lastPageIndex - 9;
		let prev = firstPageIndex != 1;
		let next = false;
		
		if(lastPageIndex * 10 >= totalCount){
			lastPageIndex = Math.ceil(totalCount / 10.0);
		}else {
			next = true;
		}
		console.log(prev+"/"+firstPageIndex+"/"+pageIndex+"/"+lastPageIndex+"/"+next);
		print_pagination(prev, firstPageIndex, pageIndex, lastPageIndex, next);
	}
	function print_list(cmt_dto, pageIndex){
		
		if(cmt_dto.cmtlist.length==0){
			$("#accordion").empty();
			$("#accordion").html("<h5 style='margin-left:15px;'>댓글이 없습니다.</h5>");
			return;
		}else{
			let listZone = $("#accordion");
			listZone.empty();
			let ses_memberID = '<c:out value="${ses_memberID}"/>';
			console.log("ses_memberID"+ses_memberID);
			for (let cvo of cmt_dto.cmtlist) {
			    let card = '  <li class="single_comment_area" style="list-style:none;">'
			    	card += '<div class="comment-wrapper d-flex">';
			    	card += '	<div class="comment-author" style="width:100px; margin-right:30px;">';
			    	card += '	<span class="comment-date text-muted">'+cvo.cmtdate+'</span><h5 class="comment-writer">'+cvo.writer+'</h5></div>';
			    	card += '	<div class="comment-content flex-fill">';
			    	card += '	<p class="cmtContent">'+cvo.cmt+'</p></div>';
			    if(cvo.writer.trim() == ses_memberID){
			    	console.log("check");
			    	card += '		<div> ';
					card += '		<i class="fa fa-wrench" data-toggle="modal" data-target="#modModal"';
			    	card += ' style="color:#7fad39; padding:3px; " data-cno="' + cvo.cno + '"></i>';
			    	card += ' <i class="fa fa-remove" style="color:red; font-size:20px; padding:3px;" data-cno="' + cvo.cno + '"></i></div>';
			    }
			    card += '</div></li>';
			    listZone.append(card);
			}
			$(".cmt_regdate").css("margin-right", "30px");
			make_paging(cmt_dto.totalCount, pageIndex);			
		}
	}
	function list_comment(rno, pgIdx, r="", kw="") {
		console.log("pgIdx : " + pgIdx);
		let pageIndex = pgIdx < 1 ? 1 : pgIdx;
		let url_val = (r=="" || kw=="") ? "/comment/rno/" + rno+ "/" + pageIndex + ".json"
				: "/comment/rno/" + rno + "/" + pageIndex + "/" + r +"/"+ kw + ".json";
		$.getJSON(url_val, function(result) {
			console.log(result.totalCount);
			print_list(result, pageIndex);
		}).fail(function(err) {
			console.log(err);
			alert("댓글 리스트 로딩 실패!");
		});
	}
	function write_comment() {
		let rno_val = $("#rnoVal").text();
		let content_val = $("#cmtInput").val();
		let memberID_val ='<c:out value="${ses_memberID}"/>';
		let review_title ='<c:out value="${rvo.title}"/>';
		let writer_val ='<c:out value="${rvo.memberID}"/>';
		let header=$("meta[name='_csrf_header']").attr("content");
		let token=$("meta[name='_csrf']").attr("content");
		if(content_val == null || content_val == ''){
			alert("댓글 내용을 입력하세요!");
			return false;
		}else{
			let cmt_data ={
				rno: rno_val,
				writer: memberID_val,
				cmt: content_val
			};
			$.ajax({
				url: "/comment/register",
				type: "post",
				data: JSON.stringify(cmt_data),
				contentType: "application/json; charset=utf-8",
				beforeSend: function(xhr){
					xhr.setRequestHeader(header,token);
				}
			}).done(function(result) {
				list_comment(rno_val,1);
				socket.send("comment,"+memberID_val+","+writer_val+","+review_title+","+rno_val);
				 connectWs();
			}).fail(function(err) {
				console.log(err);
			}).always(function() {
				$("#cmtInput").val("");
			});
		}
	}
</script>
<script>
	$(document).on("click", "#cmtsearchBtn", function(){
		let rno_val = $("#rnoVal").text();
		let range_val = $("#cmtrange option:selected").val();
		let kw_val = $("#cmtkeyword").val();
		list_comment(rno_val, 1, range_val, kw_val);
	});
	$(document).on("click", "#cmtSubmit", write_comment);
	$(document).on("click", ".fa-remove", function() {
		let cno_val = $(this).data("cno");
		remove_comment(cno_val);
	});
	// 추가된 부분 시작
	$(document).on("click", ".fa-wrench", function() {		
		let cno_val = $(this).data("cno");
		let writer=$(this).closest("li").find(".comment-writer").html();
		let content_val = $(this).closest("li").find(".cmtContent").text();		
		$(document).find(".modal-title").val(cno_val);
		$(document).find(".modal-writer").text(writer);
		$(document).find("#cmtText").val(content_val);
	});
	$(document).on("click", ".modal-footer > .modBtn", function() {
		let cmt_content_val = $(document).find("#cmtText").val();
		let temp_text = $(document).find(".modal-title").text();
		let cno_val = $(".modal-title").val();
		let cmt_obj = {cno: cno_val, cmt: cmt_content_val};
		modify_comment(cmt_obj);
	});
	// 추가된 부분 끝
	
	
	$(function() {
		list_comment($("#rnoVal").text(), 1);
	});
	
	$(function(){
		islike();
	});
</script>
					</div>
				</div>
			</section>
			<!-- Related Product Section Begin -->
	<c:choose>
	<c:when test="${r_list.size() ne 0}">
	
		
    <section class="related-product">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related__product__title">
                        <h2>작성자의 다른리뷰</h2>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
            	<c:forEach items="${r_list }" var="rrvo">
                <div class="col-lg-3 col-md-4 col-sm-6 ">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${rrvo.cover }" OnClick="location.href ='/review/detail?rno=${rrvo.rno}'" style="cursor:pointer; ">
                            <ul class="product__item__pic__hover">
                               <c:choose>
                                	<c:when test="${rrvo.likey > 99 }">
                                		<c:set var = "string1" value = "${rrvo.likey }"/>
          								<c:set var = "string2" value = "${fn:substring(string1, 0,1)}" />
                                	 <li><a href="#"><i class="fa fa-heart" style="color:red"></i>${string2}h</a></li>
                                	</c:when>
                                	<c:otherwise>
                               		  <li><a href="#"><i class="fa fa-heart" style="color:red"></i>${rrvo.likey }</a></li>
                                	</c:otherwise>
                                </c:choose>
                                <c:choose>
                                	<c:when test="${rrvo.readCount > 99 }">
                                		<c:set var = "string1" value = "${rrvo.readCount }"/>
          								<c:set var = "string2" value = "${fn:substring(string1, 0,1)}" />
                                	<li><a href="#"><i class="far fa-eye" style="color:#7fad39"></i>${string2}h</a></li>
                                	</c:when>
                                	<c:otherwise>
                               		 <li><a href="#"><i class="far fa-eye" style="color:#7fad39"></i>${rrvo.readCount }</a></li>
                                	</c:otherwise>
                                </c:choose>
                                <li><a href="#"><i class="fa fa-star" style="color:#e3d222"></i>${rrvo.recommend }</a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="#">${rrvo.bname }</a></h6>
                            <h5>${rrvo.title }</h5>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    </c:when>
	</c:choose>	
    <!-- Related Product Section End -->
		</c:when>
	</c:choose>
</sec:authorize>

<!--비로그인시  -->
<sec:authorize access="isAnonymous()">
<script>
$(document).on("click", ".goIndex", function() {	
		location.href="/";
	});
</script>
			<section class="product-details spad">
				<div class="container">
					<div class="row justify-content-center" >
						<div class="col-lg-6 col-md-6">
							<div class="product__details__pic">
								<div class="product__details__pic__item">
									<img class="product__details__pic__item--large"
										src="${rvo.cover }" alt=""  style="max-width: 400px ;  max-height: 560px; margin:50px auto; object-fit:contain;" >
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-md-6">
							<div class="product__details__text">
								<h3>${rvo.title }</h3>
								<h5>${rvo.bname }</h5>
								<c:choose>
									<c:when test="${rvo.recommend eq 5 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 4 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 3 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 2 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
												class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 1 }">
										<div class="product__details__rating">
											<i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
									<c:when test="${rvo.recommend eq 0 }">
										<div class="product__details__rating">
											<i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i
												class="fa fa-star-o"></i>
										</div>
									</c:when>
								</c:choose>
								<div class="blog__details__author">
									<div class="blog__details__author__pic">
										<c:choose>
										<c:when test="${fvo.ftype > 0 }">
										<img src="/upload/${fvo.savedir}/${fvo.uuid}_th_${fvo.fname}"
											alt="">
										</c:when>
										<c:otherwise>
										<img src="/resources/images/member/person.png"
											alt="">
										</c:otherwise>
									</c:choose>
									</div>
									<div class="blog__details__author__text">
										<span style="font-size: 36px;">${rvo.memberID }</span>
									<button class="my-transparent-button float-right" type="button" data-toggle="modal" data-target="#login-modal" ><i class="fa fa-user"></i>Login</button>
									</div>
								</div>
								<p>${rvo.content }</p>
								<div class="product__details__quantity" style="height: 30px;">
										<c:if test="${ses_memberID eq rvo.memberID }">
											<a
												href="/review/modify?rno=${rvo.rno }&pageIndex=${pgvo.pageIndex}&countPerPage=${pgvo.countPerPage}&range=${pgvo.range}&keyword=${pgvo.keyword}"
												class="btn btn-outline-warning">수정</a>
												
											<button type="button" class="btn btn-outline-danger"
												id="delBtn">삭제</button>

											<form action="/review/remove" id="delForm" method="post">
											<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
												<input type="hidden" name="rno" value="${rvo.rno }">
												<input type="hidden" name="pageIndex"
													value="${pgvo.pageIndex }"> <input type="hidden"
													name="countPerPage" value="${pgvo.countPerPage }">
												<input type="hidden" name="range" value="${pgvo.range }">
												<input type="hidden" name="keyword" value="${pgvo.keyword }">
											</form>
											<script>
												$("#delBtn").on("click", function() {
														$("#delForm").submit();
												});
											</script>
										</c:if>
									</div>
									<button type="button" class="float-right" id="likeList"
										data-toggle="modal" data-target="#likeModal"
										data-rno="${rvo.rno }">좋아요목록</button>
								<ul>
									<li><b>조회수</b> <span>${rvo.readCount }</span></li>
									<li><b>좋아요 수</b> <span id="likeyNo">${rvo.likey } </span></li>
									<li><b>리뷰 번호</b> <span id="rnoVal">${rvo.rno }</span></li>
								</ul>
							</div>
						</div>
						<!-- 좋아요 리스트 -->
						<script>
	
	function print_list_like(likelist){
		if(likelist.length==0){
			let listZone = $("#likeModalList");
			listZone.empty();
			let card = '<tr><td colspan="2" style="padding-right:15px;text-align:center;">좋아요</td><td style="text-align:center;">목록없음</td></tr>';
		    listZone.append(card);
		}else{
			let listZone = $("#likeModalList");
			listZone.empty();
			for (let lvo of likelist) {
				let card = '<tr><td style="padding-right:15px;text-align:center;">'+lvo.memberId+'</td><td style="padding-right:15px;"></td>';
				card += '<td style="text-align:center;">'+lvo.memberNickname+'</td></tr>';
			    listZone.append(card);
			}			
		}
	}
	function list_like (rno) {
		$.getJSON("/like/rno/"+ rno+ ".json", function(result) {
			console.log(result);
			print_list_like(result);
		}).fail(function(err) {
			console.log(err);
			alert("좋아요 리스트 로딩 실패!");
		});
	}
	
	$("#likeList").on("click",function(){
		list_like($("#rnoVal").text());
	});
	</script>
						<div class="modal fade" id="likeModal">
							<div class="modal-dialog  modal-dialog-centered " style="width:230px;"
								id="likeModalSize">
								<div class="modal-content" style="border-radius: 25px;">
									<!-- Modal Header -->
									<div class="modal-header" style="background: #ffffff ;border-radius: 25px;">
										<h4 class="modal-title" style="font-weight: 800;">좋아요 리스트</h4>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>
									<!-- Modal body -->
									<div class="modal-body"
										style="overflow-y: scroll; max-height: 350px;">
										<table class="">
											<thead>
												<tr>
													<th style="text-align: center; padding-right:15px;font-weight:bold;">ID</th>
													<th style="padding-right:15px;"></th>
													<th style="text-align: center; font-weight:bold;">이름</th>
												</tr>
											</thead>
											<tbody id="likeModalList">

											</tbody>
										</table>

									</div>
									<!-- Modal footer -->
									<div class="modal-footer">
										<button type="button" class="site-btn" data-dismiss="modal" style="margin: auto;">확인</button>
									</div>
								</div>
							</div>
						</div>
						<!-- Modal End -->

				<!-- Ajax Comment Part -->
				<div class="col-lg-12 col-md-12 m-5" id="list">
					<h2 style="padding-bottom: 10px;">Comments</h2>
					<hr>
					<div id="accordion" style="clear: both;"></div>
					<ul class="pagination justify-content-center pagination-sm mt-2"
						id="pgn"></ul>

					<!-- 추가된 부분 The Modal -->
					<div class="modal fade" id="modModal">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<!-- Modal Header -->
								<div class="modal-header">
									<input class="modal-title" type="hidden"> <span
										class="modal-writer"></span>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>
								<!-- Modal body -->
								<div class="modal-body">
									<textarea class="form-control" rows="5" id="cmtText"></textarea>
								</div>
								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-warning modBtn"
										style="background-color: #7fad39; border: none; color: white;">수정</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Modal End -->
				<script>

	$(document).on("click", "#pgn li a", function(e){
		e.preventDefault();
		list_comment($("#rnoVal").text(), $(this).attr("href"),
				$("#cmtrange option:selected").val(), $("#cmtkeyword").val());
	});
	function print_pagination(prev, fpgi, pgi, lpgi, next){
		let pgn ='';
		if(prev){
			pgn += '<li class="page-item"><a class="page-link" href="'+(fpgi-1)+'">Prev</a></li>';
		}
		for (let i = fpgi; i <= lpgi; i++) {
			let classActive = pgi == i ? 'active' : '';
			pgn += '<li class="page-item '+classActive+'"><a class="page-link" href="'+i+'">'+i+'</a></li>';
		}
		if(next){
			pgn += '<li class="page-item"><a class="page-link" href="'+(lpgi+1)+'">Next</a></li>';
		}
		$("#pgn").html(pgn);
	}
	function make_paging(totalCount, pageIndex){
		let lastPageIndex = Math.ceil(pageIndex / 10.0) * 10;
		let firstPageIndex =lastPageIndex - 9;
		let prev = firstPageIndex != 1;
		let next = false;
		
		if(lastPageIndex * 10 >= totalCount){
			lastPageIndex = Math.ceil(totalCount / 10.0);
		}else {
			next = true;
		}
		console.log(prev+"/"+firstPageIndex+"/"+pageIndex+"/"+lastPageIndex+"/"+next);
		print_pagination(prev, firstPageIndex, pageIndex, lastPageIndex, next);
	}
	function print_list(cmt_dto, pageIndex){
		
		if(cmt_dto.cmtlist.length==0){
			$("#accordion").empty();
			$("#accordion").html("<h5 style='margin-left:15px;'>댓글이 없습니다.</h5>");
			return;
		}else{
			let listZone = $("#accordion");
			listZone.empty();
			
			for (let cvo of cmt_dto.cmtlist) {
			    let card = '  <li class="single_comment_area" style="list-style:none;">'
			    	card += '<div class="comment-wrapper d-flex">';
			    	card += '	<div class="comment-author" style="width:100px; margin-right:30px;">';
			    	card += '	<span class="comment-date text-muted">'+cvo.cmtdate+'</span><h5 class="comment-writer">'+cvo.writer+'</h5></div>';
			    	card += '	<div class="comment-content flex-fill">';
			    	card += '	<p class="cmtContent">'+cvo.cmt+'</p></div>';
			   	 	card += '</div></li>';
			    listZone.append(card);
			}
			$(".cmt_regdate").css("margin-right", "30px");
			make_paging(cmt_dto.totalCount, pageIndex);			
		}
	}
	function list_comment(rno, pgIdx, r="", kw="") {
		console.log("pgIdx : " + pgIdx);
		let pageIndex = pgIdx < 1 ? 1 : pgIdx;
		let url_val = (r=="" || kw=="") ? "/comment/rno/" + rno+ "/" + pageIndex + ".json"
				: "/comment/rno/" + rno + "/" + pageIndex + "/" + r +"/"+ kw + ".json";
		$.getJSON(url_val, function(result) {
			console.log(result.totalCount);
			print_list(result, pageIndex);
		}).fail(function(err) {
			console.log(err);
			alert("댓글 리스트 로딩 실패!");
		});
	}
	
</script>
<script>
	$(document).on("click", "#cmtsearchBtn", function(){
		let rno_val = $("#rnoVal").text();
		let range_val = $("#cmtrange option:selected").val();
		let kw_val = $("#cmtkeyword").val();
		list_comment(rno_val, 1, range_val, kw_val);
	});
	
	$(function() {
		list_comment($("#rnoVal").text(), 1);
		islike();
	});
</script>
		</div>
	</div>
</section>
<!-- Related Product Section Begin -->
	<c:choose>
	<c:when test="${r_list.size() ne 0}">
	
		
    <section class="related-product">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related__product__title">
                        <h2>작성자의 다른리뷰</h2>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
            	<c:forEach items="${r_list }" var="rrvo">
                <div class="col-lg-3 col-md-4 col-sm-6 ">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${rrvo.cover }" OnClick="location.href ='/review/detail?rno=${rrvo.rno}'" style="cursor:pointer; ">
                            <ul class="product__item__pic__hover">
                            	 <c:choose>
                                	<c:when test="${rrvo.likey > 99 }">
                                		<c:set var = "string1" value = "${rrvo.likey }"/>
          								<c:set var = "string2" value = "${fn:substring(string1, 0,1)}" />
                                	 <li><a href="#"><i class="fa fa-heart" style="color:red"></i>${string2}h</a></li>
                                	</c:when>
                                	<c:otherwise>
                               		  <li><a href="#"><i class="fa fa-heart" style="color:red"></i>${rrvo.likey }</a></li>
                                	</c:otherwise>
                                </c:choose>
                            
                                 <c:choose>
                                	<c:when test="${rrvo.readCount > 99 }">
                                		<c:set var = "string1" value = "${rrvo.readCount }"/>
          								<c:set var = "string2" value = "${fn:substring(string1, 0,1)}" />
                                	<li><a href="#"><i class="far fa-eye" style="color:#7fad39"></i>${string2}h</a></li>
                                	</c:when>
                                	<c:otherwise>
                               		 <li><a href="#"><i class="far fa-eye" style="color:#7fad39"></i>${rrvo.readCount }</a></li>
                                	</c:otherwise>
                                </c:choose>
                                <li><a href="#"><i class="fa fa-star" style="color:#e3d222"></i>${rrvo.recommend }</a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="#">${rrvo.bname }</a></h6>
                            <h5>${rrvo.title }</h5>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    </c:when>
	</c:choose>	
    <!-- Related Product Section End -->
</sec:authorize>
<jsp:include page="../common/footer.jsp" />
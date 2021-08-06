<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
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
	<c:choose>
		<c:when test="${ses_memberID ne null && ses_memberID ne '' }">
			<!-- Breadcrumb Section Begin -->
			<section class="breadcrumb-section set-bg"
				data-setbg="/resources/img/book-diary-bookmark.jpg"
				style="background-color: green; ">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-center">
							<div class="breadcrumb__text">
								<h2>Shopping Cart</h2>
								<div class="breadcrumb__option">
									<a href="/">Home</a> <span>����, �ɼ� �� ������ ����� ��� �ֹ��� �Ұ��� ��
										�ֽ��ϴ�.</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- Breadcrumb Section End -->
			<section class="shoping-cart spad">
				<div class="container"">
					<input type="hidden" id="nowUser" name="memberID"
						value="${ses_memberID }">
					<!-- ���� value�� ���̵� ������ �� -->
					<table class="table table-hover">
						<thead class="thead-light">
							<tr>
								<th >��������</th>
								<th></th>
								<th>����</th>
								<th>����</th>
								<th>�� �ݾ�</th>
								<th>���</th>
							</tr>
						</thead>
						<tbody id="cartList">
						</tbody>
					</table>
					<hr>
					
					<div class="row">
						<div class="col-lg-3"></div>
						<div class="col-lg-6">
							<div class="shoping__checkout">
								<h5>Cart Total</h5>
								<ul>
									<li>Total <span id="totalBook"></span></li>
								</ul>
								<form action="/cart/cartorder" method="post">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
									<input type="hidden" name="price" value=""> <input
										type="hidden" name="mid" value="${ses_memberID }">
										<div style="margin: auto; text-align: center;">
											<a class="btn cart-btn" href="javascript:history.back();" style="background-color: white; border: 1px solid #7fad39; color:green;">���� ����ϱ�</a>
											<button class="btn" id="orderBtn" style="margin: 0; background-color: #7fad39;color:white;">�ֹ��ϱ�</button>
										</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</section>


		</c:when>
		<c:otherwise>
			<script>
				alert("�α����� �ʿ��� �������Դϴ�.")
				location.replace("/");
			</script>
		</c:otherwise>
	</c:choose>
</sec:authorize>
	<script>
		$(".menu-first li").removeClass("active");
		$(".menu-first li:nth-child(5)").addClass("active");
		$(function() {
			list_cart();
		});
		$(document).on("click", ".fa-remove", function() {
			let cartno_val = $(this).data("cartno");
			remove_cart(cartno_val);
		});
		$(document).on("click", ".qtyUp", function() {
			let cartno_val = $(this).data("cartno");
			let qty_val = $("input[name=qty" + cartno_val + "]").val();
			let mileage = $(this).data("mileage") / qty_val;
			updateQty(cartno_val, mileage, 1);
		});
		$(document).on("click", ".qtyDown", function() {
			let cartno_val = $(this).data("cartno");
			let qty_val = $("input[name=qty" + cartno_val + "]").val();
			let mileage = $(this).data("mileage") / qty_val;
			console.log(qty_val);
			if (qty_val == 1) {
				if (confirm("�ش� ������ ��ٱ��Ͽ��� �����Ͻðڽ��ϱ�?") == true) {
					remove_cart(cartno_val);
				} else {
					list_cart();
				}
			} else {
				updateQty(cartno_val, -mileage, -1);
			}
		});

		function updateQty(cartno, mileage, num) {
			let header = $("meta[name='_csrf_header']").attr("content");
			let token =  $("meta[name='_csrf']").attr("content");
			$.ajax({
				url : "/cart/mod",
				type : "post",
				data : {
					cartno : cartno,
					mileage : mileage,
					qty : num
				},
				beforeSend: function(xhr){
					xhr.setRequestHeader(header, token);
				}
			}).done(function(result) {
				list_cart();
			});
		}

		function list_cart() {
			let mid = $("#nowUser").val();
			let header = $("meta[name='_csrf_header']").attr("content");
			let token =  $("meta[name='_csrf']").attr("content");
			$.ajax({
						url : "/cart/list",
						type : "post",
						data : {
							memberID : mid
						},
						beforeSend: function(xhr){
							xhr.setRequestHeader(header, token);
						},
						dataType : "json"
					})
					.done(
							function(result) {
								let inbody = "";
								let totalPrice = 0;
								if (result.length == 0) {
									$("#orderBtn").attr('type', 'button');
									inbody += '<td colspan="6" style="text-align:center; font-size:32px;">��ٱ��Ͽ� ���� ������ �����ϴ�.</td>'
								} else {
									for (var i = 0; i < result.length; i++) {
										inbody += '<tr>'
										inbody += '    <td ><img src="'+result[i].cover+'"></td><td style="vertical-align: middle;">'
												+ result[i].bname
												+ '</td><td style="vertical-align: middle;">'
												+ result[i].price + '��</td>'
										inbody += '       <td style="vertical-align: middle;"><button class="btn-xs btn-default qtyDown" data-cartno="'+result[i].cartno+'" data-mileage="'+result[i].mileage+'">-</button>';
										inbody += '<input type="text" name="qty'+result[i].cartno+'" value="'+result[i].qty+'" style="width:42px; border:none;" readonly>'
										inbody += ' <button class="btn-xs btn-default qtyUp" data-cartno="'+result[i].cartno+'" data-mileage="'+result[i].mileage+'">+</button></td>'
										inbody += '     <td style="vertical-align: middle;">'
												+ (result[i].price * result[i].qty)
												+ '��</td>   '
										inbody += '      <td style="vertical-align: middle;"><i class="fa fa-remove" style="font-size:24px" data-cartno="'+result[i].cartno+'"></i></td>'
										inbody += '    </tr>'
										totalPrice += Number(result[i].price)
												* Number(result[i].qty);
									}
									$("input[name='price']").val(totalPrice);
									$("#orderBtn").attr('type', "submit");
								}
								$("#cartList").html(inbody);
								totalPrice += "��";
								$("#totalBook").text(totalPrice);
							});
		}

		function remove_cart(cartno) {
			let header = $("meta[name='_csrf_header']").attr("content");
			let token =  $("meta[name='_csrf']").attr("content");
			$.ajax({
				url : "/cart/" + cartno,
				type : "delete",
				beforeSend: function(xhr){
					xhr.setRequestHeader(header, token);
				}
			}).done(function(result) {
				alert("��ٱ��� ���� ����");
				list_cart();
				cartCount();
			});
		}
	</script>
	<jsp:include page="../common/footer.jsp" />
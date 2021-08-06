<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<style>
tr > td > img{
   width: 100px;
   display: inline-block;
   margin-right: 25px;
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
               <h2>Follower List</h2>
               <div class="breadcrumb__option">
                  <a href="/">Home</a> <span>Subscribe List</span>
               </div>
            </div>
         </div>
      </div>
   </div>
</section>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.memberID" var="ses_memberID" />
   <sec:authentication property="principal.mno" var="ses_mno" />
   <c:choose>
      <c:when test="${ses_mno eq s_list[0].receiveNo }">
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
         },beforeSend: function(xhr){
            xhr.setRequestHeader(header,token);
         }
      }).done(function(result) {
         abc=result;
         
      });
      return abc;
   }
   
   $(document).on("click", ".subBtn", function() {   
      let rmID_val = $(this).data("mid");
      let sendno = $(this).data("sendno");
      console.log("rmID_val 체크"+rmID_val);
      let smID_val = '<c:out value="${ses_memberID}"/>';
      console.log("smID_val 체크"+smID_val);
      let followerNum_val =Number($("#"+sendno).text());
      let header=$("meta[name='_csrf_header']").attr("content");
      let token=$("meta[name='_csrf']").attr("content");
      $.ajax({
         url:"/member/subscribe",
         type: "post",
         data : {
            smID : smID_val,
            rmID : rmID_val
         },beforeSend: function(xhr){
            xhr.setRequestHeader(header,token);
         }
      }).done(function(result){
         console.log("result" + result);
         if(parseInt(result)==1){
            
            $("#"+sendno).text(1+followerNum_val);
            $("#"+rmID_val).attr("class","fa fa-toggle-on my-transparent-button subBtn");
            $("#"+rmID_val).css("visibility","visible");
         }else if(parseInt(result)==2){
           
            $("#"+sendno).text(followerNum_val-1);
            $("#"+rmID_val).attr("class","fa fa-toggle-off my-transparent-button subBtn");
            $("#"+rmID_val).css("visibility","visible");
         }else if(parseInt(result)==3){
            
         }else{
            alert("구독오류");
         }
         print_btn();
      });
   });
   
   $(document).on("click", ".goIndex", function() {   
      location.href="/";
   });
</script>

<section class="shoping-cart spad" style="margin-top:30px;">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="shoping__cart__table">
               <table>
                  <thead>
                     <tr>
                        <th>팔로워 아이디</th>
                        <th>팔로워 프로필사진</th>
                        <th>팔로워 이름</th>
                        <th>팔로잉 수</th>
                        <th>팔로워 수</th>
                        <th>팔로잉 기능</th>
                        <th>위시리스트</th>
                     </tr>
                  </thead>
                  <c:choose>
                      <c:when test="${s_list.size() ne 0 }">
                     <tbody>
                        <c:forEach items="${s_list }" var="mvo">
                        <tr>
                        <td><a href="/review/myList?memberID=${mvo.sendId}">${mvo.sendId }</a></td>
                              <c:choose>
                                 <c:when test="${mvo.fvo.ftype > 0 }">
                                    <td><img
                                       src="/upload/${mvo.fvo.savedir}/${mvo.fvo.uuid}_th_${mvo.fvo.fname}"
                                       alt="이미지없음" width="100" height="100"></td>
                                 </c:when>
                                 <c:otherwise>
                                    <td><img src="/resources/images/member/person.png"
                                          alt="기본이미지" width="100" height="100"></td>
                                 </c:otherwise>
                              </c:choose>

                     <td>${mvo.sendNickname }</td>
                     <td>${mvo.sendFollowingNum }</td>
                     <td id="${mvo.sendNo }" class="fn">${mvo.sendFollowerNum }</td>
            
            <td><button type="button" id="${mvo.sendId }"  data-sendno="${mvo.sendNo }" data-mid=${mvo.sendId } class="subBtn" style="visibility: hidden;font-size: 36px;color:#7fad39;" ></button></td>
         
            <td><a href="/wish/wishList?mno=${mvo.sendNo }" class="fas fa-gift" style="font-size: 36px;color:#7fad39;"></a></td>
            <script>
            
         
            function print_btn(){
               let smID_val = '<c:out value="${ses_memberID}"/>';
               console.log(smID_val);
               let rmID_val='';
               rmID_val='<c:out value="${mvo.sendId}"/>';
                     console.log("rmID_val"+rmID_val);
                     abc =isSubscribe(smID_val,rmID_val);
                     console.log("abc "+ abc);
                     console.log("abc type" + typeof abc);
                      if(parseInt(abc)==1){
                           
                           $("#"+rmID_val).attr("class","fa fa-toggle-off my-transparent-button subBtn");
                           $("#"+rmID_val).css("visibility","visible");
                     }else if(parseInt(abc)==2){
                           
                           $("#"+rmID_val).attr("class","fa fa-toggle-on my-transparent-button subBtn");
                           $("#"+rmID_val).css("visibility","visible");
                     }else if(parseInt(abc)==3){
                        
                     }else{
                        $("#"+rmID_val).html("로그인 필요")
                        $("#"+rmID_val).attr("class","site-btn goIndex");
                        $("#"+rmID_val).css("visibility","visible");
                     }
                     
                  
            }
            </script>
            <script> print_btn() </script>
            
         </tr>
      </c:forEach>
   </tbody>
      </c:when>
       <c:otherwise>
          <tbody>
             <tr>
                
                <td colspan="7" class="text-center">
                   <h2>구독을 누른 사람이 없습니다!</h2>
                </td>
             </tr>
          </tbody>
       </c:otherwise>
    </c:choose>
    </table>
                  
</div>
</div>
</div>
</div>
</section>
</c:when>
<c:otherwise>
<section class="shoping-cart spad" style="margin-top:30px;">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="shoping__cart__table">
               <table>
                  <thead>
                     <tr>
                        <th>팔로잉 아이디</th>
                        <th>팔로잉 프로필사진</th>
                        <th>팔로잉 이름</th>
                        <th>팔로잉 수</th>
                        <th>팔로워 수</th>
                        <th>위시리스트</th>
                     </tr>
                  </thead>
                  <c:choose>
                      <c:when test="${s_list.size() ne 0 }">
                     <tbody>
                        <c:forEach items="${s_list }" var="mvo">
                        <tr>
                        <td><a href="/review/myList?memberID=${mvo.sendId}">${mvo.sendId }</a></td>
                        
            
                              <c:choose>
                                 <c:when test="${mvo.fvo.ftype > 0 }">
                                    <td><img
                                       src="/upload/${mvo.fvo.savedir}/${mvo.fvo.uuid}_th_${mvo.fvo.fname}"
                                       alt="이미지없음" width="100" height="100"></td>
                                 </c:when>
                                 <c:otherwise>
                                    <td><img src="/resources/images/member/person.png"
                                          alt="기본이미지" width="100" height="100"></td>
                                 </c:otherwise>
                              </c:choose>

                     <td>${mvo.sendNickname }</td>
                     <td>${mvo.sendFollowingNum }</td>
                     <td id=followerNum>${mvo.sendFollowerNum }</td>
            
         
            <td><a href="/wish/wishList?mno=${mvo.sendNo }" class="fas fa-gift" style="font-size: 36px;color:#7fad39;"></a></td>
            
         </tr>
      </c:forEach>
   </tbody>
      </c:when>
       <c:otherwise>
          <tbody>
             <tr>
                
                <td colspan="6" class="text-center">
                   <h2>구독을 누른 사람이 없습니다!</h2>
                </td>
             </tr>
          </tbody>
       </c:otherwise>
    </c:choose>
    </table>
</div>
</div>
</div>               
</div>
</section>


</c:otherwise>
</c:choose>
</sec:authorize>
<sec:authorize access="isAnonymous()">
<script>
      alert("로그인이 필요한 페이지입니다.")
      location.replace("/");
</script>
</sec:authorize>

<jsp:include page="../common/footer.jsp" />
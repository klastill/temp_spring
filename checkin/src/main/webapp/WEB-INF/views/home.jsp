<%@page import="com.myweb.domain.BookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.myweb.api.BookListApi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />
<%
   int pageNo = 1;
// api 호출
BookListApi bla = new BookListApi();
JsonArray array = bla.bestArray("bestList", pageNo);
List<BookVO> temp = bla.makeBookList(array);
List<BookVO> list = new ArrayList<>();
for (int i = 0; i < temp.size(); i++) {
   list.add(temp.get(i));
}
request.setAttribute("list", list);
if (pageNo == 1) {
   List<BookVO> best = new ArrayList<>();
   for (int i = 0; i < 3; i++) {
      best.add(temp.get(i));
   }
   request.setAttribute("best", best);
}
%>
<style>
.service-item {
   background-repeat: no-repeat;
   background-position: center;
   background-size: cover;
}
.service-content:hover {
   background-color: #c2db9c;
   background-image: none;
}
.portfolio-item .portfolio-thumb .portfolio-overlay{
   background-color: lightgray;
}
.team-member .member-thumb .team-overlay{
   background-color: #c2db9c;
   animation: scale1 2s;
}
.portfolio-item .portfolio-thumb .portfolio-overlay h3{
   color: green;
   font-family: 'EliceDigitalBaeum_Regular';
}
 .portfolio-overlay >p{
   overflow: hidden;
   text-overflow: ellipsis;
   display:-webkit-box;
   line-height:1.7em;
   -webkit-line-clamp: 8;
   -webkit-box-orient: vertical;
   margin-bottom: 5px;
}
.inner-service>p{
   overflow: hidden;
   text-overflow: ellipsis;
   display:-webkit-box;
   -webkit-line-clamp:10;
   -webkit-box-orient: vertical;
}
.inner-service > a{
   overflow: hidden;
   text-overflow: ellipsis;
   display:-webkit-box;
   -webkit-line-clamp:2;
   -webkit-box-orient: vertical;
}
.service-icon, .service-item{
   	min-height: 372px;
   	width: 100%;
}
  .portfolio-item .portfolio-thumb img {
  	width: 100%;
 	min-height: 372px;
  	object-fit: contain;
}
	
@media screen and (max-width: 1199px){
    .portfolio-overlay >p{
    margin-bottom:0px;
    font-size:14px;
   overflow: hidden;
   text-overflow: ellipsis;
   display:-webkit-box;
   -webkit-line-clamp: 7;
   -webkit-box-orient: vertical;
   }
   .service-icon, .service-item{
   	min-height: 350px;
   }
   .inner-service>p{
   overflow: hidden;
   text-overflow: ellipsis;
   display:-webkit-box;
   -webkit-line-clamp:9;
   -webkit-box-orient: vertical;
	}
	.service-content{
		max-height: 350px;
	}
	   .portfolio-item .portfolio-thumb img {
 		 width: 100%;
 		 min-height: 300px;
 		 object-fit: contain;
	}
}
@keyframes appear {
    from {transform: scale(0)}
    to {transform: scale(1)}
}
@keyframes disappear {
    from {transform: scale(1)}
    to {transform: scale(0)}
}
.appearAni{
   animation-name: appear; 
    animation-duration: 0.5s;
    animation-timing-function: linear;
   animation-fill-mode:forwards;
}
.disappearAni{
   animation-name: disappear; 
    animation-duration: 0.5s;
    animation-timing-function: linear;
   animation-fill-mode:forwards;
   
}
</style>

<div class="content-section" id="services">
   <div class="container">
      <div class="row">
         <div class="heading-section col-md-12 text-center">
            <h2>BEST SELLER</h2>
            <p>인기 도서들을 확인하세요.</p>
         </div>
         <!-- /.heading-section -->
      </div>
      <!-- /.row -->
      <div class="row">
      <div class="categories__slider owl-carousel">
         <c:forEach items="${list }" var="bvo" varStatus="status" begin="0"
            end="6">
            <div style="width:90%; margin: auto;">
               <div class="service-item" id="service-${status.count }"
                  style=" background-image: url('${bvo.coverImg}'); background-size: contain; background-repeat: no-repeat; background-color:white;">
                  <div class="service-icon" >
                     <i class="fa fa-book"></i>
                  </div>
                  <!-- /.service-icon -->
                  <div class="service-content"
                     style="overflow: hidden;">
                     <div class="inner-service">
                        <a href="book/bookInfo?book_isbn=${bvo.isbn}"
                           style="font-weight: bold; color: black; font-size: 18px;"
                           class="booktitle">${bvo.title}</a>
                        <p style="color: black; margin-top: 12px;">${bvo.description }</p>
                     </div>
                  </div>
                  <!-- /.service-content -->
               </div>
               <!-- /#service-1 -->
            </div>
            <!-- /.col-md-3 -->
         </c:forEach>
      </div>
      </div>
      <!-- /.row -->
   </div>
   <!-- /.container -->
</div>
<!-- /#services -->

<!-- Featured Section Begin -->
<section class="featured spad">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="heading-section col-md-12 text-center">
               <h2>Best Reviews</h2>
               <p>인기 리뷰들을 확인하세요.</p>
            </div>
            <div class="featured__controls">
               <ul>
                  <li class="active" data-filter="">All</li>
                  <li data-filter=".likeRank">좋아요</li>
                  <li data-filter=".starRank">별점</li>
                  <script>
                     $(document).on("click",".featured__controls ul> li",function(){
                           let show_class=$(this).data("filter");
                           console.log(show_class);
                           $(".featured__controls ul li").removeClass("active");
                           $(this).addClass("active");
                           
                           let box= $(".featured__filter> div");
                           box.removeClass("appearAni");
                           box.removeClass("disappearAni");
                           
                            if(show_class==""){
                              $(".featured__filter> div").addClass("disappearAni");
                              setTimeout(function() {
                                 box.css("display","none");
                                 box.removeClass("disappearAni");
                                 box.css("display","inline");
                                 box.addClass("appearAni");
                              },400)
                           }else if(show_class==".likeRank"){
                              $(".featured__filter> div").addClass("disappearAni");
                              setTimeout(function() {
                                 $(".featured__filter> div:not(.likeRank)").css("display","none");
                                 $(".likeRank").removeClass("disappearAni");
                                 $(".likeRank").css("display","inline");
                                 $(".likeRank").addClass("appearAni");
                              }, 400);
                           }else if(show_class==".starRank"){
                              $(".featured__filter> div").addClass("disappearAni");
                              setTimeout(function() {
                                 $(".featured__filter> div:not(.starRank)").css("display","none");
                                 $(".starRank").removeClass("disappearAni");
                                 $(".starRank").css("display","inline");
                                 $(".starRank").addClass("appearAni");
                              }, 400);
                           } 
                     });
                  </script>
               </ul>
            </div>
         </div>
      </div>
      <div class="row featured__filter"></div>
   </div>
</section>
<!-- Featured Section End -->
<script>
            var like_list='${likeList}';
            var recommend_list='${recommendList}';
            let str = like_list.replace(/\n/g,"\\r\\n");
            str= str.replace(/\r/g, " ");
            let parse_data_like=JSON.parse(str); 
            
            let str2=recommend_list.replace(/\n/g,"\\r\\n");
            str2=str2.replace(/\r/g, " ");
            let parse_data_recmd=JSON.parse(str2); 
            let checkDuple={};
            let inbody='';
            
            for (const elem of parse_data_like) {
                  for(const el of parse_data_recmd){
                     if(elem.rno == el.rno){
                        checkDuple[elem.rno]=1;
                     }
                  }
                  console.log(!checkDuple[elem.rno]);
                  if(!checkDuple[elem.rno]){
                     checkDuple[elem.rno]=1;
                     inbody+='   <div class="col-lg-3 col-md-4 col-sm-6 mix likeRank appearAni">'
                        inbody+='<div class="featured__item  portfolio-item ">'
                        inbody+='<div class="portfolio-thumb">'
                        inbody+='   <img src="'+elem.cover+'">'
                        inbody+='      <div class="portfolio-overlay">'
                        inbody+='         <h3>'+elem.title+'</h3>'
                        inbody+='         <p>'+elem.content+'</p>'
                        inbody+='         <a href="/review/detail?rno='+elem.rno+'" data-rel="lightbox"class="expand"> <i class="fa fa-search" style="color:green;"></i>'
                        inbody+='</a></div></div></div></div>';
                  }else{
                     inbody+='   <div class="col-lg-3 col-md-4 col-sm-6 mix likeRank starRank appearAni">'
                        inbody+='<div class="featured__item  portfolio-item ">'
                        inbody+='<div class="portfolio-thumb">'
                        inbody+='   <img src="'+elem.cover+'">'
                        inbody+='      <div class="portfolio-overlay">'
                        inbody+='         <h3>'+elem.title+'</h3>'
                        inbody+='         <p>'+elem.content+'</p>'
                        inbody+='         <a href="/review/detail?rno='+elem.rno+'" data-rel="lightbox"class="expand"> <i class="fa fa-search" style="color:green;"></i>'
                        inbody+='</a></div></div></div></div>';
                  }
            }   
            for(const el of parse_data_recmd){
               if(!checkDuple[el.rno]){
                  inbody+='   <div class="col-lg-3 col-md-4 col-sm-6 mix starRank appearAni">'
                     inbody+='<div class="featured__item  portfolio-item ">'
                     inbody+='<div class="portfolio-thumb">'
                     inbody+='   <img src="'+el.cover+'">'
                     inbody+='      <div class="portfolio-overlay">'
                     inbody+='         <h3>'+el.title+'</h3>'
                     inbody+='         <p>'+el.content+'</p>'
                     inbody+='         <a href="/review/detail?rno='+el.rno+'" data-rel="lightbox"class="expand"> <i class="fa fa-search" style="color:green;"></i>'
                     inbody+='</a></div></div></div></div>';
               }
            }
            $(".featured__filter").html(inbody);
         </script>




<!--인기 팔로워  -->
<div class="content-section" id="our-team">
   <div class="container">
      <div class="row">
         <div class="heading-section col-md-12 text-center">
            <h2>Rank Follower</h2>
            <p>Bookly 랭킹을 확인하세요.</p>
         </div>
         <!-- /.heading-section -->
      </div>
      <!-- /.row -->
      <div class="row">
         <c:forEach items="${rankFlist }" var="sdto">
            <div class="team-member col-lg-3 col-md-4 col-sm-6 product__discount__item__pic">
               <div class="making_crown" style="z-index: 2; background-color: transparent !important;"><i class='fas fa-crown' style='font-size:48px;color:#ffeb7d;'></i><span style="font-size: 18px; font-weight:bold; color:#2C5F2D;  position: absolute; left:24px;">${sdto.rankingNum }</span></div>
               <div class="member-thumb" OnClick="location.href ='/review/myList?memberID=${sdto.mvo.memberID}'" style="cursor:pointer; ">
                     <c:choose>
                        <c:when test="${sdto.fvo.ftype > 0 }">
                        <img src="/upload/${sdto.fvo.savedir}/${sdto.fvo.uuid}_th_${sdto.fvo.fname}"
                              alt=""  style="min-height:210px; max-height: 262px;  ">
                        </c:when>
                        <c:otherwise>
                        <img src="/resources/images/member/person.png" alt="기본이미지"  style="">
                        </c:otherwise>
                     </c:choose>
                  <div class="team-overlay rankimg">
                     <h3 style="font-weight: bold; color: black; margin-top: 21%;" class="rankImgID">${sdto.mvo.memberID }</h3>
                     <span style="color:black">${sdto.mvo.memberName }</span>
                     <ul class="" style="color:black">
                        <li>팔로워수 ${sdto.followerNum}</li>
                        <li>팔로잉수 ${sdto.followingNum }</li>
                        <li>리뷰 수 ${sdto.reviewNum }</li>
                     </ul>
                  </div>
                  
                  <!-- /.team-overlay -->
               </div>
               <!-- /.member-thumb -->
            </div>
         </c:forEach>
         

         <!--팔로워 끝  -->
      </div>
      <!-- /.row -->
      
      <!-- /.row -->
      
      <!-- /.row -->
   </div>
   <!-- /.container -->
</div>
<!-- /#our-team -->


<jsp:include page="common/footer.jsp" />
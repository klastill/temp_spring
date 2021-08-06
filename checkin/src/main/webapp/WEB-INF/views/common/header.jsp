<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring Framework Exercise</title>
  <meta charset="utf-8">
  <meta name="_csrf" content="${_csrf.token }">
  <meta name="_csrf_header" content="${_csrf.headerName }">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
     	<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="/resources/css/font-awesome.css">
        <link rel="stylesheet" href="/resources/css/animate.css">
        <link rel="stylesheet" href="/resources/css/templatemo_misc.css">
        <link rel="stylesheet" href="/resources/css/templatemo_style.css">
		<link rel="shortcut icon" href="favicon.png">

<!--새로운 네비추가 start  -->
	<!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
	<!--아이콘추가  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Css Styles -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/toastr.css" type="text/css">
    
 <!--새로운 네비추가 end  -->

        <script src="/resources/js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
		<script src="/resources/js/jquery-3.6.0.min.js"></script>
		<script src="/resources/js/owl.carousel.min.js"></script>
		<script src="/resources/js/jquery.slicknav.js"></script>
		<script src="/resources/js/popper.min.js"></script>
		<script src="/resources/js/bootstrap.min.js"></script>
		<script src="/resources/js/toastr.min.js"></script>
  <style>
 @font-face {
    font-family: 'EliceDigitalBaeum_Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/EliceDigitalBaeum_Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
*,p,h5{  
  font-family: 'EliceDigitalBaeum_Regular';
}

.page-link{
color: #2C5F2D;
} 
.page-item.active .page-link{
background-color: #7fad39 !important;
border-color:#7fad39 !important;
}

  </style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
 var socket = null;
   $(function (){
	   connectWs();
   });
   function connectWs(){
   	sock = new SockJS( "/echo" );
   	//sock = new SockJS('/replyEcho');
   	socket = sock;
   	sock.onopen = function() {
           console.log('info: connection opened.');
     };
 
    sock.onmessage = function(evt) {
	 	var data = evt.data;
	   	console.log("ReceivMessage : " + data + "\n");
	   	
          Command: toastr["success"](data+"", "Alarm")

          toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
          }
    };
 
    sock.onclose = function() {
      	console.log('connect close');
      	/* setTimeout(function(){conntectWs();} , 1000); */
    };
 
    sock.onerror = function (err) {console.log('Errors : ' , err);};
   }
</script>
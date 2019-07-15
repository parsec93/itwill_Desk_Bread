<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<%
String id = request.getParameter("id");

MemberDAO mdao = new MemberDAO();


MemberBean mb = new MemberBean();

mb = mdao.getMember(id);

String name = mb.getName();
String email = mb.getEmail();
String mobile = mb.getMobile();
int postcode = mb.getPostcode();
String add1 = mb.getAdd1();
String add2 = mb.getAdd2();
String add3 = mb.getAdd3();
%>
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <script type = "text/javascript">
 	
 //------------------- 항목별 빈칸 체크.--------------------------------	
 
 	function passCheck(){ // 회원가입을 눌렀을 때 각 항목들 검사.
   pass = document.fr.pass.value;
   pass2 = document.fr.pass2.value;
   if(pass!=pass2){ // 2개의 비밀번호가 같은지를 검사.
   alert("비밀번호가 다릅니다.");
   document.fr.pass.focus();
   return false;
   }
   
   
   if(pass.length<8) { // 비밀번호 길이 검사.
 	 	    alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~15자를 입력해주세요.");
 	 	    return false;
 	 	}
   
   if(!pass.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) { //비밀번호 유효성 검사.
 	 	      alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~15자를 입력해주세요.");
 	 	    return false;
 	 	 }
   
   name = document.fr.name.value;
   
   if(name==""){// 이름을 입력했는지 검사.
   alert("이름을 입력하세요.");
   document.fr.name.focus();
   return false;
   }
   
 
   
 }
 	
 	 //------------------- 이메일 체크 기능. --------------------------------	
 	function authEmail(){ //이메일 인증 기능
 		var email = document.getElementById("email").value;

        
        if(email == ""){
           alert("메일주소를 입력하세요.");
        }else{
           window.open('email_dup.jsp?email='+email, 'Email 인증요청',
                 'width=500, height=400, menubar=no, status=no, toolbar=no');
        }
 	}
 	
 	
 	
 	
	 </script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->
<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="updatePro.jsp" id="join" method="post" name = "fr">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value=<%=id %> readonly ><br>

<label>Password</label>
<input type="password" name="pass"> <br>

<label>Retype Password</label>
<input type="password" name="pass2"> <br>

<label>Name</label>
<input type="text" name="name" value ="<%=name%>"> <br>

<label>E-Mail</label>
<input type="email" name="email" value="<%=email%>">
<input type="button" value="이메일 중복체크" class="dup" onclick = "authEmail()"><br>

</fieldset>

<fieldset>
<label>우편번호</label>
<input type="text" id="sample6_postcode" placeholder="우편번호" name = "postcode" value="<%=postcode %>">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<label></label><input type="text" id="sample6_address" placeholder="주소" name="add1" value="<%=add1%>"><br>
<label></label><input type="text" id="sample6_detailAddress" placeholder="상세주소" name = "add2" value="<%=add2%>">
<input type="text" id="sample6_extraAddress" placeholder="참고항목" name = "add3" value="<%=add3%>">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script><br>
<label>휴대폰 번호</label>
<input type="text" name="mobile" value="<%=mobile %>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원 정보 수정" class="submit" onclick= "return passCheck()" >
<input type="reset" value="취소" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
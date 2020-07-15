<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/result_report_get.css" />

<!-- Main -->
<div id="main" class="wrapper style1">
	<div class="container">
		<div class="row">

			<%@include file="../includes/apply_record_sidebar.jsp"%>

			<!-- Content -->
			<div id="content" class="8u skel-cell-important">
				<section>
					<header class="major">
						<h2>결과보고서 작성</h2>
					</header>
					<form name="frm" id="reg_frm" action="/apply_support/cdims_apply_support_update" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="hidden" name="bno" value="${resultvo.bno }" />
						<input type="hidden" name="teamno" value="${resultvo.teamno }" />
					
						<!-- 유형 입력 폼 테이블-->
						<table class="table table-bordered">
							<caption class="cap">과목</caption>
							<tr>
								<td>
								<label for="year"> 년도 </label><span style="color: red;"> * </span>
								<select id="year" name="year">
									<c:forEach var="item" begin="1990" end="2025" step="1">
										<c:choose>
											<c:when test="${resultvo.year == item}">
												<option selected="selected">${item}</option>
											</c:when>
											<c:otherwise>
												<option>${item}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<label for="semester">	학기 </label><span style="color: red;"> * </span>
								<select id="semester" name="semester">
									<c:forEach var="item" begin="1" end="2" step="1">
										<c:choose>
											<c:when test="${resultvo.semester == item }">
												<option selected="selected">${item }</option>
											</c:when>
											<c:otherwise>
												<option>${item}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<label for="subject_name">	과목명 </label><span style="color: red;"> * </span>
								<select id="subject_name" name="subjectName">
									<!-- 데이터베이스의 과목테이블(subjects_tbl)의 과목명 가져오기 -->
									<c:forEach var="subject" items="${subname }">
										<c:choose>
											<c:when test="${resultvo.subjectName eq subject.subjectName }">
												<option selected="selected"><c:out value="${subject.subjectName}"/></option>
											</c:when>
											<c:otherwise>
												<option><c:out value="${subject.subjectName}"/></option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<label for="division">	분반 </label><span style="color: red;"> * </span>
								<select id="division" name="division">
									<c:forEach var="item" begin="11" end="15" step="1">
										<c:choose>
											<c:when test="${resultvo.division == item}">
												<option selected="selected">${item}</option>
											</c:when>
											<c:otherwise>
												<option>${item}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								</td>
							</tr>
						</table>
						<br> <br> <br>
						
						<table class="table table-bordered">
							<caption class="cap">유형</caption>
							<tr>
								<td><label for="assignType"> 과제유형 </label><span style="color: red;"> * </span> 
								<input type="text" id="assigntype" name="assignType" value="<c:out value="${resultvo.assignType }"></c:out>"> <br> 
								<label for="projectTitle"> 과제명 </label><span style="color: red;"> * </span> 
								<input type="text" id="projectTitle" name="projectTitle" value="<c:out value="${resultvo.projectTitle }"></c:out>"> <br>
								<label for="teamName"> 팀명 </label><span style="color: red;"> * </span> 
								<input type="text" id="teamName" name="teamName" value="<c:out value="${resultvo.teamName }"></c:out>"> <br>
								<label for="applyFee"> 지원신청금액 </label><span style="color: red;"> * </span> 
								<input type="text" id="applyFee" name="applyFee" value="<c:out value="${resultvo.applyFee }"></c:out>"> <br>
								<label for="writer"> 작성자 </label><span style="color: red;"> * </span> 
								<input type="text" id="writer" name="writer" value="<sec:authentication property="principal.username"/>" 
										readonly style="background-color: #cccccc;" value="<c:out value="${resultvo.writer }"></c:out>"> <br>
								</td>
							</tr>
						</table>
						<br> <br> <br>

						<!-- 팀원 입력 폼 테이블-->
						<table class="table table-bordered">
							<caption class="cap">팀원</caption>
							<button type="button" id="team_add_btn"
								class="btn btn-default pull-right" name="team_add_btn">팀원 추가</button>
							<tr>
								<td><label for="name"> 소속학과 </label><span
									style="color: red;"> * </span></td>
								<td><label for="name"> 학번 </label><span style="color: red;">
										* </span></td>
								<td><label for="name"> 학년 </label><span style="color: red;">
										* </span></td>
								<td><label for="name"> 성명 </label><span style="color: red;">
										* </span></td>
								<td><label for="name"> 전화번호 </label><span
									style="color: red;"> * </span></td>
								<td><label for="name"> 이메일 </label><span
									style="color: red;"> * </span></td>
								<td></td>
							</tr>
							<tr name="trStaff">
							<c:forEach var="team" items="${teamList }" varStatus="status">
								<tr name="trStaff">
								<input type="hidden" id="rtkey" name="teamList[${status.index }].rtkey" value="${team.rtkey }">
								<input type="hidden" id="teamno" name="teamList[${status.index }].teamno" value="${team.teamno }">
								<td><input type="text" id="department${status.index }" name="teamList[${status.index }].department" value="${team.department }"><br></td>
								<td><input type="text" id="studentId${status.index }" name="teamList[${status.index }].studentId" value="${team.studentId }"> <br></td>
								<td><input type="text" id="grade${status.index }" name="teamList[${status.index }].grade" value="${team.grade }"> <br></td>
								<td><input type="text" id="name${status.index }" name="teamList[${status.index }].name" value="${team.name }"> <br></td>
								<td><input type="text" id="phoneNumber${status.index }" name="teamList[${status.index }].phoneNumber" value="${team.phoneNumber }"> <br></td>
								<td><input type="text" id="email${status.index }" name="teamList[${status.index }].email" value="${team.email }"> <br></td>
								<td>
									<!-- 처음 행을 제외한 팀원 삭제 버튼 추가 -->
									<c:if test="${status.index != 0 }">
										<button type="submit" id="team_del_btn" class="btn btn-default pull-right" name="team_del_btn">팀원 삭제</button>
									</c:if>
								</td>
								</tr>
							</c:forEach>
						</table>
						<br> <br> <br>

						<!-- 기업연계/지역협력 입력 폼 테이블-->
						<table class="table table-bordered">
							<caption class="cap">기업연계/지역협력 (* 있을 시에만 작성)</caption>
							<tr>
								<td>
								<label for="type"> 연계형태 </label> 
								<input type="text" id="type" name="type" value="<c:out value="${resultvo.type }"></c:out>"> <br> 
								<label for="company"> 기관명 </label> 
								<input type="text" id="company" name="company" value="<c:out value="${resultvo.company }"></c:out>"> <br>
								<label for="ceo"> 대표자 </label> 
								<input type="text" id="ceo" name="ceo" value="<c:out value="${resultvo.ceo }"></c:out>"> <br> 
								<label for="license"> 사업자등록번호 </label> 
								<input type="text" id="license" name="license" value="<c:out value="${resultvo.license }"></c:out>"> <br> 
								<label for="business"> 업종/종목 </label> 
								<input type="text" id="business" name="business" value="<c:out value="${resultvo.business }"></c:out>"> <br> 
								<label for="postcode"> 우편번호 </label> 
								<input type="text" id="postcode" name="postcode" value="<c:out value="${resultvo.postcode }"></c:out>"> <br>
								<label for="address"> 주소 </label> 
								<input type="text" id="address" name="address" value="<c:out value="${resultvo.address }"></c:out>"> <br>
								</td>
							</tr>
						</table>
						
						<button type="submit" id="completed_btn"
							class="btn btn-default pull-right" name="completed_btn" onclick="return writeCheck()">작성 완료</button>
					</form>

				</section>
			</div>
		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>
</body>

<script>
	//팀원 카운트 (팀원 수)
	var cnt = '<c:out value="${count}"/>' - 1;
	
	//추가 버튼
	$(document).on("click","button[name=team_add_btn]", function() {
		cnt++;
		console.log(cnt);
		var addStaffText = '<tr name="trStaff">'
				+ '   <td><input type="text" id="department' + cnt + '" name="teamList[' + cnt + '].department"> <br></td>'
				+ '   <td><input type="text" id="studentId' + cnt + '" name="teamList[' + cnt + '].studentId"> <br></td>'
				+ '	<td><input type="text" id="grade' + cnt + '" name="teamList[' + cnt + '].grade"> <br></td>'
				+ '	<td><input type="text" id="name' + cnt + '" name="teamList[' + cnt + '].name"> <br></td>'
				+ '	<td><input type="text" id="phoneNumber' + cnt + '" name="teamList[' + cnt + '].phoneNumber"> <br></td>'
				+ '	<td><input type="text" id="email' + cnt + '" name="teamList[' + cnt + '].email"> <br></td>'
				+ '	<td><button type="submit" id="team_del_btn" class="btn btn-default pull-right" name="team_del_btn">팀원 삭제</button>'
				+ '   </td>' + '</tr>';
	
		var trHtml = $("tr[name=trStaff]:last");
		trHtml.after(addStaffText);
	});

	//삭제 버튼
	$(document).on("click", "button[name=team_del_btn]", function() {
		cnt--;
		console.log(cnt);
		var trHtml = $(this).parent().parent();
		trHtml.remove();
	});
</script>

<script type="text/javascript" src="/resources/js/writecheck.js"></script>
</html>
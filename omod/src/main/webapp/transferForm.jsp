<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<%@ include file="includes/js_css.jsp" %>
<input type="hidden" id="pageId" value="transferPage"/>
<form method="post" id="transferForm">
<input type="hidden" id="id" name="admittedId" value="${admitted.id }" />
<div class="box">
<c:if test ="${not empty message }">
<div class="error">
<ul>
    <li>${message}</li>   
</ul>
</div>
</c:if>
<table width="100%">
	<tr>
		<td><spring:message code="ipd.patient.patientName"/>:&nbsp;<b>${admitted.patientName }</b></td>
		<td><spring:message code="ipd.patient.patientId"/>:&nbsp;<b>${admitted.patientIdentifier}</b></td>
		<td><spring:message code="ipd.patient.age"/>:&nbsp;<b>${admitted.age }</b></td>
		<td><spring:message code="ipd.patient.gender"/>:&nbsp;<b>${admitted.gender }</b></td>
	</tr>
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.category"/>: ${patCategory }</td>
		<td colspan="2"><spring:message code="ipd.patient.monthlyIncome"/>: ${admitted.monthlyIncome}</td>
	</tr>
	<tr>
		<td colspan="4"><spring:message code="ipd.patient.fatherName"/>:  ${relationName }</td>
	</tr>
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.admittedWard"/>: ${admitted.admittedWard.name}</td>
		<td colspan="2"><spring:message code="ipd.patient.bedNumber"/>: ${admitted.bed }</td>
	</tr>
	<tr>
		<td colspan="4"><spring:message code="ipd.patient.homeAddress"/>: ${address }</td>
	</tr>
</table>

</div>
<br/>
<table class="box">
	<tr>
		<td>Select ward<em>*</em></td>
		<td>Bed number<em>*</em></td>
		<td>Select doctor<em>*</em></td>
	</tr>
	<tr>
		<td>
		<select  id="toWard" name="toWard" >
			  <option value="">[Please Select]</option>
					<c:forEach items="${listIpd}" var="ipd" >
         			<option title="${ipd.answerConcept.name}"   value="${ipd.answerConcept.id}">${ipd.answerConcept.name}</option>
      		</c:forEach>  			
		</select>
		</td>
		<td><input type="text" name="bedNumber" id="bedNumber" /></td>
		<td>
			<select id="doctor" name="doctor">
			<c:forEach items="${listDoctor}" var="doct" >
          			<option title="${doct.givenName}"   value="${doct.id}" >${doct.givenName}</option>
       		</c:forEach>
       		</select>
		</td>
	</tr>
</table>

<table  width="98%">


	<tr><td align="right"><input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Submit"></td></tr>
</table>

</form>
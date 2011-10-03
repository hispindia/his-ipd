<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<table cellpadding="5" cellspacing="0" width="100%" id="queueList">
<tr align="center" >
	<th>#</th>
	<th><spring:message code="ipd.patient.admissionAdvisedOn"/></th>
	<th><spring:message code="ipd.patient.patientId"/></th>
	<th><spring:message code="ipd.patient.patientName"/></th>
	<th><spring:message code="ipd.patient.age"/></th>
	<th><spring:message code="ipd.patient.gender"/></th>
	<th><spring:message code="ipd.patient.admissionWard"/></th>
	<th><spring:message code="ipd.patient.admissionBy"/></th>
	<th><spring:message code="ipd.patient.action"/></th>
</tr>
<c:choose>
<c:when test="${not empty listPatientAdmission}">
<c:forEach items="${listPatientAdmission}" var="pAdmission" varStatus="varStatus">
	<tr  align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } ' >
		<td><c:out value="${varStatus.count }"/></td>
		<td><openmrs:formatDate date="${pAdmission.admissionDate }" type="textbox"/></td>	
		<td>${pAdmission.patientIdentifier}</td>
		<td>${pAdmission.patientName}</td>
		<td>
			${pAdmission.age }
		</td>
		<td>${pAdmission.gender}</td>
		<td>${pAdmission.admissionWard.name}</td>
		<c:set var="person" value="${pAdmission.opdAmittedUser.person }"/>
		<td>${person.givenName} ${person.middleName } ${person.familyName }</td>
		<td>
		<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all"  value="Admit" onclick="ADMISSION.admit('${pAdmission.id}');"/>
		<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Remove" onclick="ADMISSION.removeOrNoBed('${pAdmission.id}','1');"/>
		<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="No Bed" onclick="ADMISSION.removeOrNoBed('${pAdmission.id}','2');"/>
		</td>
	</tr>
</c:forEach>
</c:when>
<c:otherwise>
<tr align="center" >
	<td colspan="9">No patient found</td>
</tr>
</c:otherwise>
</c:choose>
</table>

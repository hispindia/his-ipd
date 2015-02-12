<%--
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of IPD module.
 *
 *  IPD module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  IPD module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with IPD module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%> 
<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<script type="text/javascript">
function givePrompt(){
alert("Kindly clear patients pending bill charges");
return false;
}
</script>


<input type="hidden" name="ipdWard" id="ipdWard" value="${ipdWard}">
<table cellpadding="5" cellspacing="0" width="100%" id="queueList">
<tr align="center" >
	<th>#</th>
	<th><spring:message code="ipd.admissionDate"/></th>
	<th><spring:message code="ipd.patient.patientId"/></th>
	<th><spring:message code="ipd.patient.patientName"/></th>
	<th><spring:message code="ipd.patient.age"/></th>
	<th><spring:message code="ipd.patient.gender"/></th>
	<th><spring:message code="ipd.patient.admissionWard"/></th>
	<th><spring:message code="ipd.patient.bedNumber"/></th>
	<th><spring:message code="ipd.patient.admissionBy"/></th>
    
	<th><spring:message code="ipd.patient.action"/></th>
</tr>
<c:choose>
<c:when test="${not empty listPatientAdmitted}">
<c:forEach items="${listPatientAdmitted}" var="queue" varStatus="varStatus">
	<tr  align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } ' >
		<td><c:out value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }"/></td>	
		<td><openmrs:formatDate date="${queue.admissionDate}" type="textbox"/></td>
		<%-- ghanshyam 29-july-2013 Support #2398 [IPD]remove "Patient ID" link from "Admitted patient index" in Bangladesh module --%>
		<%--
		<td>
			<a href="#" title="Go to dashboard" onclick="ACT.go('gotoDashboard.htm?id=${queue.id}');">
				${queue.patientIdentifier}
			</a>
		</td>
		--%>
		<td>${queue.patientIdentifier}</td>
		<td>${fn:replace(queue.patientName,',',' ')}</td>
		<td>${queue.age }</td>
		<td>${queue.gender}</td>
		<td width="50">${queue.admittedWard.name}</td>
		<td>${queue.bed}</td>
		<c:set var="person" value="${queue.ipdAdmittedUser.person }"/>
		<td width="50">${person.givenName}${person.familyName }  ${fn:replace(person.middleName,',',' ')} </td>
        
		<td>
		    <!-- ghanshyam 10-june-2013 New Requirement #1847 Capture Vital statistics for admitted patient in ipd -->
		    <c:choose>
		    <c:when test="${queue.requestForDischargeStatus == 0}">
		    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Enter Vitals" onclick="ADMITTED.vitalStatistics('${queue.id}','${queue.patientAdmissionLog.id}',${ipdWard});"/>
		    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Treatment" onclick="ADMITTED.treatment('${queue.id}','${queue.patientAdmissionLog.id}',${ipdWard});"/>
		    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all"  value="Transfer" onclick="ADMITTED.transfer('${queue.id}',${ipdWard});"/>
		    </c:when>
		    <c:when test="${queue.requestForDischargeStatus == 1}">
		    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Enter Vitals" disabled="disabled" onclick="ADMITTED.vitalStatistics('${queue.id}','${queue.patientAdmissionLog.id}');"/>
		    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Treatment" disabled="disabled" onclick="ADMITTED.treatment('${queue.id}','${queue.patientAdmissionLog.id}',${ipdWard});"/>
		    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all"  value="Transfer" disabled="disabled" onclick="ADMITTED.transfer('${queue.id}');"/>
		    </c:when>
		    </c:choose>
		    <c:choose>
		    <c:when test="${queue.requestForDischargeStatus == 0}">
		    &nbsp;<input type="button"  class="ui-button ui-widget ui-state-default ui-corner-all" value="Abscond" onclick="ADMITTED.requestForDischarge('${queue.id}','${ipdWard}',1);"/>&nbsp;
		    <input type="button"  class="ui-button ui-widget ui-state-default ui-corner-all" value="Request For Discharge" onclick="ADMITTED.requestForDischarge('${queue.id}','${ipdWard}',0);"/>
		    </c:when>
		    <c:when test="${queue.requestForDischargeStatus == 1}">
            <c:choose>
		<c:when test="${queue.absconded ==1}">
        <input type="button"  class="ui-button ui-widget ui-corner-all" value="Absconded" style="font-weight: bold; color:#FFFFFF; background-color:#1AAD9B"/>&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="ui-button ui-widget ui-corner-all" value="Request sent" style="font-weight: bold; color:#FFFFFF; background-color:#1AAD9B"/>
        </c:when>
        <c:otherwise>    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="ui-button ui-widget ui-corner-all" value="Request sent" style="font-weight: bold; color:#FFFFFF; background-color:#1AAD9B"/>
            </c:otherwise>
            </c:choose>
		    </c:when>
		    </c:choose>
			<c:choose>
		    <c:when test="${queue.billingStatus == 0}">
			    <input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Discharge" onclick="givePrompt();"/>
		    </c:when>
		    <c:when test="${queue.billingStatus == 1}">
		    <input type="button"  class="ui-button ui-widget ui-state-default ui-corner-all" value="Discharge" onclick="ADMITTED.discharge('${queue.id}');"/>
		    </c:when>
		    </c:choose>
			<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Print" onclick="ADMITTED.print('${queue.id}');"/>
			<div id="printArea${queue.id}" style="display:none; margin: 10px auto; width: 981px; font-size: 1.5em;font-family:'Dot Matrix Normal',Arial,Helvetica,sans-serif;">
			<!-- 
			<img src="${pageContext.request.contextPath}/moduleResources/ipd/HEADEROPDSLIP.jpg" width="981" height="170"></img>
			 -->
			
			<table width="100%" >
			<tr><td><strong><spring:message code="ipd.patient.patientName"/></strong>:&nbsp;${fn:replace(queue.patientName,',',' ')}</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.patientId"/></strong>:&nbsp;${queue.patientIdentifier}</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.category"/></strong>:&nbsp;${queue.patientCategory }</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.age"/></strong>:&nbsp;${queue.age}</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.gender"/></strong>:&nbsp;
			<c:choose>
				<c:when test="${queue.gender eq 'M'}">
					Male
				</c:when>
				<c:otherwise>
					Female
				</c:otherwise>
			</c:choose>
			</td></tr>
			<%-- ghanshyam 30/07/2012 [IPD - Bug #325] [IPD] Inconsistency in print slip--%>
			<tr><td><strong>Relative Name</strong>:&nbsp;${mapRelationName[queue.id]}</td></tr>
			<c:set var="personAddress" value="${queue.patient.personAddress }"/>
			<tr><td ><strong><spring:message code="ipd.patient.address"/></strong>: ${personAddress.address1 } ${personAddress.countyDistrict } ${personAddress.cityVillage }</td></tr>
			<%-- ghanshyam 27-02-2013 Support #965[IPD]change Tehsil TO Upazila,reomve monthly income field,remove IST Time for Bangladesh module --%>
		    <%--
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.monthlyIncome"/>: ${queue.monthlyIncome}</td></tr>
			--%>
			<tr></tr>
			<tr><td><strong><spring:message code="ipd.patient.admittedWard"/></strong>:${queue.admittedWard.name}</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.treatingDoctor"/></strong>:${queue.ipdAdmittedUser.givenName}</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.bedNumber"/></strong>:${queue.bed }</td></tr>
			<tr><td><strong><spring:message code="ipd.patient.date/time"/></strong>:
			<fmt:formatDate value="${dateTime}" pattern="dd-MM-yyyy HH:mm:ss" />
			</td></tr>
		</table>
		<br/><br/><br/><br/><br/><br/>
	    <span style="float:right;font-size: 1.5em">Signature of Ward Sister/Attending Doctor / Stamp</span>
		</div>
		</td>
		
	</tr>
</c:forEach>
</c:when>
<c:otherwise>
<tr align="center" >
	<td colspan="6">No patient found</td>
</tr>
</c:otherwise>
</c:choose>
</table>

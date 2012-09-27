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
<%-- ghanshyam 27-sept-2012 Support #387 [ALL] Small changes in all modules(note:these lines of code written for cancel button) --%>
<div align="right">
	<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Submit">
	<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Cancel" onclick="tb_cancel();">
</div>	
</table>
</form>
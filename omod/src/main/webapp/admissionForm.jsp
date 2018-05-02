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
<%-- ghanshyam 22-april-2013 Bug #1411 [IPD]inconsistency in form validation For Patient Admission --%>
<script type="text/javascript">

jQuery(document).ready(function() {
var wardId= ${admission.admissionWard.id};
FIRSTBEDSTRENGTH.getFirstBedStrength(wardId);
});


function validate(){
var monthlyincome=document.forms["admissionForm"]["monthlyIncome"].value;
var admittedward=document.forms["admissionForm"]["admittedWard"].value;
var treatingdoctor=document.forms["admissionForm"]["treatingDoctor"].value;
var bednumber=document.forms["admissionForm"]["bedNumber"].value;
  if (monthlyincome==null || monthlyincome=="")
  {
  alert("Please enter monthly Income");
  return false;
  }
  else{
   if (!StringUtils.isDigit(monthlyincome)) {
	 alert("Please enter monthly Income in Digit");
	 return false;
	}
  }
  if (admittedward==null || admittedward=="")
  {
  alert("Please select admitted Ward");
  return false;
  }
  if (treatingdoctor==null || treatingdoctor=="")
  {
  alert("Please select treating Doctor");
  return false;
  }
  if (bednumber==null || bednumber=="")
  {
  alert("Please enter bed Number");
  return false;
  }
}
</script>



<input type="hidden" id="pageId" value="admissionPage"/>
<%-- ghanshyam 22-april-2013 Bug #1411 [IPD]inconsistency in form validation For Patient Admission --%>
<form method="post" id="admissionForm" class="box" onsubmit="javascript:return validate();">
<input type="hidden" id="id" name="id" value="${admission.id }" />
<c:if test ="${not empty message }">
<div class="error">
<ul>
    <li>${message}</li>   
</ul>
</div>
</c:if>
<table width="100%">
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.patientName"/>:&nbsp;${admission.patientName }</td>
		<td><spring:message code="ipd.patient.patientId"/>:&nbsp;${admission.patientIdentifier}</td>
	</tr>
	<tr>
		<td><spring:message code="ipd.patient.age"/>:&nbsp;${admission.age }</td>
		<td><spring:message code="ipd.patient.gender"/>:&nbsp;${admission.gender }</td>
	</tr>
	<tr>
		<td><spring:message code="ipd.patient.category"/>:&nbsp;${patCategory } </td>
		<td>${relationType }:&nbsp;${relationName }</td>
	</tr>
	<tr>
		<td><spring:message code="ipd.patient.homeAddress"/>:</td>
		<td><input id="patientPostalAddress" name="patientPostalAddress" value="${address}" /></td>
	</tr>
<%--<tr>
	<td><spring:message code="ipd.patient.districtTehsil"/>:</td>
	<td>${districtTehsil }</td> 
	</tr> --%>
	<tr>
		<td><spring:message code="ipd.patient.monthlyIncome"/><em>*</em></td>
		<td><input type="text" id="monthlyIncome" name="monthlyIncome"  /></td>
	</tr>
	<tr>
		<td><spring:message code="ipd.patient.admittedWard"/><em>*</em></td>
		<td>
		<select  id="admittedWard" name="admittedWard" onchange="BEDSTRENGTH.getBedStrength(this);">
			  <option value=""></option>
				<c:if test="${not empty listIpd }">
			  			<c:forEach items="${listIpd}" var="ipd" >
			          			<option title="${ipd.answerConcept.name}"   value="${ipd.answerConcept.id}"  
			          					<c:if test="${admission.admissionWard.id ==  ipd.answerConcept.id}">
			          				    	selected
			          				    </c:if>
			          			>${ipd.answerConcept.name}</option>
			       		</c:forEach>
		       		</c:if>
			</select>
		</td>
	</tr>
	<tr>
		<td><spring:message code="ipd.patient.treatingDoctor"/><em>*</em></td>
		<td>
			<select  id="treatingDoctor" name="treatingDoctor" >
			  <option value=""></option>
				<c:if test="${not empty listDoctor }">
			  			<c:forEach items="${listDoctor}" var="doctor" >
			          			<option title="${doctor.givenName}"   value="${doctor.id}"  
			          					<c:if test="${doctor.id ==  admission.opdLog.user.id}">
			          				    	selected
			          				    </c:if>
			          			>${doctor.givenName}</option>
			       		</c:forEach>
		       		</c:if>
			</select>
		</td>
		<td>Click To Select Bed Number</td>
	</tr>
	<tr>
		<td><spring:message code="ipd.patient.bedNumber"/><em>*</em></td>
		<td><input type="text" id="bedNumber" name="bedNumber" readonly="readonly" /></td>
		<td>
		<div id="divBedStrength"></div>
		</td>
	</tr>
	<tr> <!-- MARTA -->
		<td><spring:message code="ipd.patient.dateTime"/>: </td>
		<td>
		<openmrs:formatDate date="${dateAdmission}" type="long" /></td>  
	</tr>
</table>

<br/>
<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Submit">
<%-- ghanshyam 27-sept-2012 Support #387 [ALL] Small changes in all modules(note:these lines of code written for cancel button) --%>
<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Cancel" onclick="tb_cancel();">
</form>
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

<%@ include file="includes/js_css.jsp" %>
<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">

jQuery(document).ready(function() {
var wardId= ${admission.admissionWard.id};
FIRSTBEDSTRENGTH.getFirstBedStrength(wardId);
});

function validate(){
var admittedward=document.forms["admissionForm"]["admittedWard"].value;
var treatingdoctor=document.forms["admissionForm"]["treatingDoctor"].value;
var bednumber=document.forms["admissionForm"]["bedNumber"].value;

  if (admittedward==null || admittedward=="")
  {
  alert("Please select admitted Ward");
  return false;
  }
  
  if (treatingdoctor==null || treatingdoctor=="")
  {
  alert("Please select Doctor on Call");
  return false;
  }
  if (bednumber==null || bednumber=="")
  {
  alert("Please enter bed Number");
  return false;
  }
  if (bednumber!=null)
  {
	var checkMaxBed=parseInt(document.forms["BedStrength"]["bedMax"].value);
	if(isNaN(bednumber)){
	  alert("Please enter bed number in correct format");
	  return false;
	  }
	if(bednumber > checkMaxBed){
	  alert("Please enter correct bed number");
	  return false;
	  }
  }

}

</script>

<script type="text/javascript">
// Patient Attribute
	var _attributes = new Array();
	<c:forEach var="entry" items="${patient.attributes}">
		_attributes[${entry.key}] = "${entry.value}";
	</c:forEach>
	
MODEL = {
		patientAttributes: _attributes
		};
</script>

<input type="hidden" id="pageId" value="admissionPage"/>
<form method="post" id="admissionForm" class="box" onsubmit="javascript:return validate();">
<input type="hidden" id="id" name="id" value="${admission.id }"/>
<c:if test ="${not empty message }">
<div class="error">
<ul>
    <li>${message}</li>   
</ul>
</div>
</c:if>
<table width="100%">
	<tr>
		<td><b><spring:message code="ipd.patient.patientName"/></b>:&nbsp;${fn:replace(admission.patientName,',',' ')}</td>
		<td><b><spring:message code="ipd.patient.patientId"/></b>:&nbsp;${admission.patientIdentifier}</td>
	</tr>
	<tr>
		<td><b><spring:message code="ipd.patient.age"/></b>:&nbsp;${admission.age }</td>
		<td><b><spring:message code="ipd.patient.gender"/></b>:&nbsp;
		<c:choose>
				<c:when test="${admission.gender eq 'M'}">
					Male
				</c:when>
				<c:otherwise>
					Female
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<%-- ghanshyam 27-02-2013 Feedback #966[Billing]Add Paid Bill/Add Free Bill for Bangladesh module(remove category from registration,OPD,IPD,Inventory) --%>
	<tr>
		<%--
		<td><spring:message code="ipd.patient.category"/>:&nbsp;<b>${patCategory }</b> </td>
		--%>
		<td><b>Relative Name</b>:&nbsp;${relationName }</td>
	</tr>
		<tr>
		<td><b><spring:message code="ipd.patient.maritalStatus"/></b>: </td>
		<td> ${maritalStatus}</td>  
	</tr>
	<tr>
		<td><b><spring:message code="ipd.patient.patientCategory"/></b>: </td>
		<td> ${patientCategory}</td>  
	</tr>
	<c:if test="${not empty contactNumber}">
	<tr>
		<td><b><spring:message code="ipd.patient.contactNumber"/></b>: </td>
		<td> ${contactNumber}</td>  
	</tr>
	</c:if>
	<c:if test="${not empty emailAddress}">
	<tr>
		<td><b><spring:message code="ipd.patient.emailAddress"/></b>: </td>
		<td> ${emailAddress}</td>  
	</tr>
	</c:if>
	<c:if test="${not empty nationalID}">
	<tr>
		<td><b><spring:message code="ipd.patient.nationalID"/></b>: </td>
		<td> ${nationalID}</td>  
	</tr>
	</c:if>
	<tr>
	    <!-- ghansham 25-june-2013 issue no # 1924 Change in the address format -->
		<td><b><spring:message code="ipd.patient.address"/></b></td><td>: ${address } &nbsp;${upazila } &nbsp;${district } </td>
	</tr>
	<%-- ghanshyam 27-02-2013 Support #965[IPD]change Tehsil TO Upazila,reomve monthly income field,remove IST Time for Bangladesh module --%>
	<%--
	<tr>
		<td><spring:message code="ipd.patient.monthlyIncome"/><em>*</em></td>
		<td><input type="text" id="monthlyIncome" name="monthlyIncome"  /></td>
	</tr>
	--%>
	<tr>
		<td><b><spring:message code="ipd.patient.admittedWard"/></b><em>*</em></td>
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
		<td><b><spring:message code="ipd.patient.treatingDoctor"/></b><em>*</em></td>
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
		<td>Click To Select Bed Number
		</td>
	</tr>
	<tr>
		<td><b><spring:message code="ipd.patient.bedNumber"/></b><em>*</em></td>
		<td><input type="text" id="bedNumber" name="bedNumber" readonly="readonly" /></td>
		<td>
		<div id="divBedStrength"></div>
		</td>
	</tr>

	<tr>
		<td><b><spring:message code="ipd.patient.comments"/></b></td>
		<td><input type="text" id="comments" name="comments" /></td>
	</tr
	<tr>
		<td>&nbsp;</td>
		
	</tr
	
	<tr> 
		<td><b><spring:message code="ipd.patient.dateTime"/></b>: </td>
		<td><fmt:formatDate value="${dateAdmission}" pattern="dd-MM-yyyy HH:mm:ss" /></td> 
	</tr>

</table>

<br/>
<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Submit">
<%-- ghanshyam 27-sept-2012 Support #387 [ALL] Small changes in all modules(note:these lines of code written for cancel button) --%>
<input type="button" class="ui-button ui-widget ui-state-default ui-corner-all" value="Cancel" onclick="tb_cancel();">
</form>
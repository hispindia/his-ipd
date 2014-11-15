 <%--
 *  Copyright 2014 Society for Health Information Systems Programmes, India (HISP India)
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
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<%@ include file="../includes/js_css.jsp" %>

<script type="text/javascript">

	function runout(value){
		setTimeout(function(){
			jQuery("#printArea").printArea({popTitle: "Support by HISP india(hispindia.org)"});
			},value);
	setTimeout("self.parent.location.href=self.parent.location.href;self.parent.tb_remove()",2000);
	}
</script>
<body onload="runout(1000);">
<div class="box">
<div id="printArea" style="margin: 10px auto; width: 981px; font-size: 1.5em;font-family:'Dot Matrix Normal',Arial,Helvetica,sans-serif;">
			<p><b><center><h1> DISCHARGE SUMMARY </h1></center></b></p>
			<table width="100%" >
			<tr><td><strong>Admission File Number:</strong>${comments}</td></tr>
			<tr><td><strong>Name:</strong>${ipdPatientAdmittedLog.patientName }</td></tr>
			<tr><td><strong>Patient Identifier:</strong>${ipdPatientAdmittedLog.patientIdentifier }</td></tr>
			<c:choose>
		    <c:when test="${ipdPatientAdmittedLog.gender eq 'M'}">
			<tr><td><strong>Gender:</strong>MALE</td></tr>
			</c:when>
			<c:when test="${ipdPatientAdmittedLog.gender eq 'F'}">
			<tr><td><strong>Gender:<strong>FEMALE</td></tr>
			</c:when>
			</c:choose>
			<tr><td><strong>Address:</strong>${personAddress.address1 },${personAddress.cityVillage },${personAddress.countyDistrict }</td></tr>
			<tr><td><strong>Ward/Department:</strong>${ipdPatientAdmittedLog.admittedWard.name }</td></tr>
			<tr><td><strong>Consultant:</strong>${ipdPatientAdmittedLog.ipdAdmittedUser.username }</td></tr>
			<tr><td><strong>DOA:</strong><openmrs:formatDate date="${ipdPatientAdmittedLog.patientAdmissionLog.admissionDate}" type="long" /></td></tr>
			<tr><td><strong>DOD:</strong><openmrs:formatDate date="${dischargeDate}" type="long" /></td></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr>
			<td><strong>Final Diagnosis:</strong>
			<c:forEach items="${diagnosisList}" var="diagnosis">
			${diagnosis.valueCoded.name},
			</c:forEach>
			</td>
			</tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr><td><strong>Procedures:</strong>
			<c:forEach items="${procedureList}" var="procedure">
			${procedure.valueCoded.name},
			</c:forEach>
			</td>
			</tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr><td><strong>Remarks:</strong>${ipdPatientAdmittedLog.otherInstructions}</td></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr><td><strong>Outcome:</strong>${ipdPatientAdmittedLog.admissionOutCome}</td></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr><td><strong>Contact Number:</strong>${contactNumber}</td></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr><td><strong>Email Address:</strong>${emailAddress}</td></tr>
		</table>
<br/><br/><br/><br/>
<span style="float:right;font-size: 1.0em">Signature of ward sister/attending Doctor / Stamp</span>
<br/>
</div>
<div>
</body>
</html>

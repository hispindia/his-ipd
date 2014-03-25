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
<!--<img src="${pageContext.request.contextPath}/moduleResources/ipd/HEADEROPDSLIP.jpg" width="981" height="170"></img>
			--><p><b><h1> IPD ADMISSION SLIP </h1></b></p>
			<table width="100%" >
			<tr><td><spring:message code="ipd.patient.patientName"/>:&nbsp;<strong>${admitted.patientName }</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.patientId"/>:&nbsp;<strong>${admitted.patientIdentifier}</strong></td></tr>
			<%-- ghanshyam 27-02-2013 Feedback #966[Billing]Add Paid Bill/Add Free Bill for Bangladesh module(remove category from registration,OPD,IPD,Inventory) --%>
	        <%-- 
			<tr><td><spring:message code="ipd.patient.category"/>:&nbsp;<strong>${patCategory }</strong></td></tr>
			--%>
			<tr><td><spring:message code="ipd.patient.age"/>:&nbsp;<strong>${admitted.age}</b></td></tr>
			<tr><td><spring:message code="ipd.patient.gender"/>:&nbsp;<strong>${admitted.gender }</strong></td></tr>
			<tr> <td>${relationType }:&nbsp;${relationName }</td>  </tr>
			<tr><td><spring:message code="ipd.patient.address"/>: ${address } &nbsp;${upazila } &nbsp;${district } </td></tr>
			<%-- ghanshyam 27-02-2013 Support #965[IPD]change Tehsil TO Upazila,reomve monthly income field,remove IST Time for Bangladesh module --%>
			<%--
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.monthlyIncome"/>: ${admitted.monthlyIncome}</td></tr>
			--%>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.admittedWard"/>:<strong> ${admitted.admittedWard.name}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.treatingDoctor"/>:<strong> ${treatingDoctor.givenName}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.bedNumber"/>: <strong>${admitted.bed }</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.contactNumber"/>: <strong>${contactNumber}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.emailAddress"/>: <strong>${emailAddress}</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.dateTime"/>: <openmrs:formatDate date="${dateAdmission}" type="long" /></td></tr>
		</table>
<br/><br/><br/><br/>
<span style="float:right;font-size: 1.0em">Signature of ward sister/attending Doctor / Stamp</span>
<br/>
</div>
<div>
</body>
</html>

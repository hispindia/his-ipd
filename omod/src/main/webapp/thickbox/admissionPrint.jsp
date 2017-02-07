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
		//ghanshyam 23-april-2013 Bug #1430 [IPD - Patients for Admisssion Tab](note:added below line)	
		setTimeout("self.parent.location.href=self.parent.location.href;self.parent.tb_remove()",1000);
	}
</script>
<body onload="runout(1000);">
<div class="box">
<div id="printArea" style="margin: 10px auto; width: 981px; font-size: 1.5em;font-family:'Dot Matrix Normal',Arial,Helvetica,sans-serif;">
<!--<img src="${pageContext.request.contextPath}/moduleResources/ipd/HEADEROPDSLIP.jpg" width="981" height="170"></img>
			--><p><b><h1> IPD ADMISSION SLIP </h1></b></p>
			<table width="100%" >
			<tr><td><spring:message code="ipd.patient.patientName"/>:&nbsp;${admitted.patientName }</td></tr>
			<tr><td><spring:message code="ipd.patient.patientId"/>:&nbsp;${admitted.patientIdentifier}</td></tr>
			<tr><td><spring:message code="ipd.patient.category"/>:&nbsp;${patCategory }</td></tr>
			<tr><td><spring:message code="ipd.patient.age"/>:&nbsp;${admitted.age}</td></tr>
			<tr><td><spring:message code="ipd.patient.gender"/>:&nbsp;${admitted.gender }</td></tr>
			<tr> <td>${relationType }:&nbsp;${relationName }</td>  </tr>
			<tr><td ><spring:message code="ipd.patient.homeAddress"/>: ${address }</td></tr>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.monthlyIncome"/>: ${admitted.monthlyIncome}</td></tr>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.admittedWard"/>: ${admitted.admittedWard.name}</td></tr>
			<tr><td ><spring:message code="ipd.patient.treatingDoctor"/>:${treatingDoctor.givenName}</td></tr>
			<tr><td ><spring:message code="ipd.patient.bedNumber"/>: ${admitted.bed }</td></tr>
			<tr><td><spring:message code="ipd.patient.dateTime"/>: <openmrs:formatDate date="${dateAdmission}" type="long" /></td></tr>
		</table>
<br/><br/><br/><br/>
<span style="float:right;font-size: 1.0em">Signature of ward sister/attending Doctor / Stamp</span>
<br/>
</div>
<div>
</body>
</html>

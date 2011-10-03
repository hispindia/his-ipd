<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<%@ include file="../includes/js_css.jsp" %>

<script type="text/javascript">

	function runout(value){
		setTimeout(function(){
			jQuery("#printArea").printArea({popTitle: "Support by HISP india(hispindia.org)"});
			},value);
		//setTimeout("self.parent.location.href=self.parent.location.href;self.parent.tb_remove()",3000);
	}
</script>
<body onload="runout(1000);">
<div class="box">
<div id="printArea" style="margin: 10px auto; width: 981px; font-size: 1.5em;font-family:'Dot Matrix Normal',Arial,Helvetica,sans-serif;">
<!--<img src="${pageContext.request.contextPath}/moduleResources/ipd/HEADEROPDSLIP.jpg" width="981" height="170"></img>
			--><p><b><h1><openmrs:globalProperty key="hospitalcore.hospitalName" /> HOSPITAL</h1></b></p>
			<table width="100%" >
			<tr><td><spring:message code="ipd.patient.patientName"/>:&nbsp;<strong>${admitted.patientName }</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.patientId"/>:&nbsp;<strong>${admitted.patientIdentifier}</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.category"/>:&nbsp;<strong>${patCategory }</strong></td></tr>
			<tr><td><spring:message code="ipd.patient.age"/>:&nbsp;<strong>${admitted.age}</b></td></tr>
			<tr><td><spring:message code="ipd.patient.gender"/>:&nbsp;<strong>${admitted.gender }</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.fatherName"/>:  ${relationName }</td></tr>
			<tr><td ><spring:message code="ipd.patient.homeAddress"/>: ${address }</td></tr>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.monthlyIncome"/>: ${admitted.monthlyIncome}</td></tr>
			<tr></tr>
			<tr><td ><spring:message code="ipd.patient.admittedWard"/>:<strong> ${admitted.admittedWard.name}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.treatingDoctor"/>:<strong> ${treatingDoctor.givenName}</strong></td></tr>
			<tr><td ><spring:message code="ipd.patient.bedNumber"/>: <strong>${admitted.bed }</strong></td></tr>
		</table>
<br/><br/><br/><br/>
<span style="float:right;font-size: 1.0em">Signature of ward sister/attending Doctor / Stamp</span>
<br/>
</div>
<div>
</body>
</html>

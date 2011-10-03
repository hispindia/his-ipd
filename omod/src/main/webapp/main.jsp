<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="includes/js_css.jsp" %>



<b class="boxHeader">Dashboard Ipd</b>
<input type="hidden" id="pageId" value="Ipd"/>
<div class="box" >
<form method="get"  id="IpdMainForm">
<input type="hidden" name="tab" id="tab" value="${tab}">
<table >
		<tr valign="top">
			<td><spring:message code="ipd.patient.search"/></td>
			<td>
				<input type="text" name="searchPatient" id="searchPatient" value="${searchPatient }"/>
			</td>
			<td><spring:message code="ipd.ipdWard.name"/></td>
			<td>
				<select id="ipdWard"  name="ipdWard" multiple="multiple" style="width: 150px;" size="10">
					<option value=""></option>
					<c:if test="${not empty listIpd }">
			  			<c:forEach items="${listIpd}" var="ipd" >
			          			<option title="${ipd.answerConcept.name}"   value="${ipd.answerConcept.id}"  
			          			<c:if test="${not empty ipdWard}">
			          				<c:forEach items="${ipdWard}" var="x" >
			          				    <c:if test="${x ==  ipd.answerConcept.id}">
			          				    	selected
			          				    </c:if>
			          				</c:forEach>
			          			</c:if>
			          			
			          			>${ipd.answerConcept.name}</option>
			       		</c:forEach>
		       		</c:if>
	  			</select> 
	  		</td>
	  		<td><spring:message code="ipd.doctor.name"/></td>	
	  		<td>
				<select id="doctor"  name="doctor" multiple="multiple" style="width: 150px;" size="10">
					<option value=""></option>
					<c:if test="${not empty listDoctor }">
			  			<c:forEach items="${listDoctor}" var="doct" >
			          			<option title="${doct.givenName}"   value="${doct.id}"  
			          			<c:if test="${not empty doctor}">
			          				<c:forEach items="${doctor}" var="x" >
			          				    <c:if test="${x ==  doct.id}">
			          				    	selected
			          				    </c:if>
			          				</c:forEach>
			          			</c:if>
			          			
			          			>${doct.givenName}</option>
			       		</c:forEach>
		       		</c:if>
	  			</select> 
	  		</td>	
			<td><spring:message code="ipd.fromDate"/></td>
			<td><input type="text" id="fromDate" class="date-pick left" readonly="readonly" style="width: 80px;" name="fromDate" value="${fromDate}" title="Double Click to Clear" ondblclick="this.value='';"/></td>
			<td><spring:message code="ipd.toDate"/></td>
			<td><input type="text" id="toDate" class="date-pick left" readonly="readonly" style="width: 80px;" name="toDate" value="${toDate}" title="Double Click to Clear" ondblclick="this.value='';"/></td>
			<td ><input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Search" onclick="IPD.submit(this);"/></td>
			
			<input type="hidden" id="ipdWardString" name="ipdWardString" value="${ipdWardString }"/>
			<input type="hidden" id="doctorString" name="doctorString" value="${doctorString }"/>
	    </tr>
</table>
</form>
<br />
<input type="hidden" id="intervalId" value=""/>
<div id="tabs">
     <ul>
         <li><a href="patientsForAdmission.htm?searchPatient=${searchPatient}&ipdWardString=${ipdWardString}&doctorString=${doctorString }&fromDate=${fromDate}&toDate=${toDate}"  title="Patients for admission"><span >Patients for admission</span></a></li>
         <li><a href="admittedPatientIndex.htm?searchPatient=${searchPatient}&ipdWardString=${ipdWardString}&doctorString=${doctorString }&fromDate=${fromDate}&toDate=${toDate}"  title="Admitted patient index"><span>Admitted patient index</span></a></li>
     </ul>
     
     <div id="Patients_for_admission">
     </div>
	 <div id="Admitted_patient_index"></div>
</div>

</div>


<%@ include file="/WEB-INF/template/footer.jsp" %> 
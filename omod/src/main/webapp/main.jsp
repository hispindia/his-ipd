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
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="includes/js_css.jsp" %>


<b class="boxHeader">IPD Dashboard</b>
<input type="hidden" id="pageId" value="Ipd"/>
<div class="box" >
<form method="get"  id="IpdMainForm">
<input type="hidden" name="tab" id="tab" value="${tab}">
<table >
		<tr valign="top">
			<td width="30%"></td>	
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="ipd.patient.search"/></td>
			<td>
				<input type="text" name="searchPatient" id="searchPatient" value="${searchPatient }"/>
			</td>
			
	  		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="ipd.doctor.name"/>&nbsp;</td>	
	  		<td>
				<select id="doctor"  name="doctor" multiple="multiple" style="width: 150px;" size="10">
					<option value=""></option>
					<c:if test="${not empty listDoctor }">
			  			<c:forEach items="${listDoctor}" var="doct" >
			          			<option title="${doct.givenName}"   value="${doct.id}">
			          			${doct.givenName}
			          			</option> 
			          			<c:if test="${not empty doctor}">
			          				<c:forEach items="${doctor}" var="x" >
			          				    <c:if test="${x ==  doct.id}">
			          				    	selected
			          				    </c:if>
			          				</c:forEach>
			          			</c:if>
			       		</c:forEach>
		       		</c:if>
	  			</select> 
	  		</td>	
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="ipd.fromDate"/></td>
			<td><input type="text" id="fromDate" class="date-pick left" readonly="readonly" style="width: 80px;" name="fromDate" value="${fromDate}" title="Double Click to Clear" ondblclick="this.value='';"/></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="ipd.toDate"/></td>
			<td><input type="text" id="toDate" class="date-pick left" readonly="readonly" style="width: 80px;" name="toDate" value="${toDate}" title="Double Click to Clear" ondblclick="this.value='';"/></td>
			<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Search" onclick="IPD.submit(this);"/></td>
			
			<input type="hidden" id="ipdWard" name="ipdWard" value="${ipdWard }"/>
			<input type="hidden" id="doctorString" name="doctorString" value="${doctorString }"/>
	    </tr>
</table>
</form>
<br />
<input type="hidden" id="intervalId" value=""/>
<div id="tabs">
     <ul>
         <li><a href="patientsForAdmission.htm?searchPatient=${searchPatient}&ipdWard=${ipdWard}&doctorString=${doctorString }&fromDate=${fromDate}&toDate=${toDate}"  title="Patients for admission"><span>Patients for Admission</span></a></li>
         <li><a href="admittedPatientIndex.htm?searchPatient=${searchPatient}&ipdWard=${ipdWard}&doctorString=${doctorString }&fromDate=${fromDate}&toDate=${toDate}"  title="Admitted patient index"><span>Admitted Patient Index</span></a></li>
     </ul>
     
     <div id="Patients_for_admission">
     </div>
	 <div id="Admitted_patient_index"></div>
</div>

</div>


<%@ include file="/WEB-INF/template/footer.jsp" %> 
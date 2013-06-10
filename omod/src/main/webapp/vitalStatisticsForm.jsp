<%--
 *  Copyright 2013 Society for Health Information Systems Programmes, India (HISP India)
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
 *  author: ghanshyam
 *  date: 10-june-2013
 *  issue no: #1847
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm"
	redirect="index.htm" />
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="includes/js_css.jsp"%>
<input type="hidden" id="pageId" value="vitalStatisticsPage" />
<form method="post" id="vitalStatisticsForm" action="vitalStatistics.htm?patientId=${admitted.patient.patientId}">
	<input type="hidden" id="admittedId" name="admittedId" value="${admitted.id }" />
	<div class="box">
		<c:if test="${not empty message }">
			<div class="error">
				<ul>
					<li>${message}</li>
				</ul>
			</div>
		</c:if>
		<table width="100%">
			<tr>
				<td><spring:message code="ipd.patient.patientName" />:&nbsp;<b>${admitted.patientName
						}</b>
				</td>
				<td><spring:message code="ipd.patient.patientId" />:&nbsp;<b>${admitted.patientIdentifier}</b>
				</td>
				<td><spring:message code="ipd.patient.age" />:&nbsp;<b>${admitted.age
						}</b>
				</td>
				<td><spring:message code="ipd.patient.gender" />:&nbsp;<b>${admitted.gender
						}</b>
				</td>
			</tr>
			<%-- ghanshyam 27-02-2013 Feedback #966[Billing]Add Paid Bill/Add Free Bill for Bangladesh module(remove category from registration,OPD,IPD,Inventory) --%>
			<%-- ghanshyam 27-02-2013 Support #965[IPD]change Tehsil TO Upazila,reomve monthly income field,remove IST Time for Bangladesh module --%>
			<%--
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.category"/>: ${patCategory }</td>
		<td colspan="2"><spring:message code="ipd.patient.monthlyIncome"/>: ${admitted.monthlyIncome}</td>
	</tr>
	--%>
			<tr>
				<td colspan="4"><spring:message code="ipd.patient.fatherName" />:
					${relationName }</td>
			</tr>
			<tr>
				<td colspan="2"><spring:message code="ipd.patient.admittedWard" />:
					${admitted.admittedWard.name}</td>
				<td colspan="2"><spring:message code="ipd.patient.bedNumber" />:
					${admitted.bed }</td>
			</tr>
			<tr>
				<td colspan="4"><spring:message code="ipd.patient.homeAddress" />:
					${address }</td>
			</tr>
		</table>

	</div>
	<br />
	<table class="box">
		<tr>
			<td><b>Blood Pressure:</b>
			</td>
			<td>Systolic</td>
			<td><input type="text" id="systolic" name="systolic" size="11"></td>
		</tr>
		<tr>
			<td></td>
			<td>Diastolic</td>
			<td><input type="text" id="diastolic" name="diastolic" size="11">
			</td>
		</tr>
		<tr>
			<td><b>Pulse:</b>
			</td>
			<td></td>
			<td><input type="text" id="pulse" name="pulse" size="11"></td>
		</tr>
		<tr>
			<td><b>Temperature:</b>
			</td>
			<td>In Fahrenheit</td>
			<td><input type="text" id="temperature" name="temperature" size="11">
			</td>
		</tr>
		<tr>
			<td><b>Diet Advised :</b></td>
			<td><input type="checkbox" id="dietadvisedsolid"
				name="dietadvisedsolid" value="solid">Solid</input></td>
			<td><input type="checkbox" id="dietadvisedsemsolid"
				name="dietadvisedsemsolid" value="semisolid">Semi solid</input></td>
			<td><input type="checkbox" name="dietadvisedliquid"
				id="dietadvisedliquid" value="liquid">Liquid</input></td>
		</tr>
		<tr>
			<td><b>Notes:</b>
		</tr>
		<tr>
			<td></td>
			<td><TEXTAREA id="note" name="note" rows=5 cols=30>
		</TEXTAREA>
			</td>
		</tr>
	</table>

	<table width="98%">
		<%-- ghanshyam 27-sept-2012 Support #387 [ALL] Small changes in all modules(note:these lines of code written for cancel button) --%>
		<div align="right">
			<input type="submit"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Submit"> <input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Cancel" onclick="tb_cancel();">
		</div>
	</table>
</form>
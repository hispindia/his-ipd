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
<script type="text/javascript">
	function validate() {

		var bloodpressure = document.forms["vitalStatisticsForm"]["bloodPressure"].value;
		var pulserate = document.forms["vitalStatisticsForm"]["pulseRate"].value;
		var temperature = document.forms["vitalStatisticsForm"]["temperature"].value;
		if (bloodpressure == null || bloodpressure == "") {
			alert("Please enter blood pressure");
			return false;
		}
		if (pulserate == null || pulserate == "") {
			alert("Please enter pulse");
			return false;
		}
		if (temperature == null || temperature == "") {
			alert("Please enter temperature");
			return false;
		}
	}
</script>
<script type="text/javascript">
	// Print the slip
	function print() {

		var bloodPressure = document.getElementById('bloodPressure').value;
		var pulserate = document.getElementById('pulseRate').value;
		var temperature = document.getElementById('temperature').value;
		var notes = document.getElementById('notes').value;
		var count = 0;
		if (bloodPressure != "" && bloodPressure != null) {
			jQuery("#printableBp").empty();
			count = 1;
			jQuery("#printableBp")
					.append(
							"<input type='text' value='" + bloodPressure + "' size='14'>");
		}

		if (pulserate != "" && pulserate != null) {
			jQuery("#printablePulseRate").empty();
			count = 1;
			jQuery("#printablePulseRate").append(
					"<input type='text' value='" + pulserate + "' size='16'>");
		}

		if (temperature != "" && temperature != null) {
			jQuery("#printabletemperature").empty();
			count = 1;
			jQuery("#printabletemperature")
					.append(
							"<input type='text' value='" + temperature + "' size='15'>");
		}

		var dietAdvised = jQuery("#dietAdvised option:selected").text();
		jQuery("#printableDiet").empty();
		if (dietAdvised != "" && dietAdvised != null) {
			count = 1;
			jQuery("#printableDiet")
					.append(
							"<input type='text' value='" + dietAdvised + "' size='11'>");
		}

		if (notes != "" && notes != null) {
			jQuery("#printableNote").empty();
			count = 1;
			jQuery("#printableNote").append(
					"<input type='text' value='" + notes + "' size='30'>");
		}

		if (count == 1) {
			jQuery("#printableSlNo").empty();
			jQuery("#printableDateTime").empty();
			jQuery("#printableSlNo")
					.append(
							"<input type='text' id='slNo' name='slNo' value='${sizeOfipdPatientVitalStatistics}' size='7' readonly='readonly'>");
			jQuery("#printableDateTime")
					.append(
							"<input type='text' id='dateTime' name='dateTime' value='${dat}' size='21' readonly='readonly'>");
		}

		jQuery("#printVitalSlip").printArea({
			mode : "popup",
			popClose : true
		});
	}
</script>

<input type="hidden" id="pageId" value="vitalStatisticsPage" />
<form method="post" id="vitalStatisticsForm"
	action="vitalStatistics.htm?patientId=${admitted.patient.patientId}"
	;
	onsubmit="javascript:return validate();">
	<input type="hidden" id="ipdWard" name="ipdWard" value="${ipdWard}" />
	<input type="hidden" id="admittedId" name="admittedId"
		value="${admitted.id }" />
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
				<td><spring:message code="ipd.patient.patientName" />:&nbsp;${fn:replace(admitted.patientName,',',' ')}
				</td>
				<td><spring:message code="ipd.patient.patientId" />:&nbsp;${admitted.patientIdentifier}
				</td>
				<td><spring:message code="ipd.patient.age" />:&nbsp;${admitted.age}
				</td>
				<td><spring:message code="ipd.patient.gender" />:&nbsp;${admitted.gender}
				</td>
			</tr>
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
				<!-- ghansham 25-june-2013 issue no # 1924 Change in the address format -->
				<td><spring:message code="ipd.patient.homeAddress"/>: ${address}</td>
			</tr>
		</table>

	</div>
	<br />
	<table class="box">
		<thead>
			<tr>
				<td><input type="text" id="hSlNo" name="hSlNo" value="S.No"
					size="7" readonly="readonly"></td>
				<td><input type="text" id="hDateTime" name="hDateTime"
					value="Date/Time" size="21" readonly="readonly"></td>
				<td><input type="text" id="hBloodPressure"
					name="hBloodPressure" value="Blood Pressure" size="14"
					readonly="readonly"></td>
				<td><input type="text" id="hPulseRate" name="hPulseRate"
					value="Pulse Rate(/min)" size="16" readonly="readonly"></td>
				<td><input type="text" id="hTemperature" name="hTemperature"
					value="Temperature(F)" size="15" readonly="readonly"></td>
				<td><input type="text" id="hDietAdvised" name="hDietAdvised"
					value="Diet Advised" size="11" readonly="readonly"></td>
				<td><input type="text" id="hNotes" name="hNotes"
					value="Notes(if any)" size="30" readonly="readonly"></td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="ipvs" items="${ipdPatientVitalStatistics}"
				varStatus="index">
				<c:choose>
					<c:when test="${index.count mod 2 == 0}">
						<c:set var="klass" value="odd" />
					</c:when>
					<c:otherwise>
						<c:set var="klass" value="even" />
					</c:otherwise>
				</c:choose>
				<tr>
					<td><input type="text" id="rSlNo" name="rSlNo"
						value="${index.count}" size="7" readonly="readonly"></td>
					<td><input type="text" id="rDateTime" name="rDateTime"
						value="${ipvs.createdOn}" size="21" readonly="readonly"></td>
					<td><input type="text" id="rBloodPressure"
						name="rBloodPressure" value="${ipvs.bloodPressure}" size="14"
						readonly="readonly"></td>
					<td><input type="text" id="rPulseRate" name="rPulseRate"
						value="${ipvs.pulseRate}" size="16" readonly="readonly"></td>
					<td><input type="text" id="rTemperature" name="rTemperature"
						value="${ipvs.temperature}" size="15" readonly="readonly">
					</td>
					<td><input type="text" id="rDietAdvised" name="rDietAdvised"
						value="${ipvs.dietAdvised}" size="11" readonly="readonly">
					</td>
					<td><input type="text" id="rNotes" name="rNotes"
						value="${ipvs.note}" size="30" readonly="readonly"></td>
				</tr>
			</c:forEach>
			<tr>
				<td><input type="text" id="slNo" name="slNo"
					value="${sizeOfipdPatientVitalStatistics}" size="7"
					readonly="readonly"></td>
				<td><input type="text" id="dateTime" name="dateTime"
					value="${dat}" size="21" readonly="readonly"></td>
				<td><input type="text" id="bloodPressure" name="bloodPressure"
					size="14"></td>
				<td><input type="text" id="pulseRate" name="pulseRate"
					size="16"></td>
				<td><input type="text" id="temperature" name="temperature"
					size="15"></td>
				<td><select id="dietAdvised" name="dietAdvised" size="3"
					multiple="multiple">
						<!--  
						<option value="">Select</option>
						-->
						<c:forEach items="${dietList}" var="dl">
							<option value="${dl.name}">${dl.name}</option>
						</c:forEach>
				</select></td>
				<td><input type="text" id="notes" name="notes" value=""
					size="30"></td>
			</tr>
		</tbody>
	</table>

	<table width="98%">
		<div align="right">
			<input type="submit"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Submit"> <input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Print" onclick="print();"> <input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Cancel" onclick="tb_cancel();">
		</div>
	</table>

	<div id="printVitalSlip" style="visibility: hidden;">
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
					<td><spring:message code="ipd.patient.patientName" />:&nbsp;${fn:replace(admitted.patientName,',',' ')}
					</td>
					<td><spring:message code="ipd.patient.patientId" />:&nbsp;${admitted.patientIdentifier}
					</td>
					<td><spring:message code="ipd.patient.age" />:&nbsp;${admitted.age
						}
					</td>
					<td><spring:message code="ipd.patient.gender" />:&nbsp;${admitted.gender
						}
					</td>
				</tr>
				<tr>
					<td colspan="4"><spring:message code="ipd.patient.fatherName" />:
						${relationName }</td>
				</tr>
				<tr>
					<td colspan="2"><spring:message
							code="ipd.patient.admittedWard" />:
						${admitted.admittedWard.name}</td>
					<td colspan="2"><spring:message code="ipd.patient.bedNumber" />:
						${admitted.bed }</td>
				</tr>
				<tr>
					<!-- ghansham 25-june-2013 issue no # 1924 Change in the address format -->
					<td><spring:message code="ipd.patient.address" />: ${address }
						</td>
				</tr>
			</table>

		</div>
		<br />
		<table class="box">
			<thead>
				<tr>
					<td><input type="text" id="hSlNo" name="hSlNo" value="S.No"
						size="7" readonly="readonly"></td>
					<td><input type="text" id="hDateTime" name="hDateTime"
						value="Date/Time" size="21" readonly="readonly"></td>
					<td><input type="text" id="hBloodPressure"
						name="hBloodPressure" value="Blood Pressure" size="14"
						readonly="readonly"></td>
					<td><input type="text" id="hPulseRate" name="hPulseRate"
						value="Pulse Rate(/min)" size="16" readonly="readonly"></td>
					<td><input type="text" id="hTemperature" name="hTemperature"
						value="Temperature(C)" size="15" readonly="readonly"></td>
					<td><input type="text" id="hDietAdvised" name="hDietAdvised"
						value="Diet Advised" size="11" readonly="readonly"></td>
					<td><input type="text" id="hNotes" name="hNotes"
						value="Notes(if any)" size="30" readonly="readonly"></td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="ipvs" items="${ipdPatientVitalStatistics}"
					varStatus="index">
					<c:choose>
						<c:when test="${index.count mod 2 == 0}">
							<c:set var="klass" value="odd" />
						</c:when>
						<c:otherwise>
							<c:set var="klass" value="even" />
						</c:otherwise>
					</c:choose>
					<tr>
						<td><input type="text" id="rSlNo" name="rSlNo"
							value="${index.count}" size="7" readonly="readonly"></td>
						<td><input type="text" id="rDateTime" name="rDateTime"
							value="${ipvs.createdOn}" size="21" readonly="readonly"></td>
						<td><input type="text" id="rBloodPressure"
							name="rBloodPressure" value="${ipvs.bloodPressure}" size="14"
							readonly="readonly"></td>
						<td><input type="text" id="rPulseRate" name="rPulseRate"
							value="${ipvs.pulseRate}" size="16" readonly="readonly">
						</td>
						<td><input type="text" id="rTemperature" name="rTemperature"
							value="${ipvs.temperature}" size="15" readonly="readonly">
						</td>
						<td><input type="text" id="rDietAdvised" name="rDietAdvised"
							value="${ipvs.dietAdvised}" size="11" readonly="readonly">
						</td>
						<td><input type="text" id="rNotes" name="rNotes"
							value="${ipvs.note}" size="30" readonly="readonly"></td>
					</tr>
				</c:forEach>
				<tr>
					<td><div id="printableSlNo"></div></td>
					<td><div id="printableDateTime"></div></td>
					<td><div id="printableBp"></div></td>
					<td><div id="printablePulseRate"></div></td>
					<td><div id="printabletemperature"></div></td>
					<td><div id="printableDiet"></div></td>
					<td><div id="printableNote"></div></td>
				</tr>
			</tbody>
		</table>

	</div>
</form>
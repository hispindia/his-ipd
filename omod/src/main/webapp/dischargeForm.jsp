
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
<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm"
	redirect="index.htm" />
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="includes/js_css.jsp"%>
<style>
.drug-order {
	width: 100%;
}

.drugs {
	width: 16%;
	height: 10%;
	float: left;
}

.formulation {
	width: 23%;
	height: 10%;
	float: left;
}

.frequency {
	width: 23%;
	height: 10%;
	float: left;
}

.no-of-days {
	width: 13%;
	height: 10%;
	float: left;
}

.comments {
	width: 13%;
	height: 10%;
	float: left;
}

.ui-button { margin-left: -1px; }
.ui-button-icon-only .ui-button-text { padding: 0.35em; } 
.ui-autocomplete-input { margin: 0; padding: 0.48em 0 0.47em 0.45em; }

.container {
	overflow: hidden;
}


</style> 

<script type="text/javascript">
var drugIssuedList = new Array();
function addDrugOrder() {
   var drugName=document.getElementById('drugName').value;
   drugIssuedList.push(drugName);
   if(drugName==null || drugName==""){
   alert("Please enter drug name");
   return false;
   }else{
   var formulation=document.getElementById('formulation').value;
   if(formulation==null || formulation==""){
   alert("Please select formulation");
   return false;
   }
   var formulationArr=formulation.split("."); 
   var frequency=document.getElementById('frequency').value;
   if(frequency==null || frequency==""){
   alert("Please select frequency");
   return false;
   }
   var frequencyArr=frequency.split("."); 
   var noOfDays=document.getElementById('noOfDays').value;
   if(noOfDays==null || noOfDays==""){
   alert("Please enter no of days");
   return false;
   }
   if (noOfDays!=null || noOfDays!=""){
    if(isNaN(noOfDays)){
    alert("Please enter no of days in correct format");
    return false;
    }
   }
   var comments=document.getElementById('comments').value;
   var deleteString = 'deleteInput(\"'+drugName+'\")';
   var htmlText =  "<div id='com_"+drugName+"_div'>"
	       	 +"<input id='"+drugName+"_name'  name='drugOrder' type='text' size='12' value='"+drugName+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_formulationName'  name='"+drugName+"_formulatioNname' type='text' size='14' value='"+formulationArr[0]+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_frequencyName'  name='"+drugName+"_frequencyName' type='text' size='6' value='"+frequencyArr[0]+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_noOfDays'  name='"+drugName+"_noOfDays' type='text' size='7' value='"+noOfDays+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_comments'  name='"+drugName+"_comments' type='text' size='12' value='"+comments+"'  readonly='readonly'/>&nbsp;&nbsp;"
	       	 +"<input id='"+drugName+"_formulationId'  name='"+drugName+"_formulationId' type='hidden' value='"+formulationArr[1]+"'/>&nbsp;"
	       	 +"<input id='"+drugName+"_frequencyId'  name='"+drugName+"_frequencyId' type='hidden' value='"+frequencyArr[1]+"'/>&nbsp;"
	       	 +"<a style='color:red' href='#' onclick='"+deleteString+"' >[X]</a>"		
	       	 +"</div>";
	       	
   var newElement = document.createElement('div');
   newElement.setAttribute("id", drugName);   
   newElement.innerHTML = htmlText;
   var fieldsArea = document.getElementById('headerValue');
   fieldsArea.appendChild(newElement);
   jQuery("#drugName").val("");
   jQuery("#formulation").val("");
   jQuery("#frequency").val("");
   jQuery("#noOfDays").val("");
   jQuery("#comments").val("");
   }
}
</script>
<input type="hidden" id="pageId" value="dischagePage" />
<input type="hidden" id="ipdWard" name="ipdWard" value="${ipdWard}" />
<form method="post" id="dischargeForm">
	<input type="hidden" id="id" name="admittedId" value="${admitted.id }" />
	<!-- harsh 14/6/2012: to get patient ID -->
	<input type="hidden" id="patientId" name="patientId"
		value="${patientId}" />

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
				<td><spring:message code="ipd.patient.patientName" />:&nbsp;<b>${admitted.patientName }</b></td>
				<td><spring:message code="ipd.patient.patientId" />:&nbsp;<b>${admitted.patientIdentifier}</b></td>
				<td><spring:message code="ipd.patient.age" />:&nbsp;<b>${admitted.age}</b></td>
				<td><spring:message code="ipd.patient.gender" />:&nbsp;<b>${admitted.gender }</b></td>
			</tr>
			<tr>
				<td colspan="2"><spring:message code="ipd.patient.category" />:
					${patCategory }</td>
				<td colspan="2"><spring:message
						code="ipd.patient.monthlyIncome" />: ${admitted.monthlyIncome}</td>
			</tr>
			<%-- ghanshyam 10/07/2012 New Requirement #312 [IPD] Add fields in the Discharge screen and print out --%>
			<tr>
				<td>${relationType }:&nbsp;${relationName }</td>
				<td colspan="2"><spring:message code="ipd.patient.bedNumber" />:
					${admitted.bed }</td>
			</tr>
			<tr>
				<td colspan="2"><spring:message code="ipd.patient.admittedWard" />:
					${admitted.admittedWard.name}</td>
			</tr>
			<%-- ghanshyam 10/07/2012 New Requirement #312 [IPD] Add fields in the Discharge screen and print out --%>
			<tr>
				<td colspan="4"><spring:message code="ipd.patient.homeAddress" />:
					${address }</td>
			</tr>
			<tr>
				<td colspan="4"><spring:message code="ipd.patient.date/time" />:
					${dateTime }</td>
			</tr>
		</table>

	</div>
	<br />
	<table class="box">
		<tr>
			<td colspan="3"><strong><spring:message
						code="patientdashboard.clinicalSummary.diagnosis" />:</strong><em>*</em> <input
				class="ui-autocomplete-input ui-widget-content ui-corner-all"
				id="diagnosis" title="${opd.conceptId}" style="width: 290px"
				name="diagnosis" /></td>
		</tr>
		<tr>
			<td>
				<!-- List of all available DataElements -->
				<div id="divAvailableDiagnosisList">
					<select size="8" style="width: 400px;" id="availableDiagnosisList"
						name="availableDiagnosisList" multiple="multiple"
						style="min-width:25em;height:10em"
						ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');">
						<c:forEach items="${listDiagnosis}" var="diagnosis">
							<option value="${diagnosis.id}">${diagnosis.name}</option>
						</c:forEach>
					</select>
				</div>
			</td>
			<td><input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&gt;" style="width: 50px"
				onclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList');" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&lt;" style="width: 50px"
				onclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList');" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&gt;&gt;" style="width: 50px"
				onclick="moveAllById( 'availableDiagnosisList', 'selectedDiagnosisList' );" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&lt;&lt;" style="width: 50px"
				onclick="moveAllById( 'selectedDiagnosisList', 'availableDiagnosisList' );" />
			</td>
			<td>
				<!-- List of all selected DataElements --> <select size="8"
				style="width: 400px;" id="selectedDiagnosisList"
				name="selectedDiagnosisList" multiple="multiple"
				style="min-width:25em;height:10em"
				ondblclick="moveSelectedById( 'selectedDiagnosisList', 'availableDiagnosisList' );">
					<c:forEach items="${sDiagnosisList}" var="ss">
						<option value="${ss.id}">${ss.name}</option>
					</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div class="ui-widget">
					<strong><spring:message code="patientdashboard.procedures" />:</strong>
					<input
						class="ui-autocomplete-input ui-widget-content ui-corner-all"
						title="${opd.conceptId }" id="procedure" style="width: 300px"
						name="procedure" />
				</div>

			</td>
		</tr>
		<tr>
			<td>
				<!-- List of all available DataElements -->
				<div id="divAvailableProcedureList">
					<select size="8" style="width: 400px;" id="availableProcedureList"
						name="availableProcedureList" multiple="multiple"
						style="min-width:25em;height:10em"
						ondblclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');">
						<c:forEach items="${listProcedures}" var="procedure">
							<option value="${procedure.conceptId}">${procedure.name}</option>
						</c:forEach>
					</select>
				</div>
			</td>
			<td><input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&gt;" style="width: 50px"
				onclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList');" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&lt;" style="width: 50px"
				onclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList');" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&gt;&gt;" style="width: 50px"
				onclick="moveAllById( 'availableProcedureList', 'selectedProcedureList' );" /><br />
				<input type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="&lt;&lt;" style="width: 50px"
				onclick="moveAllById( 'selectedProcedureList', 'availableProcedureList' );" />
			</td>
			<td>
				<!-- List of all selected DataElements --> <select size="8"
				style="width: 400px;" id="selectedProcedureList"
				name="selectedProcedureList" multiple="multiple"
				style="min-width:25em;height:5em"
				ondblclick="moveSelectedById( 'selectedProcedureList', 'availableProcedureList' )">
					<c:forEach items="${sProcedureList}" var="xx">
						<option value="${xx.id}">${xx.name}</option>
					</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div class="ui-widget">
					<strong>Drug:</strong>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="1">
				<div class="drug-order" id="drugOrder"
					style="background: #FFFFFF; border: 1px #808080 solid; padding: 0.3em; margin: 0.3em 0em; min-width: 25em; height: 5em;">
					<div class="drugs" class="ui-widget">
						<input title="${opd.conceptId}" id="drugName" name="drugName"
							placeholder="Search for drugs" onblur="ISSUE.onBlur(this);" />
					</div>
					<div class="formulation" id="divFormulation">
						<select id="formulation" name="formulation">
							<option value="">
								<spring:message code="patientdashboard.SelectFormulation" />
							</option>
						</select>
					</div>
					<div class="frequency">
						<select id="frequency" name="frequency">
							<option value="">Select Frequency</option>
							<c:forEach items="${drugFrequencyList}" var="dfl">
								<option value="${dfl.name}.${dfl.conceptId}">${dfl.name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="no-of-days">
						<input type="text" id="noOfDays" name="noOfDays"
							placeholder="No Of Days" size="7">
					</div>

					<div class="comments">
						<TEXTAREA id="comments" name="comments" placeholder="Comments"
							rows=1 cols=8></TEXTAREA>
					</div>

				</div>
			</td>

			<td><div class="add">
					<input type="button"
						class="ui-button ui-widget ui-state-default ui-corner-all"
						value="Add" onClick="addDrugOrder();" />
				</div></td>

			<td>
				<div id="headerValue"
					style="background: #FFFFFF; border: 1px #808080 solid; padding: 0.3em; margin: 0.3em 0em; width: 100%;">
					<input type='text' id="drug" name="drug" value='Drugs' size="12"
						readonly="readonly" />&nbsp; <input type='text' id="formulation"
						name='formulation' value="Formulation" size="14"
						readonly="readonly" />&nbsp; <input type='text' id='frequency'
						name='frequency' value='Frequency' size="6" readonly="readonly" />&nbsp;
					<input type='text' id='noOfDays' name='noOfDays' value='No Of Days'
						size="7" readonly="readonly" />&nbsp; <input type='text'
						id='comments' name='comments' value='Comments' size="12"
						readonly="readonly" />&nbsp;
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">Out come<em>*</em> <select id="outCome"
				name="outCome">
					<option value="">[Please Select]</option>
					<c:forEach items="${listOutCome}" var="outCome">
						<option value="${outCome.answerConcept.id}">${outCome.answerConcept.name }</option>
					</c:forEach>
			</select></td>
			<td></td>
		</tr>
	</table>

	<table width="98%">
		<%-- ghanshyam 27-sept-2012 Support #387 [ALL] Small changes in all modules(note:these lines of code written for cancel button) --%>
		<div align="right">
			<input type="submit"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Submit" onclick="ADMITTED.submitIpdFinalResult();"> <input
				type="button"
				class="ui-button ui-widget ui-state-default ui-corner-all"
				value="Cancel" onclick="tb_cancel();">
		</div>
	</table>

</form>
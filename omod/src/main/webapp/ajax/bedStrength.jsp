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

<script type="text/javascript">
function validateCheck(checkAlert,maxPatientOnBed){
	if(document.forms["transferForm"] != undefined)
	{
	document.forms["transferForm"]["bedNumber"].value=checkAlert;	
	}
	else {
	var mpob=parseInt(maxPatientOnBed);
	if(mpob>0 && ${isBedVacant}==true){
	alert("please select vacant bed");
	jQuery("#bedNumber").val("");  
	return false;
	}
	else if(mpob>1 && ${isBedWithOnePatient}==true){
	alert("please select one bed patient");
	jQuery("#bedNumber").val("");  
	return false;
	}
	else if(mpob>2){
	alert("This bed already has 3 patients admitted. Please select another bed.");
	jQuery("#bedNumber").val("");  
	return false;
	}
	else{
	document.forms["admissionForm"]["bedNumber"].value=checkAlert;
	 }
	}
}
</script>

<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<form method="POST"  id="BedStrength">
<input type="hidden" name="size" value="${size}">
<c:set var="count" value="0" />
<c:set var="bedCount" value="0" />
<c:set var="bedOccupied" value="0" />
<c:set var="bedMax" value="${bedMax}" />
<c:forEach begin="1" end="${bedMax}" step="1" var="m">
	<c:set var="bedCount" value="${bedCount +1 }" />
	<c:choose>
	<c:when test="${bedStrengthMap[bedCount] != null && bedStrengthMap[bedCount] > 0}">
		<c:set var="bedOccupied" value="${bedOccupied +1 }" />
	</c:when>
	</c:choose>
</c:forEach>

<table border = .5>
	<c:forEach begin="1" end="${size}" step="1" var="i">
	<tr>
		<c:forEach begin="1" end="${size}" step="1" var="j">
		<c:set var="count" value="${count +1 }" />			
		<c:choose>
					<c:when test="${bedStrengthMap[count] != null }">
						<c:choose>
							<c:when test="${bedStrengthMap[count] > 0 && bedOccupied < bedMax}">
								<td>
									<input id="validate" name="validateName" size="4" style="background-color:red" onMouseOver="this.bgColor='#00CC00'" value="${count}/${bedStrengthMap[count]}" readonly="readonly" onclick="javascript:return validateCheck(${count},${bedStrengthMap[count]});"/>
							</c:when>
							
							<c:when test="${bedStrengthMap[count] > 0 && bedOccupied >= bedMax}">
								<td>
									<input id="validate" name="validateName" size="4" style="background-color:red" onMouseOver="this.bgColor='#00CC00'" value="${count}/${bedStrengthMap[count]}" readonly="readonly" onclick="javascript:return validateCheck(${count},${bedStrengthMap[count]});" />
							</c:when>
							
							<c:otherwise>
								<td style="background-color:green" onMouseOver="this.bgColor='#00CC11'">
									<input id="validate" name="validateName" size="4" style="background-color:green" onMouseOver="this.bgColor='#00CC00'" value="${count}/${bedStrengthMap[count]}" readonly="readonly" onclick="javascript:return validateCheck(${count},${bedStrengthMap[count]});" />
							</c:otherwise>
						</c:choose>

					</td>	
					</c:when>
					<c:otherwise>
						
					</c:otherwise>
				</c:choose>
		</c:forEach>
	</tr>
	</c:forEach>
		
</table>
<input id="bedMax" name="bedMax" type="hidden" value="${bedMax}"/>
</form>


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

<form method="POST"  id="ManageWardStrengthForm">
<table>
	<tr>
	<td>Ward Name</td>
	<td>Bed Strength</td>
	</tr>
	<c:if test="${not empty wards }">			  	
		<c:forEach items="${wards}" var="ward">
		<tr>
		<td>	${ward.answerConcept.name} </td>
		<td><input type="text" id="${ward.answerConcept.id}" style="width: 80px;" name="${ward.answerConcept.id}"  value = "${bedStrengthMap[ward.answerConcept.id] }"/></td>
		</tr>
		</c:forEach>
    </c:if>
</table>
<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value = "Save"/>

</form>

<%@ include file="/WEB-INF/template/footer.jsp" %> 
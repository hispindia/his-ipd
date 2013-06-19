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

<form method="POST"  id="BedStrength">

<c:set var="count" value="0" />
<table border = .5>
	<c:forEach begin="1" end="${size}" step="1" var="i">
	<tr>
		<c:forEach begin="1" end="${size}" step="1" var="j">
		<c:set var="count" value="${count +1 }" />			
		<c:choose>
					<c:when test="${bedStrengthMap[count] != null }">
						<c:choose>
							<c:when test="${bedStrengthMap[count] > 0 }">
								<td style="background-color:red" onMouseOver="this.bgColor='#00CC00'">
							</c:when>
							<c:otherwise>
								<td style="background-color:green" onMouseOver="this.bgColor='#00CC00'">
							</c:otherwise>
						</c:choose>
						${count}/${bedStrengthMap[count]}
					</td>	
					</c:when>
					<c:otherwise>
						
					</c:otherwise>
				</c:choose>
		
		
		
		</c:forEach>
	</tr>
	</c:forEach>
		
</table>

</form>


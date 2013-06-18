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
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />

<form method="POST"  id="BedStrength">
${bedStrengthMap[4]}

<table>

<c:forEach items="${bedStrengthMap}" var="bedStrength">


</c:forEach>
	<tr>
	<td>hi</td>
	<td>Bed Strength</td>
	</tr>
	
</table>

</form>


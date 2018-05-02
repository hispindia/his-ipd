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




<b style="text-align: center" class="boxHeader">IPD Ward Selection</b>
<input type="hidden" id="pageId" value="Ipd"/>
<div class="box" >
<form method="get"  id="chooseIpdWardForm" action="main.htm">
<input type="hidden" name="tab" id="tab" value="${tab}">
<table id="ipdWardtable" width="100%">
		<tr >
		
			<td width="100%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select Ipd Ward :
			
				<select id="ipdWard"  name="ipdWard" style="width: 400px;" >
					<option value="">
						<c:forEach items="${listIpd}" var="ipd" >
			          			<option value="${ipd.answerConcept.id}">
			          			${ipd.answerConcept.name}
			          			</option> 
			          			<c:if test="${ipdId == ipd.answerConcept.id  }">selected="selected"</c:if>
			        	</c:forEach>
			        	</option>
		       	</select> 
	  		</td>
	  		</tr>
	  		<tr>
	  		<td width="100%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"  
	  		 class="ui-button ui-widget ui-state-default ui-corner-all" value="Go" /></td>
		</tr>
			
</table>
</form>


</div>


<%@ include file="/WEB-INF/template/footer.jsp" %> 
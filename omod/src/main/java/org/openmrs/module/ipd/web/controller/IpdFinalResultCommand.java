/**
 *  Copyright 2010 Health Information Systems Project of India
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
 **/


package org.openmrs.module.ipd.web.controller;

/**
 * <p> Class: IpdFinalResultCommand </p>
 * <p> Package: org.openmrs.module.patientdashboard.web.controller.ajax </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 26, 2011 1:02:39 PM </p>
 * <p> Update date: Mar 26, 2011 1:02:39 PM </p>
 **/
public class IpdFinalResultCommand {
	private Integer[] selectedDiagnosisList;
	private Integer[] selectedProcedureList;
	private Integer admissionLogId;
	private Integer admittedId;
	private Integer outCome;
	public Integer[] getSelectedDiagnosisList() {
		return selectedDiagnosisList;
	}
	public void setSelectedDiagnosisList(Integer[] selectedDiagnosisList) {
		this.selectedDiagnosisList = selectedDiagnosisList;
	}
	public Integer[] getSelectedProcedureList() {
		return selectedProcedureList;
	}
	public void setSelectedProcedureList(Integer[] selectedProcedureList) {
		this.selectedProcedureList = selectedProcedureList;
	}
	public Integer getAdmissionLogId() {
		return admissionLogId;
	}
	public void setAdmissionLogId(Integer admissionLogId) {
		this.admissionLogId = admissionLogId;
	}
	public Integer getOutCome() {
		return outCome;
	}
	public void setOutCome(Integer outCome) {
		this.outCome = outCome;
	}
	public Integer getAdmittedId() {
		return admittedId;
	}
	public void setAdmittedId(Integer admittedId) {
		this.admittedId = admittedId;
	}
	
	
	
}

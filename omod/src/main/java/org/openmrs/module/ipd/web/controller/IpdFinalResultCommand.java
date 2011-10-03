/**
 * <p> File: org.openmrs.module.patientdashboard.web.controller.ajax.IpdFinalResultCommand.java </p>
 * <p> Project: patientdashboard-omod </p>
 * <p> Copyright (c) 2011 HISP Technologies. </p>
 * <p> All rights reserved. </p>
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Email: chuyennmth@gmail.com</p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 26, 2011 1:02:39 PM </p>
 * <p> Update date: Mar 26, 2011 1:02:39 PM </p>
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

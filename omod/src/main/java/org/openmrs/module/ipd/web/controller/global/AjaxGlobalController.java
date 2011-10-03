/**
 * <p> File: org.openmrs.module.ipd.web.controller.global.AjaxGlobalController.java </p>
 * <p> Project: ipd-omod </p>
 * <p> Copyright (c) 2011 HISP Technologies. </p>
 * <p> All rights reserved. </p>
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 15, 2011 12:58:02 PM </p>
 * <p> Update date: Mar 15, 2011 12:58:02 PM </p>
 **/

package org.openmrs.module.ipd.web.controller.global;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openmrs.Concept;
import org.openmrs.PersonAttribute;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.model.Department;
import org.openmrs.module.hospitalcore.model.DepartmentConcept;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmission;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmissionLog;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.OpdPatientQueueLog;
import org.openmrs.module.ipd.util.IpdUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p>
 * Class: AjaxGlobalController
 * </p>
 * <p>
 * Package: org.openmrs.module.ipd.web.controller.global
 * </p>
 * <p>
 * Author: Nguyen manh chuyen
 * </p>
 * <p>
 * Update by: Nguyen manh chuyen
 * </p>
 * <p>
 * Version: $1.0
 * </p>
 * <p>
 * Create date: Mar 15, 2011 12:58:02 PM
 * </p>
 * <p>
 * Update date: Mar 15, 2011 12:58:02 PM
 * </p>
 **/
@Controller("IPDAjaxGlobalController")
public class AjaxGlobalController {

	@RequestMapping(value = "/module/ipd/gotoDashboard.htm", method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "id", required = false) Integer id,
			Model model) {
		IpdService is = (IpdService) Context.getService(IpdService.class);
		IpdPatientAdmitted pa = is.getIpdPatientAdmitted(id);
		IpdPatientAdmissionLog pal = pa.getPatientAdmissionLog();
		OpdPatientQueueLog pql = pal.getOpdLog();
		Integer patientId = pql.getPatient().getPatientId();
		Integer opdId = pql.getOpdConcept().getConceptId();
		Integer referralId = pql.getReferralConcept().getConceptId();
		String url = "/module/patientdashboard/main.htm?patientId=" + patientId + "&opdId=" + opdId + "&referralId=" + referralId;		
		return "redirect:" + url;
	}
	@RequestMapping(value = "/module/ipd/addConceptToWard.htm" , method=RequestMethod.POST)
	public String addConceptToWard(
			@RequestParam(value ="opdId",required=false) Integer opdId, 
			@RequestParam(value ="conceptId",required=false) Integer conceptId,
			@RequestParam(value ="typeConcept",required=false) Integer typeConcept,
			Model model){
		
		if(opdId != null && opdId > 0 && conceptId != null && conceptId > 0 && typeConcept != null && typeConcept > 0){
			PatientDashboardService patientDashboardService = Context.getService(PatientDashboardService.class);
			Department department = patientDashboardService.getDepartmentByWard(opdId);
			Concept concept = Context.getConceptService().getConcept(conceptId);
			if(concept != null && department != null){
				DepartmentConcept departmentConcept = new DepartmentConcept();
				departmentConcept.setConcept(concept);
				departmentConcept.setDepartment(department);
				departmentConcept.setCreatedOn(new Date());
				departmentConcept.setCreatedBy(Context.getAuthenticatedUser().getGivenName());
				departmentConcept.setTypeConcept(typeConcept);
				patientDashboardService.createDepartmentConcept(departmentConcept);
			}
		}
		
		return "/module/ipd/ajax/addConceptToWard";
	}
	@RequestMapping(value = "/module/ipd/patientsForAdmissionAjax.htm", method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "searchPatient", required = false) String searchPatient,// patient
																							// name
																							// or
																							// patient
																							// identifier
			@RequestParam(value = "fromDate", required = false) String fromDate,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "ipdWardString", required = false) String ipdWardString, // ipdWard
																							// multiselect
			@RequestParam(value = "doctorString", required = false) String doctorString,
			Model model) {

		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		List<IpdPatientAdmission> listPatientAdmission = ipdService
				.searchIpdPatientAdmission(searchPatient,
						IpdUtils.convertStringToList(doctorString),
						fromDate, toDate,
						IpdUtils.convertStringToList(ipdWardString), "");

		model.addAttribute("listPatientAdmission", listPatientAdmission);

		return "module/ipd/ajax/patientsForAdmissionAjax";
	}

	@RequestMapping(value = "/module/ipd/admittedPatientIndexAjax.htm", method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "searchPatient", required = false) String searchPatient,// patient
																							// name
																							// or
																							// patient
																							// identifier
			@RequestParam(value = "fromDate", required = false) String fromDate,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "ipdWardString", required = false) String ipdWardString, // note
																							// ipdWardString
																							// =
																							// 1,2,3,4.....
			@RequestParam(value = "tab", required = false) Integer tab, // If
																		// that
																		// tab
																		// is
																		// active
																		// we
																		// will
																		// set
																		// that
																		// tab
																		// active
																		// when
																		// page
																		// load.
			@RequestParam(value = "doctorString", required = false) String doctorString,// note:
																						// doctorString=
																						// 1,2,3,4.....
			Model model) {
		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		List<IpdPatientAdmitted> listPatientAdmitted = ipdService
				.searchIpdPatientAdmitted(searchPatient,
						IpdUtils.convertStringToList(doctorString),
						fromDate, toDate,
						IpdUtils.convertStringToList(ipdWardString), "");

		Map<Integer, String> mapRelationName = new HashMap<Integer, String>();
		for (IpdPatientAdmitted admit : listPatientAdmitted) {
			PersonAttribute relationNameattr = admit.getPatient().getAttribute(
					"Father/Husband Name");
			mapRelationName.put(admit.getId(), relationNameattr.getValue());
		}
		model.addAttribute("mapRelationName", mapRelationName);

		model.addAttribute("listPatientAdmitted", listPatientAdmitted);

		return "module/ipd/ajax/admittedListAjax";
	}
}

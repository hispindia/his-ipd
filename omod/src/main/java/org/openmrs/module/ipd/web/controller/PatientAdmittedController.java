/**
 *  Copyright 2010 Society for Health Information Systems Programmes, India (HISP India)
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

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.Encounter;
import org.openmrs.GlobalProperty;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.PersonAddress;
import org.openmrs.PersonAttribute;
import org.openmrs.PersonAttributeType;
import org.openmrs.Role;
import org.openmrs.User;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.ipd.util.IpdConstants;
import org.openmrs.module.ipd.util.IpdUtils;
import org.openmrs.module.hospitalcore.HospitalCoreService;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.PatientQueueService;
import org.openmrs.module.hospitalcore.model.DepartmentConcept;
import org.openmrs.module.hospitalcore.model.InventoryDrug;
import org.openmrs.module.hospitalcore.model.InventoryDrugFormulation;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmitted;
import org.openmrs.module.hospitalcore.model.IpdPatientAdmittedLog;
import org.openmrs.module.hospitalcore.model.IpdPatientVitalStatistics;
import org.openmrs.module.hospitalcore.model.OpdDrugOrder;
import org.openmrs.module.hospitalcore.model.PatientSearch;
import org.openmrs.module.hospitalcore.util.ConceptComparator;
import org.openmrs.module.hospitalcore.util.HospitalCoreConstants;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.hospitalcore.util.PatientUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p>
 * Class: PatientAdmittedController
 * </p>
 * <p>
 * Package: org.openmrs.module.ipd.web.controller
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
 * Create date: Mar 18, 2011 12:43:28 PM
 * </p>
 * <p>
 * Update date: Mar 18, 2011 12:43:28 PM
 * </p>
 **/
@Controller("IPDPatientAdmittedController")
public class PatientAdmittedController {

	Log log = LogFactory.getLog(getClass());

	@RequestMapping(value = "/module/ipd/admittedPatientIndex.htm", method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "searchPatient", required = false) String searchPatient,// patient
																							// name
																							// or
																							// patient
																							// identifier
			@RequestParam(value = "fromDate", required = false) String fromDate,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			// @RequestParam(value = "ipdWardString", required = false) String
			// ipdWardString, //note ipdWardString = 1,2,3,4.....
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
						IpdUtils.convertStringToList(doctorString), fromDate,
						toDate, ipdWard, "");

		/*
		 * Sagar Bele 08-08-2012 Support #327 [IPD] (DDU(SDMX)instance)
		 * snapshot- age column in IPD admitted patient index
		 */
		model.addAttribute("listPatientAdmitted", listPatientAdmitted);

		Map<Integer, String> mapRelationName = new HashMap<Integer, String>();
		Map<Integer, String> mapRelationType = new HashMap<Integer, String>();
		for (IpdPatientAdmitted admit : listPatientAdmitted) {
			PersonAttribute relationNameattr = admit.getPatient().getAttribute(
					"Father/Husband Name");
			// ghanshyam 10/07/2012 New Requirement #312 [IPD] Add fields in the
			// Discharge screen and print out
		/*	PersonAddress add = admit.getPatient().getPersonAddress();
			String address1 = add.getAddress1();
			if (address1 != null) {
				String address = " " + add.getAddress1() + " "
						+ add.getCountyDistrict() + " " + add.getCityVillage();
				model.addAttribute("address", address);
			} else {
				String address = " " + add.getCountyDistrict() + " "
						+ add.getCityVillage();
				model.addAttribute("address", address);
			}*/
			String[] parts=admit.getPatientAddress().split("-");
			model.addAttribute("address", parts[0]);
			PersonAttribute relationTypeattr = admit.getPatient().getAttribute(
					"Relative Name Type");
			// ghanshyam 30/07/2012 this code modified under feedback of 'New
			// Requirement #313'
			if (relationTypeattr != null) {
				mapRelationType.put(admit.getId(), relationTypeattr.getValue());
			} else {
				mapRelationType.put(admit.getId(), "Relative Name");
			}
			mapRelationName.put(admit.getId(), relationNameattr.getValue());
		}
		model.addAttribute("mapRelationName", mapRelationName);
		model.addAttribute("mapRelationType", mapRelationType);
		model.addAttribute("dateTime", new Date().toString());
		model.addAttribute("ipdWard", ipdWard);
		// model.addAttribute("listPatientAdmitted", listPatientAdmitted);

		return "module/ipd/admittedList";
	}

	@RequestMapping(value = "/module/ipd/treatment.htm", method = RequestMethod.GET)
	public String treatmentView(
			@RequestParam(value = "id", required = false) Integer admittedId,
			@ModelAttribute("ipdCommand") IpdFinalResultCommand command,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			Model model) {

		HospitalCoreService hospitalCoreService = (HospitalCoreService) Context
				.getService(HospitalCoreService.class);
		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		IpdPatientAdmitted admitted = ipdService
				.getIpdPatientAdmitted(admittedId);

		Patient patient = admitted.getPatient();
		model.addAttribute("patientId", patient.getId());

	/*	PersonAddress add = patient.getPersonAddress();
		String address = add.getAddress1();
		String district = add.getCountyDistrict();
		String upazila = add.getCityVillage();
		model.addAttribute("address", StringUtils.isNotBlank(address) ? address
				: "");
		model.addAttribute("district", district);
		model.addAttribute("upazila", upazila);*/
		
		//New requirement only address entered in text box should be visible
		String[] parts=admitted.getPatientAddress().split("-");
		model.addAttribute("address", parts[0]);

		PersonAttribute relationNameattr = patient
				.getAttribute("Father/Husband Name");
		PersonAttribute relationTypeattr = patient
				.getAttribute("Relative Name Type");
		model.addAttribute("relationName", relationNameattr.getValue());
		if (relationTypeattr != null) {
			model.addAttribute("relationType", relationTypeattr.getValue());
		} else {
			model.addAttribute("relationType", "Relative Name");
		}
		model.addAttribute("dateTime", new Date());

		model.addAttribute("admitted", admitted);

		// change CHUYEN

		//
		ConceptService conceptService = Context.getConceptService();
		AdministrationService administrationService = Context
				.getAdministrationService();
		String gpDiagnosis = administrationService
				.getGlobalProperty(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		String gpProcedure = administrationService
				.getGlobalProperty(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		List<Obs> obsList = new ArrayList<Obs>(admitted
				.getPatientAdmissionLog().getIpdEncounter().getAllObs());
		Concept conDiagnosis = conceptService.getConcept(gpDiagnosis);

		Concept conProcedure = conceptService.getConcept(gpProcedure);

		List<Concept> selectedDiagnosisList = new ArrayList<Concept>();
		List<Concept> selectedProcedureList = new ArrayList<Concept>();
		if (CollectionUtils.isNotEmpty(obsList)) {
			for (Obs obs : obsList) {
				if (obs.getConcept().getConceptId()
						.equals(conDiagnosis.getConceptId())) {
					selectedDiagnosisList.add(obs.getValueCoded());
				}
				if (obs.getConcept().getConceptId()
						.equals(conProcedure.getConceptId())) {
					selectedProcedureList.add(obs.getValueCoded());
				}
			}
		}

		//
		PatientDashboardService dashboardService = Context
				.getService(PatientDashboardService.class);
		List<Concept> diagnosis = dashboardService.listByDepartmentByWard(
				admitted.getAdmittedWard().getId(), DepartmentConcept.TYPES[0]);
		if (CollectionUtils.isNotEmpty(diagnosis)
				&& CollectionUtils.isNotEmpty(selectedDiagnosisList)) {
			diagnosis.removeAll(selectedDiagnosisList);
		}
		if (CollectionUtils.isNotEmpty(diagnosis)) {
			Collections.sort(diagnosis, new ConceptComparator());
		}
		model.addAttribute("listDiagnosis", diagnosis);

		List<Obs> pDiagnosis = new ArrayList<Obs>();
		List<Obs> pFinalDiagnosis = new ArrayList<Obs>();
		Set<String> lhs = new LinkedHashSet<String>();
		pDiagnosis = hospitalCoreService.getObsInstanceForDiagnosis(admitted
				.getPatientAdmissionLog().getOpdLog().getEncounter(), Context
				.getConceptService().getConcept("PROVISIONAL DIAGNOSIS"));
		pDiagnosis.addAll(hospitalCoreService.getObsInstanceForDiagnosis(
				admitted.getPatientAdmissionLog().getIpdEncounter(), Context
						.getConceptService()
						.getConcept("PROVISIONAL DIAGNOSIS")));
		pFinalDiagnosis = hospitalCoreService.getObsInstanceForDiagnosis(
				admitted.getPatientAdmissionLog().getOpdLog().getEncounter(),
				Context.getConceptService().getConcept("FINAL DIAGNOSIS"));
		pDiagnosis.addAll(pFinalDiagnosis);
		pDiagnosis.addAll(hospitalCoreService.getObsInstanceForDiagnosis(
				admitted.getPatientAdmissionLog().getIpdEncounter(), Context
						.getConceptService().getConcept("FINAL DIAGNOSIS")));
		String pd = "";
		if (pDiagnosis.size() > 0) {
			for (Obs pDiagnos : pDiagnosis) {
				lhs.add(pDiagnos.getValueCoded().getName().getName());
			}
			for (String lh : lhs) {
				pd = pd + lh + ",";
			}
			pd = pd.substring(0, pd.length() - 1);
		}

		model.addAttribute("provisionalDiagnosis", pd);

		List<Concept> procedures = dashboardService.listByDepartmentByWard(
				admitted.getAdmittedWard().getId(), DepartmentConcept.TYPES[1]);
		if (CollectionUtils.isNotEmpty(procedures)
				&& CollectionUtils.isNotEmpty(selectedProcedureList)) {
			procedures.removeAll(selectedProcedureList);
		}
		if (CollectionUtils.isNotEmpty(procedures)) {
			Collections.sort(procedures, new ConceptComparator());
		}
		model.addAttribute("listProcedures", procedures);

		Collections.sort(selectedDiagnosisList, new ConceptComparator());
		Collections.sort(selectedProcedureList, new ConceptComparator());
		// Patient category
		model.addAttribute("patCategory",
				PatientUtils.getPatientCategory(patient));
		model.addAttribute("sDiagnosisList", selectedDiagnosisList);
		model.addAttribute("sProcedureList", selectedProcedureList);

		InventoryCommonService inventoryCommonService = Context
				.getService(InventoryCommonService.class);
		List<Concept> drugFrequencyConcept = inventoryCommonService
				.getDrugFrequency();
		model.addAttribute("drugFrequencyList", drugFrequencyConcept);

		Concept concept = Context.getConceptService().getConcept(
				"MINOR OPERATION");

		Collection<ConceptAnswer> allMinorOTProcedures = null;
		List<Integer> id = new ArrayList<Integer>();
		if (concept != null) {
			allMinorOTProcedures = concept.getAnswers();
			for (ConceptAnswer c : allMinorOTProcedures) {
				id.add(c.getAnswerConcept().getId());
			}
		}
		model.addAttribute("allMinorOTProcedures", id);

		Concept concept2 = Context.getConceptService().getConcept(
				"MAJOR OPERATION");

		Collection<ConceptAnswer> allMajorOTProcedures = null;
		List<Integer> id2 = new ArrayList<Integer>();
		if (concept2 != null) {
			allMajorOTProcedures = concept2.getAnswers();
			for (ConceptAnswer c : allMajorOTProcedures) {
				id2.add(c.getAnswerConcept().getId());
			}
		}
		model.addAttribute("allMajorOTProcedures", id2);

		model.addAttribute("ipdWard", ipdWard);

		String hospitalName = Context.getAdministrationService()
				.getGlobalProperty("hospital.location_user");
		model.addAttribute("hospitalName", hospitalName);

		SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
		model.addAttribute("currentDateTime", sdf.format(new Date()));

		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		List<PersonAttribute> pas = hcs.getPersonAttributes(patient
				.getPatientId());
		for (PersonAttribute pa : pas) {
			PersonAttributeType attributeType = pa.getAttributeType();
			if (attributeType.getPersonAttributeTypeId() == 14) {
				model.addAttribute("selectedCategory", pa.getValue());
			}

		}

		String patientName;
		if (patient.getMiddleName() != null) {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName() + " " + patient.getMiddleName();
		} else {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName();
		}
		model.addAttribute("patientName", patientName);

		Date birthday = patient.getBirthdate();
		model.addAttribute("age", PatientUtils.estimateAge(birthday));

		return "module/ipd/treatmentForm";
	}

	@RequestMapping(value = "/module/ipd/treatment.htm", method = RequestMethod.POST)
	public String treatmentPost(
			@RequestParam(value = "drugOrder", required = false) String[] drugOrder,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			@ModelAttribute("ipdCommand") IpdFinalResultCommand command,
			HttpServletRequest request, Model model) throws Exception {

		HospitalCoreService hcs = (HospitalCoreService) Context
				.getService(HospitalCoreService.class);
		IpdService ipdService = Context.getService(IpdService.class);
		IpdPatientAdmitted admitted = ipdService.getAdmittedByPatientId(command
				.getPatientId());
		Patient patient = Context.getPatientService().getPatient(
				command.getPatientId());

		AdministrationService administrationService = Context
				.getAdministrationService();
		GlobalProperty procedure = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		GlobalProperty investigationn = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_FOR_INVESTIGATION);
		User user = Context.getAuthenticatedUser();
		Date date = new Date();
		PatientDashboardService patientDashboardService = Context
				.getService(PatientDashboardService.class);
		Concept cOtherInstructions = Context.getConceptService()
				.getConceptByName("OTHER INSTRUCTIONS");
		Obs obsGroup = null;
		obsGroup = hcs.getObsGroupCurrentDate(patient.getPersonId());
		Encounter encounter = new Encounter();
		encounter = admitted.getPatientAdmissionLog().getIpdEncounter();
		Location location = new Location(1);

		ConceptService conceptService = Context.getConceptService();

		if (admitted != null) {
			if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {
				Concept cProcedure = Context.getConceptService()
						.getConceptByName(procedure.getPropertyValue());
				if (cProcedure == null) {
					throw new Exception("Post for procedure concept null");
				}
				for (Integer pId : command.getSelectedProcedureList()) {
					Obs oProcedure = new Obs();
					oProcedure.setObsGroup(obsGroup);
					oProcedure.setConcept(cProcedure);
					oProcedure.setValueCoded(Context.getConceptService()
							.getConcept(pId));
					oProcedure.setCreator(user);
					oProcedure.setDateCreated(date);
					oProcedure.setEncounter(encounter);
					oProcedure.setObsDatetime(encounter.getEncounterDatetime());
					oProcedure.setLocation(location);
					oProcedure.setPatient(patient);
					Context.getObsService().saveObs(oProcedure,
							"save procedure");
				}

			}

			if (!ArrayUtils.isEmpty(command.getSelectedInvestigationList())) {
				Concept coninvt = Context.getConceptService().getConceptByName(
						investigationn.getPropertyValue());
				if (coninvt == null) {
					throw new Exception("Investigation concept null");
				}
				for (Integer pId : command.getSelectedInvestigationList()) {
					Obs obsInvestigation = new Obs();
					obsInvestigation.setObsGroup(obsGroup);
					obsInvestigation.setConcept(coninvt);
					obsInvestigation.setValueCoded(Context.getConceptService()
							.getConcept(pId));
					obsInvestigation.setCreator(user);
					obsInvestigation.setDateCreated(date);
					obsInvestigation.setEncounter(encounter);
					obsInvestigation.setObsDatetime(encounter
							.getEncounterDatetime());
					obsInvestigation.setLocation(location);
					obsInvestigation.setPatient(patient);
					Context.getObsService().saveObs(obsInvestigation,
							"save investigation");
				}

			}

			if (StringUtils.isNotBlank(command.getNote())) {
				Obs obs = new Obs();
				obs.setObsGroup(obsGroup);
				obs.setConcept(cOtherInstructions);
				obs.setValueText(command.getNote());
				obs.setCreator(user);
				obs.setDateCreated(date);
				obs.setEncounter(encounter);
				obs.setObsDatetime(encounter.getEncounterDatetime());
				obs.setLocation(location);
				obs.setPatient(patient);
				Context.getObsService().saveObs(obs, "save other instruction");
			}

		}

		Integer formulationId;
		Integer frequencyId;
		Integer noOfDays;
		String comments;
		if (drugOrder != null) {
			for (String drugName : drugOrder) {
				InventoryCommonService inventoryCommonService = Context
						.getService(InventoryCommonService.class);
				InventoryDrug inventoryDrug = inventoryCommonService
						.getDrugByName(drugName);
				if (inventoryDrug != null) {
					formulationId = Integer.parseInt(request
							.getParameter(drugName + "_formulationId"));
					frequencyId = Integer.parseInt(request
							.getParameter(drugName + "_frequencyId"));
					noOfDays = Integer.parseInt(request.getParameter(drugName
							+ "_noOfDays"));
					comments = request.getParameter(drugName + "_comments");
					InventoryDrugFormulation inventoryDrugFormulation = inventoryCommonService
							.getDrugFormulationById(formulationId);
					Concept freCon = conceptService.getConcept(frequencyId);

					OpdDrugOrder opdDrugOrder = new OpdDrugOrder();
					opdDrugOrder.setPatient(patient);
					opdDrugOrder.setEncounter(encounter);
					opdDrugOrder.setInventoryDrug(inventoryDrug);
					opdDrugOrder
							.setInventoryDrugFormulation(inventoryDrugFormulation);
					
					opdDrugOrder.setFrequency(freCon);
					opdDrugOrder.setNoOfDays(noOfDays);
					opdDrugOrder.setComments(comments);
					opdDrugOrder.setCreator(user);
					opdDrugOrder.setCreatedOn(date);
					opdDrugOrder.setOrderFrom(1);
					patientDashboardService
							.saveOrUpdateOpdDrugOrder(opdDrugOrder);
				}
			}
		}

		model.addAttribute("urlS", "main.htm?tab=1&ipdWard=" + ipdWard);
		model.addAttribute("message", "Succesfully");
		return "/module/ipd/thickbox/success";
	}

	// Requiremnt for record vitals

	@RequestMapping(value = "/module/ipd/vitalStatistics.htm", method = RequestMethod.GET)
	public String vitalSatatisticsView(
			@RequestParam(value = "id", required = false) Integer admittedId,
			@RequestParam(value = "patientAdmissionLogId", required = false) Integer patientAdmissionLogId,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			Model model) {

		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		Concept ipdConcept = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						IpdConstants.PROPERTY_IPDWARD));
		model.addAttribute(
				"listIpd",
				ipdConcept != null ? new ArrayList<ConceptAnswer>(ipdConcept
						.getAnswers()) : null);
		IpdPatientAdmitted admitted = ipdService
				.getIpdPatientAdmitted(admittedId);
		model.addAttribute("admitted", admitted);

		Patient patient = admitted.getPatient();

		/*PersonAddress add = patient.getPersonAddress();
		String address = add.getAddress1();
		// ghansham 25-june-2013 issue no # 1924 Change in the address format
		String district = add.getCountyDistrict();
		String upazila = add.getCityVillage();
		model.addAttribute("address", StringUtils.isNotBlank(address) ? address
				: "");
		model.addAttribute("district", district);
		model.addAttribute("upazila", upazila);
*/
		//New requirement only address entered in text box should be visible
				String[] parts=admitted.getPatientAddress().split("-");
				model.addAttribute("address", parts[0]);
		PersonAttribute relationNameattr = patient
				.getAttribute("Father/Husband Name");
		model.addAttribute("relationName", relationNameattr.getValue());

		// Patient category
		model.addAttribute("patCategory",
				PatientUtils.getPatientCategory(patient));
		List<IpdPatientVitalStatistics> ipdPatientVitalStatistics = ipdService
				.getIpdPatientVitalStatistics(patient.getPatientId(),
						patientAdmissionLogId);
		model.addAttribute("ipdPatientVitalStatistics",
				ipdPatientVitalStatistics);
		model.addAttribute("sizeOfipdPatientVitalStatistics",
				ipdPatientVitalStatistics.size() + 1);
		// SimpleDateFormat formatter = new
		// SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		model.addAttribute("dat", formatter.format(new Date()));
		List<Concept> dietConcept = ipdService.getDiet();
		model.addAttribute("dietList", dietConcept);
		model.addAttribute("ipdWard", ipdWard);
		return "module/ipd/vitalStatisticsForm";
	}

	// Capture Vital statistics for admitted patient in ipd
	@RequestMapping(value = "/module/ipd/vitalStatistics.htm", method = RequestMethod.POST)
	public String vitalSatatisticsPost(
			@RequestParam("admittedId") Integer admittedId,
			@RequestParam("patientId") Integer patientId,
			@RequestParam(value = "bloodPressure", required = false) String bloodPressure,
			@RequestParam(value = "pulseRate", required = false) String pulseRate,
			@RequestParam(value = "temperature", required = false) String temperature,
			// @RequestParam(value = "dietAdvised", required = false) String
			// dietAdvised,
			@RequestParam(value = "notes", required = false) String notes,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			Model model, HttpServletRequest request) {

		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		PatientService patientService = Context.getPatientService();
		Patient patient = patientService.getPatient(patientId);
		IpdPatientAdmitted admitted = ipdService
				.getIpdPatientAdmitted(admittedId);
		String dietAdvise = "";
		String select[] = request.getParameterValues("dietAdvised");
		if (select != null && select.length != 0) {
			for (int i = 0; i < select.length; i++) {
				dietAdvise = dietAdvise + select[i] + " ";
			}
		}
		IpdPatientVitalStatistics ipdPatientVitalStatistics = new IpdPatientVitalStatistics();
		ipdPatientVitalStatistics.setPatient(patient);
		ipdPatientVitalStatistics.setIpdPatientAdmissionLog(admitted
				.getPatientAdmissionLog());
		ipdPatientVitalStatistics.setBloodPressure(bloodPressure);
		ipdPatientVitalStatistics.setPulseRate(pulseRate);
		ipdPatientVitalStatistics.setTemperature(temperature);
		ipdPatientVitalStatistics.setDietAdvised(dietAdvise);
		ipdPatientVitalStatistics.setNote(notes);
		// User user =Context.getAuthenticatedUser();
		ipdPatientVitalStatistics.setCreator(Context.getAuthenticatedUser()
				.getUserId());
		ipdPatientVitalStatistics.setCreatedOn(new Date());
		ipdService.saveIpdPatientVitalStatistics(ipdPatientVitalStatistics);
		model.addAttribute("urlS", "main.htm?tab=1&ipdWard=" + ipdWard);
		model.addAttribute("message", "Succesfully");
		return "/module/ipd/thickbox/success";
	}

	@RequestMapping(value = "/module/ipd/transfer.htm", method = RequestMethod.POST)
	public String transferPost(
			@RequestParam("admittedId") Integer id,
			@RequestParam("toWard") Integer toWardId,
			@RequestParam("doctor") Integer doctorId,
			@RequestParam(value = "bedNumber", required = false) String bed,
			@RequestParam(value = "comments", required = false) String comments,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			Model model) {
		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		ipdService.transfer(id, toWardId, doctorId, bed, comments);
		model.addAttribute("urlS", "main.htm?tab=1&ipdWard=" + ipdWard);
		model.addAttribute("message", "Succesfully");
		return "/module/ipd/thickbox/success";
	}

	@RequestMapping(value = "/module/ipd/transfer.htm", method = RequestMethod.GET)
	public String transferView(
			@RequestParam(value = "id", required = false) Integer admittedId,
			@RequestParam(value = "ipdWard", required = false) String ipdWard,
			Model model) {

		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		Concept ipdConcept = Context.getConceptService().getConceptByName(
				Context.getAdministrationService().getGlobalProperty(
						IpdConstants.PROPERTY_IPDWARD));
		model.addAttribute(
				"listIpd",
				ipdConcept != null ? new ArrayList<ConceptAnswer>(ipdConcept
						.getAnswers()) : null);
		IpdPatientAdmitted admitted = ipdService
				.getIpdPatientAdmitted(admittedId);
		model.addAttribute("admitted", admitted);

		String doctorRoleProps = Context.getAdministrationService()
				.getGlobalProperty(IpdConstants.PROPERTY_NAME_DOCTOR_ROLE);
		Role doctorRole = Context.getUserService().getRole(doctorRoleProps);
		if (doctorRole != null) {
			List<User> listDoctor = Context.getUserService().getUsersByRole(
					doctorRole);
			model.addAttribute("listDoctor", listDoctor);
		}

		Patient patient = admitted.getPatient();

		/*PersonAddress add = patient.getPersonAddress();
		String address = " " + add.getCountyDistrict() + " "
				+ add.getCityVillage();

		model.addAttribute("address", address);*/
		//New requirement only address entered in text box should be visible
				String[] parts=admitted.getPatientAddress().split("-");
				model.addAttribute("address", parts[0]);

		PersonAttribute relationNameattr = patient
				.getAttribute("Father/Husband Name");
		model.addAttribute("relationName", relationNameattr.getValue());

		// Patient category
		model.addAttribute("patCategory",
				PatientUtils.getPatientCategory(patient));
		model.addAttribute("ipdWard", ipdWard);
		return "module/ipd/transferForm";
	}

	@RequestMapping(value = "/module/ipd/discharge.htm", method = RequestMethod.POST)
	public String dischargePost(
			@RequestParam(value = "drugOrder", required = false) String[] drugOrder,
			IpdFinalResultCommand command, HttpServletRequest request,
			Model model) {
		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		HospitalCoreService hospitalCoreService = (HospitalCoreService) Context.getService(HospitalCoreService.class);
		PatientQueueService queueService = Context.getService(PatientQueueService.class);
        PatientSearch patientSearch = hospitalCoreService.getPatient(command.getPatientId());
		Concept cOtherInstructions = Context.getConceptService()
				.getConceptByName("OTHER INSTRUCTIONS");
		if (Context.getConceptService().getConcept(command.getOutCome())
				.getName().getName().equalsIgnoreCase("DEATH")) {
			ConceptService conceptService = Context.getConceptService();
			Concept causeOfDeath = conceptService.getConceptByName("NONE");
			PatientService ps = Context.getPatientService();
			Patient patient = ps.getPatient(command.getPatientId());
			patient.setDead(true);
			patient.setDeathDate(new Date());
			patient.setCauseOfDeath(causeOfDeath);
			ps.savePatient(patient);
			patientSearch.setDead(true);
			patientSearch.setAdmitted(false);
			hospitalCoreService.savePatientSearch(patientSearch);
		}
		else{
			patientSearch.setAdmitted(false);
			hospitalCoreService.savePatientSearch(patientSearch);
		}

		// star
		//
		AdministrationService administrationService = Context
				.getAdministrationService();
		GlobalProperty gpDiagnosis = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		GlobalProperty procedure = administrationService
				.getGlobalPropertyObject(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		ConceptService conceptService = Context.getConceptService();
		Concept cDiagnosis = conceptService.getConceptByName(gpDiagnosis
				.getPropertyValue());
		Concept cProcedure = conceptService.getConceptByName(procedure
				.getPropertyValue());
		IpdPatientAdmitted admitted = ipdService.getIpdPatientAdmitted(command
				.getAdmittedId());
		Encounter ipdEncounter = admitted.getPatientAdmissionLog()
				.getIpdEncounter();
		List<Obs> listObsOfIpdEncounter = new ArrayList<Obs>(
				ipdEncounter.getAllObs());
		Location location = new Location(1);

		User user = Context.getAuthenticatedUser();
		Date date = new Date();
		// diagnosis

		Set<Obs> obses = new HashSet(ipdEncounter.getAllObs());

		ipdEncounter.setObs(null);

		List<Concept> listConceptDianosisOfIpdEncounter = new ArrayList<Concept>();
		List<Concept> listConceptProcedureOfIpdEncounter = new ArrayList<Concept>();
		if (CollectionUtils.isNotEmpty(listObsOfIpdEncounter)) {
			for (Obs obx : obses) {
				if (obx.getConcept().getConceptId()
						.equals(cDiagnosis.getConceptId())) {
					listConceptDianosisOfIpdEncounter.add(obx.getValueCoded());
				}

				if (obx.getConcept().getConceptId()
						.equals(cProcedure.getConceptId())) {
					listConceptProcedureOfIpdEncounter.add(obx.getValueCoded());
				}
			}
		}

		List<Concept> listConceptDiagnosis = new ArrayList<Concept>();
		if (command.getSelectedDiagnosisList() != null) {
			for (Integer cId : command.getSelectedDiagnosisList()) {
				Concept cons = conceptService.getConcept(cId);
				listConceptDiagnosis.add(cons);
				if (!listConceptDianosisOfIpdEncounter.contains(cons)) {
					Obs obsDiagnosis = new Obs();
					// obsDiagnosis.setObsGroup(obsGroup);
					obsDiagnosis.setConcept(cDiagnosis);
					obsDiagnosis.setValueCoded(cons);
					obsDiagnosis.setCreator(user);
					obsDiagnosis.setObsDatetime(date);
					obsDiagnosis.setLocation(location);
					obsDiagnosis.setDateCreated(date);
					obsDiagnosis.setPatient(ipdEncounter.getPatient());
					obsDiagnosis.setEncounter(ipdEncounter);
					obsDiagnosis = Context.getObsService().saveObs(
							obsDiagnosis, "update obs diagnosis if need");
					obses.add(obsDiagnosis);
				}
			}
		}
		List<Concept> listConceptProcedure = new ArrayList<Concept>();
		if (!ArrayUtils.isEmpty(command.getSelectedProcedureList())) {

			if (cProcedure == null) {
				try {
					throw new Exception("Post for procedure concept null");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			for (Integer pId : command.getSelectedProcedureList()) {
				Concept cons = conceptService.getConcept(pId);
				listConceptProcedure.add(cons);
				if (!listConceptProcedureOfIpdEncounter.contains(cons)) {
					Obs obsProcedure = new Obs();
					// obsDiagnosis.setObsGroup(obsGroup);
					obsProcedure.setConcept(cProcedure);
					obsProcedure.setValueCoded(conceptService.getConcept(pId));
					obsProcedure.setCreator(user);
					obsProcedure.setObsDatetime(date);
					obsProcedure.setLocation(location);
					obsProcedure.setPatient(ipdEncounter.getPatient());
					obsProcedure.setDateCreated(date);
					obsProcedure.setEncounter(ipdEncounter);
					obsProcedure = Context.getObsService().saveObs(
							obsProcedure, "update obs diagnosis if need");
					// ipdEncounter.addObs(obsProcedure);
					obses.add(obsProcedure);
				}
			}

		}

		// Remove obs diagnosis and procedure
		/*
		 * for (Concept con : listConceptDianosisOfIpdEncounter) { if
		 * (!listConceptDiagnosis.contains(con)) { for (Obs obx :
		 * listObsOfIpdEncounter) { if
		 * (obx.getValueCoded().getConceptId().intValue() ==
		 * con.getConceptId().intValue()) {
		 * Context.getObsService().deleteObs(obx); obses.remove(obx); } } } }
		 * 
		 * for (Concept con : listConceptProcedureOfIpdEncounter) { if
		 * (!listConceptProcedure.contains(con)) { for (Obs obx :
		 * listObsOfIpdEncounter) { if
		 * (obx.getValueCoded().getConceptId().intValue() ==
		 * con.getConceptId().intValue()) {
		 * Context.getObsService().deleteObs(obx); obses.remove(obx); } } } }
		 */
		ipdEncounter.setObs(obses);

		Context.getEncounterService().saveEncounter(ipdEncounter);

		// end

		// New requirement add drug row in discharge

		Integer formulationId;
		Integer frequencyId;
		Integer noOfDays;
		String comments;
		if (drugOrder != null) {
			for (String drugName : drugOrder) {
				PatientDashboardService patientDashboardService = Context
						.getService(PatientDashboardService.class);
				InventoryCommonService inventoryCommonService = Context
						.getService(InventoryCommonService.class);
				InventoryDrug inventoryDrug = inventoryCommonService
						.getDrugByName(drugName);
				if (inventoryDrug != null) {
					formulationId = Integer.parseInt(request
							.getParameter(drugName + "_formulationId"));
					frequencyId = Integer.parseInt(request
							.getParameter(drugName + "_frequencyId"));
					noOfDays = Integer.parseInt(request.getParameter(drugName
							+ "_noOfDays"));
					comments = request.getParameter(drugName + "_comments");
					InventoryDrugFormulation inventoryDrugFormulation = inventoryCommonService
							.getDrugFormulationById(formulationId);
					Concept freCon = conceptService.getConcept(frequencyId);

					OpdDrugOrder opdDrugOrder = new OpdDrugOrder();
					opdDrugOrder.setPatient(ipdEncounter.getPatient());
					opdDrugOrder.setEncounter(ipdEncounter);
					opdDrugOrder.setInventoryDrug(inventoryDrug);
					opdDrugOrder
							.setInventoryDrugFormulation(inventoryDrugFormulation);
					opdDrugOrder.setFrequency(freCon);
					opdDrugOrder.setNoOfDays(noOfDays);
					opdDrugOrder.setComments(comments);
					opdDrugOrder.setCreator(user);
					opdDrugOrder.setCreatedOn(date);
					opdDrugOrder.setOrderFrom(2);
					patientDashboardService
							.saveOrUpdateOpdDrugOrder(opdDrugOrder);
				}
			}
		}
		ipdService.discharge(command.getAdmittedId(), command.getOutCome());

		if (StringUtils.isNotBlank(command.getNote())) {
			Obs obs = new Obs();
			// obs.setObsGroup(obsGroup);
			obs.setConcept(cOtherInstructions);
			obs.setValueText(command.getNote());
			obs.setCreator(user);
			obs.setDateCreated(date);
			obs.setEncounter(ipdEncounter);
			obs.setObsDatetime(ipdEncounter.getEncounterDatetime());
			obs.setLocation(location);
			obs.setPatient(ipdEncounter.getPatient());
			Context.getObsService().saveObs(obs, "save other instruction");
		}

		model.addAttribute("urlS", "main.htm?tab=1&ipdWard="
				+ admitted.getAdmittedWard().toString());
		model.addAttribute("message", "Succesfully");
		return "/module/ipd/thickbox/success";
	}

	@RequestMapping(value = "/module/ipd/discharge.htm", method = RequestMethod.GET)
	public String dischargeView(
			@RequestParam(value = "id", required = false) Integer admittedId,
			@ModelAttribute("ipdCommand") IpdFinalResultCommand command,
			Model model) {

		IpdService ipdService = (IpdService) Context
				.getService(IpdService.class);
		IpdPatientAdmitted admitted = ipdService
				.getIpdPatientAdmitted(admittedId);

		Patient patient = admitted.getPatient();
		model.addAttribute("patientId", patient.getId());

		if (admitted.getPatientAdmittedLogTransferFrom() != null) {
			/*
			 * Get IPD, patient referred from
			 */
			IpdPatientAdmittedLog ipl = admitted
					.getPatientAdmittedLogTransferFrom();
			model.addAttribute("referredFrom", ipl.getAdmittedWard().getName());
		} else {
			/*
			 * Get OPD, patient referred from
			 */
			model.addAttribute("referredFrom", admitted
					.getPatientAdmissionLog().getOpdLog().getOpdConceptName());
		}

		// PersonAddress add = patient.getPersonAddress();
		// String address = " " + add.getAddress1() +" " +
		// add.getCountyDistrict() + " " + add.getCityVillage();
		/*
		 * Will be shown stored address during IPD admission.
		 */
		//New requirement only address entered in text box should be visible
				String[] parts=admitted.getPatientAddress().split("-");
				model.addAttribute("address", parts[0]);

		//admitted.getPatientAddress();

		PersonAttribute relationNameattr = patient
				.getAttribute("Father/Husband Name");
		// ghanshyam 10/07/2012 New Requirement #312 [IPD] Add fields in the
		// Discharge screen and print out
		PersonAttribute relationTypeattr = patient
				.getAttribute("Relative Name Type");
		model.addAttribute("relationName", relationNameattr.getValue());
		// ghanshyam 30/07/2012 this code modified under feedback of 'New
		// Requirement #312
		if (relationTypeattr != null) {
			model.addAttribute("relationType", relationTypeattr.getValue());
		} else {
			model.addAttribute("relationType", "Relative Name");
		}
		model.addAttribute("dateTime", new Date().toString());

		Concept outComeList = Context.getConceptService().getConceptByName(
				HospitalCoreConstants.CONCEPT_ADMISSION_OUTCOME);

		model.addAttribute("listOutCome", outComeList.getAnswers());

		model.addAttribute("admitted", admitted);

		// change CHUYEN

		//
		ConceptService conceptService = Context.getConceptService();
		AdministrationService administrationService = Context
				.getAdministrationService();
		String gpDiagnosis = administrationService
				.getGlobalProperty(PatientDashboardConstants.PROPERTY_PROVISIONAL_DIAGNOSIS);
		String gpProcedure = administrationService
				.getGlobalProperty(PatientDashboardConstants.PROPERTY_POST_FOR_PROCEDURE);
		List<Obs> obsList = new ArrayList<Obs>(admitted
				.getPatientAdmissionLog().getIpdEncounter().getAllObs());
		Concept conDiagnosis = conceptService.getConcept(gpDiagnosis);

		Concept conProcedure = conceptService.getConcept(gpProcedure);

		List<Concept> selectedDiagnosisList = new ArrayList<Concept>();
		List<Concept> selectedProcedureList = new ArrayList<Concept>();
		if (CollectionUtils.isNotEmpty(obsList)) {
			for (Obs obs : obsList) {
				if (obs.getConcept().getConceptId()
						.equals(conDiagnosis.getConceptId())) {
					selectedDiagnosisList.add(obs.getValueCoded());
				}
				if (obs.getConcept().getConceptId()
						.equals(conProcedure.getConceptId())) {
					selectedProcedureList.add(obs.getValueCoded());
				}
			}
		}

		//
		PatientDashboardService dashboardService = Context
				.getService(PatientDashboardService.class);
		List<Concept> diagnosis = dashboardService.listByDepartmentByWard(
				admitted.getAdmittedWard().getId(), DepartmentConcept.TYPES[0]);
		if (CollectionUtils.isNotEmpty(diagnosis)
				&& CollectionUtils.isNotEmpty(selectedDiagnosisList)) {
			diagnosis.removeAll(selectedDiagnosisList);
		}
		if (CollectionUtils.isNotEmpty(diagnosis)) {
			Collections.sort(diagnosis, new ConceptComparator());
		}
		model.addAttribute("listDiagnosis", diagnosis);
		List<Concept> procedures = dashboardService.listByDepartmentByWard(
				admitted.getAdmittedWard().getId(), DepartmentConcept.TYPES[1]);
		if (CollectionUtils.isNotEmpty(procedures)
				&& CollectionUtils.isNotEmpty(selectedProcedureList)) {
			procedures.removeAll(selectedProcedureList);
		}
		if (CollectionUtils.isNotEmpty(procedures)) {
			Collections.sort(procedures, new ConceptComparator());
		}
		model.addAttribute("listProcedures", procedures);
		// New Requirement add drug row in discharge slip
		InventoryCommonService inventoryCommonService = Context
				.getService(InventoryCommonService.class);
		List<Concept> drugFrequencyConcept = inventoryCommonService
				.getDrugFrequency();
		model.addAttribute("drugFrequencyList", drugFrequencyConcept);
		//

		/*
		 * PatientDashboardService dashboardService =
		 * Context.getService(PatientDashboardService.class); List<Concept>
		 * diagnosis = dashboardService.searchDiagnosis(null);
		 * if(CollectionUtils.isNotEmpty(diagnosis) &&
		 * CollectionUtils.isNotEmpty(selectedDiagnosisList)){
		 * diagnosis.removeAll(selectedDiagnosisList); }
		 * Collections.sort(diagnosis, new ConceptComparator());
		 * model.addAttribute("listDiagnosis", diagnosis); List<Concept>
		 * procedures = dashboardService.searchProcedure(null);
		 * if(CollectionUtils.isNotEmpty(procedures) &&
		 * CollectionUtils.isNotEmpty(selectedProcedureList)){
		 * procedures.removeAll(selectedProcedureList); }
		 * Collections.sort(procedures, new ConceptComparator());
		 * model.addAttribute("listProcedures", procedures);
		 */
		Collections.sort(selectedDiagnosisList, new ConceptComparator());
		Collections.sort(selectedProcedureList, new ConceptComparator());
		// Patient category
		model.addAttribute("patCategory",
				PatientUtils.getPatientCategory(patient));
		model.addAttribute("sDiagnosisList", selectedDiagnosisList);
		model.addAttribute("sProcedureList", selectedProcedureList);

		String hospitalName = Context.getAdministrationService()
				.getGlobalProperty("hospital.location_user");
		model.addAttribute("hospitalName", hospitalName);

		SimpleDateFormat sdf = new SimpleDateFormat("EEE dd/MM/yyyy hh:mm a");
		model.addAttribute("currentDateTime", sdf.format(new Date()));

		model.addAttribute("admissionDateTime", sdf.format(admitted
				.getPatientAdmissionLog().getAdmissionDate()));

		final long DAY_IN_MILLIS = 1000 * 60 * 60 * 24;

		int diffInDays = (int) ((new Date().getTime() - admitted
				.getPatientAdmissionLog().getAdmissionDate().getTime()) / DAY_IN_MILLIS);
		if (diffInDays < 1) {
			diffInDays = 1;
		}
		model.addAttribute("admittedDays", diffInDays);

		HospitalCoreService hcs = Context.getService(HospitalCoreService.class);
		List<PersonAttribute> pas = hcs.getPersonAttributes(patient
				.getPatientId());
		for (PersonAttribute pa : pas) {
			PersonAttributeType attributeType = pa.getAttributeType();
			if (attributeType.getPersonAttributeTypeId() == 14) {
				model.addAttribute("selectedCategory", pa.getValue());
			}

		}

		String patientName;
		if (patient.getMiddleName() != null) {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName() + " " + patient.getMiddleName();
		} else {
			patientName = patient.getGivenName() + " "
					+ patient.getFamilyName();
		}
		model.addAttribute("patientName", patientName);

		Date birthday = patient.getBirthdate();
		model.addAttribute("age", PatientUtils.estimateAge(birthday));

		return "module/ipd/dischargeForm";
	}

}

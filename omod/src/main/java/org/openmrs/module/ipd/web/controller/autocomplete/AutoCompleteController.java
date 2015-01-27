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


package org.openmrs.module.ipd.web.controller.autocomplete;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.Concept;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.model.InventoryDrug;
import org.openmrs.module.hospitalcore.model.InventoryDrugFormulation;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p> Class: AutoCompleteController </p>
 * <p> Package: org.openmrs.module.ipd.web.controller.autocomplete </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Jan 26, 2011 5:15:41 PM </p>
 * <p> Update date: Jan 26, 2011 5:15:41 PM </p>
 **/
@Controller("IPDAutoCompleteController")
public class AutoCompleteController {
	
	@RequestMapping("/module/ipd/checkSession.htm")
	public String checkSession(HttpServletRequest request,Model model) {
		 if( Context.getAuthenticatedUser() != null &&  Context.getAuthenticatedUser().getId() != null){
			 model.addAttribute("session","1");
		 }else{
			 model.addAttribute("session","0");
		 }
		
		return "/module/ipd/session/checkSession";
	}
	
	@RequestMapping(value="/module/ipd/autoCompleteDiagnosis.htm", method=RequestMethod.GET)
	public String autoCompleteDiagnosis(@RequestParam(value="q",required=false) String name, Model model) {
		List<Concept> diagnosis = Context.getService(PatientDashboardService.class).searchDiagnosis(name);
		model.addAttribute("diagnosis",diagnosis);
		return "module/ipd/autocomplete/autoCompleteDiagnosis";
	}
	
	@RequestMapping(value="/module/ipd/autoCompleteProcedure.htm", method=RequestMethod.GET)
	public String autoCompleteProcedure(@RequestParam(value="q",required=false) String name, Model model) {
		List<Concept> procedures = Context.getService(PatientDashboardService.class).searchProcedure(name);
		
		model.addAttribute("procedures",procedures);
		return "module/ipd/autocomplete/autoCompleteProcedure";
	}
	
	@RequestMapping(value="/module/ipd/autoCompleteInvestigation.htm", method=RequestMethod.GET)
	public String autoCompleteInvestigation(@RequestParam(value="q",required=false) String name, Model model) {
		List<Concept> investigation = Context.getService(PatientDashboardService.class).searchInvestigation(name);
		model.addAttribute("investigation",investigation);
		return "module/ipd/autocomplete/autoCompleteInvestigation";
	}
	
	@RequestMapping(value="/module/ipd/autoCompleteDrug.htm", method=RequestMethod.GET)
	public String autoCompleteDrug(@RequestParam(value="q",required=false) String name, Model model) {
		List<InventoryDrug> drugs = Context.getService(PatientDashboardService.class).findDrug(name);
		model.addAttribute("drugs",drugs);
		return "module/ipd/autocomplete/autoCompleteDrug";
	}
	
	@RequestMapping(value="/module/ipd/formulationByDrugNameForIssue.form",method=RequestMethod.GET)
	public String formulationByDrugNameForIssueDrug(@RequestParam(value="drugName",required=false)String drugName, Model model) {
		InventoryCommonService inventoryCommonService = (InventoryCommonService) Context.getService(InventoryCommonService.class);
		InventoryDrug drug = inventoryCommonService.getDrugByName(drugName);
		if(drug != null){
			List<InventoryDrugFormulation> formulations = new ArrayList<InventoryDrugFormulation>(drug.getFormulations());
			model.addAttribute("formulations", formulations);
			model.addAttribute("drugId", drug.getId());
		}
		return "/module/ipd/autocomplete/formulationByDrugForIssue";
	}
}

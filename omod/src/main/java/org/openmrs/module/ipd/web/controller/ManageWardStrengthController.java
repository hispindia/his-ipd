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

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.User;
import org.openmrs.api.ConceptService;
import org.openmrs.api.UserService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.BillingConstants;
import org.openmrs.module.hospitalcore.IpdService;
import org.openmrs.module.hospitalcore.model.WardBedStrength;
import org.openmrs.propertyeditor.ConceptAnswersEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller("manageWardStrength")
public class ManageWardStrengthController {
	
	@RequestMapping(value = "module/ipd/manageWardStrengthController.htm", method = RequestMethod.GET)
	public String showForm(Model model) {
		
		ConceptService cs = Context.getConceptService();
		IpdService ipdService = (IpdService) Context.getService(IpdService.class);
		
		Integer gp = Integer.valueOf(Context.getAdministrationService()
				.getGlobalProperty(
						"ipd.allWards"));

		Concept concept = cs.getConcept(gp);
		
		Collection<ConceptAnswer> wards = concept.getAnswers();
		
		model.addAttribute("wards",wards);
		
		return "module/ipd/manageWardStrength";
	}
	
	@RequestMapping(value = "module/ipd/manageWardStrengthController.htm", method = RequestMethod.POST)
	public String saveBedStrength(HttpServletRequest request,Model model) {
		
	ConceptService cs = Context.getConceptService();
	IpdService ipdService = (IpdService) Context.getService(IpdService.class);
		Integer gp = Integer.valueOf(Context.getAdministrationService()
				.getGlobalProperty(
						"ipd.allWards"));

		Concept concept = cs.getConcept(gp);
		Integer bedStrength=0;
		Collection<ConceptAnswer> wards = concept.getAnswers();
		 WardBedStrength wardBedStrength=null ;
		for (ConceptAnswer ward : wards){
			System.out.println(ward.getAnswerConcept().getId());
			String bedStrengthRequest = request.getParameter(""+ward.getAnswerConcept().getId());
			if (bedStrengthRequest!=null && !bedStrengthRequest.equalsIgnoreCase("")){
			 bedStrength = Integer.parseInt(bedStrengthRequest);
			
			 wardBedStrength = ipdService.getWardBedStrengthByWardId(ward.getAnswerConcept().getId());
			if (wardBedStrength==null){
			 wardBedStrength = new WardBedStrength();
			}
			 wardBedStrength.setWard(ward.getAnswerConcept());
			 wardBedStrength.setBedStrength(bedStrength);
			 wardBedStrength.setCreatedOn(new Date());
			 wardBedStrength.setCreatedBy(Context.getAuthenticatedUser());
			ipdService.saveWardBedStrength(wardBedStrength);
			 
			}
			
		}
		
		return "redirect:manageWardStrengthController.htm";
	}
	
	
	}

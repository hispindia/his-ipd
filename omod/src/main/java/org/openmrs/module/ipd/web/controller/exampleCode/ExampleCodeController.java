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


package org.openmrs.module.ipd.web.controller.exampleCode;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * <p> Class: ExampleCodeController </p>
 * <p> Package: org.openmrs.module.ipd.web.controller.exampleCode </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Jan 26, 2011 5:27:52 PM </p>
 * <p> Update date: Jan 26, 2011 5:27:52 PM </p>
 **/
@Controller("IPDExampleCodeController")
@RequestMapping("/module/ipd/example.htm")
public class ExampleCodeController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(Model model) {
		return "/module/ipd/exampleCode/example";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String submit(Model model) {
		return "/module/ipd/exampleCode/example";
	}

}

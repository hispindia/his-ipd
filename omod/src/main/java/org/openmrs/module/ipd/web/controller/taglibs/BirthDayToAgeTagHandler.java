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


package org.openmrs.module.ipd.web.controller.taglibs;

import java.io.IOException;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.openmrs.module.ipd.util.DateUtils;

/**
 * <p> Class: BirthDayToAgeTagHandler </p>
 * <p> Package: org.openmrs.module.ipd.web.controller.taglibs </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 20, 2011 2:23:27 PM </p>
 * <p> Update date: Mar 20, 2011 2:23:27 PM </p>
 **/
public class BirthDayToAgeTagHandler extends TagSupport {
	
	private static final long serialVersionUID = 1L;
	private Date input;
    @Override
    public int doStartTag() throws JspException {
 
        try {
            //Get the writer object for output.
            JspWriter out = pageContext.getOut();
            //Perform substr operation on string.
            Integer temp = DateUtils.getAgeFromBirthday(input);
            out.println(temp != null && temp > 0? temp : "<1");
 
        } catch (IOException e) {
            e.printStackTrace();
        }
        return SKIP_BODY;
    }
	public Date getInput() {
		return input;
	}
	public void setInput(Date input) {
		this.input = input;
	}
    

}

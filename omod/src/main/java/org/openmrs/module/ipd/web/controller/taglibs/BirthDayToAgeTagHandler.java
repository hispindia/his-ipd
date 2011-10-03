/**
 * <p> File: org.openmrs.module.ipd.web.controller.taglibs.BirthDayToAgeTagHandler.java </p>
 * <p> Project: ipd-omod </p>
 * <p> Copyright (c) 2011 HISP Technologies. </p>
 * <p> All rights reserved. </p>
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Email: chuyennmth@gmail.com</p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 20, 2011 2:23:27 PM </p>
 * <p> Update date: Mar 20, 2011 2:23:27 PM </p>
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

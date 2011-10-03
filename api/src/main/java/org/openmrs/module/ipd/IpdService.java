package org.openmrs.module.ipd;

import java.util.List;

import org.openmrs.Concept;
import org.openmrs.api.APIException;

public interface IpdService {
	
	public List<Concept> searchDiagnosis(String text) throws APIException;

}

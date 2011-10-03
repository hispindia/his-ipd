/**
 * <p> File: org.openmrs.module.ipd.util.IpdUtils.java </p>
 * <p> Project: dduipd-api </p>
 * <p> Copyright (c) 2011 HISP Technologies. </p>
 * <p> All rights reserved. </p>
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Email: chuyennmth@gmail.com</p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 19, 2011 12:22:54 PM </p>
 * <p> Update date: Mar 19, 2011 12:22:54 PM </p>
 **/

package org.openmrs.module.ipd.util;

import java.util.ArrayList;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

/**
 * <p> Class: IpdUtils </p>
 * <p> Package: org.openmrs.module.ipd.util </p> 
 * <p> Author: Nguyen manh chuyen </p>
 * <p> Update by: Nguyen manh chuyen </p>
 * <p> Version: $1.0 </p>
 * <p> Create date: Mar 19, 2011 12:22:54 PM </p>
 * <p> Update date: Mar 19, 2011 12:22:54 PM </p>
 **/
public class IpdUtils {
	public static Integer[] convertStringArraytoIntArray(String[] sarray)  {
		if (sarray != null && sarray.length > 0)
		{
			Integer intarray[] = new Integer[sarray.length];
			for (int i = 0; i < sarray.length; i++) {
				intarray[i] = NumberUtils.toInt(sarray[i], 0);
			}
			return intarray;
		}
		return null;
		}
	
	public static <T> ArrayList<T> convertArrayToList(T[] array){
		if(array == null || array.length == 0 )
			return null;
		ArrayList<T> list = new ArrayList<T>();
		for(T element : array){
			list.add(element);
		}
		return list;
		}

	public static String convertStringArraytoString(String[] sarray)  {
		String temp = "";
		if (sarray != null && sarray.length > 0)
		{
			
			for (int i = 0; i < sarray.length; i++) {
				temp += sarray[i]+",";
			}
			return StringUtils.isNotBlank(temp)? temp.substring(0, temp.length()-1) : "";
		}
		return "";
		}
	public static  ArrayList<Integer> convertArrayToList(String[] array){
		if(array == null || array.length == 0 ){
			return null;
		}
		ArrayList<Integer> list = new ArrayList<Integer>();
		for(String element : array){
			Integer temp = NumberUtils.toInt(element , 0);
			if(temp > 0){
				list.add(temp);
			}
		}
		return list;
		}
	public static  ArrayList<Integer> convertStringToList(String ids){
		if(StringUtils.isBlank(ids)){
			return null;
		}
		ArrayList<Integer> list = new ArrayList<Integer>();
		if(ids.indexOf(",") != -1){
			String []array = ids.split(",");
			for(String element : array){
				Integer temp = NumberUtils.toInt(element , 0);
				if(temp > 0){
					list.add(temp);
				}
			}
			return list;
		}
		list.add(NumberUtils.toInt(ids , 0));
		return list;
		}
}

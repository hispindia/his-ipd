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

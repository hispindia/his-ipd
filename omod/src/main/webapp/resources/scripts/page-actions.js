/*
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
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
*/

var EVT =
{
	ready : function()
	{
		/**
		 * Page Actions
		 */
		var enableCheck = true;
		var pageId = jQuery("#pageId").val();
		if(enableCheck && pageId != undefined && eval("CHECK." + pageId))
		{
			eval("CHECK." + pageId + "()");
		}

		/**
		 * Ajax Indicator when send and receive data
		 */
		if(jQuery.browser.msie)
		{
			jQuery.ajaxSetup({cache: false});
		}
	
	}
};

var CHECK = 
{
	
	
	formExample : function()
	{
		jQuery("#drugCore").autocomplete({source: 'autoCompleteDrugCoreList.htm', minLength: 3 } );
		jQuery('#tabs').tabs();
		var validator = jQuery("#formExample").validate(
		{
			event : "blur",
			rules : 
			{
			
				"drugCore" : { required : true}
				
			}
		});
	},
	Ipd : function()
	{

		 ////getter
	    //		var selected = $( ".selector" ).tabs( "option", "selected" );
		//setter
		//$( ".selector" ).tabs( "option", "selected", 3 );
		$("select#ipdWard").multiselect({noneSelectedText: "Select ipd ward"});
		$("select#doctor").multiselect({noneSelectedText: "Select treating doctor"});
		jQuery('.date-pick').datepicker({yearRange:'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});
		jQuery("#tabs").tabs({cache: true, 
            load : function(event, ui)
            { 

			 	var t = jQuery("#tabs").tabs();
				var selected = t.tabs('option', 'selected');
				
				if( selected == 0 ){
					QUEUE.initTableHover();
					clearInterval(jQuery("#intervalId").val()) ;
					var intervalId = setInterval("QUEUE.refreshQueue()", 10000);
					jQuery("#intervalId").val(intervalId);
					
				}
				if( selected == 1 ){
					// Admitted queue
					QUEUE.initTableHover();
					clearInterval(jQuery("#intervalId").val()) ;
					var intervalId = setInterval("QUEUE.refreshAdmittedQueue()", 10000);
					jQuery("#intervalId").val(intervalId);
				}
				
            },
            select : function(event,ui)
			{
            	var t = jQuery("#tabs").tabs();
				var selected = t.tabs('option', 'selected');
				
				if( selected == 0 ){
					QUEUE.initTableHover();
					clearInterval(jQuery("#intervalId").val()) ;
					var intervalId = setInterval("QUEUE.refreshQueue()", 10000);
					jQuery("#intervalId").val(intervalId);
					
				}
				if( selected == 1 ){
					// Admitted queue
					QUEUE.initTableHover();
					clearInterval(jQuery("#intervalId").val()) ;
					var intervalId = setInterval("QUEUE.refreshAdmittedQueue()", 10000);
					jQuery("#intervalId").val(intervalId);
				}
			},
			selected : jQuery("#tab").val() 
			
            });
		
	},
	admissionPage : function()
	{
		jQuery('.date-pick').datepicker({yearRange:'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});
		var validator = jQuery("#admissionForm").validate(
				{
					event : "blur",
					rules : 
					{
						"monthlyIncome" : { required : true , number: true},
						"admittedWard" : { required : true},
						"bedNumber" : { required : true},
						"treatingDoctor" : { required : true}
					}
				});
	},
	transferPage: function(){
		var validator = jQuery("#transferForm").validate(
				{
					event : "blur",
					rules : 
					{
						"toWard" : { required : true},
						"doctor" : { required : true},
						"bedNumber" : { required : true}
					}
				});
	},
	dischagePage: function(){
		var validator = jQuery("#dischargeForm").validate(
				{
					event : "blur",
					rules : 
					{
						"outCome" : { required : true},
						"selectedDiagnosisList" : { required : true}
					}
				});
		jQuery("#diagnosis").autocomplete('autoCompleteDiagnosis.htm', {
			delay:1000,
			scroll: true,
			 parse: function(xml){
	                var results = [];
	                $(xml).find('item').each(function() {
	                    var text = $.trim($(this).find('text').text());
	                    var value = $.trim($(this).find('value').text());
	                    results[results.length] = { 'data': { text: text, value: value },
	                        'result': text, 'value': value
	                    };
	                });
	                return results;

			 },
			formatItem: function(data) {
				  return data.text;
			},
			formatResult: function(data) {
			      return data.text;
			}
			  
			}).result(function(event, item) {
				ADMITTED.onChangeDiagnosis('diagnosis',item.value, item.text);
			});
		
		
		jQuery("#procedure").autocomplete('autoCompleteProcedure.htm', {
			delay:1000,
			scroll: true,
			 parse: function(xml){
	                var results = [];
	                $(xml).find('item').each(function() {
	                    var text = $.trim($(this).find('text').text());
	                    var value = $.trim($(this).find('value').text());
	                    results[results.length] = { 'data': { text: text, value: value },
	                        'result': text, 'value': value
	                    };
	                });
	                return results;

			 },
			formatItem: function(data) {
				  return data.text;
			},
			formatResult: function(data) {
			      return data.text;
			}
			  
			}).result(function(event, item) {
				ADMITTED.onChangeDiagnosis('procedure',item.value, item.text);
			});
			
			jQuery("#investigation").autocomplete('autoCompleteInvestigation.htm', {
			delay:1000,
			scroll: true,
			 parse: function(xml){
	                var results = [];
	                $(xml).find('item').each(function() {
	                    var text = $.trim($(this).find('text').text());
	                    var value = $.trim($(this).find('value').text());
	                    results[results.length] = { 'data': { text: text, value: value },
	                        'result': text, 'value': value
	                    };
	                });
	                return results;

			 },
			formatItem: function(data) {
				  return data.text;
			},
			formatResult: function(data) {
			      return data.text;
			}
			  
			}).result(function(event, item) {
				ADMITTED.onChangeDiagnosis('investigation',item.value, item.text);
			});

            jQuery("#drugName").autocomplete('autoCompleteDrug.htm', {
						delay:1000,
						scroll: true,
						 parse: function(xml){
				                var results = [];
				                $(xml).find('item').each(function() {
				                    var text = $.trim($(this).find('text').text());
				                    var value = $.trim($(this).find('value').text());
				                    results[results.length] = { 'data': { text: text, value: value },
				                        'result': text, 'value': value
				                    };
				                });
				                return results;

						 },
						formatItem: function(data) {
							  return data.text;
						},
						formatResult: function(data) {
						      return data.text;
						}
						  
						}).result(function(event, item) {
							ADMITTED.onChangeDiagnosis('drug',item.value, item.text);
						});
	}
	
};

/**
 * Pageload actions trigger
 */

jQuery(document).ready(
	function() 
	{
		EVT.ready();
	}
);




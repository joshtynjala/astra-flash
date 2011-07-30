/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package {
	import fl.controls.RadioButtonGroup;
	// Add Adobe as3Validators into proper class path.
	// http://code.google.com/p/flash-validators/
	import com.adobe.as3Validators.as3DataValidation;
	import com.yahoo.astra.events.FormDataManagerEvent;
	import com.yahoo.astra.fl.utils.FlValueParser;
	import com.yahoo.astra.managers.FormDataManager;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;	
	// To use MX validations, import MXValidationHelper class.
	//	import com.yahoo.astra.utils.MXValidationHelper;
	
	
	public class UsingFormDataManager extends MovieClip {
		private var formDataManager : FormDataManager;
		private var radioGroup : RadioButtonGroup;
		public function UsingFormDataManager() {
			initUI();
			initFormDataManager();
		}
		private function initUI() : void {
			// first, hide check box of the result icons.
			this["name_result"].visible = this["zip_result"].visible = this["email_result"].visible = this["delivery_result"].visible = this["message_result"].visible = false;
			
			// hide the background of TextArea.
			this["messageInput"].setStyle("upSkin", Shape);
			this["messageInput"].setStyle("focusRectSkin", Shape);
			
			// set Radio button group for Fmail Format selection.
			radioGroup = new RadioButtonGroup("myRadioGroup");
			this["rd_html"].group = this["rd_text"].group = radioGroup;
			
			
			// we will show the data result in the text field under the forms.
			//resultTF = this["resultTxt"] as TextArea;
			(this["deliveryInput"] as TextField).restrict = "0-9";
		}
		private function initFormDataManager() : void {
			
			// init the validator you want to use.
			var validator : as3DataValidation = new as3DataValidation();
			//	If you use MXValidationHelper class, init  MXValidationHelper constructor instead. 
			//	var validator : MXValidationHelper  = new MXValidationHelper();
			
			// set data manager with value paser for UI component(FlValueParser).
			formDataManager = new FormDataManager(FlValueParser);
			
			// each item will be trigger these functions upto the result of validation.
			formDataManager.functionValidationPassed = handlerValidationPassed;
			formDataManager.functionValidationFailed = handlerValidationFailed;
			formDataManager.errorString = "Please check your input again.";
			
			formDataManager.dataSource = [
			{id:"name", source:this["nameInput"], validator:validator.isNotEmpty, required:true, eventTargetObj:this["name_result"]},
			{id:"address", source:[this["addressLine1"],"\n",this["addressLine2"]]},			{id:"state", source:this["stateComboBox"]},
			{id:"zipcode", source:this["zipcodeInput"], validator:validator.isZip, required:true, eventTargetObj:this["zip_result"]},
			{id:"email", source:this["emailInput"], validator:validator.isEmail, required:true, eventTargetObj:this["email_result"], functionValidationPassed:handlerEmailValidationPassed, functionValidationFailed: handlerEmailValidationFailed},
			{id:"emailformat", source:radioGroup},
			{id:"delivery", source:this["deliveryInput"], validator:validator.isIntegerInRange, validatorExtraParam:[1, 20], required:true, errorString:"Number between 1-20 only.", eventTargetObj:this["delivery_result"]},
			{id:"message", source:this["messageInput"], validator:validator.isNotEmpty, required:true, eventTargetObj:this["message_result"]}];
			/*
			//If you use MXValidationHelper class, use dataSource below instead. 
			formDataManager.dataSource = [
			{id:"name", source:this["nameInput"], validator:validator.validateString, validatorExtraParam:[null, ["tooShortError","Hmmm, please enter your name."]],required:true, eventTargetObj:this["fistName_result"]},
			{id:"address", source:[this["addressLine2"],"\n",this["addressLine2"]]},
			{id:"state", source:this["stateComboBox"]},
			{id:"zipcode", source:this["zipcodeInput"], validator:validator.validateZipCode,required:true, eventTargetObj:this["zip_result"]},
			{id:"email", source:this["emailInput"], validator:validator.validateEmail,required:true, eventTargetObj:this["email_result"], functionValidationPassed:handlerEmailValidationPassed, functionValidationFailed: handlerEmailValidationFailed},
			{id:"emailformat", source:radioGroup},
			{id:"delivery", source:this["deliveryInput"], validator:validator.validateNumber, validatorExtraParam:[null, ["minValue",1], ["maxValue",20]], required:true, eventTargetObj:this["delivery_result"]},
			{id:"message", source:this["messageInput"], validator:validator.validateString, required:true, eventTargetObj:this["message_result"]},
			];
			 */
			 
			// trigging collectData() function
			formDataManager.addTrigger(this["sendButton"], handlerDataCollectionSuccess, handlerDataCollectionFail);
		}
				//-----------------------------------------
		// Event handlers : validation result for specific eventTargetObj(email_result)
		//-----------------------------------------
		private function handlerEmailValidationPassed(e : FormDataManagerEvent) : void {
			this["emailErrTxt"].text = "";
			handlerValidationPassed(e);
		}
		private function handlerEmailValidationFailed(e : FormDataManagerEvent) : void {
			this["emailErrTxt"].text = e.errorMessage.toString();
			handlerValidationFailed(e);
		} 
		//-----------------------------------------
		// Event handlers : validation result
		//-----------------------------------------
		private function handlerValidationPassed(e : FormDataManagerEvent) : void {
			var successMC : DisplayObject = e.target as DisplayObject;
			if(successMC) { 
				successMC["passed"].visible = true;	
				successMC["warning"].visible = false;	
				successMC.visible = true;
			}
		}
		private function handlerValidationFailed(e : FormDataManagerEvent) : void {
			var failedMC : DisplayObject = e.target as DisplayObject;
			if(failedMC) { 
				failedMC["passed"].visible = false;	
				failedMC["warning"].visible = true;	
				failedMC.visible = true;
			}
		}
		//-----------------------------------------
		// Event handlers : Data collection result
		//-----------------------------------------
		private function handlerDataCollectionSuccess(e : FormDataManagerEvent) : void {
			formDataManager.removeTrigger(this["sendButton"]);
			this["sendButton"].enabled = false;
			
			var resultStr : String = "*** SUCCESS ***\n"; 
			for (var i : String in FormDataManager.collectedData) {
				resultStr += i + " : " + FormDataManager.collectedData[i].toString() + "\n";
			}
			this["resultTxt"].text = resultStr;
		}	
		private function handlerDataCollectionFail(e : FormDataManagerEvent) : void {
			var resultStr : String = "*** ERRORS ***\n"; 
			for (var i : String in FormDataManager.failedData) {
				resultStr += i + " : " + FormDataManager.failedData[i] + "\n";
			}
			this["resultTxt"].text = resultStr;
		}
	}
}

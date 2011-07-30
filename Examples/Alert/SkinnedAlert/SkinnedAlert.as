/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package
{
	import com.yahoo.astra.fl.managers.AlertManager;
	import flash.events.MouseEvent;
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.DisplayObject;
	import com.yahoo.astra.utils.InstanceFactory;
	import flash.text.TextFormat;
	import flash.events.Event;
	
	public class SkinnedAlert extends Sprite
	{
		/**
		 * Constructor
		 */
		public function SkinnedAlert()
		{
			this.stage.align = StageAlign.TOP_LEFT;		
			super();
			//this.styleAlert();
			this.addButtons();
		}
		
		/**
		 * @private
		 */
		private var _showAlert:Button;
		
		/**
		 * @private 
		 * Adds buttons to the stage
		 */
		private function addButtons():void
		{
			_showAlert = new Button();
			_showAlert.label = "Show Alert";
			_showAlert.x = 20;
			_showAlert.y = 20;
			_showAlert.addEventListener(MouseEvent.CLICK, handleShowAlert);
			this.addChild(_showAlert);					
		}
		
		
		private function handleShowAlert(event:MouseEvent):void
		{			
			var textFormat:TextFormat = new TextFormat("Verdana", 9, 0x000000);
			var titleTextFormat:TextFormat = new TextFormat("Verdana", 9, 0xeeeeee);
			var titleSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																{width:10, 
																colors:[0x666666, 0x999999, 0x666666], 
																alphas:[1, 1, 1], 
																ratios:[0, 90, 180], 
																height:10, 
																gradientRotation:90});
																
			var upSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																{width:10, 
																colors:[0x666666, 0xaaaaaa, 0x666666], 
																alphas:[1, 1, 1], 
																ratios:[0, 90, 180], 
																height:10, 
																hasBevel:true,
																bevelShadow:0x666666,
																gradientRotation:90});			
			
			var overSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																{width:10, 
																colors:[0x666666, 0xdddddd, 0x666666], 
																alphas:[1, 1, 1], 
																ratios:[0, 90, 180], 
																height:10, 
																hasBevel:true,
																bevelShadow:0x666666,
																gradientRotation:90});			
			
			var downSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																{width:10, 
																colors:[0x666666, 0xaaaaaa, 0x666666], 
																alphas:[1, 1, 1], 
																ratios:[0, 90, 180], 
																height:10, 
																borderWidth:2,
																borderAlpha:.5,
																hasBevel:true,
																borderColor:0x000000,
																bevelAngle:225,
																bevelShadow:0x999999,
																gradientRotation:90});
																
			var bgSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, {
																width:10, 
																colors:[0x999999, 0xeeeeee, 0x999999], 
																alphas:[1, 1, 1], 
																ratios:[0, 90, 180], 
																height:10, 
																gradientRotation:90});
																
			var focusRectSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, {
																width:10,
																height:10,
																colors:[0x000000],
																alphas:[0],
																ratios:[0],
																borderWidth:2,
																borderAlpha:.5,
																hasBevel:true,
																borderColor:0x666666});
			
			AlertManager.setTitleBarStyle("backgroundSkin", titleSkin);
			AlertManager.setTitleBarStyle("titleTextFormat", textFormat);
			AlertManager.setButtonStyle("upSkin", upSkin);
			AlertManager.setButtonStyle("overSkin", overSkin);
			AlertManager.setButtonStyle("downSkin", downSkin);
			
			AlertManager.setButtonStyle("focusRectSkin", focusRectSkin);
			AlertManager.setButtonStyle("textFormat", textFormat);
			AlertManager.setAlertStyle("skin", bgSkin);
			AlertManager.setMessageBoxStyle("textFormat", textFormat);
			AlertManager.createAlert(this, "This Alert has been styled through the AlertManager.", "Title Bar", ["OK", "SHOW ME ANOTHER"], handleSecondAlert);
		}
		
		private function handleSecondAlert(event:Event):void
		{
			if(event.currentTarget.name == "SHOW ME ANOTHER")
			{
				var textFormat:TextFormat = new TextFormat("Verdana", 9, 0x000000);
				var titleTextFormat:TextFormat = new TextFormat("Verdana", 9, 0xeeeeee);				
				var titleSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																	{width:10, 
																	colors:[0x899FAA, 0x556C77, 0x899FAA], 
																	alphas:[1, 1, 1], 
																	ratios:[0, 90, 180], 
																	height:10, 
																	gradientRotation:90});

				var upSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																	{width:10, 
																	colors:[0x899FAA, 0xaaaaaa, 0x899FAA], 
																	alphas:[1, 1, 1], 
																	ratios:[0, 90, 180], 
																	height:10, 
																	hasBevel:true,
																	gradientRotation:90});			

				var overSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																	{width:10, 
																	colors:[0x899FAA, 0xdddddd, 0x899FAA], 
																	alphas:[1, 1, 1], 
																	ratios:[0, 90, 180], 
																	height:10, 
																	hasBevel:true,
																	gradientRotation:90});			

				var downSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, 
																	{width:10, 
																	colors:[0x899FAA, 0xaaaaaa, 0x899FAA], 
																	alphas:[1, 1, 1], 
																	ratios:[0, 90, 180], 
																	height:10, 
																	borderWidth:2,
																	borderAlpha:.5,
																	hasBevel:true,
																	bevelShadow:0x666666,
																	borderColor:0x000000,
																	bevelAngle:225,
																	gradientRotation:90});

				var bgSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, {
																	width:10, 
																	colors:[0xB0BFC6, 0xeeeeee, 0xB0BFC6], 
																	alphas:[1, 1, 1], 
																	ratios:[0, 90, 180], 
																	height:10, 
																	gradientRotation:90});

				var focusRectSkin:InstanceFactory = new InstanceFactory(ProgramaticSkin, {
																	width:10,
																	height:10,
																	colors:[0x000000],
																	alphas:[0],
																	ratios:[0],
																	borderWidth:2,
																	borderAlpha:.5,
																	hasBevel:true,
																	borderColor:0x899FAA});				
				
				
				var props:Object = {};
				props.buttonStyles = {upSkin:upSkin, downSkin:downSkin, overSkin:overSkin, focusRectSkin:focusRectSkin};
				props.alertStyles = {skin:bgSkin};
				props.messageBoxStyle = {textFormat:textFormat};
				props.titleBarStyles = {textFormat:titleTextFormat, backgroundSkin:titleSkin};
				AlertManager.createAlert(this, "This Alert has been styled through props object.", "Title Bar", ["OK"], null, null, true, props);			
			}
		}		
	}	
}
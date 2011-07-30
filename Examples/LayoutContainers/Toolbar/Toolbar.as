/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.containers.HBoxPane;
	
	import fl.controls.Button;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * The document class for the Toolbar example application. Demonstrates
	 * the use of the HBoxPane layout container from the Yahoo! ASTRA library
	 * for Flash CS3.
	 * 
	 * @author Josh Tynjala
	 * @see http://developer.yahoo.com/flash/astra-flash/
	 */
	public class Toolbar extends Sprite
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor
		 */
		public function Toolbar()
		{
			super();
			
			//some simple initialization to ensure the stage doesn't stretch
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			
			//specifies what will be displayed in each button on the toolbar
			var buttonData:Array =
			[
				{ label: "Reply", icon: "ReplyIcon", width: 65 },
				{ label: "Forward", icon: "ForwardIcon", width: 80 },
				{ label: "Delete", icon: "DeleteIcon", width: 65 },
				{ label: "Spam", icon: "SpamIcon", width: 65 },
				{ label: "Print", icon: "PrintIcon", width: 60 }
			];
			
			//Note: We don't instantiate toolbar here because it is created
			//on stage in Flash
			
			//add some padding between the buttons and the edge of the toolbar
			toolbar.paddingLeft = 6;
			toolbar.paddingTop = 3;
			
			//make sure there's some spacing between the buttons
			toolbar.horizontalGap = 2;
			
			//set the skin from the FLA file's library
			toolbar.setStyle("skin", "ToolbarSkin");
			
			//add the toolbar to the stage
			this.addChild(toolbar);
			
			//create the buttons and add them to the toolbar
			this.createToolbarButtons(toolbar, buttonData);
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
		
		/**
		 * @private
		 * The toolbar instance. Created on stage in the FLA file.
		 */
		public var toolbar:HBoxPane;
		
	//--------------------------------------
	//  Private Methods
	//--------------------------------------
	
		/**
		 * @private
		 * Loop through the button data and add buttons to the toolbar
		 */
		private function createToolbarButtons(toolbar:HBoxPane, buttonData:Array):void
		{
			var buttonCount:int = buttonData.length; 
			for(var i:int = 0; i < buttonCount; i++)
			{
				//get the current data
				var data:Object = buttonData[i];
				
				//create a new button, set the label, icon, and width from the data
				var button:Button = new Button();
				button.label = data.label;
				button.setStyle("icon", data.icon);
				button.width = data.width
				
				button.useHandCursor = true;
				
				//a blank upSkin. we only want to see the text and icon in the up state.
				button.setStyle("upSkin", Shape);
				button.setStyle("overSkin", "ToolbarButtonOverSkin");
				button.setStyle("downSkin", "ToolbarButtonDownSkin");
				
				//add it to the toolbar
				toolbar.addChild(button);
			}
		}
	}
}

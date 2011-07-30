/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example
{
	import fl.controls.Button;
	import fl.controls.TextInput;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;

	/**
	 * A mock settings page for personal options.
	 * @author Josh Tynjala
	 */
	public class PersonalSettingsPage extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function PersonalSettingsPage()
		{
			super();
			
			//style the display name text input
			this.displayNameInput.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.displayNameInput.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));;
			
			//style the email text input
			this.emailInput.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.emailInput.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));
						
			//style the save button
			this.saveButton.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.saveButton.setStyle("upSkin", "BlackNavigationSkin");
			this.saveButton.setStyle("overSkin", "PurpleNavigationSkin");
			this.saveButton.setStyle("downSkin", "PurpleHighlightNavigationSkin");
			this.saveButton.setStyle("textFormat", new TextFormat("Arial", 12, 0xffffff, true));
		}
		
		/**
		 * A TextInput control that allows the user to specify a display name.
		 */
		public var displayNameInput:TextInput;
		
		/**
		 * A TextInput control that allows the user to specify his or her email address.
		 */
		public var emailInput:TextInput;
		
		/**
		 * A button that saves the personal settings when clicked.
		 */
		public var saveButton:Button;
	}
}
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
	 * A mock settings page that allows the user to change his or her password.
	 */
	public class PasswordSettingsPage extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function PasswordSettingsPage()
		{
			super();
			
			//style the input for the current password
			this.currentPasswordInput.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.currentPasswordInput.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));
			
			//style the input for the new password
			this.newPasswordInput.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.newPasswordInput.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));
			
			//style the input for the retyped new password
			this.newPasswordInput2.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.newPasswordInput2.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));
						
			//style the change password button
			this.changeButton.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.changeButton.setStyle("upSkin", "BlackNavigationSkin");
			this.changeButton.setStyle("overSkin", "PurpleNavigationSkin");
			this.changeButton.setStyle("downSkin", "PurpleHighlightNavigationSkin");
			this.changeButton.setStyle("textFormat", new TextFormat("Arial", 12, 0xffffff, true));
		}
		
		/**
		 * A TextInput where the user must enter his or her current password.
		 */
		public var currentPasswordInput:TextInput;
		
		/**
		 * A TextInput where the user must enter his or her desired new password.
		 */
		public var newPasswordInput:TextInput;
		
		/**
		 * A TextInput where the user must retype his or her password to confirm.
		 */
		public var newPasswordInput2:TextInput;
		
		/**
		 * A button that saves the user's new password when clicked.
		 */
		public var changeButton:Button;
		
	}
}
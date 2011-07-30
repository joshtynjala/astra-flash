/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example
{
	import fl.controls.Button;
	import fl.controls.CheckBox;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;

	/**
	 * A mock settings page for newsletter subscriptions.
	 * 
	 * @author Josh Tynjala
	 */
	public class NewsletterSettingsPage extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function NewsletterSettingsPage()
		{
			super();
			
			//style the monthly subscription checkbox
			this.monthlyCheck.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.monthlyCheck.setStyle("upIcon", "BlackCheckBoxIcon");
			this.monthlyCheck.setStyle("overIcon", "PurpleCheckBoxIcon");
			this.monthlyCheck.setStyle("downIcon", "PurpleCheckBoxIcon");
			this.monthlyCheck.setStyle("selectedUpIcon", "BlackCheckBoxSelectedIcon");
			this.monthlyCheck.setStyle("selectedOverIcon", "PurpleCheckBoxSelectedIcon");
			this.monthlyCheck.setStyle("selectedDownIcon", "PurpleCheckBoxSelectedIcon");
			this.monthlyCheck.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));
			
			//style the hot products checkbox
			this.hotProductsCheck.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.hotProductsCheck.setStyle("upIcon", "BlackCheckBoxIcon");
			this.hotProductsCheck.setStyle("overIcon", "PurpleCheckBoxIcon");
			this.hotProductsCheck.setStyle("downIcon", "PurpleCheckBoxIcon");
			this.hotProductsCheck.setStyle("selectedUpIcon", "BlackCheckBoxSelectedIcon");
			this.hotProductsCheck.setStyle("selectedOverIcon", "PurpleCheckBoxSelectedIcon");
			this.hotProductsCheck.setStyle("selectedDownIcon", "PurpleCheckBoxSelectedIcon");
			this.hotProductsCheck.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000));
			
			//style the update button
			this.updateButton.setStyle("focusRectSkin", "PurpleFocusRectSkin");
			this.updateButton.setStyle("upSkin", "BlackNavigationSkin");
			this.updateButton.setStyle("overSkin", "PurpleNavigationSkin");
			this.updateButton.setStyle("downSkin", "PurpleHighlightNavigationSkin");
			this.updateButton.setStyle("textFormat", new TextFormat("Arial", 12, 0xffffff, true));
		}
		
		/**
		 * A CheckBox that indicates whether the user is subscribed
		 * to the monthly newsletter.
		 */
		public var monthlyCheck:CheckBox;
		
		/**
		 * A CheckBox that indicates whether the user is subscribed
		 * to the hot products newsletter.
		 */
		public var hotProductsCheck:CheckBox;
		
		/**
		 * A Button that saves the subscriptions settings when clicked.
		 */
		public var updateButton:Button;
	}
}
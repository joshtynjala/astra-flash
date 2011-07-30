/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.controls.TabBar;
	
	import fl.controls.CheckBox;
	import fl.controls.TextInput;
	import fl.managers.StyleManager;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFormat;

	/**
	 * Demonstrates the use of the TabBar control in the Yahoo! Astra library
	 * of Flash components.
	 * 
	 * @author Josh Tynjala
	 */
	public class TabPages extends MovieClip
	{
		/**
		 * Constructor.
		 */
		public function TabPages()
		{
			super();
			stop();
			
			this.navigation.setStyle("textFormat", new TextFormat("Arial", 12, 0xffffff, true));
			this.navigation.setRendererStyle("upSkin", "BlackNavigationSkin");
			this.navigation.setRendererStyle("overSkin", "PurpleHighlightNavigationSkin");
			this.navigation.setRendererStyle("downSkin", "PurpleNavigationSkin");
			this.navigation.setRendererStyle("selectedUpSkin", "PurpleNavigationSkin");
			this.navigation.setRendererStyle("selectedOverSkin", "PurpleNavigationSkin");
			this.navigation.setRendererStyle("selectedDownSkin", "PurpleNavigationSkin");
			this.navigation.addEventListener(Event.CHANGE, navigationChangeHandler);
		}
		
		/**
		 * The TabBar control that allows navigation through the pages.
		 */
		public var navigation:TabBar;
		
		/**
		 * Changes to a different frame when the TabBar's selected item changes.
		 * Each frame in this MovieClip is a new page for the tabs.
		 */
		private function navigationChangeHandler(event:Event):void
		{
			var frameLabel:String = this.navigation.selectedItem.data;
			this.gotoAndStop(frameLabel);
		}
	}
}

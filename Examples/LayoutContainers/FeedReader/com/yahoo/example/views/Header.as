/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.views
{
	import com.yahoo.astra.fl.containers.HBoxPane;
	import com.yahoo.astra.layout.modes.VerticalAlignment;
	
	import fl.controls.TextInput;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * Displays the application title and a short description.
	 * 
	 * @author Josh Tynjala
	 */
	public class Header extends HBoxPane
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function Header()
		{
			super();
			
			//allow this container to determine its optimal size
			this.setSize(NaN, NaN);
			
			//positioning properties for the children
			this.horizontalGap = 4;
			this.verticalAlign = VerticalAlignment.MIDDLE;
			
			//loads the title image symbol from the library
			var title:DisplayObject = this.getDisplayObjectInstance("AstraFeeds");
			
			//displays a short description of this application
			var subtitle:TextField = new TextField();
			subtitle.defaultTextFormat = new TextFormat("Arial", 11, 0x6f9cb9, false, false, false, null, null, "right");
			subtitle.text = "A demonstration of the layout controls from the Yahoo! ASTRA library for Flash CS3";//"An example of layout with Yahoo! ASTRA";
			subtitle.height = subtitle.textHeight + 4;
			
			//to add the title and subtitle as children of this container, we
			//may use addChild(), like any other DisplayObjectContainer. However,
			//we're using this container's configuration property because we
			//want the subtitle to grow fluidly to be aligned to the right
			this.configuration =
			[
				{target: title}, //no configuration options for the title
				{target: subtitle, percentWidth: 100} //the subtitle will be sized to fit the remaining space
			];
		}
		
	}
}
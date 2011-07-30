/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.events
{
	import flash.events.Event;

	public class FilterEvent extends Event
	{
		
	//--------------------------------------
	//  Static Properties
	//--------------------------------------
	
		public static const FILTER:String = "filter";
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function FilterEvent(type:String, text:String, caseSensitive:Boolean = false)
		{
			super(type, false, false);
			this.text = text;
			this.caseSensitive = caseSensitive;
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * The text used to filter.
		 */
		public var text:String;
		
		/**
		 * Indicates whether to match by case.
		 */
		public var caseSensitive:Boolean;
		
	//--------------------------------------
	//  Public Methods
	//--------------------------------------
	
		/**
		 * @private
		 */
		override public function clone():Event
		{
			return new FilterEvent(this.type, this.text, this.caseSensitive);
		}
	}
}
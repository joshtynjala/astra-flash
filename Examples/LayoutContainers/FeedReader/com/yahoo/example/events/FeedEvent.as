/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.events
{
	import flash.events.Event;

	public class FeedEvent extends Event
	{
		
	//--------------------------------------
	//  Static Properties
	//--------------------------------------
	
		public static const FEED_LOAD_COMPLETE:String = "feedLoadComplete";
		public static const FEED_LOAD_ERROR:String = "feedLoadError";
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function FeedEvent(type:String, url:String)
		{
			super(type, false, false);
			this.url = url;
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * The feed's URL.
		 */
		public var url:String;
		
	//--------------------------------------
	//  Public Methods
	//--------------------------------------
	
		/**
		 * @private
		 */
		override public function clone():Event
		{
			return new FeedEvent(this.type, this.url);
		}
	}
}
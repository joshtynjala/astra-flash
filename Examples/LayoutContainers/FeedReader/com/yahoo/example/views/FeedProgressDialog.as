/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.views
{
	import fl.controls.ProgressBar;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * Displays the status of a loading feed. While the feed is being
	 * downloaded, a progress bar is displayed. Alternatively, some status
	 * text may be displayed when needed.
	 * 
	 * @author Josh Tynjala
	 */
	public class FeedProgressDialog extends Sprite
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function FeedProgressDialog()
		{
			super();
			
			//use a custom skin on the progress bar
			this.progressBar.setStyle("indeterminateSkin", "ProgressIndeterminateSkin");
			
			//set the message font styles
			this.message.defaultTextFormat = new TextFormat("Arial", 12, 0x000000, true);
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * @private
		 * The background skin of this component.
		 * 
		 * Placed on the Flash CS3 stage. See the related FLA file. 
		 */
		public var background:Sprite;
		
		/**
		 * @private
		 * The progress bar component.
		 * 
		 * Placed on the Flash CS3 stage. See the related FLA file. 
		 */
		public var progressBar:ProgressBar;
		
		/**
		 * @private
		 * The status message field.
		 * 
		 * Placed on the Flash CS3 stage. See the related FLA file. 
		 */
		public var message:TextField;
		
		/**
		 * @private
		 * Storage for the status property.
		 */
		private var _status:String = "";
		
		/**
		 * A message that indicates the status of a feed loading operation.
		 * If "" or null, displays "Loading Feed".
		 */
		public function get status():String
		{
			return this._status;
		}
		
		/**
		 * @private
		 */
		public function set status(value:String):void
		{
			this._status = value;
			this.refreshStatus();
		}
		
		/**
		 * @private
		 * Since this is a Sprite, it resizes based on content, and the moving
		 * progressbar causes size changes.
		 */
		override public function get width():Number
		{
			return this.background.width;
		}
		
		/**
		 * @private
		 * Do nothing. we don't want stretching!
		 */
		override public function set width(value:Number):void
		{
		}
		
		/**
		 * @private
		 * Since this is a Sprite, it resizes based on content, and the moving
		 * progressbar causes size changes.
		 */
		override public function get height():Number
		{
			return this.background.height;
		}
		
		/**
		 * @private
		 * Do nothing. we don't want stretching!
		 */
		override public function set height(value:Number):void
		{
		}
		
	//--------------------------------------
	//  Protected Methods
	//--------------------------------------
	
		/**
		 * @private
		 * Updates the status message and the progress bar, as needed.
		 */
		protected function refreshStatus():void
		{
			if(this._status)
			{
				//if we have a status message, display it and hide the progress bar
				this.message.text = this._status;
				this.progressBar.visible = false;
			}
			else
			{
				//if we don't have a status message, display the default text
				//and show the progress bar.
				this.message.text = "Loading Feed";
				this.progressBar.visible = true;
			}
		}
	}
}
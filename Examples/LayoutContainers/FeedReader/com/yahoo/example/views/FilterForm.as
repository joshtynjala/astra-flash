/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.views
{
	import com.yahoo.example.events.FilterEvent;
	
	import fl.controls.CheckBox;
	import fl.controls.TextInput;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	[Event(name="filter", type="com.yahoo.example.events.FilterEvent")]

	public class FilterForm extends Sprite
	{
		public function FilterForm()
		{
			super();
			this.filterInput.setStyle("focusRectSkin", Shape);
			this.filterInput.addEventListener(Event.CHANGE, filterChangeHandler);
			this.caseSensitiveBox.addEventListener(Event.CHANGE, caseSensitiveChangeHandler);
		}
		
		public var filterInput:TextInput;
		public var caseSensitiveBox:CheckBox;
		
		/**
		 * @private
		 * Do nothing. we don't want stretching!
		 */
		override public function set width(value:Number):void
		{
		}
		
		/**
		 * @private
		 * Do nothing. we don't want stretching!
		 */
		override public function set height(value:Number):void
		{
		}
		
		public function get text():String
		{
			return this.filterInput.text;
		}
		
		public function set text(value:String):void
		{
			this.filterInput.text = value;
			this.requestFilter();
		}
		
		public function get caseSensitive():Boolean
		{
			return this.caseSensitiveBox.selected;
		}
		
		protected function requestFilter():void
		{
			var event:FilterEvent = new FilterEvent(FilterEvent.FILTER, this.filterInput.text, this.caseSensitiveBox.selected);
			this.dispatchEvent(event);
		}
		
		protected function filterChangeHandler(event:Event):void
		{
			this.requestFilter();
		}
		
		protected function caseSensitiveChangeHandler(event:Event):void
		{
			this.requestFilter();
		}
		
	}
}
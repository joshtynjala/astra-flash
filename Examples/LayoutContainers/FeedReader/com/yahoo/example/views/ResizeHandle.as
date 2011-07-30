/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.views
{
	import com.yahoo.example.events.DragEvent;
	
	import fl.controls.Button;
	import fl.events.ComponentEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	[Event(name="dragUpdate",type="com.yahoo.example.events.DragEvent")]
	
	/**
	 * After the mouse is pressed on this button, it dispatches events
	 * indicating that something is being dragged.
	 * 
	 * @author Josh Tynjala
	 */
	public class ResizeHandle extends Button
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function ResizeHandle()
		{
			super();
			
			this.label = "";
			this.buttonMode = true;
			this.useHandCursor = true;
			this.setSize(10, 30);
			this.setStyle("textPadding", 0);
			
			//no skin, just an icon
			this.setStyle("upSkin", Shape);
			this.setStyle("overSkin", Shape);
			this.setStyle("downSkin", Shape);
			this.setStyle("disabledSkin", Shape);
			this.setStyle("icon", "HorizontalHandleIcon");
			
			//listen for when this button is held down
			this.addEventListener(ComponentEvent.BUTTON_DOWN, resizeHandleDownHandler);
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * @private
		 * The location where the button was pressed down. Used to calculate the delta of the drag.
		 */
		protected var startDragPosition:Number;
		
		private var _direction:String = "horizontal";
		
		public function get direction():String
		{
			return this._direction;
		}
		
		public function set direction(value:String):void
		{
			this._direction = value;
			
			switch(this._direction)
			{
				case "vertical":
					this.setStyle("icon", "VerticalHandleIcon");
					this.setSize(30, 10);
					break;
				default:
					this.setStyle("icon", "HorizontalHandleIcon");
					this.setSize(10, 30);
			}
		}
		
		protected function resizeHandleDownHandler(event:ComponentEvent):void
		{
			if(this._direction == "vertical")
			{
				this.startDragPosition = this.stage.mouseY;
			}
			else
			{
				this.startDragPosition = this.stage.mouseX;
			}
			
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleDragHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, handleDragStopHandler, false, 0, true);
			
			var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_START, 0);
			this.dispatchEvent(dragEvent);
		}
		
		protected function handleDragHandler(event:MouseEvent):void
		{
			var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_UPDATE, this.calculateOffset());
			this.dispatchEvent(dragEvent);
		}
		
		protected function handleDragStopHandler(event:MouseEvent):void
		{
			this.handleDragHandler(event);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleDragHandler);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, handleDragStopHandler);
			
			var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_END, this.calculateOffset());
			this.dispatchEvent(dragEvent);
		}
		
		protected function calculateOffset():Number
		{
			var offset:Number = 0;
			if(this._direction == "vertical")
			{
				offset = this.stage.mouseY - this.startDragPosition;
			}
			else
			{
				offset = this.stage.mouseX - this.startDragPosition;
			}
			return offset;
		}

	}
}
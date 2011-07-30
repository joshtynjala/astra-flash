/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.example.views
{
	import com.adobe.xml.syndication.generic.Author;
	import com.adobe.xml.syndication.generic.Excerpt;
	import com.adobe.xml.syndication.generic.IItem;
	import com.yahoo.astra.fl.containers.BorderPane;
	import com.yahoo.astra.fl.containers.VBoxPane;
	import com.yahoo.astra.layout.modes.BorderConstraints;
	
	import fl.controls.TextArea;
	
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ReadingPane extends BorderPane
	{
		public function ReadingPane()
		{
			super();
			
			this.paddingTop = this.paddingRight = this.paddingBottom = this.paddingLeft = 1;
			this.setStyle("skin", "TextArea_upSkin");
			
			var headerFormat:TextFormat = new TextFormat("Arial", 12, 0x000000);
			
			var header:VBoxPane = new VBoxPane();
			//allow this container to determine its optimal size
			header.setSize(NaN, NaN);
			header.paddingTop = header.paddingRight = header.paddingBottom = header.paddingLeft = 3;
			header.setStyle("skin", "MessageHeaderSkin");
			header.verticalGap = 3;
			
			this.titleField = new TextField();
			this.titleField.autoSize = TextFieldAutoSize.LEFT;
			this.titleField.defaultTextFormat = headerFormat;
			header.addChild(this.titleField);
			
			this.authorField = new TextField();
			this.authorField.autoSize = TextFieldAutoSize.LEFT;
			this.authorField.defaultTextFormat = headerFormat;
			header.addChild(this.authorField);
			
			this.contentArea = new TextArea();
			this.contentArea.editable = false;
			this.contentArea.setStyle("upSkin", Shape);
			this.contentArea.setStyle("textFormat", new TextFormat("Courier New", 14, 0x000000));
			
			this.configuration = 
			[
				{target: header, constraint: BorderConstraints.TOP},
				{target: this.contentArea, constraint: BorderConstraints.CENTER}
			];
			
			this.verticalGap = 2;
		}
		
		protected var titleField:TextField;
		protected var authorField:TextField;
		protected var contentArea:TextArea;
		
		private var _data:IItem;
		
		public function get data():IItem
		{
			return this._data;
		}
		
		public function set data(value:IItem):void
		{
			this._data = value;
			this.invalidate();
		}
		
		override protected function draw():void
		{
			var titleText:String = " ";
			var authorText:String = " ";
			var contentText:String = " ";
			
			if(this.data)
			{
				var author:Author = this.data.authors[0] as Author;
				var excerpt:Excerpt = this.data.excerpt;
				titleText = "<b>Title:</b> " + this.data.title;
				authorText = "<b>Author:</b> " + (author.name ? author.name : author.email); 
				contentText = "<p>" + excerpt.value + " [...]</p><br>";
				contentText += "<font color=\"#0000ff\"><u><p><a href=\"" + encodeURI(this.data.link) + "\">View the full message</a></p></u></font>";
			}
			
			this.titleField.htmlText = titleText;
			this.authorField.htmlText = authorText;
			this.contentArea.htmlText = contentText;
			
			super.draw();
		}
		
	}
}
/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.example.views
{
	import com.adobe.utils.DateUtil;
	import com.adobe.xml.syndication.generic.Author;
	import com.adobe.xml.syndication.generic.FeedFactory;
	import com.adobe.xml.syndication.generic.IFeed;
	import com.adobe.xml.syndication.generic.IItem;
	import com.yahoo.astra.fl.containers.BorderPane;
	import com.yahoo.astra.fl.containers.HBoxPane;
	import com.yahoo.astra.fl.containers.VBoxPane;
	import com.yahoo.astra.layout.modes.BorderConstraints;
	import com.yahoo.astra.layout.modes.VerticalAlignment;
	import com.yahoo.example.events.DragEvent;
	import com.yahoo.example.events.FeedEvent;
	import com.yahoo.example.events.FilterEvent;
	
	import fl.controls.Button;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	
	import flash.display.Shape;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	[Event(name="feedLoadComplete",type="com.yahoo.example.events.FeedEvent")]
	[Event(name="feedLoadError",type="com.yahoo.example.events.FeedEvent")]

	public class FeedViewer extends BorderPane
	{
		public function FeedViewer()
		{
			super();
			
			this.verticalGap = 1;
			
			this.feedToolbar = new HBoxPane();
			this.configureFeedToolbar();
			
			this.feedItemsGrid = new DataGrid();
			this.configureItemGrid();
			
			this.filterToolbar = new HBoxPane();
			this.configureFilterToolbar();
			
			//the upper content container holds the feedToolbar, the
			//feedItemsGrid, and the filterToolbar
			this.upperContentContainer = new VBoxPane();
			//allow this container to determine its optimal size
			this.upperContentContainer.setSize(NaN, NaN);
			this.upperContentContainer.verticalGap = 6;
			this.upperContentContainer.configuration =
			[
				{target: this.feedToolbar, percentWidth: 100},
				{target: this.feedItemsGrid, percentWidth: 100, percentHeight: 100},
				{target: this.filterToolbar, percentWidth: 100, includeInLayout: false}
			];
			
			//the resize handle resize the reading pane
			this.resizeHandle = new ResizeHandle();
			this.resizeHandle.direction = "vertical";
			this.resizeHandle.addEventListener(DragEvent.DRAG_START, dragStartHandler);
			this.resizeHandle.addEventListener(DragEvent.DRAG_UPDATE, dragUpdateHandler);
			
			this.readingPane = new ReadingPane();
			this.readingPane.height = 200;
			
			this.configuration = 
			[
				{target: this.upperContentContainer, constraint: BorderConstraints.CENTER},
				{target: this.readingPane, constraint: BorderConstraints.BOTTOM},
				{target: this.resizeHandle, constraint: BorderConstraints.BOTTOM}
			];
		}
		
		protected var upperContentContainer:VBoxPane;
		
		protected var feedToolbar:HBoxPane;
		protected var findButton:Button;
		
		protected var filterToolbar:HBoxPane;
		protected var filterForm:FilterForm;
		
		protected var feedItemsGrid:DataGrid;
		protected var readingPane:ReadingPane;
		
		protected var resizeHandle:ResizeHandle;
		protected var dragStartSize:Number;
		
		protected var feedURL:String;
		protected var feedLoader:URLLoader;
		protected var feedItems:Array = [];
		
		public function loadFeed(url:String):void
		{
			this.findButton.selected = false;
			this.findToggleHandler(null);
			
			this.feedURL = url;
			
			this.feedItems = [];
			this.feedItemsGrid.removeAll();
			this.readingPane.data = null;
			
			this.cleanUpLoader();
			
			if(!this.feedURL)
			{
				return;
			}
			
			this.feedLoader = new URLLoader();
			this.feedLoader.addEventListener(Event.COMPLETE, feedLoadCompleteHandler);
			this.feedLoader.addEventListener(IOErrorEvent.IO_ERROR, feedLoadErrorHandler);
			this.feedLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, feedLoadErrorHandler);
			this.feedLoader.load(new URLRequest(url));
		}
		
		protected function configureItemGrid():void
		{
			var authorColumn:DataGridColumn = new DataGridColumn();
			authorColumn.headerText = "Author";
			authorColumn.width = 80;
			authorColumn.labelFunction = itemToAuthors;
			authorColumn.sortCompareFunction = function(item1:IItem, item2:IItem):int
			{
				var item1Value:String = itemToAuthors(item1).toLowerCase();
				var item2Value:String = itemToAuthors(item2).toLowerCase();
				return item1Value.localeCompare(item2Value);
			}
			
			var titleColumn:DataGridColumn = new DataGridColumn("title");
			titleColumn.headerText = "Title";
			titleColumn.sortOptions = Array.CASEINSENSITIVE;
			
			var dateColumn:DataGridColumn = new DataGridColumn("date");
			dateColumn.width = 80;
			dateColumn.headerText = "Date";
			dateColumn.labelFunction = formatDate;
			
			dateColumn.sortCompareFunction = function(item1:IItem, item2:IItem):int
			{
				var item1Value:Number = item1.date.valueOf();
				var item2Value:Number = item2.date.valueOf();
				if(item1Value < item2Value)
				{
					return -1;
				}
				else if(item1Value > item2Value)
				{
					return 1;
				}
				return 0;
			}
			
			this.feedItemsGrid.columns = [authorColumn, titleColumn, dateColumn];
			this.feedItemsGrid.addEventListener(Event.CHANGE, dataGridSelectionChangeHandler);
			this.feedItemsGrid.setStyle("skin", "TextArea_upSkin");
			this.feedItemsGrid.setStyle("headerUpSkin", "HighlightedToolbarSkin");
			this.feedItemsGrid.setStyle("headerOverSkin", "HighlightedToolbarSkin");
			this.feedItemsGrid.setStyle("headerDownSkin", "HighlightedToolbarSkin");
			this.feedItemsGrid.setStyle("contentPadding", 1);
			this.feedItemsGrid.setStyle("headerTextFormat", new TextFormat("Arial", 12, 0x000000, true));
			this.feedItemsGrid.setRendererStyle("textFormat", new TextFormat("Arial", 11, 0x000000));
			this.feedItemsGrid.setRendererStyle("selectedTextFormat", new TextFormat("Arial", 11, 0xffffff));
			this.feedItemsGrid.setRendererStyle("upSkin", Shape);
			this.feedItemsGrid.setRendererStyle("downSkin", "SimpleOverSkin");
			this.feedItemsGrid.setRendererStyle("overSkin", "SimpleOverSkin");
			this.feedItemsGrid.setRendererStyle("selectedUpSkin", "SimpleSelectedSkin");
			this.feedItemsGrid.setRendererStyle("selectedDownSkin", "SimpleSelectedSkin");
			this.feedItemsGrid.setRendererStyle("selectedOverSkin", "SimpleSelectedSkin");
		}
		
		protected function configureFeedToolbar():void
		{
			//allow this container to determine its optimal size
			this.feedToolbar.setSize(NaN, NaN);
			this.feedToolbar.paddingTop = this.feedToolbar.paddingRight = this.feedToolbar.paddingBottom = this.feedToolbar.paddingLeft = 4;
			this.feedToolbar.horizontalGap = 2;
			this.feedToolbar.setStyle("skin", "ToolbarSkin");
			
			this.findButton = new Button();
			this.findButton.width = 50;
			this.findButton.label = "Find";
			this.findButton.toggle = true;
			this.findButton.setStyle("icon", "SearchIcon");
			this.findButton.setStyle("upSkin", Shape);
			this.findButton.setStyle("overSkin", "ToolbarButtonOverSkin");
			this.findButton.setStyle("downSkin", "ToolbarButtonDownSkin");
			this.findButton.setStyle("selectedUpSkin", "ToolbarButtonDownSkin");
			this.findButton.setStyle("selectedOverSkin", "ToolbarButtonDownSkin");
			this.findButton.setStyle("selectedDownSkin", "ToolbarButtonDownSkin");
			this.findButton.setStyle("textPadding", 2);
			this.findButton.addEventListener(Event.CHANGE, findToggleHandler);
			this.feedToolbar.addChild(this.findButton);
			
			var refreshButton:Button = new Button();
			refreshButton.width = 70;
			refreshButton.label = "Refresh";
			refreshButton.setStyle("icon", "RefreshIcon");
			refreshButton.setStyle("upSkin", Shape);
			refreshButton.setStyle("overSkin", "ToolbarButtonOverSkin");
			refreshButton.setStyle("downSkin", "ToolbarButtonDownSkin");
			refreshButton.setStyle("textPadding", 2);
			refreshButton.addEventListener(MouseEvent.CLICK, refreshClickHandler);
			this.feedToolbar.addChild(refreshButton);
		}
		
		protected function configureFilterToolbar():void
		{
			this.filterToolbar.visible = false;
			//allow this container to determine its optimal size
			this.filterToolbar.setSize(NaN, NaN);
			this.filterToolbar.paddingTop = this.filterToolbar.paddingRight = this.filterToolbar.paddingBottom = this.filterToolbar.paddingLeft = 4;
			this.filterToolbar.verticalAlign = VerticalAlignment.MIDDLE;
			this.filterToolbar.setStyle("skin", "ToolbarSkin");
			this.filterForm = new FilterForm();
			this.filterForm.addEventListener(FilterEvent.FILTER, filterChangeHandler);
			this.filterToolbar.addChild(this.filterForm);
		}
		
		protected function itemToAuthors(item:IItem):String
		{		
			var authorCount:int = item.authors.length;
			if(authorCount == 0)
			{
				return "Unknown Author";
			}
			
			var citation:String = "";
			for(var i:int = 0; i < authorCount; i++)
			{
				var author:Author = Author(item.authors[i]);
				citation += (author.name ? author.name : author.email);
				
				if(i < authorCount - 1)
				{
					citation += ", ";
				}
			}
			return citation;
		}
		
		protected function feedLoadCompleteHandler(event:Event):void
		{
			var feed:IFeed = FeedFactory.getFeedByString(this.feedLoader.data);
			this.feedItems = feed.items;
			this.updateFilter(this.filterForm.text, this.filterForm.caseSensitive);
			this.cleanUpLoader();
			
			var feedEvent:FeedEvent = new FeedEvent(FeedEvent.FEED_LOAD_COMPLETE, this.feedURL);
			this.dispatchEvent(feedEvent);
		}
		
		protected function feedLoadErrorHandler(event:ErrorEvent):void
		{
			this.cleanUpLoader();
			
			var feedEvent:FeedEvent = new FeedEvent(FeedEvent.FEED_LOAD_ERROR, this.feedURL);
			this.dispatchEvent(feedEvent);
		}
		
		protected function cleanUpLoader():void
		{
			if(!this.feedLoader)
			{
				//already cleaned up
				return;
			}
			
			this.feedLoader.removeEventListener(Event.COMPLETE, feedLoadCompleteHandler);
			this.feedLoader.removeEventListener(IOErrorEvent.IO_ERROR, feedLoadErrorHandler);
			this.feedLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, feedLoadErrorHandler);
			this.feedLoader = null;
		}
		
		protected function updateFilter(text:String, caseSensitive:Boolean):void
		{
			if(!caseSensitive)
			{
				text = text.toLowerCase();
			}
			
			if(!text)
			{
				this.feedItemsGrid.dataProvider = new DataProvider(this.feedItems);
				return;
			}
			
			var filteredData:Array = this.feedItems.filter(function(item:IItem, index:int, source:Array):Boolean
			{
				var author:Author = item.authors[0] as Author;
				if(author)
				{
					if(author.name && (caseSensitive ? author.name : author.name.toLowerCase()).indexOf(text) >= 0)
					{
						return true;
					}
					if(author.email && (caseSensitive ? author.email : author.email.toLowerCase()).indexOf(text) >= 0)
					{
						return true;
					}
				}
				
				return (item.title && (caseSensitive ? item.title : item.title.toLowerCase()).indexOf(text) >= 0) ||
					(item.excerpt && item.excerpt.value && (caseSensitive ? item.excerpt.value : item.excerpt.value.toLowerCase()).indexOf(text) >= 0);
			});
			this.feedItemsGrid.dataProvider = new DataProvider(filteredData);
		}
		
		protected function formatDate(item:Object):String
		{
			var itemDate:Date = item.date; 
			return DateUtil.getShortDayName(itemDate) + " " + (itemDate.getMonth() + 1) + "/" + itemDate.getDate() + "/" + itemDate.getFullYear() + " " + itemDate.toLocaleTimeString();
		}
		
		protected function refreshClickHandler(event:MouseEvent):void
		{
			this.loadFeed(this.feedURL);
		}
		
		/**
		 * @private
		 * When the find button is toggled, we need to update it's
		 * includeInLayout configuration option to add or remove the
		 * filter form from the layout.
		 */
		protected function findToggleHandler(event:Event):void
		{
			var showFilterControls:Boolean = this.findButton.selected;
			
			if(!showFilterControls)
			{
				this.filterForm.text = "";
			}
			
			this.filterToolbar.visible = showFilterControls;
			
			var config:Array = this.upperContentContainer.configuration.concat();
			var filtered:Array = config.filter(function(item:Object, index:int, source:Array):Boolean
			{
				return item.target == this.filterToolbar;
			}, this);
			
			var filteredCount:int = filtered.length;
			for(var i:int = 0; i < filteredCount; i++)
			{
				filtered[i].includeInLayout = showFilterControls;
			}
			
			this.upperContentContainer.configuration = config;
		}
		
		protected function dataGridSelectionChangeHandler(event:Event):void
		{
			this.readingPane.data = IItem(this.feedItemsGrid.selectedItem);
		}
		
		protected function filterChangeHandler(event:FilterEvent):void
		{
			this.updateFilter(event.text, event.caseSensitive);
		}
		
		protected function dragStartHandler(event:DragEvent):void
		{
			this.dragStartSize = this.readingPane.height;
		}
		
		protected function dragUpdateHandler(event:DragEvent):void
		{
			this.readingPane.height = Math.min(2 * this.height / 3, Math.max(0, this.dragStartSize - event.delta));
		}
	}
}
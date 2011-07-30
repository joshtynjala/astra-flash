/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.controls.Menu;
	import com.yahoo.astra.fl.controls.TabBar;
	import com.yahoo.astra.fl.events.MenuEvent;
	
	import fl.controls.Button;
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.TextInput;
	import fl.data.DataProvider;
	import fl.events.ComponentEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextFormat;

	/**
	 * Demonstrates a possible use of tabs in an application.
	 * 
	 * @author Josh Tynjala
	 */
	public class SearchTabs extends Sprite
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function SearchTabs()
		{
			super();
			
			this.createTabBar();
			this.createAstraDropDown();
			this.createQueryInput();
			this.createSearchButton();
			
			//listen for clicks to start the search
			this.searchButton.addEventListener(MouseEvent.CLICK, searchStartHandler);
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
		
		/**
		 * A set of search services available from Yahoo!.
		 */
		public var searchOptions:TabBar;
		
		/**
		 * A button that links to YDN.
		 */
		public var astraButton:Button;
		
		/**
		 * Insert the text to find in this TextInput.
		 */
		public var queryInput:TextInput;
		
		/**
		 * When pressed, this button passes the search query to Yahoo!.
		 */
		public var searchButton:Button;
		
	//--------------------------------------
	//  Private Methods
	//--------------------------------------
	
		/**
		 * Creates and styles the tab bar.
		 */
		private function createTabBar():void
		{
			//the data to be used by the TabBar
			var tabData:Array =
			[
				{text: "Web", urlPrefix: "http://search.yahoo.com/search?p="},
				{text: "Images", urlPrefix: "http://images.search.yahoo.com/search/images?p="},
				{text: "Local", urlPrefix: "http://local.yahoo.com/results?stx="}
			];
			
			this.searchOptions = new TabBar();
			
			//tells the tab bar to use the ideal tab size for the data it displays
			//ignores explicit width values
			this.searchOptions.autoSizeTabsToTextWidth = false;
			
			//the label text for each tab should come from the "text" field in the
			//data provider.
			this.searchOptions.labelField = "text";
			
			//just like the List control, the TabBar uses fl.data.DataProvider.
			this.searchOptions.dataProvider = new DataProvider(tabData);
			
			//set up the hand cursor for the tabs
			this.searchOptions.buttonMode = true;
			this.searchOptions.useHandCursor = true;
			
			//skin the tab bar
			this.searchOptions.setRendererStyle("upSkin", "TabRightEdge");
			this.searchOptions.setRendererStyle("overSkin", "TabRightEdge");
			this.searchOptions.setRendererStyle("downSkin", "TabRightEdge");
			this.searchOptions.setRendererStyle("selectedUpSkin", "TabRightEdge");
			this.searchOptions.setRendererStyle("selectedOverSkin", "TabRightEdge");
			this.searchOptions.setRendererStyle("selectedDownSkin", "TabRightEdge");
			this.searchOptions.setStyle("textFormat", new TextFormat("Arial", 12, 0x133891, false, false, true));
			this.searchOptions.setStyle("selectedTextFormat", new TextFormat("Arial", 12, 0x000000, true, false, false));
			
			//position the tab bar and add it to the display list
			this.searchOptions.move(170, 15);
			this.searchOptions.width = 200;
			this.addChild(this.searchOptions);
			
			//listen for tab changes on the tab bar to change the selected search target
			this.searchOptions.addEventListener(Event.CHANGE, searchOptionsChangeHandler);
		}
		
		/**
		 * Creates a button with a popup menu to link to Astra.
		 */
		private function createAstraDropDown():void
		{
			this.astraButton = new Button();
			this.astraButton.labelPlacement = ButtonLabelPlacement.LEFT;
			
			//a transparent skin creates a proper hit area on the button
			var astraButtonSkin:Shape = new Shape();
			astraButtonSkin.graphics.beginFill(0xff0000, 0);
			astraButtonSkin.graphics.drawRect(0, 0, 100, 100);
			astraButtonSkin.graphics.endFill();
			this.astraButton.setStyle("upSkin", astraButtonSkin);
			this.astraButton.setStyle("overSkin", astraButtonSkin);
			this.astraButton.setStyle("downSkin", astraButtonSkin);
			this.astraButton.setStyle("icon", "DownArrowIcon");
			this.astraButton.setStyle("textFormat", new TextFormat("Arial", 12, 0x133891, false, false, true));
			
			this.astraButton.label = "Get Astra!";
			this.astraButton.buttonMode = true;
			this.astraButton.useHandCursor = true;
			this.astraButton.setSize(90, 22);
			this.astraButton.move(370, 15);
			this.addChild(this.astraButton);
			this.astraButton.addEventListener(MouseEvent.CLICK, astraButtonClickHandler);
		}
		
		/**
		 * Creates a text input for the search query.
		 */
		private function createQueryInput():void
		{
			this.queryInput = new TextInput();
			this.queryInput.setSize(295, 22);
			this.queryInput.move(175, 46);
			this.addChild(this.queryInput);
			
			//listen for Enter key presses to start the search
			this.queryInput.addEventListener(ComponentEvent.ENTER, searchStartHandler);
		}
		
		/**
		 * Creates the button that initiates a search.
		 */
		private function createSearchButton():void
		{
			this.searchButton = new Button();
			this.searchButton.label = "Search Web";
			this.searchButton.setSize(95, 22);
			this.searchButton.move(480, 46);
			this.addChild(this.searchButton);
		}
		
	//--------------------------------------
	//  Private Event Handlers
	//--------------------------------------
		
		/**
		 * When the selected tab changes, we also change the text on the search button.
		 */
		private function searchOptionsChangeHandler(event:Event):void
		{
			this.searchButton.label = "Search " + this.searchOptions.selectedItem.text;
		}
		
		/**
		 * Begins a search with one of the Yahoo! services.
		 */
		private function searchStartHandler(event:Event):void
		{
			var query:String = this.queryInput.text;
			if(!query)
			{
				return;
			}
			
			var selectedSearchType:Object = this.searchOptions.selectedItem;
			var url:String = selectedSearchType.urlPrefix + escape(query);
			navigateToURL(new URLRequest(url), "_top");
		}
		
		/**
		 * Shows a menu with links to the Yahoo! Astra libraries.
		 */
		private function astraButtonClickHandler(event:MouseEvent):void
		{
			var menuData:XML = <menu>
					<item label="Astra Components for Flash" url="astra-flash"/>
					<item label="Astra Components for Flex" url="astra-flex"/>
					<item label="Astra Utilities" url="astra-utils"/>
					<item label="Astra Web APIs" url="astra-webapis"/>
				</menu>;
			var menu:Menu = Menu.createMenu(this, menuData);
			menu.addEventListener(MenuEvent.ITEM_CLICK, menuItemClickHandler, false, 0, true);
			menu.show(this.astraButton.x + 4, this.astraButton.y + 22);
		}
		
		/**
		 * Navigates to the selected Yahoo! Astra library.
		 */
		private function menuItemClickHandler(event:MenuEvent):void
		{
			var section:String = event.item.url;
			var baseURL:String = "http://developer.yahoo.com/flash/";
			navigateToURL(new URLRequest(baseURL + section + "/"), "_top");
		}
	}
}
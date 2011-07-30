/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.PagedPhotoList;
	import com.adobe.webapis.flickr.Photo;
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.yahoo.astra.fl.containers.TilePane;
	import com.yahoo.astra.fl.containers.VBoxPane;
	import com.yahoo.astra.layout.modes.HorizontalAlignment;
	import com.yahoo.astra.layout.modes.VerticalAlignment;
	import com.yahoo.example.events.SearchEvent;
	import com.yahoo.example.views.ImageResult;
	import com.yahoo.example.views.SearchForm;
	
	import fl.controls.ScrollPolicy;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * The document class for the Flickr Image Search example application.
	 * Demonstrates the use of the TilePane and other layout containers from the
	 * Yahoo! ASTRA library for Flash CS3.
	 * 
	 * @author Josh Tynjala
	 * @see http://developer.yahoo.com/flash/astra-flash/
	 */
	public class FlickrImageSearch extends Sprite
	{
		
	//--------------------------------------
	//  Static Properties
	//--------------------------------------
	
		/**
		 * @private
		 * Application key for Flickr service.
		 * 
		 * Get yours here: http://flickr.com/services/api/keys/
		 */
		private static const FLICKR_KEY:String = "9798b7c0eb8bcd4740f737b57a9c09dd";
		
		/**
		 * @private
		 * The number of results to capture from the Flickr API.
		 */
		private static const TOTAL_RESULTS_PER_PAGE:int = 25;
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function FlickrImageSearch()
		{
			if(this.stage)
			{
				// standard stage alignment and scaling stuff
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				
				// listen to resize so that we can update the size of the main
				// layout container
				this.stage.addEventListener(Event.RESIZE, stageResizeHandler);
			}
			
			// this is the main container, which displays its children in a
			// vertical stack
			this.main = new VBoxPane();
			this.main.setStyle("skin", "MainBackgroundSkin");
			this.main.verticalScrollPolicy = ScrollPolicy.ON;
			this.main.horizontalAlign = HorizontalAlignment.CENTER;
			this.main.width = this.stage.stageWidth;
			this.main.height = this.stage.stageHeight;
			this.main.verticalGap = 30;
			this.main.paddingTop = 40;
			this.main.paddingRight = this.main.paddingBottom = this.main.paddingLeft = 30;
			this.main.verticalLineScrollSize = 12;
			this.addChild(this.main);
			
			// SearchForm is a component that requests searches.
			// it has a class and a symbol in the FLA file's library
			this.searchForm = new SearchForm();
			this.searchForm.addEventListener(SearchEvent.SEARCH, searchFormSearchHandler);
			this.main.addChild(this.searchForm);
			
			var description:TextField = new TextField();
			description.defaultTextFormat = new TextFormat("Arial", 11, 0x6f9cb9);
			description.autoSize = TextFieldAutoSize.LEFT;
			description.text = "A demonstration of the layout controls from the Yahoo! ASTRA library for Flash CS3";
			this.main.addChild(description);
			
			// the TilePane control displays results
			this.results = new TilePane();
			
			// autosize the height
			this.results.height = NaN;
			
			// align results to the middle-center of the tiles
			this.results.horizontalAlign = HorizontalAlignment.CENTER;
			this.results.verticalAlign = VerticalAlignment.MIDDLE;
			
			// use a gap of 50 pixels between results
			this.results.horizontalGap = this.results.verticalGap = 30;
			this.main.addChild(this.results);
			
			// ensure that the results pane is always the full width of the main container
			this.main.configuration =
			[
				{ target: this.results, percentWidth: 100 }
			];
			
			// instantiate the FlickrService class from the open source as3flickrlib
			this.service = new FlickrService(FLICKR_KEY);
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * @private
		 * AS3 library for the Flickr API.
		 */
		protected var service:FlickrService;
		
		/**
		 * @private
		 * The main layout container for the application.
		 */
		protected var main:VBoxPane;
		
		/**
		 * @private
		 * A form for performing searches.
		 */
		protected var searchForm:SearchForm;
		
		/**
		 * @private
		 * The layout container for search results.
		 */
		protected var results:TilePane;
		
		protected var lastQuery:String;
		
	//--------------------------------------
	//  Protected Methods
	//--------------------------------------
		
		protected function search(query:String, pageNumber:int = 1):void
		{
			// for some reason, we need to remove and readd the listener
			if(this.service.hasEventListener(FlickrResultEvent.PHOTOS_SEARCH))
			{
				this.service.removeEventListener(FlickrResultEvent.PHOTOS_SEARCH, photosSearchResultHandler);
			}
			
			// clear the old results
			var resultCount:int = this.results.numChildren;
			for(var i:int = 0; i < resultCount; i++)
			{
				var resultRenderer:ImageResult = ImageResult(this.results.getChildAt(0));
				this.results.removeChild(resultRenderer);
			}
			
			this.lastQuery = query;
			
			this.service.addEventListener(FlickrResultEvent.PHOTOS_SEARCH, photosSearchResultHandler);
			this.service.photos.search("", "", "all", query, null, null, null, null, -1, "owner_name", TOTAL_RESULTS_PER_PAGE, pageNumber);
		}
		
	//--------------------------------------
	//  Protected Event Handlers
	//--------------------------------------
	
		/**
		 * @private
		 * When the browser window resizes, resize the main container to fit.
		 */
		protected function stageResizeHandler(event:Event):void
		{
			main.width = this.stage.stageWidth;
			main.height = this.stage.stageHeight;
		}
		
		/**
		 * @private
		 * When the user searches, request their query from Flickr.
		 */
		protected function searchFormSearchHandler(event:SearchEvent):void
		{
			this.search(event.query);
		}
		
		/**
		 * @private
		 * When we get results, create the renderers and add them to the results pane.
		 */
		protected function photosSearchResultHandler(event:FlickrResultEvent):void
		{
			if(!event.success)
			{
				//some sort of error happened. do nothing.
				return;
			}
			this.service.removeEventListener(FlickrResultEvent.PHOTOS_SEARCH, photosSearchResultHandler);
			
			
			
			var photos:Array = PagedPhotoList(event.data.photos).photos;
			var photoCount:int = photos.length;
			for(var i:int = 0; i < photoCount; i++)
			{
				var photo:Photo = Photo(photos[i]);
				
				var resultRenderer:ImageResult = new ImageResult();
				resultRenderer.flickrData = photo;
				this.results.addChild(resultRenderer);
			}
		}
	}
}

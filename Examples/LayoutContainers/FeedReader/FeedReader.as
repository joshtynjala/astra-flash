/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.animation.Animation;
	import com.yahoo.astra.animation.AnimationEvent;
	import com.yahoo.astra.fl.containers.BorderPane;
	import com.yahoo.astra.layout.modes.BorderConstraints;
	import com.yahoo.example.events.DragEvent;
	import com.yahoo.example.events.FeedEvent;
	import com.yahoo.example.views.FeedProgressDialog;
	import com.yahoo.example.views.FeedViewer;
	import com.yahoo.example.views.Header;
	import com.yahoo.example.views.ResizeHandle;
	
	import fl.controls.List;
	import fl.data.DataProvider;
	
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * The document class for the Feed Reader example application. Demonstrates
	 * the use of the layout containers in the Yahoo! ASTRA library for Flash CS3.
	 * 
	 * @author Josh Tynjala
	 * @see http://developer.yahoo.com/flash/astra-flash/
	 */
	public class FeedReader extends BorderPane 
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function FeedReader()
		{
			super();
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.addEventListener(Event.RESIZE, stageResizeHandler, false, 0, true);
			}
			
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			this.paddingLeft = 6;
			this.paddingRight = 6;
			this.paddingTop = 6;
			this.paddingBottom = 6;
			this.verticalGap = 8;
			this.horizontalGap = 1;
			this.setStyle("skin", "MainBackground");
			
			var feedNames:Array =
			[
				{label: "ydn-flash", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/ydn-flash/rss?count=50"},
				{label: "ydn-javascript", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/ydn-javascript/rss?count=50"},
				{label: "ydn-patterns", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/ydn-patterns/rss?count=50"},
				{label: "yws-maps", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/yws-maps/rss?count=50"},
				{label: "yws-flickr", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/yws-flickr/rss?count=50"},
				{label: "ydn-delicious", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/ydn-delicious/rss?count=50"},
				{label: "ydn-mail", icon: "YahooLogo", url: "http://rss.groups.yahoo.com/group/ydn-mail/rss?count=50"}
			];
			
			this.feedsList = new List();
			this.feedsList.width = 180
			this.feedsList.dataProvider = new DataProvider(feedNames);
			this.feedsList.labelField = "label";
			this.feedsList.iconField = "icon";
			this.feedsList.setStyle("skin", "TextArea_upSkin");
			this.feedsList.setStyle("contentPadding", 1);
			this.feedsList.setRendererStyle("textFormat", new TextFormat("Arial", 11, 0x000000));
			this.feedsList.setRendererStyle("upSkin", Shape);
			this.feedsList.setRendererStyle("downSkin", "SimpleOverSkin");
			this.feedsList.setRendererStyle("overSkin", "SimpleOverSkin");
			this.feedsList.setRendererStyle("selectedUpSkin", "SimpleSelectedSkin");
			this.feedsList.setRendererStyle("selectedDownSkin", "SimpleSelectedSkin");
			this.feedsList.setRendererStyle("selectedOverSkin", "SimpleSelectedSkin");
			this.feedsList.addEventListener(Event.CHANGE, feedSelectionChangeHandler);
			
			this.resizeHandle = new ResizeHandle();
			this.resizeHandle.direction = "horizontal";
			this.resizeHandle.addEventListener(DragEvent.DRAG_START, resizeDragStartHandler);
			this.resizeHandle.addEventListener(DragEvent.DRAG_UPDATE, resizeDragUpdateHandler);
			
			this.header = new Header();
			
			this.feedViewer = new FeedViewer();
			this.feedViewer.addEventListener(FeedEvent.FEED_LOAD_COMPLETE, feedCompleteHandler);
			this.feedViewer.addEventListener(FeedEvent.FEED_LOAD_ERROR, feedErrorHandler);
			
			this.loadingDialog = new FeedProgressDialog();
			this.loadingDialog.visible = false;
			this.loadingDialog.alpha = 0;
			
			var config:Array = 
			[
				{target: this.header, constraint: BorderConstraints.TOP},
				{target: this.feedsList, constraint: BorderConstraints.LEFT},
				{target: this.resizeHandle, constraint: BorderConstraints.LEFT},
				{target: this.feedViewer, constraint: BorderConstraints.CENTER},
				{target: this.loadingDialog, includeInLayout: false}
			];
			this.configuration = config;
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * @private
		 * The title portion of the application.
		 */
		protected var header:Header;
		
		/**
		 * @private
		 * A list of feeds that may be viewed in the application.
		 */
		protected var feedsList:List;
		
		protected var resizeHandle:ResizeHandle;
		
		protected var dragStartWidth:Number;
		
		/**
		 * @private
		 * Displays the selected feed in a datagrid with a reading pane.
		 */
		protected var feedViewer:FeedViewer;
		
		/**
		 * @private
		 * A simple animated indicator to display when a feed is loading.
		 * Includes a status message for errors or other updates.
		 */
		protected var loadingDialog:FeedProgressDialog;
		
		/**
		 * @private
		 * Stores the fade in animation for the loading status dialog
		 * so that we can wait until it finishes before fading out.
		 */
		protected var fadeInAnimation:Animation;
		
		/**
		 * @private
		 * An id for a timeout before fading out the loading status dialog.
		 */
		protected var hideTimeoutID:uint = 0;
		
	//--------------------------------------
	//  Protected Methods
	//--------------------------------------
	
		/**
		 * @private
		 * Displays the loading status dialog. To be called when a feed begins loading.
		 */
		protected function showLoadingDialog():void
		{
			this.clearAnimationQueue();
			
			//center to the stage dimensions
			this.loadingDialog.x = (this.stage.stageWidth - this.loadingDialog.width) / 2;
			this.loadingDialog.y = (this.stage.stageHeight - this.loadingDialog.height) / 2;
			
			//clear the status
			this.loadingDialog.status = "";
			
			//fade in
			this.loadingDialog.alpha = 0;
			this.loadingDialog.visible = true;
			this.fadeInAnimation = Animation.create(this.loadingDialog, 150, {alpha: 1}, true, true);
		}
		
		/**
		 * @private
		 * Hides the loading status dialog. To be called when a feed has finished loading.
		 */
		protected function hideLoadingDialog():void
		{
			this.clearAnimationQueue();
			
			//if we're still fading in, wait a bit before fading out (better user experience)
			if(this.fadeInAnimation && this.fadeInAnimation.active)
			{
				this.hideTimeoutID = setTimeout(hideLoadingDialog, 500);
				return;
			}
			
			//fade out
			var fadeOutAnimation:Animation = Animation.create(this.loadingDialog, 150, {alpha: 0}, true, true);
			fadeOutAnimation.addEventListener(AnimationEvent.COMPLETE, fadeOutAnimationCompleteHandler, false, 0, true);
		}
		
		/**
		 * @private
		 * Ensures that the show and hide animations don't conflict with each other.
		 */
		protected function clearAnimationQueue():void
		{
			if(this.hideTimeoutID != 0)
			{	
				clearTimeout(this.hideTimeoutID);
				this.hideTimeoutID = 0;
			}
		}
		
	//--------------------------------------
	//  Protected Event Handlers
	//--------------------------------------
	
		/**
		 * @private
		 * When the stage resizes, resize the applicationand reposition
		 * the loading status dialog.
		 */
		protected function stageResizeHandler(event:Event):void
		{
			//resize the application to match the stage dimensions (liquid)
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			this.drawNow();
			
			//reposition the loading status dialog
			this.loadingDialog.x = (this.stage.stageWidth - this.loadingDialog.width) / 2;
			this.loadingDialog.y = (this.stage.stageHeight - this.loadingDialog.height) / 2;
		}
		
		/**
		 * @private
		 * When a new feed is selected, pass the URL to the feed viewer.
		 */
		protected function feedSelectionChangeHandler(event:Event):void
		{
			var feedURL:String = this.feedsList.selectedItem.url;
			this.feedViewer.loadFeed(feedURL);
			
			//show the loading status dialog while the feed is loading
			this.showLoadingDialog();
		}
		
		/**
		 * @private
		 * React when the feed viewer finishes loading the feed.
		 */
		protected function feedCompleteHandler(event:FeedEvent):void
		{
			//hide after a slight delay so that instantaneous loads don't just show a flicker.
			this.hideTimeoutID = setTimeout(hideLoadingDialog, 500);
		}
		
		/**
		 * @private
		 * React when the feed viewer fails to load the feed.
		 */
		protected function feedErrorHandler(event:FeedEvent):void
		{
			//set a status message that tells the user that something failed.
			this.loadingDialog.status = "An error occurred. Please try again later.";
			
			//give the user a few seconds to read the message
			this.hideTimeoutID = setTimeout(hideLoadingDialog, 3000);
		}
		
		/**
		 * @private
		 * Hide the loading status dialog when it finishes fading out.
		 * We need to do this because the fonts aren't embedded
		 */
		protected function fadeOutAnimationCompleteHandler(event:AnimationEvent):void
		{
			Animation(event.currentTarget).removeEventListener(AnimationEvent.COMPLETE, fadeOutAnimationCompleteHandler);
			this.loadingDialog.visible = false;
			this.loadingDialog.status = null;
		}
		
		protected function resizeDragStartHandler(event:DragEvent):void
		{
			this.dragStartWidth = this.feedsList.width;
		}
		
		protected function resizeDragUpdateHandler(event:DragEvent):void
		{
			this.feedsList.width = Math.min(2 * this.width / 3, Math.max(0, this.dragStartWidth + event.delta));
		}
	}
}

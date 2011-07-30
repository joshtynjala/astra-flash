/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.controls.Carousel;
	import com.yahoo.astra.fl.controls.carouselClasses.SlidingCarouselRenderer;
	
	import fl.controls.Button;
	import fl.data.DataProvider;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * This example creates a Carousel where items are displayed two at a time
	 * in a set of three pages. Navigation in the Carousel is controlled by
	 * two buttons that go to the next or previous page respectively.
	 * 
	 * @author Josh Tynjala
	 */
	public class PagedCarousel extends MovieClip
	{
		/**
		 * Constructor.
		 */
		public function PagedCarousel()
		{
			super();
			
			//this is where the images for this example are loaded from
			//we're borrowing some images that the YUI library uses for their examples
			const BASE_URL:String = "http://developer.yahoo.com/yui/docs/assets/examples/exampleimages/small/"
			
			//we're hard coding the data here.
			//it could easy be loaded as XML, JSON, or any other format
			var carouselData:Array =
			[
				{title: "Ayers Rock", url: "http://en.wikipedia.org/wiki/Uluru", description: "A large standstone rock formation in central Australia that is also known as Uluru to the Aboriginal people.", imageURL: BASE_URL + "uluru.jpg"},
				{title: "Kata Tjuta", url: "http://en.wikipedia.org/wiki/Kata_Tjuta", description: "Kata Tjuta, referred to locally as The Olgas, are domed rock formations in the southern part of central Australia.",  imageURL: BASE_URL + "katatjuta.jpg"},
				{title: "Moraine", url: "http://en.wikipedia.org/wiki/Moraine", description: "A Moraine is a geological formation created by glacially accumulated debris in a past ice age.", imageURL: BASE_URL + "morraine.jpg"},
			 	{title: "Japan", url: "http://en.wikipedia.org/wiki/Japan", description: "Japan is a nation located in East Asia that consists of over 3000 islands in the Pacific Ocean. Its name means \"sun-origin\".", imageURL: BASE_URL + "japan.jpg"},
			 	{title: "Shadow", url: "http://en.wikipedia.org/wiki/Shadow", description: "Obviously, the Sun and Moon can cast shadows on Earth, but under certain conditions, Venus can cast shadows too!", imageURL: BASE_URL + "museum.jpg"},
				{title: "YUI", url: "http://developer.yahoo.com/yui/", description: "The Yahoo! User Interface library is an open source set of utilities and UI controls for JavaScript.", imageURL: BASE_URL + "yui.jpg"}
			];
			
			this.initializeButtons();
			this.initializeCarousel(carouselData);
		}
		
		/**
		 * @private
		 * Skin the buttons and listen for their click events.
		 */
		private function initializeButtons():void
		{
			this.prevButton.setStyle("upSkin", "NavButtonUpSkin");
			this.prevButton.setStyle("overSkin", "NavButtonUpSkin");
			this.prevButton.setStyle("downSkin", "NavButtonDownSkin");
			this.prevButton.setStyle("disabledSkin", "NavButtonDisabledSkin");
			this.prevButton.setStyle("icon", "BackIcon");
			this.prevButton.setStyle("disabledIcon", "BackDisabledIcon");
			this.prevButton.addEventListener(MouseEvent.CLICK, prevButtonClickHandler);
			
			this.nextButton.setStyle("upSkin", "NavButtonUpSkin");
			this.nextButton.setStyle("overSkin", "NavButtonUpSkin");
			this.nextButton.setStyle("downSkin", "NavButtonDownSkin");
			this.nextButton.setStyle("disabledSkin", "NavButtonDisabledSkin");
			this.nextButton.setStyle("icon", "NextIcon");
			this.nextButton.setStyle("disabledIcon", "NextDisabledIcon");
			this.nextButton.addEventListener(MouseEvent.CLICK, nextButtonClickHandler);	
		}
		
		/**
		 * @private
		 * Set up the skin and some properties on the carousel.
		 */
		private function initializeCarousel(data:Array):void
		{
			//pass the data into the Carousel with a DataProvider (just like List)
			this.carousel.dataProvider = new DataProvider(data);
			
			//the fields from which to extract label text and the image source
			this.carousel.labelField = "title";
			this.carousel.sourceField = "imageURL";
			
			//ItemNode is a symbol in the library
			this.carousel.setStyle("cellRenderer", "ItemNode");
			
			//hide the background
			this.carousel.setStyle("skin", Shape);
			
			//we're customizing the renderer that handles carousel
			//layout. the standard renderer is a SlidingCarouselRenderer,
			//but we're changing a few properties to fit our needs
			var layout:SlidingCarouselRenderer = new SlidingCarouselRenderer();
			
			//align the selected item to the left
			layout.horizontalAlign = "left";
			
			//put a ten pixel gap between items
			layout.horizontalGap = 10;
			
			//always display two items. the carousel will resize to fit.
			layout.displayedItemCount = 2;
			
			//we don't want to select items by clicking them.
			//that's the default behavior. we'll control selection
			//with other controls
			layout.clickToSelect = false;
			
			this.carousel.layoutRenderer = layout;
			
			this.carousel.addEventListener(Event.CHANGE, carouselChangeHandler);
		}
		
		/**
		 * @private
		 * If we can't go back, disable the previous button. If we can't go forward,
		 * disable the next button.
		 */
		private function updateButtonEnabledState():void
		{
			this.prevButton.enabled = this.carousel.selectedIndex > 0;
			this.nextButton.enabled = this.carousel.selectedIndex < this.carousel.length - 2;
		}
		
		/**
		 * @private
		 * When the previous button is clicked, go back two items because
		 * that's how many items we're displaying per page. Don't go past
		 * the beginning.
		 */
		private function prevButtonClickHandler(event:MouseEvent):void
		{
			var prev:int = this.carousel.selectedIndex - 2;
			this.carousel.selectedIndex = Math.max(prev, 0);
			this.updateButtonEnabledState();
		}
		
		/**
		 * @private
		 * When the next button is clicked, go forward two items because that's
		 * how many items we're displaying per page. Don't go past the end.
		 */
		private function nextButtonClickHandler(event:MouseEvent):void
		{
			var next:int = this.carousel.selectedIndex + 2;
			this.carousel.selectedIndex = Math.min(next, this.carousel.length - 2);
			this.updateButtonEnabledState();
		}
		
		/**
		 * @private
		 * Any time the carousel selection changes, update the enabled state
		 * of the navigation buttons.
		 */
		private function carouselChangeHandler(event:Event):void
		{
			this.updateButtonEnabledState();
		}
	}
}
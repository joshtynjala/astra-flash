/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.controls.carouselClasses.StackCarouselRenderer;
	
	import fl.data.DataProvider;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	/**
	 * An example to demonstrate the StackCarouselRenderer layout
	 * renderer for the Carousel control.
	 * 
	 * @author Josh Tynjala
	 */
	public class StackCarousel extends MovieClip
	{
		/**
		 * Constructor.
		 */
		public function StackCarousel()
		{
			super();
			
			//this is the location of the images we're using. we're borrowing them
			//from some YUI examples.
			const BASE_URL:String = "http://developer.yahoo.com/yui/docs/assets/examples/exampleimages/medium/"
			var carouselData:Array =
			[
				{title: "Ayers Rock", imageURL: BASE_URL + "uluru.jpg"},
				{title: "Kata Tjuta", imageURL: BASE_URL + "katatjuta.jpg"},
				{title: "Moraine", imageURL: BASE_URL + "morraine.jpg"},
			 	{title: "Museum", imageURL: BASE_URL + "museum.jpg"},
				{title: "Japan", imageURL: BASE_URL + "japan.jpg"},
				{title: "YUI", imageURL: BASE_URL + "yui.jpg"}
			];
			
			this.initializeNavigation(carouselData);
			this.initializeCarousel(carouselData);
		}
		
		/**
		 * @private
		 * Pass the data to the carousel and skin it. Set the layout renderer.
		 */
		private function initializeCarousel(data:Array):void
		{
			//standard data code. Similar to how List is initialized
			//with data.
			this.carousel.dataProvider = new DataProvider(data);
			//the field to use for the label text
			this.carousel.labelField = "title";
			//the field to use for the image source
			this.carousel.sourceField = "imageURL";
			
			//hide the background by using a transparent Shape
			this.carousel.setStyle("skin", Shape);
			//no padding needed
			this.carousel.setStyle("contentPadding", 0);
			//a custom cell renderer is created from a symbol in the library
			this.carousel.setStyle("cellRenderer", "CustomCarouselRenderer");
			
			//the stack carousel renderer displays one item at a time
			//and fades items in and out when the selection changes
			var stackLayout:StackCarouselRenderer = new StackCarouselRenderer();
			
			//since we're only showing a few items, we want the layout renderer
			//to create all cell renderers when it draws so that the animation
			//appears smoothly and there are no delays loading images
			stackLayout.drawAllRenderers = true;
			
			this.carousel.layoutRenderer = stackLayout;
		}
		
		/**
		 * @private
		 * Pass the data to the navigation list, listen for changes and customize
		 * some properties. Listen for click events from the arrow buttons on stage.
		 */
		private function initializeNavigation(data:Array):void
		{
			this.navigation.dataProvider = new DataProvider(data);
			this.navigation.labelField = "title";
			
			this.navigation.addEventListener(Event.CHANGE, navigationChangeHandler);
			
			//automatically select the first item to match the Carousel
			this.navigation.selectedIndex = 0;
			
			//rows are 40 pixels high, just like the cell renderer we're using
			this.navigation.rowHeight = 40;
			
			//we always want to display all items, so set the row count
			//and the list will automatically resize to fit
			this.navigation.rowCount = this.navigation.dataProvider.length;
			
			//set a transparent background by using Shape
			this.navigation.setStyle("skin", Shape);
			
			//pass in the custom cell renderer type. it's in the library
			this.navigation.setStyle("cellRenderer", "CustomListRenderer");
			
			//add a simple drop shadow to make it look better. :)
			this.navigation.filters = [new DropShadowFilter(1, 60)];
			
			//listen for when the buttons are clicked
			//and then update the list.
			this.prevButton.addEventListener(MouseEvent.CLICK, prevButtonClickHandler);
			this.nextButton.addEventListener(MouseEvent.CLICK, nextButtonClickHandler);
		}
		
		/**
		 * @private
		 * When the navigation list changes, update the Carousel too.
		 */
		private function navigationChangeHandler(event:Event):void
		{
			this.carousel.selectedIndex = this.navigation.selectedIndex;
		}
		
		/**
		 * @private
		 * When the previous (up) button is clicked, update the selected index
		 * of the Carousel and the List.
		 */
		private function prevButtonClickHandler(event:MouseEvent):void
		{
			var index:int = this.carousel.selectedIndex - 1;
			if(index < 0)
			{
				index = this.carousel.length - 1;
			}
			this.navigation.selectedIndex = this.carousel.selectedIndex = index;
		}
		
		/**
		 * @private
		 * When the next (down) button is clicked, update the selected index
		 * of the Carousel and the List.
		 */
		private function nextButtonClickHandler(event:MouseEvent):void
		{
			var index:int = this.carousel.selectedIndex + 1;
			if(index >= this.carousel.length)
			{
				index = 0;
			}
			this.navigation.selectedIndex = this.carousel.selectedIndex = index;
		}
	}
}

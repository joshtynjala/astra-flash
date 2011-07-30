/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.charts.LineChart;
	import com.yahoo.astra.fl.charts.axes.NumericAxis;
	import com.yahoo.astra.fl.charts.axes.TimeAxis;
	import com.yahoo.astra.fl.charts.legend.Legend;
	import com.yahoo.astra.fl.charts.series.LineSeries;
	import com.yahoo.astra.utils.DateUtil;
	import com.yahoo.astra.utils.TimeUnit;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	
	/**
	 * Document class for MultiSeriesLineChart example. This example
	 * demonstrates how to load an XML data file and display that
	 * data in a LineChart using two series.
	 * 
	 * @author Josh Tynjala
	 */
	public class FinancialTimeline extends Sprite
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function FinancialTimeline()
		{
			super();
			
			//initialize the components
			this.initializeChart();
			this.initializeLegend();
			
			this.loadXMLData();
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * @private
		 * The chart that will display the loaded data.
		 */
		protected var chart:LineChart;
		
		/**
		 * @private
		 * The chart's legend.
		 */
		protected var legend:Legend;
		
		/**
		 * @private
		 * Used to load the XML data.
		 */
		protected var xmlLoader:URLLoader;

	//--------------------------------------
	//  Private Methods
	//--------------------------------------
	
		/**
		 * @private
		 * Creates the chart and initializes it.
		 */
		private function initializeChart():void
		{
			//create the LineChart
			this.chart = new LineChart();
			
			//the attribute from the XML data provider to use with the horizontal axis
			this.chart.horizontalField = "@date";
			
			//set the size and position of the chart
			this.chart.setSize(460, 280);
			this.chart.move(10, 30);
			
			//let each individual series determine its own color
			this.chart.setStyle("seriesColors", []);
			
			//set some styles for the horizontal axis through the chart
			this.chart.setStyle("showHorizontalAxisTicks", true);
			this.chart.setStyle("showHorizontalAxisMinorTicks", true);
			this.chart.setStyle("horizontalAxisTickLength", 4);
			this.chart.setStyle("horizontalAxisMinorTickLength", 3);
			
			//the horizontal axis will be a TimeAxis
			var xAxis:TimeAxis = new TimeAxis();
			
			//let's make the axis a little more clear by showing only every other month
			xAxis.majorTimeUnit = TimeUnit.MONTH;
			xAxis.majorUnit = 2;
			
			//format the date strings
			xAxis.labelFunction = function(value:Date, timeUnit:String):String
			{
				return DateUtil.getShortMonthName(value.month) + " " + value.getFullYear().toString().substr(2);
			}
			
			//pass the axis to the chart
			this.chart.horizontalAxis = xAxis;
			
			//we're going to give the chart a custom vertical axis
			var yAxis:NumericAxis = new NumericAxis();
			
			//set the minimum value displayed by the axis
			yAxis.minimum = 11000;
			yAxis.maximum = 14000;
			
			//format the labels of the vertical axis with a custom label function
			yAxis.labelFunction = numberToCurrency;
			
			//pass it to the chart
			this.chart.verticalAxis = yAxis;
			
			//add the chart to the display list
			this.addChild(this.chart);
		}
	
		/**
		 * @private
		 * Creates the legend and initializes it.
		 */
		private function initializeLegend():void
		{
			//create a legend for the chart and position it
			this.legend = new Legend();
			this.legend.move(160, 315);
			
			//we want the legend items to appear in a horizontal row
			this.legend.setStyle("direction", "horizontal");
			
			//give it a custom font style
			this.legend.setStyle("textFormat", new TextFormat("Arial", 12, 0x000000, true));
			
			//set the amount of spacing between legend items and clear the padding
			this.legend.setStyle("gap", 12);
			this.legend.setStyle("contentPadding", 0);
			
			//add the legend to the display list and pass it to the chart
			//the chart passes all the data to the legend automatically
			this.addChild(this.legend);
			this.chart.legend = this.legend;
		}
	
		/**
		 * @private
		 * Initializes the URLLoader and requests the file data.xml
		 */
		private function loadXMLData():void
		{
			var request:URLRequest = new URLRequest("data.xml");
			
			this.xmlLoader = new URLLoader();
			
			//listen for the complete event, and make sure errors are caught
			this.xmlLoader.addEventListener(Event.COMPLETE, xmlLoadCompleteHandler);
			this.xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadErrorHandler);
			
			this.xmlLoader.load(request);
		}
		
		/**
		 * @private
		 * When the XML has finished loading, the data is passed into new series
		 * objects and given to the chart.
		 */
		private function xmlLoadCompleteHandler(event:Event):void
		{
			//data comes in as a String. create a new XML object.
			var data:XML = new XML(this.xmlLoader.data);
			
			//get the month elements from the XML object
			var monthData:XMLList = data.month;
			
			//the first series will display the "revenue" attribute
			//from the XML file.
			var series1:LineSeries = new LineSeries();
			
			//the series display name will be used in the rollover data tip and the legend
			series1.displayName = "Revenue";
			
			//use the monthData XMLList and set the vertical axis field
			series1.dataProvider = monthData.copy();
			series1.verticalField = "@revenue";
			
			//give the series a custom base color
			series1.setStyle("color", 0x54ca22);
			
			//the second series will display the "expenses" attribute
			//from the XML file.
			var series2:LineSeries = new LineSeries();
			series2.displayName = "Expenses";
			series2.dataProvider = monthData.copy();
			series2.verticalField = "@expenses";
			series2.setStyle("color", 0xc82d24);
			
			this.chart.dataProvider = [series1, series2];
		}
		
		/**
		 * @private
		 * In a complete application, you would probably display an error
		 * so that the user understands that something went wrong.
		 */
		private function xmlLoadErrorHandler(event:IOErrorEvent):void
		{
			trace("Unable to load data!");
		}
		
		/**
		 * @private
		 * Formats a numeric value to the form $#,####,###
		 */
		private function numberToCurrency(value:Number):String
		{
			var valueAsString:String = value.toString();
			
			//check if negative, and remove the sign if present
			var negative:Boolean = valueAsString.indexOf("-") == 0;
			if(negative)
			{
				valueAsString = valueAsString.substr(1);
			}

			// add 1000s seperators
			var length:int = valueAsString.length;
			for( var i:int = length - 3; i > 0; i -= 3 )
			{
				valueAsString = valueAsString.substr(0, i) + "," + valueAsString.substr(i);
			}
			
			//readd the negative sign, if needed
			if(negative)
			{
				valueAsString = "-" + valueAsString;
			}
			
			//add the dollar sign
			return "$" + valueAsString;
		}
	}
}
/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package
{
	import com.yahoo.astra.fl.charts.BarChart;
	import com.yahoo.astra.fl.charts.axes.NumericAxis;
	import com.yahoo.astra.fl.charts.legend.Legend;
	import com.yahoo.astra.fl.charts.series.StackedBarSeries;
	import com.yahoo.astra.fl.charts.series.LineSeries;
	
	import flash.display.Sprite;

	public class CombinationChart extends Sprite
	{
		public function CombinationChart()
		{
			super();
			
			var actualProducts:StackedBarSeries = new StackedBarSeries();
			actualProducts.displayName = "Actual Products";
			actualProducts.dataProvider = [202, 237, 282, 345, 304];
			
			var actualServices:StackedBarSeries = new StackedBarSeries();
			actualServices.displayName = "Actual Services";
			actualServices.dataProvider = [447, 359, 393, 421, 416];
			
			var idealTotal:LineSeries = new LineSeries();
			idealTotal.displayName = "Ideal Total";
			idealTotal.dataProvider = [525, 550, 600, 650, 750];
			
			this.chart.dataProvider = [actualProducts, actualServices, idealTotal];
			this.chart.categoryNames = ["Q107", "Q207", "Q307", "Q407", "Q108"];
			
			this.legend.setStyle("direction", "horizontal");
			this.chart.legend = this.legend;
		}
		
		public var chart:BarChart;
		public var legend:Legend;
	}
}

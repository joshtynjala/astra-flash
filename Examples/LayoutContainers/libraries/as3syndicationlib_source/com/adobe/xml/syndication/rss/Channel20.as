/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿/*
	Adobe Systems Incorporated(r) Source Code License Agreement
	Copyright(c) 2005 Adobe Systems Incorporated. All rights reserved.
	
	Please read this Source Code License Agreement carefully before using
	the source code.
	
	Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive, 
	no-charge, royalty-free, irrevocable copyright license, to reproduce,
	prepare derivative works of, publicly display, publicly perform, and
	distribute this source code and such derivative works in source or 
	object code form without any attribution requirements.  
	
	The name "Adobe Systems Incorporated" must not be used to endorse or promote products
	derived from the source code without prior written permission.
	
	You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
	against any loss, damage, claims or lawsuits, including attorney's 
	fees that arise or result from your use or distribution of the source 
	code.
	
	THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT 
	ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
	BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
	FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  ALSO, THERE IS NO WARRANTY OF 
	NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT.  IN NO EVENT SHALL MACROMEDIA
	OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
	EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
	PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
	OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
	OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
	ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.xml.syndication.rss
{
	import com.adobe.utils.DateUtil;
	import com.adobe.xml.syndication.NewsFeedElement;
	import com.adobe.xml.syndication.ParsingTools;
	import com.adobe.utils.StringUtil;

	/**
	 * Class that represents an RSS 2.0 Channel element.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 8.5
	 * @tiptext
	 * 
	 * @see http://blogs.law.harvard.edu/tech/rss#requiredChannelElements
	 * @see http://blogs.law.harvard.edu/tech/rss#optionalChannelElements
	 */	
	public class Channel20
		extends NewsFeedElement
			implements IChannel
	{

		/**
		 * Create a new Channel20 instance.
		 * 
		 * @param x The XML with which to construct the channel.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function Channel20(x:XMLList)
		{
			super(x);
		}

		/**
		 * The name of the channel. It's how people refer to your service.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get title():String
		{
			return ParsingTools.nullCheck(this.x.title);
		}

		/**
		 * The URL to the HTML website corresponding to the channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get link():String
		{
			return ParsingTools.nullCheck(this.x.link);
		}

		/**
		 * Phrase or sentence describing the channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get description():String
		{
			return ParsingTools.nullCheck(this.x.description);
		}

		/**
		 * The language the channel is written in.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/stories/storyReader$15
		 * @see http://www.w3.org/TR/REC-html40/struct/dirlang.html#langcodes
		 */
		public function get language():String
		{
			return ParsingTools.nullCheck(this.x.language);
		}

		/**
		 * Copyright notice for content in the channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get copyright():String
		{
			return ParsingTools.nullCheck(this.x.copyright);
		}

		/**
		 * Email address for person responsible for editorial content.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get managingEditor():String
		{
			return ParsingTools.nullCheck(this.x.managingEditor);
		}

		/**
		 * Email address for person responsible for technical issues relating to channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get webMaster():String
		{
			return ParsingTools.nullCheck(this.x.webMaster);
		}

		/**
		 * The PICS rating for the channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://www.w3.org/PICS/
		 */
		public function get rating():String
		{
			return ParsingTools.nullCheck(this.x.rating);
		}

		/**
		 * The publication date for the content in the channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get pubDate():Date
		{
			return ParsingTools.dateCheck(this.x.pubDate, DateUtil.parseRFC822);
		}

		/**
		 * The last time the content of the channel changed.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get lastBuildDate():Date
		{
			return ParsingTools.dateCheck(this.x.lastBuildDate,
										  DateUtil.parseRFC822);
		}

		/**
		 * A URL that points to the documentation for the format used in the
		 * RSS file.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get docs():String
		{
			return ParsingTools.nullCheck(this.x.docs);
		}

		/**
		 * A hint for aggregators telling them which days they can skip.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/skipHoursDays#skipdays
		 */
		public function get skipDays():Array
		{
			if (ParsingTools.nullCheck(this.x.skipDays) == null)
			{
				return null;
			}
			var days:Array = new Array();
			var d:XML;
			for each (d in this.x.skipDays.day)
			{
				days.push(String(d));
			}
			return days;
		}

		/**
		 * A hint for aggregators telling them which hours they can skip.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/skipHoursDays#skipdays
		 */
		public function get skipHours():Array
		{
			if (ParsingTools.nullCheck(this.x.skipHours) == null)
			{
				return null;
			}
			var hours:Array = new Array();
			var h:XML;
			for each (h in this.x.skipHours.hour)
			{
				hours.push(String(h));
			}
			return hours;
		}

		/**
		 * Specify one or more categories that the channel belongs to.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#syndic8
		 */
		public function get categories():Array
		{
			return ParsingTools.xmlToCategories(this.x.category);
		}

		/**
		 * A string indicating the program used to generate the channel.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get generator():String
		{
			return ParsingTools.nullCheck(this.x.generator);
		}

		/**
		 * ttl stands for time to live. It's a number of minutes that
		 * indicates how long a channel can be cached before refreshing
		 * from the source.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltttlgtSubelementOfLtchannelgt
		 */
		public function get ttl():String
		{
			return ParsingTools.nullCheck(this.x.ttl);
		}

		/**
		 * Allows processes to register with a cloud to be notified of updates
		 * to the channel, implementing a lightweight publish-subscribe
		 * protocol for RSS feeds.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltcloudgtSubelementOfLtchannelgt
		 */
		public function get cloud():Cloud
		{
			if (ParsingTools.nullCheck(this.x.cloud.@protocol) == null)
			{
				return null;
			}
			var c:Cloud = new Cloud();
			c.domain = String(this.x.cloud.@domain);
			c.path = String(this.x.cloud.@path);
			c.port = uint(this.x.cloud.@port);
			c.protocol = String(this.x.cloud.@protocol);
			c.registerProcedure = String(this.x.cloud.@registerProcedure);
			return c;
		}
	}
}
/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
/*
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
	import com.adobe.xml.syndication.Namespaces;
	import com.adobe.xml.syndication.NewsFeedElement;
	import com.adobe.xml.syndication.ParsingTools;

	/**
	 * Class that represents an RSS 2.0 item.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 8.5
	 * @tiptext
	 * 
	 * @see http://blogs.law.harvard.edu/tech/rss#hrelementsOfLtitemgt
	 */	
	public class Item20
		extends NewsFeedElement
			implements IItem
	{

		private var dc:Namespace = Namespaces.DC_NS;

		/**
		 * Create a new Item20 instance.
		 * 
		 * @param x The XML with which to construct the item.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function Item20(x:XMLList)
		{
			super(x);
		}

		/**
		 * The title of the item.
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
		 * The URL of the item.
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
		 * The item synopsis.
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
		 * The name and, optionally, email address of the creator of the feed.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function get creator():String
		{
			return ParsingTools.nullCheck(this.x.dc::creator);
		}

		/**
		 * URL of a page for comments relating to the item.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltcommentsgtSubelementOfLtitemgt
		 */
		public function get comments():String
		{
			return ParsingTools.nullCheck(this.x["comments"]);
		}

		/**
		 * Email address of the author of the item.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltauthorgtSubelementOfLtitemgt
		 */
		public function get author():String
		{
			return ParsingTools.nullCheck(this.x.author);
		}

		/**
		 * Indicates when the item was published.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltpubdategtSubelementOfLtitemgt
		 */
		public function get pubDate():Date
		{
			return ParsingTools.dateCheck(this.x.pubDate, DateUtil.parseRFC822);
		}

		/**
		 * Includes the item in one or more categories.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltcategorygtSubelementOfLtitemgt
		 */
		public function get categories():Array
		{
			return ParsingTools.xmlToCategories(this.x.category);
		}

		/**
		 * The RSS channel that the item came from.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltsourcegtSubelementOfLtitemgt
		 */
		public function get source():Source
		{
			if (ParsingTools.nullCheck(this.x.source) == null)
			{
				return null;
			}
			var source:Source = new Source();
			source.url = String(this.x.source.@url);
			source.name = String(this.x.source);
			return source;
		}

		/**
		 * Describes a media object that is attached to the item.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltenclosuregtSubelementOfLtitemgt
		 */
		public function get enclosure():Enclosure
		{
			if (ParsingTools.nullCheck(this.x.enclosure.@url) == null)
			{
				return null;
			}
			var enclosure:Enclosure = new Enclosure();
			enclosure.url = String(this.x.enclosure.@url);
			enclosure.length = uint(this.x.enclosure.@length);
			enclosure.type = String(this.x.enclosure.@type);
			return enclosure;
		}

		/**
		 * A string that uniquely identifies the item.
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 *
		 * @see http://blogs.law.harvard.edu/tech/rss#ltguidgtSubelementOfLtitemgt
		 */
		public function get guid():Guid
		{
			if (ParsingTools.nullCheck(this.x.guid) == null)
			{
				return null;
			}
			var guid:Guid = new Guid();
			if (ParsingTools.nullCheck(this.x.guid.@isPermaLink) != null)
			{
				guid.permaLink = Boolean(this.x.guid.@isPermaLink);
			}
			guid.id = String(this.x.guid);
			return guid;
		}
	}
}
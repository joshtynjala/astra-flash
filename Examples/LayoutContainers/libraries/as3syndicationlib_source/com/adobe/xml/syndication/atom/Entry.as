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

package com.adobe.xml.syndication.atom
{
	import com.adobe.xml.syndication.Namespaces;
	import com.adobe.xml.syndication.NewsFeedElement;
	import com.adobe.utils.DateUtil;
	import com.adobe.xml.syndication.ParsingTools;


	/**
	*	Class that represents an Entry element within an Atom feed
	* 
	* 	@langversion ActionScript 3.0
	*	@playerversion Flash 8.5
	*	@tiptext
	* 
	* 	@see http://www.atomenabled.org/developers/syndication/atom-format-spec.php#rfc.section.4.1.2
	*/
	public class Entry extends NewsFeedElement
	{
		private var atom:Namespace = Namespaces.ATOM_NS;
		private var xhtml:Namespace = Namespaces.XHTML_NS;

		/**
		*	Constructor for class.
		* 
		*	@param x An XML document that contains an individual Entry element from 
		*	an Aton XML feed.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function Entry(x:XMLList)
		{
			super(x);
		}

		/**
		*	A String that contains the title for the entry.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get title():String
		{
			return ParsingTools.nullCheck(this.x.atom::title);
		}

		/**
		*	An array containing one or more link objects relating to this entry.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get links():Array
		{	
			var links:Array = new Array();
			var i:XML;
			for each (i in this.x.atom::link)
			{
				var link:Link = new Link();
				link.rel = ParsingTools.nullCheck(i.@rel);
				link.type = ParsingTools.nullCheck(i.@type);
				link.hreflang = ParsingTools.nullCheck(i.@hreflang);
				link.href = ParsingTools.nullCheck(i.@href);
				link.title = ParsingTools.nullCheck(i.@title);
				link.length = ParsingTools.nanCheck(i.@["length"]);
				links.push(link);
			}
			return links;
		}

		/**
		*	A String that uniquely identifies the Entry.
		*
		*	This property conveys a permanent, universally unique identifier for
		*	an entry or feed.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get id():String
		{
			return ParsingTools.nullCheck(this.x.atom::id);
		}

		/**
		*	A Date that represents when the entry was last updated.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get updated():Date
		{
			return ParsingTools.dateCheck(this.x.atom::updated, DateUtil.parseW3CDTF);
		}

		/**
		*	A Date that represents when the entry was originally published.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get published():Date
		{
			return ParsingTools.dateCheck(this.x.atom::published, DateUtil.parseW3CDTF);
		}

		/**
		*	An Array of Author objects that represent the authors for the entry.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get authors():Array
		{
			var authors:Array = new Array();
			var i:XML;
			for each (i in this.x.atom::author)
			{
				var author:Author = new Author();
				author.name = ParsingTools.nullCheck(i.atom::["name"]);
				author.email = ParsingTools.nullCheck(i.atom::email);
				author.uri = ParsingTools.nullCheck(i.atom::uri);
				authors.push(author);
			}
			return authors;
		}

		/**
		*	An Array of Author objects that represent the contributors for the entry.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get contributors():Array
		{
			var contributors:Array = new Array();
			var i:XML;
			for each (i in this.x.atom::contributor)
			{
				var contributor:Contributor = new Contributor();
				contributor.name = ParsingTools.nullCheck(i.atom::["name"]);
				contributor.email = ParsingTools.nullCheck(i.atom::email);
				contributor.uri = ParsingTools.nullCheck(i.atom::uri);
				contributors.push(contributor);
			}
			return contributors;
		}

		/**
		*	A Content object that contains the content of the entry.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get content():Content
		{
			var content:Content = new Content();
			content.type = ParsingTools.nullCheck(this.x.atom::content.@type);
			content.src = ParsingTools.nullCheck(this.x.atom::content.@src);
			if (content.type == "xhtml")
			{
				content.value = ParsingTools.nullCheck(this.x.atom::content.xhtml::div);				
			}
			else
			{
				content.value = ParsingTools.nullCheck(this.x.atom::content);
			}
			return content;
		}

		/**
		*	An Array of Category objecst that represent the categories that the
		*	feed is associated with.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*/	
		public function get categories():Array
		{
			var categories:Array = new Array();
			var i:XML;
			for each (i in this.x.atom::category)
			{
				var category:Category = new Category();
				category.term = ParsingTools.nullCheck(i.@term);
				category.scheme = ParsingTools.nullCheck(i.@scheme);
				category.label = ParsingTools.nullCheck(i.@label);
				categories.push(category);
			}
			return categories;
		}

		/**
		*	A FeedData object that represents the source element of an Atom
		*	entry
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 8.5
		*	@tiptext
		*
		*	@see http://www.atomenabled.org/developers/syndication/atom-format-spec.php#atomContent
		*/	
		public function get source():FeedData
		{
			return new FeedData(XMLList(this.x.atom::source));
		}
	}
}
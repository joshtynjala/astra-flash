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

package com.adobe.xml.syndication
{
	import com.adobe.utils.StringUtil;
	import com.adobe.xml.syndication.rss.Category;

	/**
	 * Utility class with functions to help parse RSS and Atom feeds.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 8.5
	 * @tiptext
	 */	
	public class ParsingTools
	{
		/**
		 * Checks to see if a piece of XML that should be a string is empty.
		 * If so, returns null.
		 * 
		 * @param x The piece of XML to test.
		 * @return null if the string is emply, otherwise the value of the XML
		 *         node.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function nullCheck(x:XMLList):String
		{
			var s:String = String(x);
			if (StringUtil.trim(s).length == 0)
			{
				return null;
			}
			return s;
		}

		/**
		 * Checks to see if a piece of XML that should be a number is empty.
		 * If so, returns NaN.
		 * 
		 * @param x The piece of XML to test.
		 * @return null if the number is emply, otherwise the value of the XML
		 *         node.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function nanCheck(x:XMLList):Number
		{
			var s:String = String(x);
			if (ParsingTools.nullCheck(x) == null || s.search(/\d/) == -1)
			{
				return NaN;
			}
			return Number(s);
		}

		/**
		 * Checks to see if a piece of XML that should be a date is empty.
		 * If so, returns null. If not, parses the string into a date using
		 * the specifid date parsing function.
		 * 
		 * @param x The piece of XML to test.
		 * @param f The date parsing function to use to parse the string if
		 *          it's not null.
		 * @return null if the date is emply, otherwise a date object created
		 *         using the specified date-parsing function.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function dateCheck(x:XMLList, f:Function):Date
		{
			var s:String = String(x);
			if (ParsingTools.nullCheck(x) == null)
			{
				return null;
			}
			return f(s);
		}

		/**
		 * Checks to see if a piece of XML that should be a string represents
		 * categories. If it's empty, return null. If not, parse the string
		 * into an array of category objects.
		 * 
		 * @param x The piece of XML to test.
		 * @return null if the string is empty, otherwise an array of Category
		 *         objects.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function xmlToCategories(x:XMLList):Array
		{
			if (ParsingTools.nullCheck(x) == null)
			{
				return null;
			}
			var categories:Array = new Array();
			var c:XML;
			for each (c in x)
			{
				var cat:Category = new Category();
				var domain:String = String(c.@domain);
				if (StringUtil.trim(domain).length != 0)
				{
					cat.domain = domain;
				}
				cat.addPaths(String(c).split("/"));
				categories.push(cat);
			}
			return categories;
		}
	}
}
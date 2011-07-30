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

package com.adobe.xml.syndication.atom.tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import com.adobe.xml.syndication.atom.Link;

	public class LinkTest extends TestCase 
	{
		
		private const TYPE:String = "en";
		private const REL:String = "self";
		private const HREFLANG:String = "self";
		private const HREF:String = "self";
		private const TITLE:String = "self";
		private const LENGTH:Number = 5736498364243;
		
		private static const REL_ALTERNATE:String = "alternate";
		private static const REL_RELATED:String = "related";
		private static const REL_SELF:String = "self";
		private static const REL_ENCLOSURE:String = "enclosure";
		private static const REL_VIA:String = "via";
	
		public function LinkTest(methodName:String = null)
		{
			super(methodName);
		}
		
		public function testLength():void
		{
			var c:Link = new Link();
			
			c.length = LENGTH;
			
			assertTrue("!isNaN(c.length)", !isNaN(c.length));
			assertTrue("c.length == LENGTH", c.length == LENGTH);
		}		
		
		public function testTitle():void
		{
			var c:Link = new Link();
			
			c.title = TITLE;
			
			assertNotNull("c.title is null", c.title);
			assertTrue("c.title == TITLE", c.title == TITLE);
		}			
		
		public function testLink():void
		{
			var c:Link = new Link();
			
			c.href = HREF;
			
			assertNotNull("c.href is null", c.href);
			assertTrue("c.href == HREF", c.href == HREF);
		}		
		
		public function testHrefLang():void
		{
			var c:Link = new Link();
			
			c.hreflang = HREFLANG;
			
			assertNotNull("c.hreflang is null", c.hreflang);
			assertTrue("c.hreflang == HREFLANG", c.hreflang == HREFLANG);
		}		
		
		public function testRel():void
		{
			var c:Link = new Link();
			
			c.rel = REL;
			
			assertNotNull("c.rel is null", c.rel);
			assertTrue("c.rel == REL", c.rel == REL);
		}
		
		public function testType():void
		{
			var c:Link = new Link();
			
			c.type = TYPE;
			
			assertNotNull("c.type is null", c.type);
			assertTrue("c.type == TYPE", c.type == TYPE);
		}
		
		public function testREL_VIA():void
		{
			assertNotNull("Link.REL_VIA is null", Link.REL_VIA);
			assertTrue("Link.REL_VIA == REL_VIA",
											Link.REL_VIA == REL_VIA);
		}		
		
		public function testREL_ENCLOSURE():void
		{
			assertNotNull("Link.REL_ENCLOSURE is null", Link.REL_ENCLOSURE);
			assertTrue("Link.REL_ENCLOSURE == REL_ENCLOSURE",
											Link.REL_ENCLOSURE == REL_ENCLOSURE);
		}		
		
		public function testREL_SELF():void
		{
			assertNotNull("Link.REL_SELF is null", Link.REL_SELF);
			assertTrue("Link.REL_SELF == REL_SELF",
											Link.REL_SELF == REL_SELF);
		}			
		
		public function testREL_ALTERNATE():void
		{
			assertNotNull("Link.REL_ALTERNATE is null", Link.REL_ALTERNATE);
			assertTrue("Link.REL_ALTERNATE == REL_ALTERNATE",
											Link.REL_ALTERNATE == REL_ALTERNATE);
		}		
		
		public function testREL_RELATED():void
		{
			assertNotNull("Link.REL_RELATED is null", Link.REL_RELATED);
			assertTrue("Link.REL_RELATED == REL_RELATED",
											Link.REL_RELATED == REL_RELATED);
		}			
	
	}
}
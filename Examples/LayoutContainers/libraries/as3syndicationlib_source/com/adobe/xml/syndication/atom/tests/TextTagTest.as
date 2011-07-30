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
	
	import com.adobe.xml.syndication.atom.TextTag;

	public class TextTagTest extends TestCase 
	{
		
		private const TYPE:String = "html";
		private const VALUE:String = "html";
		
		public static const TYPE_TEXT:String = "text";
		public static const TYPE_HTML:String = "html";
		public static const TYPE_XHTML:String = "xhtml";
	
		public function TextTagTest(methodName:String = null)
		{
			super(methodName);
		}	
		
		public function testTYPE_TEXT():void
		{
			assertNotNull("TextTag.TYPE_TEXT is null", TextTag.TYPE_TEXT);
			assertTrue("TextTag.TYPE_TEXT == TYPE_TEXT",
											TextTag.TYPE_TEXT == TYPE_TEXT);
		}
		
		public function testTYPE_HTML():void
		{
			assertNotNull("TextTag.TYPE_HTML is null", TextTag.TYPE_HTML);
			assertTrue("TextTag.TYPE_HTML == TYPE_HTML",
											TextTag.TYPE_HTML == TYPE_HTML);
		}		
		
		public function testTYPE_XHTML():void
		{
			assertNotNull("TextTag.TYPE_XHTML is null", TextTag.TYPE_XHTML);
			assertTrue("TextTag.TYPE_XHTML == TYPE_XHTML",
											TextTag.TYPE_XHTML == TYPE_XHTML);
		}			
		
		public function testType():void
		{
			var c:TextTag = new TextTag();
			
			c.type = TYPE;
			
			assertNotNull("c.type is null", c.type);
			assertTrue("c.type == TYPE", c.type == TYPE);
		}
		
		
		public function testValue():void
		{
			var c:TextTag = new TextTag();
			
			c.value = VALUE;
			
			assertNotNull("c.value is null", c.value);
			assertTrue("c.value == VALUE", c.value == VALUE);
		}
	}
}
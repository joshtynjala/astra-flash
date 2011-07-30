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

package com.adobe.xml.syndication.rss.tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import com.adobe.xml.syndication.rss.Enclosure;

	public class EnclosureTest extends TestCase 
	{
	
		public function EnclosureTest(methodName:String = null)
		{
			super(methodName);
		}	
		
		private const URL:String = "";
		private const LENGTH:Number = 473246893468343;
		private const TYPE:String = "audio/mpeg";
		
		public function testURL():void
		{
			var c:Enclosure = new Enclosure();
			
			c.url = URL;
			
			assertNotNull("c.url is null", URL);
			assertTrue("c.url == URL", c.url == URL);
		}
		
		public function testLength():void
		{
			var c:Enclosure = new Enclosure();
			
			c.length = LENGTH;
			
			assertTrue("c.length != 0", c.length != 0);
			assertTrue("c.length == TYPE", c.length == LENGTH);
		}
		
		public function testType():void
		{
			var c:Enclosure = new Enclosure();
			
			c.type = TYPE;
			
			assertNotNull("c.type is null", c.type);
			assertTrue("c.type == TYPE", c.type == TYPE);
		}
		

	}
}
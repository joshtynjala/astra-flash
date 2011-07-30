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
	
	import com.adobe.xml.syndication.rss.Cloud;

	public class CloudTest extends TestCase 
	{
	
		public function CloudTest(methodName:String = null)
		{
			super(methodName);
		}	
		
		
		private const DOMAIN:String = "foo.macromedia.com";
		private const PATH:String = "/path";
		private const REGISTER_PROCEDURE:String = "api.foo.call";
		private const PROTOCOL:String = "xml-rpc";
		private const PORT:uint = 80;
		
		public function testDomain():void
		{
			var c:Cloud = new Cloud();
			
			c.domain = DOMAIN;
			
			assertNotNull("c.domain is null", c.domain);
			assertTrue("c.domain == DOMAIN", c.domain == DOMAIN);
		}
		
		public function testPort():void
		{
			var c:Cloud = new Cloud();
			
			c.port = PORT;
			
			assertTrue("c.port is 0", c.port != 0);
			assertTrue("c.port == PORT", c.port == PORT);
		}

		public function testPath():void
		{
			var c:Cloud = new Cloud();
			
			c.path = PATH;
			
			assertNotNull("c.path is null", c.path);
			assertTrue("c.path == PATH", c.path == PATH);
		}
		
		public function testRegisterProcedure():void
		{
			var c:Cloud = new Cloud();
			
			c.registerProcedure = REGISTER_PROCEDURE;
			
			assertNotNull("c.registerProcedure is null", c.registerProcedure);
			assertTrue("c.registerProcedure == REGISTER_PROCEDURE", c.registerProcedure == REGISTER_PROCEDURE);
		}
		
		public function testProtocol():void
		{
			var c:Cloud = new Cloud();
			
			c.protocol = PROTOCOL;
			
			assertNotNull("c.protocol is null", c.protocol);
			assertTrue("c.protocol == PROTOCOL", c.protocol == PROTOCOL);
		}

	}
}

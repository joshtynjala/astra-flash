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
	
	import com.adobe.xml.syndication.rss.RSS10;
	import com.adobe.xml.syndication.rss.Channel10;
	import com.adobe.xml.syndication.rss.Image10;
	import com.adobe.xml.syndication.rss.Item10;

	public class RSS10Test extends TestCase 
	{
		
		private var rss10:RSS10;
		
		public function RSS10Test(methodName:String = null)
		{
			super(methodName);
		}
		
		public override function setUp():void
		{
			this.rss10 = new RSS10();
			rss10.populate(RSS10_DOCUMENT);
		}

		public function testChannel():void
		{
			var c:Channel10 = Channel10(this.rss10.channel);
			assertNotNull(c);
            assertEquals("about",            c.about,                  "http://about/this/rss10/feed/");
            assertEquals("title",            c.title,                  "RSS 1.0 Feed Title");
            assertEquals("link",             c.link,                   "http://host.domain.com/path/to/blog");
            assertEquals("description",      c.description,            "This is a description of an RSS 1.0 feed.");
            assertEquals("publisher",        c.publisher,              "Cantrell Press");
            assertEquals("language",         c.language,               "en");
            assertEquals("creator",          c.creator,                "Cantrell The Creator");
            assertEquals("date",             c.date.toString(),        "Thu Sep 15 10:00:00 GMT-0700 2005");
            assertEquals("rights'",          c.rights,                 "Copyright 2005 Christian Cantrell");
            assertEquals("updatePeriod",     c.updatePeriod,           "hourly");
            assertEquals("updateFrequency",  c.updateFrequency,        "2");
            assertEquals("updateBase'",      c.updateBase.toString(),  "Fri Sep 16 11:00:00 GMT-0700 2005");
            assertEquals("image",            c.image,                  "http://host.domain.com/someimage.jpg");
		}

		public function testImage():void
		{
			var i:Image10 = Image10(this.rss10.image);
			assertNotNull(i);
            assertEquals("about",  i.about,  "http://about/url/");
            assertEquals("title",  i.title,  "Image Title");
            assertEquals("link",   i.link,   "http://host.domain.com/image/link");
            assertEquals("url",    i.url,    "http://host.domain.com/image/myImage.png");
		}

		public function testItems():void
		{
            var items:Array = this.rss10.items;
			assertNotNull(items);
			assertEquals("items size", items.length, 2);

			var item:Item10 = Item10(items[0]);
			assertNotNull(item);
            assertEquals("about",        item.about,            "http://host.domain.com/path/to/post.html");
            assertEquals("title",        item.title,            "Post Title");
            assertEquals("link",         item.link,             "http://host.domain.com/path/to/post.html");
            assertEquals("description",  item.description,      "This is a post description.");
            assertEquals("subject",      item.subject,          "Flash");
            assertEquals("publisher",    item.publisher,        "Cantrell Press");
            assertEquals("creator",      item.creator,          "Cantrell The Creator");
            assertEquals("date",         item.date.toString(),  "Sat Oct 15 10:00:00 GMT-0700 2005");
            assertEquals("rights",       item.rights,           "Copyright 2006 Christian Cantrell");
		}

		private const RSS10_DOCUMENT:XML =
			<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" xmlns:co="http://purl.org/rss/1.0/modules/company/" xmlns="http://purl.org/rss/1.0/">
				<channel rdf:about="http://about/this/rss10/feed/">
					<title>RSS 1.0 Feed Title</title>
					<link>http://host.domain.com/path/to/blog</link>
					<description>This is a description of an RSS 1.0 feed.</description>
					<dc:publisher>Cantrell Press</dc:publisher>
					<dc:language>en</dc:language>
					<dc:creator>Cantrell The Creator</dc:creator>
					<dc:date>2005-09-15T10:00:00-07:00</dc:date>
					<dc:rights>Copyright 2005 Christian Cantrell</dc:rights>
					<sy:updatePeriod>hourly</sy:updatePeriod>
					<sy:updateFrequency>2</sy:updateFrequency>
					<sy:updateBase>2005-09-16T11:00:00-07:00</sy:updateBase>
					<image rdf:resource="http://host.domain.com/someimage.jpg"/>
					<items>
						<rdf:Seq>
							<rdf:li rdf:resource="http://host.domain.com/path/to/post.html" />
						</rdf:Seq>
					</items>
				</channel>
				<image rdf:about="http://about/url/">
					<title>Image Title</title>
					<link>http://host.domain.com/image/link</link>
					<url>http://host.domain.com/image/myImage.png</url>
				</image>
				<item rdf:about="http://host.domain.com/path/to/post.html">
					<title>Post Title</title>
					<link>http://host.domain.com/path/to/post.html</link>
					<description>This is a post description.</description>
					<dc:subject>Flash</dc:subject>
					<dc:publisher>Cantrell Press</dc:publisher>
					<dc:creator>Cantrell The Creator</dc:creator>
					<dc:date>2005-10-15T10:00:00-07:00</dc:date>
					<dc:rights>Copyright 2006 Christian Cantrell</dc:rights>
					<foo>bar</foo>
				</item>
				<item rdf:about="http://host.domain.com/path/to/post.html">
					<title>Post Title</title>
					<link>http://host.domain.com/path/to/post.html</link>
					<description>This is a post description.</description>
					<dc:subject>Flash</dc:subject>
					<dc:publisher>Cantrell Press</dc:publisher>
					<dc:creator>Cantrell The Creator</dc:creator>
					<dc:date>2005-10-15T10:00:00-07:00</dc:date>
					<dc:rights>Copyright 2006 Christian Cantrell</dc:rights>
					<foo>bar</foo>
				</item>
			</rdf:RDF>
	}
}

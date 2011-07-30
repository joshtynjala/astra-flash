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
	
	import com.adobe.xml.syndication.rss.RSS20;
	import com.adobe.xml.syndication.rss.Channel20;
	import com.adobe.xml.syndication.rss.Image20;
	import com.adobe.xml.syndication.rss.Item20;
	import com.adobe.xml.syndication.rss.Cloud;

	public class RSS20Test extends TestCase 
	{
		
		private var rss20:RSS20;
		
		public function RSS20Test(methodName:String = null)
		{
			super(methodName);
		}
		
		public override function setUp():void
		{
			this.rss20 = new RSS20();
			rss20.populate(RSS20_DOCUMENT);
		}

		public function testChannel():void
		{
			var c:Channel20 = Channel20(this.rss20.channel);
			assertNotNull(c);
            assertEquals("title",            c.title,            "RSS 1.0 Feed Title");
            assertEquals("link",             c.link,             "http://host.domain.com/path/to/blog");
            assertEquals("description",      c.description,      "This is a description of an RSS 2.0 feed.");
            assertEquals("language",         c.language,         "en");
            assertEquals("copyright",        c.copyright,        "Copyright 2005 Christian Cantrell");
            assertEquals("managingEditor",   c.managingEditor,   "managing_editor@macromedia.com");
            assertEquals("webMaster",        c.webMaster,        "webmaster@macromedia.com");
            assertEquals("rating",           c.rating,           "This is the rating.");

            assertEquals("pubDate",         c.pubDate.toUTCString(),         "Fri Jan 20 04:00:00 2006 UTC");
            assertEquals("lastBuildDate",   c.lastBuildDate.toUTCString(),   "Thu Jan 19 02:00:00 2006 UTC");
            assertEquals("docs",            c.docs,                          "http://blogs.law.harvard.edu/tech/rss");

            var skipDays:Array = c.skipDays;
            assertEquals("skipDays.length",  skipDays.length,  2);
            assertEquals("skipDays",         skipDays[0],      "Monday");
            assertEquals("skipDays",         skipDays[1],      "Tuesday");

            var skipHours:Array = c.skipHours;
            assertEquals("skipHours.length",  skipHours.length,  3);
            assertEquals("skipHours",         skipHours[0],      0);
            assertEquals("skipHours",         skipHours[1],      11);
            assertEquals("skipHours",         skipHours[2],      23);

            var cats:Array = c.categories;
            assertEquals("categories.length",  cats.length,     2);
            assertEquals("categories.domain",  cats[0].domain,  "http://www.dmoz.org");

            var catPath:Array = cats[0].path;
            assertEquals("categories.path.length",  catPath.length,  3);
            assertEquals("categories.path",         catPath[0],      "Business");
            assertEquals("categories.path",         catPath[1],      "Industries");
            assertEquals("categories.path",         catPath[2],      "Publishing");
            assertEquals("categories.domain",       cats[0].domain,  "http://www.dmoz.org");

            catPath = cats[1].path;
            assertEquals("categories.path.length",  catPath.length,  4);
            assertEquals("categories.path",         catPath[0],      "A");
            assertEquals("categories.path",         catPath[1],      "B");
            assertEquals("categories.path",         catPath[2],      "C");
            assertEquals("categories.path",         catPath[3],      "D");
            assertEquals("categories.domain",       cats[1].domain,  "http://www.mycategories.com");

            assertEquals("generator",  c.generator,  "News-o-Matic");
            assertEquals("ttl",        c.ttl,        30);

            var cloud:Cloud = c.cloud;
            assertEquals("cloud.domain",             cloud.domain,             "http://www.exampleurl.com");
            assertEquals("cloud.port",               cloud.port,               "80");
            assertEquals("cloud.path",               cloud.path,               "/RPC2");
            assertEquals("cloud.registerProcedure",  cloud.registerProcedure,  "pleaseNotify");
            assertEquals("cloud.protocol",           cloud.protocol,           "XML-RPC");
		}

		public function testImage():void
		{
			var i:Image20 = Image20(this.rss20.image);
			assertNotNull(i);
            assertEquals("title",        i.title,        "Image Title");
            assertEquals("link",         i.link,         "http://host.domain.com/image/link");
            assertEquals("url",          i.url,          "http://host.domain.com/image/myImage.png");
            assertEquals("width",        i.width,        123);
            assertEquals("height",       i.height,       321);
            assertEquals("description",  i.description,  "This is my image.");
		}

		public function testItems():void
		{
            var items:Array = this.rss20.items;
			assertNotNull(items);
			assertEquals("items size", items.length, 2);

			var item:Item20 = Item20(items[0]);
			assertNotNull(item);
            assertEquals("title",             item.title,             "Post Title");
            assertEquals("link",              item.link,              "http://host.domain.com/path/to/post.html");
            assertEquals("description",       item.description,       "This is a post description.");
            assertEquals("creator",           item.creator,           "Cantrell The Creator");
            assertEquals("source.url",        item.source.url,        "http://www.anothersite.com/index.html");
            assertEquals("source.name",       item.source.name,       "Another Site");
            assertEquals("enclosure.url",     item.enclosure.url,     "http://www.exampleurl.com/example/001.mp3");
            assertEquals("enclosure.length",  item.enclosure.length,  543210);
            assertEquals("enclosure.type",    item.enclosure.type,    "audio/mpeg");

            var cats:Array = item.categories;
            var catPath:Array = cats[0].path;
            assertEquals("categories.path.length", catPath.length, 3);
            assertEquals("categories.path",    catPath[0],      "Business");
            assertEquals("categories.path",    catPath[1],      "Industries");
            assertEquals("categories.path",    catPath[2],      "Publishing");
            assertEquals("categories.domain",  cats[0].domain,  "http://www.dmoz.org");

            catPath = cats[1].path;
            assertEquals("categories.path.length",  catPath.length,              4);
            assertEquals("categories.path",         catPath[0],                  "A");
            assertEquals("categories.path",         catPath[1],                  "B");
            assertEquals("categories.path",         catPath[2],                  "C");
            assertEquals("categories.path",         catPath[3],                  "D");
            assertEquals("categories.domain",       cats[1].domain,              "http://my.domain.com");
            assertEquals("comments",                item.comments,               "http://www.exampleurl.com/mycomments.html");
            assertEquals("author",                  item.author,                 "Christian Cantrell");
            assertEquals("pubDate",                 item.pubDate.toUTCString(),  "Wed Jan 18 02:00:00 2006 UTC");
            assertEquals("guid.permaLink",          item.guid.permaLink,         true);
            assertEquals("guid.id",                 item.guid.id,                "http://www.exampleurl.com/example/001.html");
		}

		private const RSS20_DOCUMENT:XML =
            <rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">
				<channel>
					<title>RSS 1.0 Feed Title</title>
					<link>http://host.domain.com/path/to/blog</link>
					<description>This is a description of an RSS 2.0 feed.</description>
					<language>en</language>
                    <copyright>Copyright 2005 Christian Cantrell</copyright>
                    <managingEditor>managing_editor@macromedia.com</managingEditor>
                    <webMaster>webmaster@macromedia.com</webMaster>
                    <rating>This is the rating.</rating>
                    <pubDate>Fri, 20 Jan 2006 04:00:00 GMT</pubDate>
                    <lastBuildDate>Thu, 19 Jan 2006 02:00:00 GMT</lastBuildDate>
                    <docs>http://blogs.law.harvard.edu/tech/rss</docs>
                    <skipDays>
                        <day>Monday</day>
                        <day>Tuesday</day>
                    </skipDays>
                    <skipHours>
                        <hour>0</hour>
                        <hour>11</hour>
                        <hour>23</hour>
                    </skipHours>
                    <category domain="http://www.dmoz.org">Business/Industries/Publishing</category>
                    <category domain="http://www.mycategories.com">A/B/C/D</category>
                    <generator>News-o-Matic</generator>
                    <ttl>30</ttl>
                    <cloud domain="http://www.exampleurl.com" port="80" path="/RPC2" registerProcedure="pleaseNotify" protocol="XML-RPC"/>
                    <image>
                        <title>Image Title</title>
                        <link>http://host.domain.com/image/link</link>
                        <url>http://host.domain.com/image/myImage.png</url>
                        <width>123</width>
                        <height>321</height>
                        <description>This is my image.</description>
                    </image>
                    <item>
                        <title>Post Title</title>
                        <link>http://host.domain.com/path/to/post.html</link>
                        <description>This is a post description.</description>
                        <dc:creator>Cantrell The Creator</dc:creator>
                        <source url="http://www.anothersite.com/index.html">Another Site</source>
                        <enclosure url="http://www.exampleurl.com/example/001.mp3" length="543210" type="audio/mpeg"/>
                        <category domain="http://www.dmoz.org">Business/Industries/Publishing</category>
                        <category domain="http://my.domain.com">A/B/C/D</category>
                        <comments>http://www.exampleurl.com/mycomments.html</comments>
                        <author>Christian Cantrell</author>
                        <pubDate>Wed, 18 Jan 2006 02:00:00 GMT</pubDate>
                        <guid isPermaLink="true">http://www.exampleurl.com/example/001.html</guid>
                    </item>
                    <item>
                        <title>Post Title 2</title>
                        <link>http://host.domain2.com/path/to/post.html</link>
                        <description>This is a post description 2.</description>
                        <dc:creator>Cantrell The Creator 2</dc:creator>
                        <source url="http://www.anothersite2.com/index.html">Another Site</source>
                        <enclosure url="http://www.exampleurl2.com/example/001.mp3" length="543210" type="audio/mpeg"/>
                        <category domain="http://www.dmoz2.org">Business/Industries/Publishing</category>
                        <category domain="http://my.domain2.com">foo/bar/baz</category>
                        <comments>http://www.exampleurl2.com/mycomments.html</comments>
                        <author>Christian Cantrell 2</author>
                        <pubDate>Tue, 17 Jan 2006 02:00:00 GMT</pubDate>
                        <guid isPermaLink="true">http://www.exampleurl2.com/example/001.html</guid>
                    </item>
				</channel>
			</rss>
	}
}

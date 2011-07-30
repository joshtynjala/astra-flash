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
	
	import com.adobe.xml.syndication.atom.Atom10;
	import com.adobe.xml.syndication.atom.FeedData;
	import com.adobe.xml.syndication.atom.Link;
	import com.adobe.xml.syndication.atom.Entry;

	public class Atom10Test extends TestCase 
	{
		
		private var atom10:Atom10;
		
		public function Atom10Test(methodName:String = null)
		{
			super(methodName);
		}
		
		public override function setUp():void
		{
			this.atom10 = new Atom10();
			atom10.populate(ATOM10_DOCUMENT);
		}

		public function testFeedData():void
		{
            var feedData:FeedData = atom10.feedData;
			assertNotNull(feedData);
            assertEquals("title.type", feedData.title.type, "text");
            assertEquals("title.value", feedData.title.value, "Atom 1.0 Feed");
            assertEquals("subtitle.type", feedData.subtitle.type, "text");
            assertEquals("subtitle.value", feedData.subtitle.value, "Subtitle here.");
            assertEquals("subtitle.updated", feedData.updated.toString(), "Fri Jan 20 04:00:00 GMT-0800 2006");
            assertEquals("subtitle.id", feedData.id, "1234567890abcdef");

            // Authors
            var authors:Array = feedData.authors;
			assertNotNull(authors);
            assertEquals("authors.length", authors.length, 1);
            assertEquals("authors.name", authors[0].name, "Christian Cantrell");
            assertEquals("authors.email", authors[0].email, "christian.cantrell@adobe.com");
            assertEquals("authors.uri", authors[0].uri, "http://weblogs.macromedia.com/cantrell");

            // Contributors 
            var contributors:Array = feedData.contributors;
			assertNotNull(contributors);
            assertEquals("contributors.length", contributors.length, 1);
            assertEquals("contributors.name", contributors[0].name, "Christian Cantrell");
            assertEquals("contributors.email", contributors[0].email, "christian.cantrell@adobe.com");
            assertEquals("contributors.uri", contributors[0].uri, "http://weblogs.macromedia.com/cantrell");

            // Categories 
            var categories:Array = feedData.categories;
			assertNotNull(categories);
            assertEquals("categories.length", categories.length, 1);
            assertEquals("categories.term", categories[0].term, "sports");
            assertEquals("categories.scheme", categories[0].scheme, "some_scheme");
            assertEquals("categories.label", categories[0].label, "label");

            // Link
            var link:Link = feedData.link;
            assertEquals("link.rel", link.rel, "alternate");
            assertEquals("link.type", link.type, "text/html");
            assertEquals("link.hreflang", link.hreflang, "en");
            assertEquals("link.href", link.href, "http://example.org/");
            assertEquals("link.title", link.title, "Some Human-readable Title");
            assertEquals("link.length", link.length, "128");

            // Rights
            assertEquals("rights.type", feedData.rights.type, "text");
            assertEquals("rights.value", feedData.rights.value, "Copyright (c) 2006, Christian Cantrell");

            // Generator 
            assertEquals("generator.uri", feedData.generator.uri, "http://www.example.com/generator");
            assertEquals("generator.version", feedData.generator.version, "1.0");
            assertEquals("generator.value", feedData.generator.value, "Example Toolkit");

            assertEquals("icon", feedData.icon, "/icon.jpg");
            assertEquals("logo", feedData.logo, "/logo.jpg");
		}

		public function testEntries():void
		{
            var entries:Array = atom10.entries;
			assertNotNull(entries);
            assertEquals("entries.length", entries.length, 1);
            var entry:Entry = entries[0];
            assertEquals("entry.title", entry.title, "Atom title #1");

            // Links
            var links:Array = entry.links;
			assertNotNull(links);
            assertEquals("links.length", links.length, 1);
            var link:Link = links[0];
            assertEquals("link.rel", link.rel, "alternate");
            assertEquals("link.type", link.type, "text/html");
            assertEquals("link.hreflang", link.hreflang, "fr");
            assertEquals("link.href", link.href, "http://example.org/");
            assertEquals("link.title", link.title, "Some Link Title");
            assertEquals("link.length", link.length, "256");

            assertEquals("id", entry.id, "abcdef1234567890");
            assertEquals("updated", entry.updated.toString(), "Thu Jan 19 04:00:00 GMT-0800 2006");
            assertEquals("published", entry.published.toString(), "Wed Jan 18 04:00:00 GMT-0800 2006");

            // Authors
            var authors:Array = entry.authors;
			assertNotNull(authors);
            assertEquals("authors.length", authors.length, 1);
            assertEquals("authors.name", authors[0].name, "Christian Author");
            assertEquals("authors.email", authors[0].email, "christian.cantrell@adobe.com");
            assertEquals("authors.uri", authors[0].uri, "http://author.example.org/");

            // Contributors 
            var contributors:Array = entry.contributors;
			assertNotNull(contributors);
            assertEquals("contributors.length", contributors.length, 1);
            assertEquals("contributors.name", contributors[0].name, "Christian Contributor");
            assertEquals("contributors.email", contributors[0].email, "john@contributor.com");
            assertEquals("contributors.uri", contributors[0].uri, "http://contributor.example.org/");

            // Content
            assertEquals("content.type", entry.content.type, "text");
            assertEquals("content.value", entry.content.value, "This is some content.");
            assertNull(entry.content.src);

            // Categories 
            var categories:Array = entry.categories;
			assertNotNull(categories);
            assertEquals("categories.length", categories.length, 1);
            assertEquals("categories.term", categories[0].term, "news");
            assertEquals("categories.scheme", categories[0].scheme, "some_scheme");
            assertEquals("categories.label", categories[0].label, "label");

            // Source
            var sourceFeedData:FeedData = entry.source;
			assertNotNull(sourceFeedData);
            assertEquals("source.id", sourceFeedData.id, "this:is:the:metadata:id");
        }

		private const ATOM10_DOCUMENT:XML =
                <feed xmlns="http://www.w3.org/2005/Atom">
                    <title type="text">Atom 1.0 Feed</title>
                    <subtitle type="text">Subtitle here.</subtitle>
                    <updated>2006-01-20T12:00:00Z</updated>
                    <id>1234567890abcdef</id>
                    <author>
                        <name>Christian Cantrell</name>
                        <email>christian.cantrell@adobe.com</email>
                        <uri>http://weblogs.macromedia.com/cantrell</uri>
                    </author> 
                    <contributor>
                        <name>Christian Cantrell</name>
                        <email>christian.cantrell@adobe.com</email>
                        <uri>http://weblogs.macromedia.com/cantrell</uri>
                    </contributor>
                    <!-- You can have multiple categories -->
                    <category term="sports" scheme="some_scheme" label="label"/>
                    <link rel="alternate" type="text/html" hreflang="en" href="http://example.org/" title="Some Human-readable Title" length="128"/>
                    <rights type="text">Copyright (c) 2006, Christian Cantrell</rights>
                    <generator uri="http://www.example.com/generator" version="1.0">Example Toolkit</generator>
                    <icon>/icon.jpg</icon>
                    <logo>/logo.jpg</logo>
                    <entry>
                        <title>Atom title #1</title>
                        <link rel="alternate" type="text/html" href="http://example.org/" hreflang="fr" title="Some Link Title" length="256"/>
                        <id>abcdef1234567890</id>
                        <updated>2006-01-19T12:00:00Z</updated>
                        <published>2006-01-18T12:00:00Z</published>
                        <author>
                            <name>Christian Author</name>
                            <uri>http://author.example.org/</uri>
                            <email>christian.cantrell@adobe.com</email>
                        </author>
                        <contributor>
                            <name>Christian Contributor</name>
                            <uri>http://contributor.example.org/</uri>
                            <email>john@contributor.com</email>
                        </contributor>
                        <content type="text">This is some content.</content>
                        <category term="news" scheme="some_scheme" label="label"/>
                        <source>
                            <id>this:is:the:metadata:id</id>
                        </source>
                    </entry>
                </feed>
	}
}

/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package {
	import fl.controls.Button;
	import com.yahoo.astra.containers.formClasses.FormLayoutStyle;	import com.yahoo.astra.fl.containers.Form;
	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.MouseEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	import flash.text.TextFormatAlign;	

	/*
	 *<?
	 *
	 *include("connectdb.php");
	 *
	 *$database = "formmessage";
	 *
	 *if (!mysql_select_db($database)) {
	 *  $r_string = '&errorcode=2&';
	 *	
	 *} else {
	 *	
	 *	$sql =  "SELECT * FROM messageboard ORDER BY time DESC	LIMIT 0 , 10";
	 *	
	 *	$result = mysql_query ($sql);	
	 *
	 *
	 *  if (!$result) {
	 *    $msg = mysql_error();
	 *   $r_string = '&errorcode=3&msg='.$msg;
	 * } else {
	 *     $r_string = '&errorcode=0&thedata=';
	 *
	 *	  $Return = "<messageboard>";
	 *	
	 *		while ( $message = mysql_fetch_object( $result ) )
	 *		{
	 *
	 *			$Return .= "<msg><name>".$message->name."</name><email>".$message->email."</email><website>".$message->website."</website><message>".$message->message."</message><time>".$message->time."</time></msg>";
	 *		
	 *		}
	 *		$Return .= "</messageboard>";
	 *	
	 *      $r_string .= $Return;
	 *
	 *  }
	 *}
	 *
	 *echo $r_string;
	 *?>
	 */
	public class ReceiveFormData extends Sprite {
		private var callBtn : Button;		private var myForm : Form ;

		public function ReceiveFormData() {
			initUI();
		}

		private function initUI() : void {
			callBtn = new Button();
			callBtn.label = "Call message board.";
			callBtn.width = 300;
			callBtn.x = 125;
			callBtn.addEventListener(MouseEvent.CLICK, hanlder_callBtn_clicked);
			this.addChild(callBtn);
		}

		private function hanlder_callBtn_clicked(e : MouseEvent) : void {
			callBtn.enabled = false;
			callBtn.label = "Loading Data...";
			loadData();				
		}

		private function loadData() : void {
			var url : String = "http://www.yswfblog.com/form/retrieveMessage.php";

			var request : URLRequest = new URLRequest(url);
			var myLoader : URLLoader = new URLLoader();
			myLoader.addEventListener(Event.COMPLETE, completeHandler);
			myLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			try {
				myLoader.load(request);
			} catch (error : Error) {
				trace("Unable to load requested document.");
			}
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			trace("ioErrorHandler: " + event);
			callBtn.label = "Set your server setting first.";
		}

		private function completeHandler(event : Event) : void {
			var loader : URLLoader = URLLoader(event.target);
			var dataStr : String = loader.data.toString();
			var errStr : String = dataStr.substr(dataStr.indexOf("errorcode=") + 10, 1);
			var alertMsg : String = "";
			switch(errStr) {
				case "0":
					alertMsg = "Data retrieving success.";
					att_form(loader.data);
					break;
				case "1":
					alertMsg = "Can not connect to server.";
					break;
				case "2":
					alertMsg = "Can not find database.";
				case "3":
					var msg : String = dataStr.substr(dataStr.indexOf("msg=") + 4);
					alertMsg = (msg) ? msg : "Error in your SQL syntax";
					break;
			}
			trace("alertMsg:", alertMsg);
			
			callBtn.enabled = true;
			callBtn.label = "Call message board.";
		}

		
		private function att_form(data : Object) : void {
		
			var dataStr : String = data.toString();		
			var messageboard : XML = new XML(dataStr.substr(dataStr.indexOf("thedata=") + 8));
	 
			var msgLength : int = messageboard.msg.length();
			var sourceArr : Array = [];
	
			for (var i : int = 0;i < msgLength; i++) {
				var curData : Object = messageboard.msg[i];
				var website : String = curData.website.toString();
				website = (website.indexOf("http://") == -1) ? "http://" + website : website;
				var name : String = curData.name.toString();
				if(name && website) name = "<a href=" + '"' + website + '"' + "><font color='#336699' ><b>" + curData.name + "</b></font></a>" ;
				var email : String = curData.email.toString();
				var labelStr : String = (name) ? name + "\n(" + email + ")" : email;	
			
				sourceArr.push({label:labelStr, items:[messageBox(curData)], itemAlign:"vertical"});
			}
			if(myForm) this.removeChild(myForm);
			myForm = new Form();
			myForm.setSize(500, 400);
//			myForm.labelWidth = 120;
			myForm.setStyle("skin", "GrayBlock");
			myForm.paddingTop = myForm.paddingBottom = myForm.paddingLeft = myForm.paddingRight = 20;
			
			myForm.labelAlign = FormLayoutStyle.LEFT;
			myForm.dataSource = sourceArr;
			
			myForm.x = myForm.y = 50;			this.addChild(myForm);
		}

		private function messageBox(data : Object) : Sprite {
			var txtFd : TextField = new TextField();
			txtFd.width = 260;
			txtFd.text = data.message.toString();
			txtFd.wordWrap = true;
			txtFd.autoSize = TextFieldAutoSize.LEFT;
			txtFd.x = 15;
			txtFd.y = 10;
			
			var lightGrayBlock : MovieClip = new LightGrayBlock();
			lightGrayBlock.width = 300;
			lightGrayBlock.height = txtFd.height + 35;
			
			var timeTxtFd : TextField = new TextField();
			var timeTxtFormat : TextFormat = new TextFormat();
			timeTxtFormat.align = TextFormatAlign.RIGHT;
			timeTxtFormat.color = 0x666666;
			timeTxtFd.defaultTextFormat = timeTxtFormat;
			timeTxtFd.width = 280;
			timeTxtFd.height = 22;
			timeTxtFd.text = data.time.toString();
			timeTxtFd.x = 15;
			timeTxtFd.y = txtFd.height + 10;
				
				
			var grayBox : Sprite = new Sprite();
			grayBox.addChild(lightGrayBlock);
			grayBox.addChild(txtFd);
			grayBox.addChild(timeTxtFd);
				
			
			return grayBox;	
		}	}
}

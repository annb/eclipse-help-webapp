<html>
  <head>
    <title>Content Toolbar Frame</title>
    <style>
	
    </style>
    <link rel="stylesheet" type="text/css" href="breadcrumbs.css" />
    <script language="javascript" src="jquery.js"></script>
    <script language="javascript" src="jquery-ui.js"></script>
    <script language="JavaScript">
	function showPopup(){
		var permalink = parent.ContentViewFrame.document.getElementById('permlink');
		permalink.style.display='block';
		parent.ContentViewFrame.document.getElementById('pageLink').focus();
		parent.ContentViewFrame.document.getElementById('pageLink').select();
		return false;
	}
	
	function resync(){
		var topic = parent.ContentViewFrame.window.location.href;
		var i = topic.indexOf('?');
		if (i != -1) {
			topic = topic.substring(0, i);
		}
		if (topic.indexOf("home.html") != -1) {
			alert("The current document displayed does not exist in the table of contents.");
		} else {
			try {
				parent.parent.NavFrame.displayTocFor(topic, false);
			} catch(e) {}
		}
	}
    </script>
  </head>
  <body>
    <div class="toolbar">
	<a class="permlink" onclick="showPopup();" title="Get Permanent Link"></a>
	<a class="showintoc" onclick="resync();" title="Show in Table of Contents"></a>
    </div>
  </body>
</html>

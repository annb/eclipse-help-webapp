<%--
 Copyright (c) 2000, 2010 IBM Corporation and others.
 All rights reserved. This program and the accompanying materials 
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html
 
 Contributors:
     IBM Corporation - initial API and implementation
--%>
<html lang="en">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Resize Bar</title>
		<link href="css/bootstrap.css" rel="stylesheet">
		<link href="css/global.css" rel="stylesheet">
		<!--link href="searchList.css" rel="stylesheet"-->
		<style type="text/css">
		.showintoc a{
			height: 16px;
			display: block;
			background: url('images/show_icon.png') no-repeat scroll right top transparent;
			margin: 5px 10px;
		}
		.showintoc a:hover{
			background: url('images/show_hover_icon.png') no-repeat scroll right top transparent;
		}
		</style>
		<script language="JavaScript" src="jquery.js"></script>
		<script language="JavaScript" src="jquery-ui.js"></script>		

<script language="JavaScript">
function getCurrentTopic() {
    var topic = parent.ContentViewFrame.window.location.href;
	// remove the query, if any
	var i = topic.indexOf('?');
	if (i != -1) {
		topic = topic.substring(0, i);
	}
	return topic;
}

function resynch(button, param)
{
	try {
		parent.parent.NavFrame.displayTocFor(getCurrentTopic(), false);
	} catch(e) {}
	if (button && document.getElementById(button)){
		document.getElementById(button).blur();
	}
}
</script>
	</head>
	<body>
		<div class="showintoc" id="synchToc">
			<a onclick="synchWithToc();" title="Show in Table of Contents"></a>
		</div>
	</body>
</html>
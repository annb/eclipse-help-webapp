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
		<script type="text/javascript" src="jquery.js" />
<script type="text/javascript">
$(function(){
	alert("abc");
	/*$("#verticalBar").mousedown(function(e){
		//e.preventDefault();
		alert("is clicked");
		//window.location.href=$(this).attr("href");
		//alert(window.location.href);
	});*/
});

function resizeFrame(obj) {
	alert(obj.offsetLeft);
}
		
function restore_maximize(button)
{
	toggleFrame();
	if (button && document.getElementById(button)){
		document.getElementById(button).blur();
	}
}
function toggleFrame(){
	// get to the frameset
	var p = parent;
	while (p && !p.toggleFrame)  {	   
	    if (p === p.parent)  {
	        return;
        }
		p = p.parent;
	}
	
	if (p!= null){
		p.toggleFrame('');
	}
	if(!p.isRestored) {
		document.getElementById("maximize_restore").firstChild.className = "uiIconMiniArrowRight pull-left";
		document.getElementById("verticalBar").style.display = "none";
		document.getElementById("resizeLineBar").className = "resize  clearfix resizeLt";
	} else {
		document.getElementById("maximize_restore").firstChild.className = "uiIconMiniArrowLeft pull-left";
		document.getElementById("verticalBar").style.display = "block";
		document.getElementById("resizeLineBar").className = "resize  clearfix";
	}
	//document.selection.clear;	
}		
</script>
	</head>
	<body>
		<div class="resize  clearfix" id="resizeLineBar">
			<a id="maximize_restore" class="iconControll" href="javascript:restore_maximize(this);"><i class="uiIconMiniArrowLeft pull-left" ></i></a>
			<div id="verticalBar" class="line pull-left" style="height: 100%; display: block;"></div>
		</div>
	</body>
</html>
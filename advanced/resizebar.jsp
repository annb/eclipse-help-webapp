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
		<script language="JavaScript" src="jquery.js"></script>
		<script language="JavaScript" src="jquery-ui.js"></script>		

<script language="JavaScript">
/*$(function(){
	var oldPosition = $( "#resizeLineBar" ).offset();
	var resizeWidth = $("#resizeLineBar").width();
	var frameSet = parent.document.getElementById("helpFrameset");
	$("#resizeLineBar").draggable({ 
		axis: "x",
		drag: function(event, ui) {
			var position = $(this).offset();
			var delta = oldPosition.left - position.left;
			var leftSize = parent.NavFrame.document.body.offsetWidth;
			var rightSize = parent.ContentFrame.document.body.offsetWidth;
			var leftCols = (leftSize+delta) * 100 / (leftSize + resizeWidth + rightSize);
			var rightCols = 98 - leftCols;
			if ((leftSize=="310px") || (rightSize=="750px")) $(this).draggable("disable");
			frameSet.setAttribute("cols", leftCols+"%,2%,"+rightCols+"%");
		},
		stop: function(event, ui) {
			$(document).unbind('mousemove');
		}
	});
});*/

/*$(function(){
	var leftWidth = parent.NavFrame.document.body.offsetWidth;
	var resizeWidth = parent.ResizeBarFrame.document.body.offsetWidth;
	var rightWidth = parent.ContentFrame.document.body.offsetWidth;
	var sum = leftWidth + resizeWidth + rightWidth;
	var drag = false;
	var frameSet = parent.document.getElementById("helpFrameset");
	$('#resizeLineBar').mousedown(function(e){
		$("#resizeLineBar").draggable({axis: "x"});
		e.preventDefault();
		drag = true;
		$(document).mousemove(function(e){
			var leftCols = (leftWidth + e.pageX)*100/sum;
			var rightCols = 98 - leftCols;
			frameSet.setAttribute("cols", leftCols+"%,2%,"+rightCols+"%");
		});
	});
	
	$(document).mouseup(function(e){
		if (drag){
			$(document).unbind('mousemove');
			drag = false;
		}
	});
});*/

var leftOrRight = false;
		
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
		document.getElementById("maximize_restore").firstChild.className = "uiIconMiniArrowRight";
		document.getElementById("verticalBar").style.display = "none";
		document.getElementById("resizeLineBar").className = "resize  clearfix resizeLt";
		leftOrRight = true;
	} else {
		document.getElementById("maximize_restore").firstChild.className = "uiIconMiniArrowLeft";
		document.getElementById("verticalBar").style.display = "block";
		document.getElementById("resizeLineBar").className = "resize  clearfix";
		leftOrRight = false;
	}
	//document.selection.clear;	
}
	
function changeClass(obj, out){
	if (leftOrRight) var currentClass = "uiIconMiniArrowRight uiIconDarkGray";
	else var currentClass = "uiIconMiniArrowLeft uiIconDarkGray";
	if (out) {
		obj.className = currentClass;
	} else{ 
		obj.className = currentClass + " uiIconBlue";
	}
}
</script>
	</head>
	<body>
		<div id="position" style="display: none"></div>
		<div class="resize  clearfix" id="resizeLineBar">
			<a id="maximize_restore" class="iconControll" href="javascript:restore_maximize(this);"><i class="uiIconMiniArrowLeft uiIconDarkGray" style="padding: 0px 4px 0 10px; width: 7px;" onmouseover="changeClass(this, false);" onmouseout="changeClass(this, true);">&nbsp;</i></a>
			<div id="verticalBar" class="line pull-right" style="height: 1000px; display: block;"></div>
		</div>
	</body>
</html>
<%--
 Copyright (c) 2000, 2010 IBM Corporation and others.
 All rights reserved. This program and the accompanying materials 
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html
 
 Contributors:
     IBM Corporation - initial API and implementation
--%>
<%@ include file="fheader.jsp"%>

<% 
	LayoutData data = new LayoutData(application,request, response);
	FrameData frameData = new FrameData(application,request, response);
	WebappPreferences prefs = data.getPrefs();
%>

<html lang="<%=ServletResources.getString("locale", request)%>">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=ServletResources.getString("Help", request)%></title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/global.css" />
<script language="javascript" src="jquery.js"></script>

<script language="JavaScript">

function loadFrameHandle(){
	var jquery = document.createElement('script');
	jquery.type = 'text/javascript';
	jquery.src = '../../advanced/jquery.js';
	ContentViewFrame.document.getElementsByTagName('head')[0].appendChild(jquery);
	var jqueryUI = document.createElement('script');
	jqueryUI.type = 'text/javascript';
	jqueryUI.src = '../../advanced/jquery-ui.js';
	ContentViewFrame.document.getElementsByTagName('head')[0].appendChild(jqueryUI);
	var breadcrumbs = ContentViewFrame.document.getElementsByClassName("help_breadcrumbs");
	var currentBC = parent.parent.parent.HelpToolbarFrame.SearchFrame.document.getElementById("newBreadcrumbs");
	currentBC.innerHTML = "";	
	if ((breadcrumbs != null) && (breadcrumbs.length != 0)) {
		var divBreadcrumbs = breadcrumbs[0].getElementsByTagName("a");
		if (divBreadcrumbs != null) {
			var html = '';
			for (var i=1; i< divBreadcrumbs.length; i++){
				var currentChild = divBreadcrumbs[i];
				html += '<div';
				if (i == divBreadcrumbs.length-1) html += ' class="active">';
				else html += ' class="">';
				html += '<a href="' + currentChild.href + '" target="ContentViewFrame">' + $(currentChild).text() + '</a></div>';
				if (i < (divBreadcrumbs.length-1)) {
					html += '<span class="uiIconMiniArrowRight"></span>';
				}				
			}
			currentBC.innerHTML = html;
		}
		
		breadcrumbs[0].innerHTML = "";
		breadcrumbs[0].style.display = "block";
		var location = ContentViewFrame.window.location.href;
		var shortLocation = "";
		if (location.indexOf("/public/topic/") != -1) shortLocation = location.replace("/public/topic/", "/");
		else shortLocation = location;
		var bcHtml = '<div id="permlink" class="popupContainer"><div class="popupHeader"><a onclick="document.getElementById(\'permlink\').style.display=\'none\';" class="uiIcon uiIconClose pull-right" title="Close"></a><span class="popupTitle">Permalink</span></div><div class="popupContent"><div class="linkShare"><i class="uiIconPermalink"></i>&nbsp;Link to share</div><div><input type="text" value="' + shortLocation +'" id="pageLink" class="inputPermlink input-xxxlarge"></div></div></div>';
		bcHtml += '<div class="toolbar"><a class="permlink" onclick="var permalink=document.getElementById(\'permlink\');permalink.style.display=\'block\';permalink.style.top=\'107px\';permalink.style.left=\'90px\';document.getElementById(\'pageLink\').focus(); $(\'#permlink\').draggable({containment: \'document\'});"></a><a class="showintoc" onclick="var topic=window.location.href;var i=topic.indexOf(' + "'?'" + ');if (i != -1) {topic=topic.substring(0, i);}parent.parent.NavFrame.displayTocFor(topic, false);" title="Show in Table of Contents"></a></div>';
		breadcrumbs[0].innerHTML = bcHtml;
	} 
}
</script>
</head>
    <frameset id="contentFrameset" rows="*" frameborder=0" framespacing="0" border="0" spacing="0">
	<frame ACCESSKEY="K" name="ContentViewFrame" title="<%=ServletResources.getString("topicView", request)%>" src='<%=UrlUtil.htmlEncode(data.getContentURL())%>'  marginwidth="10"<%=(data.isIE() && "6.0".compareTo(data.getIEVersion()) <=0)?"scrolling=\"yes\"":""%> marginheight="0" frameborder="0" onload="loadFrameHandle();">
	<%
	    AbstractFrame[] frames = frameData.getFrames(AbstractFrame.BELOW_CONTENT);
	    for (int f = 0; f < frames.length; f++) {
	        AbstractFrame frame = frames[f];
	        String url = frameData.getUrl(frame);
	%>
	<frame name="<%=frame.getName()%>" src="<%=url %>" <%=frame.getFrameAttributes()%> >
	<% 
	 } 
	%>
</frameset>
</html>


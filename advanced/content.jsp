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
	var breadcrumbs = ContentViewFrame.document.getElementsByClassName("help_breadcrumbs");
	var currentBC = parent.parent.parent.HelpToolbarFrame.SearchFrame.document.getElementById("newBreadcrumbs");
	while(currentBC.hasChildNodes()){
		currentBC.removeChild(currentBC.lastChild);
	}	
	if ((breadcrumbs != null) && (breadcrumbs.length != 0)) {
		var divBreadcrumbs = breadcrumbs[0].getElementsByTagName("a");
		if (divBreadcrumbs != null) {
			for (var i=1; i< divBreadcrumbs.length; i++){
				var currentChild = divBreadcrumbs[i];
				var childItem = document.createElement("div");
				if (i == divBreadcrumbs.length-1) childItem.className = "active";
				else childItem.className = "";
				currentBC.appendChild(childItem);
				var anchor = document.createElement("a");
				anchor.href = currentChild.href;
				anchor.target = "ContentViewFrame";
				anchor.appendChild(document.createTextNode($(currentChild).text()));
				childItem.appendChild(anchor);
				if (i < (divBreadcrumbs.length-1)) {
					var arrowIcon = document.createElement("span");
					arrowIcon.className = "uiIconMiniArrowRight";
					currentBC.appendChild(arrowIcon);
				}				
			}
		}
		while(breadcrumbs[0].hasChildNodes()){
			breadcrumbs[0].removeChild(breadcrumbs[0].lastChild);
		}
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


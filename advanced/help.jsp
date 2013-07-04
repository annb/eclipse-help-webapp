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
	WebappPreferences prefs = data.getPrefs();
%>

<html lang="<%=ServletResources.getString("locale", request)%>">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=ServletResources.getString("Help", request)%></title>
<script language="JavaScript">
<%-- map of maximize listener functions indexed by name --%>
var maximizeListeners=new Object();
var isRestored = false;
function registerMaximizeListener(name, listener){
	maximizeListeners[name]=listener;
}
function notifyMaximizeListeners(maximizedNotRestored){
	for(i in maximizeListeners){
		try{
			maximizeListeners[i](maximizedNotRestored);
		}catch(exc){}
	}
}
<%-- vars to keep track of frame sizes before max/restore --%>
var leftCols = "<%=isRTL?"73%":"25%"%>";
var centerCols = "2%";
var rightCols = "<%=isRTL?"25%":"73%"%>";
<%--
param title "" for content frame
--%>
function toggleFrame(title)
{
	var frameset = document.getElementById("helpFrameset");
	var navFrameSize = frameset.getAttribute("cols");
	var left = navFrameSize.split(",")[0];
	var right = navFrameSize.split(",")[2];

	if (left == "*" || right == "*") {
		// restore frames
		frameset.frameSpacing="3";
		frameset.setAttribute("cols", leftCols+","+centerCols+","+rightCols);
		isRestored = true;
		notifyMaximizeListeners(false);
	} else {

<%
if(isRTL) {
%>
			frameset.setAttribute("cols", "98%,2%,*");
<%
} else {
%>
			frameset.setAttribute("cols", "*,2%,98%");
<%
}
%>	
		isRestored = false;
		frameset.frameSpacing="0";
		frameset.setAttribute("border", "0");
		notifyMaximizeListeners(true);
	}
}
</script>
</head>

<frameset
<% 
if (data.isIE()) {
%> 
	style="border-top: 0px solid <%=prefs.getToolbarBackground()%>;"
	style="border-right: 4px solid <%=prefs.getToolbarBackground()%>;"
	style="border-bottom: 4px solid <%=prefs.getToolbarBackground()%>;"
	style="border-left: 4px solid <%=prefs.getToolbarBackground()%>;"
<%
}
%> 
    id="helpFrameset" cols="<%=isRTL?"73%,2%,25%":"25%,2%,73%"%>" framespacing="0" border="0"  frameborder="0"   scrolling="no" bordercolor="#FFFFFF">
<%
if (isRTL) {
%>
   	<frame name="ContentFrame" title="<%=ServletResources.getString("ignore", "ContentFrame", request)%>" class="content" src='<%="content.jsp"+UrlUtil.htmlEncode(data.getQuery())%>' marginwidth="0" marginheight="0" scrolling="no" frameborder="0" resize=no>
	<frame name="ResizeBarFrame" title="Resize Bar Frame" src="resizebar.jsp" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" resize=no>
   	<frame class="nav" name="NavFrame" title="<%=ServletResources.getString("ignore", "NavFrame", request)%>" src='<%="nav.jsp"+UrlUtil.htmlEncode(data.getQuery())%>' marginwidth="0" marginheight="0" scrolling="no" frameborder="0" resize=no>
<%
} else {
%>
   	<frame class="nav" name="NavFrame" title="<%=ServletResources.getString("ignore", "NavFrame", request)%>" src='<%="nav.jsp"+UrlUtil.htmlEncode(data.getQuery())%>' marginwidth="0" marginheight="0" scrolling="no" frameborder="0" resize=no>
	<frame name="ResizeBarFrame" title="Resize Bar Frame" src="resizebar.jsp" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" resize=no>
   	<frame name="ContentFrame" title="<%=ServletResources.getString("ignore", "ContentFrame", request)%>" class="content" src='<%="content.jsp"+UrlUtil.htmlEncode(data.getQuery())%>' marginwidth="0" marginheight="0" scrolling="no" frameborder="0" resize=no>
<%
}
%>
</frameset>

</html>


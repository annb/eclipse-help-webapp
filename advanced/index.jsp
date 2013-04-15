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
	// Initiate test for persisted cookies
	if(data.getMode() == LayoutData.MODE_INFOCENTER){
		Cookie cookieTest=new Cookie("cookiesEnabled", "yes");
		cookieTest.setMaxAge(365*24*60*60);
		response.addCookie(cookieTest);
	}
%>

<html lang="<%=ServletResources.getString("locale", request)%>">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<noscript>
<meta HTTP-EQUIV="REFRESH" CONTENT="0;URL=index.jsp?noscript=1">
</noscript>
<title><%=data.getWindowTitle()%></title>
<jsp:include page="livehelp_js.jsp"/>

<style type="text/css">
FRAMESET {
	border: 0px;
}
</style>

<script language="JavaScript">

function onloadHandler(e)
{
<%
if (data.isMozilla()){
// restore mozilla from minimized
%>
	window.focus();
<%
}
%>
    /*try {
	    window.HelpToolbarFrame.frames["SearchFrame"].document.getElementById("searchWord").focus();
	} catch (e) {
	}*/

	//alert(topic);
}

</script>
<script language="javascript" src="advanced/jquery.js"></script>
<script language="JavaScript">
$(window).bind("load", function() {
	var breadcrumbs = window.HelpFrame.ContentFrame.ContentViewFrame.document.getElementsByClassName("help_breadcrumbs");
	var currentBC = window.HelpToolbarFrame.SearchFrame.document.getElementById("newBreadcrumbs");
	if ((breadcrumbs != null) && (breadcrumbs.length != 0)) {
		var divBreadcrumbs = breadcrumbs[0].getElementsByTagName("a");
		if (divBreadcrumbs != null) {
			for (var i=1; i< divBreadcrumbs.length; i++){
				var currentChild = divBreadcrumbs[i];
				var childItem = document.createElement("div");
				//if (i == divBreadcrumbs.length-1) childItem.className = "active";
				//else childItem.className = "";
				childItem.className="";
				currentBC.appendChild(childItem);
				//if ((i!=1)) {
					var arrowIcon = document.createElement("span");
					arrowIcon.className = "uiIconMiniArrowRight";
					currentBC.appendChild(arrowIcon);
				//}
				var anchor = document.createElement("a");
				anchor.href = currentChild.href;
				anchor.appendChild(document.createTextNode($(currentChild).text()));
				childItem.appendChild(anchor);
			}
			//var topicUrl = window.location.href;
			//var slash = topicUrl.lastIndexOf("2F");
			//var topic = topicUrl.substr(slash+2);
			//topic = topic.substr(0, topic.length-5);
			//var topicUrl ="<%=topic%>";
			//alert(topicUrl);
			var lastTopic = document.createElement("div");
			lastTopic.className = "active";
			var lastTopicAnchor = document.createElement("a");
			lastTopicAnchor.href ="#";
			var topicTitle = window.HelpFrame.NavFrame.ViewsFrame.toc.tocViewFrame.document.getElementById("selectedTopicTitle").innerHTML;
			//window.HelpFrame.NavFrame.ViewsFrame.toc.tocViewFrame.document.getElementById("selectedTopicTitle").innerHTML);
			//var topicTitle = getAnchorTitle(topicUrl);
			//alert(topicTitle);
			//lastTopicAnchor.appendChild(document.createTextNode(topicTitle));
			//lastTopic.appendChild(lastTopicAnchor);
			//currentBC.appendChild(lastTopic);
		}
		while( breadcrumbs[0].hasChildNodes() ){
			breadcrumbs[0].removeChild(breadcrumbs[0].lastChild);
		}
	}
});

//function getAnchorTitle(anchorHref){
	//var anchors = window.HelpFrame.NavFrame.ViewsFrame.toc.tocViewFrame.document.getElementById("tree_root").getElementsByClassName("active");
	//alert(anchors.length);
	//for (var i=0; i<anchors.length; i++){
		//alert(anchors[i].href);
		//if (anchors[i].href.indexOf(anchorHref.substr(2)) != -1) {
		//	alert(anchors[i].title);
		//	return anchors[i].title;
		//}
	//}
	//return null;
//}
</script>

</head>

<frameset id="indexFrameset" onload="onloadHandler()" rows="60,55,*"  frameborder="0" framespacing="0" border=0 spacing=0>
<%
	if(!("0".equals(data.getBannerHeight()))){
%>
	<frame name="BannerFrame" title="<%=ServletResources.getString("Banner", request)%>" src='<%=data.getBannerURL()%>'  tabIndex="3" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize=0>
<%
	}
%>
	<frame name="HelpToolbarFrame" title="<%=ServletResources.getString("ignore", "HelpToolbarFrame", request)%>" src='<%="advanced/helpToolbar.jsp"+UrlUtil.htmlEncode(data.getQuery())%>' marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize=0>
	<frame name="HelpFrame" title="<%=ServletResources.getString("ignore", "HelpFrame", request)%>" src='<%="advanced/help.jsp"+UrlUtil.htmlEncode(data.getQuery())%>' marginwidth="0" marginheight="0" scrolling="no" frameborder="0" >
</frameset>

</html>


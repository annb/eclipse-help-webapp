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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<noscript>
<meta HTTP-EQUIV="REFRESH" CONTENT="0;URL=index.jsp?noscript=1">
</noscript>
<title><%=data.getWindowTitle()%></title>
<jsp:include page="livehelp_js.jsp"/>
<script language="javascript" src="advanced/jquery.js"></script>

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
}
//var listDoc = window.HelpFrame.NavFrame.ViewsFrame.toc.tocViewFrame.document.getElementById("listOfDocs");
//var divDoc = window.HelpFrame.NavFrame.ViewsFrame.toc.tocViewFrame.document.getElementById("select_doc");

/*$(function(){

	$('html').click(function(event){
		$(listDoc).hide();
	});
	$(divDoc).click(function(event){
		event.stopPropagation();
	});
});*/
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


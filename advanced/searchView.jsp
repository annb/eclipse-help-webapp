<%--
 Copyright (c) 2000, 2011 IBM Corporation and others.
 All rights reserved. This program and the accompanying materials 
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html
 
 Contributors:
     IBM Corporation - initial API and implementation
--%>
<%@ include file="header.jsp"%>

<% 
	SearchData data = new SearchData(application, request, response);
	Cookie[] cookies = request.getCookies();
	String scope = "";
	for (int i = 0; i < cookies.length; i++) {
		if (cookies[i].getName().contains("scope")) scope = cookies[i].getValue();
	}
	WebappPreferences prefs = data.getPrefs();
%>

<html lang="<%=ServletResources.getString("locale", request)%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<title><%=ServletResources.getString("SearchResults", request)%></title>

<style type="text/css">
<%@ include file="searchList.css"%>
</style>


<base target="ContentViewFrame">
<script language="JavaScript" src="utils.js"></script>
<script language="JavaScript" src="list.js"></script>
<script language="JavaScript" src="view.js"></script>
<script language="JavaScript">	

var cookiesRequired = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("cookiesRequired", request))%>";	
var showCategories = <%=data.isShowCategories()%>;
var scope ="<%=UrlUtil.JavaScriptEncode(data.getScope())%>";

function toggleFrameLink(){
	// get to the frameset
	var p = parent;
	while (p && !p.toggleFrame)  {	   
	    if (p === p.parent)  {
	        return;
        }
		p = p.parent;
	}
	
	if (p!= null){
		p.toggleFrameLink('');
	}

	//document.selection.clear;	
}

function refresh() { 
	window.location.replace("searchView.jsp?<%=UrlUtil.JavaScriptEncode(request.getQueryString())%>");
}

function isShowDescriptions() {
	var value = getCookie("showDescriptions");
	return value ? value == "true" : true;
}

function setShowCategories(value) { 	    
	parent.searchToolbarFrame.setButtonState("show_categories", value);
	var searchWord = "<%=UrlUtil.JavaScriptEncode(data.getSearchWord())%>";
	    window.location="searchView.jsp?searchWord=" + encodeURIComponent(searchWord) 
	       + "&showSearchCategories=" + value +
	       "&scope=" + encodeURIComponent(scope);    
}



function setShowDescriptions(value) {
	setCookie("showDescriptions", value);
	var newValue = isShowDescriptions();   	
	parent.searchToolbarFrame.setButtonState("show_descriptions", newValue);
	if (value != newValue) {
	    alert(cookiesRequired);
	} else { 
	    setCSSRule(".description", "display", value ? "block" : "none");
	}
}

function toggleShowCategories() {
	setShowCategories(!showCategories);
}

function toggleShowDescriptions() {
	setShowDescriptions(!isShowDescriptions());
}

function onShow() { 
}
</script>


</head>

<body dir="<%=direction%>">
<%
	String preResults = data.getPreProcessorResults();

	if (!preResults.equals(""))
	{
		out.write(preResults);
		out.write("<HR/>");
	}


if (!data.isSearchRequest()) {
	out.write(ServletResources.getString("doSearch", request));
} else if (data.getQueryExceptionMessage()!=null) {
	out.write(data.getQueryExceptionMessage());
} else if (data.isProgressRequest()) {
%>
<center>
<table border='0'>
	<tr><td><div style="font-size: 13px"><%=ServletResources.getString("Indexing", request)%></div></td></tr>
	<tr><td align='<%=isRTL?"RIGHT":"LEFT"%>'>
		<div class='index'>
			<div id='divProgress' style='width:<%=data.getIndexedPercentage()%>px;'></div>
		</div>
	</td></tr>
	<tr><td><div style="font-size: 13px;"><%=data.getIndexedPercentage()%>% <%=ServletResources.getString("complete", request)%></div></td></tr>
	<tr><td><div style="font-size: 13px;"><br><%=ServletResources.getString("IndexingPleaseWait", request)%></div></td></tr>
</table>
</center>
<script language='JavaScript'>
setTimeout('refresh()', 2000);
</script>
</body>
</html>

<%
	return;
} else if (data.getResultsCount() == 0){
	out.write(UrlUtil.htmlEncode(data.getNotFoundMessage()));   
    if (data.isScopeActive()) {
%>
<a class="showall" onclick="showAll();" ><%=ServletResources.getString("showAllLink", request)%></a>
<%
    }
} else {
	//String matchResult = UrlUtil.htmlEncode(data.getMatchesInScopeMessage());	
	int resultFound = 0;
	for (int topic = 0; topic < data.getResultsCount(); topic++)
	{
	    if (data.getTopicHref(topic).contains(scope)) {
		resultFound ++;
		}
	}
	if (resultFound ==0){
		%>
<table>
	<tr>
		<td width="85%"><span><b><%=data.getNotFoundMessage()%></b></span></td>
		<td class="showall" width="10%"><a onclick="backToContent();" title="Back to Content"></a></td>
	</tr>
<table>
		<%
	}
	else{
	//int f = matchResult.indexOf("All topics");
	//String newResult = matchResult.substring(0, f);
	String newResult = resultFound +"";
	String scopeLabel = "";
	if (scope.contains("PLF43")) 
		{scopeLabel = "eXo Platform 4.3";}	
	else if (scope.contains("PLF42")) 
		{scopeLabel = "eXo Platform 4.2";}	
	else if (scope.contains("PLF41")) 
		{scopeLabel = "eXo Platform 4.1";}	
	else if (scope.contains("PLF40")) 
		{scopeLabel = "eXo Platform 4.0";}
	else if(scope.contains("PLF35")) 
		{scopeLabel = "eXo Platform 3.5";}
	newResult += " matches in "+scopeLabel;			
%>
<table>
	<tr>
		<td width="85%"><span><b><%=newResult%></b></span></td>
		<td class="showall" width="10%"><a onclick="backToContent();" title="Back to Content"></a></td>
	</tr>
<table>
	<%}%>
<table class="results" cellspacing='0'>

<%
	String oldCat = null;
	for (int topic = 0; topic < data.getResultsCount(); topic++)
	{
	    if (data.getTopicHref(topic).contains(scope)) {
		if(data.isActivityFiltering() && !data.isEnabled(topic)){
			continue;
		}

		String cat = data.getCategoryLabel(topic);
		if (data.isShowCategories() && cat != null
				&& (oldCat == null || !oldCat.equals(cat))) {
%>

</table>
<table class="category" cellspacing='0'>
	<tr class='list' id='r<%=topic%>c'>
		<td>
			<a href="<%=UrlUtil.htmlEncode(data.getCategoryHref(topic))%>"
					id="a<%=topic%>c"'
					class="link"
					onmouseover="showStatus(event);return true;"
					onmouseout="clearStatus();return true;"
						>
				<%=UrlUtil.htmlEncode(cat)%>
			</a>
		</td>
	</tr>
</table>
<table class="results" cellspacing='0'>

<%
			oldCat = cat;
		}
%>

<tr class='list' id='r<%=topic%>'>
	<td class='icon'>

<%
		boolean isPotentialHit = data.isPotentialHit(topic);
		if (isPotentialHit) {
%>


	<img src="<%=prefs.getImagesDirectory()%>/d_topic.gif" alt=""/>

<%
		}
		else {
%>

	<img src="<%=prefs.getImagesDirectory()%>/topic.gif" alt=""/>

<%
		}
%>

	</td>
	<td align='<%=isRTL?"right":"left"%>'>
		<a class='link' id='a<%=topic%>' 
		   href="<%=UrlUtil.htmlEncode(data.getTopicHref(topic))%>" 
		   onmouseover="showStatus(event);return true;"
		   onmouseout="clearStatus();return true;"
		   onclick="toggleFrameLink(); return true;"
		   title="<%=data.getTopicTocLabel(topic)%>">

<%
		String label = null;
		if (isPotentialHit) {
            label = ServletResources.getString("PotentialHit", data.getTopicLabel(topic), request);
        }
        else {
            label = data.getTopicLabel(topic);
        }
%>

        <%=label%></a>
	</td>
</tr>

<%
		String desc = data.getTopicDescription(topic);
		if (desc!=null) {
%>
<tr id='d<%=topic%>'>
	<td class='icon'>
	</td>
	<td align='<%=isRTL?"right":"left"%>'>
		<div class="description">
			<%=desc%>
		</div>
	</td>
</tr>
<%
		}
	    }
	}
%>
</table>

<%
}
%>

<script language="JavaScript">
	selectTopicById('<%=UrlUtil.JavaScriptEncode(data.getSelectedTopicId())%>');
</script>

</body>
</html>

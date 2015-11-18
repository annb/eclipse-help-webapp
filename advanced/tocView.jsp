<%--
 Copyright (c) 2000, 2010 IBM Corporation and others.
 All rights reserved. This program and the accompanying materials 
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html
 
 Contributors:
     IBM Corporation - initial API and implementation
--%>
<%@ include file="../advanced/header.jsp"%>

<% 
	RequestData requestData = new RequestData(application,request, response);
	WebappPreferences prefs = requestData.getPrefs();
	SearchData searchData = new SearchData(application,request, response);
%>

<html lang="<%=ServletResources.getString("locale", request)%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title><%=ServletResources.getString("Content", request)%></title>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/global.css" rel="stylesheet">
	<script language="JavaScript" src="jquery.js"></script>
<style type="text/css">
	.hidden {
		display: none;
	}
	.h {
		visibility: hidden;
	}
	.topic a {
		background: url('images/container_topic.gif') no-repeat scroll left top transparent;
		padding-left: 20px;
	}
	.topic a:hover {
		background: url('images/container_topic_hover.gif') no-repeat scroll left top transparent;
		padding-left: 20px;
	}
	.leaf a {
		background: url('images/topic.gif') no-repeat scroll left top transparent;
		padding-left: 20px;
	}
	.leaf a:hover {
		background: url('images/topic_hover.gif') no-repeat scroll left top transparent;
		padding-left: 20px;
	}
	a.active {
		font-weight: bold;
	}
</style>  
    
<base target="ContentViewFrame">
<script language="JavaScript" src="helptree.js"></script>
<script language="JavaScript" src="helptreechildren.js"></script>
<script language="JavaScript" src="xmlajax.js"></script>
<script language="JavaScript" src="utils.js"></script>
<script language="JavaScript" src="tocTree.js"></script>
<script language="JavaScript" src="view.js"></script>
<script language="JavaScript" src="jquery.js"></script>

<script language="JavaScript">

// Preload images
var imagesDirectory = "<%=prefs.getImagesDirectory()%>";
minus = new Image();
minus.src = imagesDirectory + "/minus.gif";
plus = new Image();
plus.src = imagesDirectory + "/plus.gif";
toc_open_img = new Image();
toc_open_img.src = imagesDirectory + "/toc_open.gif";
toc_closed_img = new Image();
toc_closed_img.src = imagesDirectory + "/toc_closed.gif";
folder_img = new Image();
folder_img.src = imagesDirectory + "/container_obj.gif";
folder_topic = new Image();
folder_topic.src = imagesDirectory + "/container_topic.gif";
topic_img = new Image();
topic_img.src = imagesDirectory + "/topic.gif";

var altTopic = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("altTopic", request))%>";
var altContainer = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("altContainer", request))%>";
var altContainerTopic = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("altContainerTopic", request))%>";
var altBookClosed = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("bookClosed", request))%>";
var altBookOpen = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("bookOpen", request))%>";
var altPlus = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("expandTopicTitles", request))%>";
var altMinus = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("collapseTopicTitles", request))%>";
var loadingMessage = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("Loading", request))%>";
var cookiesRequired = "<%=UrlUtil.JavaScriptEncode(ServletResources.getString("cookiesRequired", request))%>";

var isIE = navigator.userAgent.indexOf('MSIE') != -1;
var isRTL = <%=isRTL%>;

var tocTitle = "";
var tocId = "";

$(function(){
	$("#listOfDocs").hover(function(){
		$("#listOfDocs").show();
	},
	function(){
		$("#listOfDocs").hide();
	});
	
	/*$("#tree_root").live("mouseover", ".selector", function(){
		$("#tree_root").html($(this).closest("img").attr("src"));
	});*/
});

/*function onHover(obj){
	var oldSrc = obj.src;
	if (oldSrc.indexOf("container") != -1) obj.src = imagesDirectory + "/container_topic_hover.gif";
	else obj.src = imagesDirectory + "/topic-hover.gif";
}

function offHover(obj){
	var oldSrc = obj.src;
	if (oldSrc.indexOf("container") != -1) obj.src = imagesDirectory + "/container_topic.gif";
	else obj.src = imagesDirectory + "/topic.gif";
}*/

function openDropBox() {
  var docsList = document.getElementById("listOfDocs");
  docsList.style.display = "block";
}

function selectDoc(e, selected)
{
  e = e||window.event;
  e.cancelBubble=!0;
  var parentDiv = document.getElementById("select_doc");
  var selectedDoc = selected.firstChild.data;
  document.getElementById("currentItem").innerHTML = selectedDoc;
  document.getElementById("listOfDocs").style.display = "none";
  document.getElementById("tree_root").innerHTML = "";

  if (selectedDoc.indexOf("4.3") != -1) {  
  	document.cookie = "scope=PLF43";
	loadSelectedDoc("/PLF43/toc.xml");
  } 
  else if (selectedDoc.indexOf("4.2") != -1) {  
  	document.cookie = "scope=PLF42";
	loadSelectedDoc("/PLF42/toc.xml");
  } 		
  else if (selectedDoc.indexOf("4.1") != -1) {  
  	document.cookie = "scope=PLF41";
	loadSelectedDoc("/PLF41/toc.xml");
  } 	
  else if (selectedDoc.indexOf("4.0") != -1) {
  	document.cookie = "scope=PLF40";
	loadSelectedDoc("/PLF40/toc.xml");
  } 
  else if (selectedDoc.indexOf("3.5") != -1) {
  	document.cookie = "scope=PLF35";
	loadSelectedDoc("/PLF35/toc.xml");
  }
}
	
function onloadHandler()
{
	setRootAccessibility();
	// fix IE8 javascript can not use innerHeight
	//document.getElementById("wai_application").style.minHeight = (window.innerHeight - 43) + "px";
	// Set prefix for AJAX calls by removing tocView.jsp from location
	var locationHref = window.location.href;
	if (locationHref.indexOf("PLF43") != -1) {
		loadSelectedDoc("/PLF43/toc.xml");
		document.getElementById("currentItem").innerHTML = "eXo Platform 4.3";
		document.cookie = "scope=PLF43";
	} 
	else if (locationHref.indexOf("PLF42") != -1) {
		loadSelectedDoc("/PLF42/toc.xml");
		document.getElementById("currentItem").innerHTML = "eXo Platform 4.2";
		document.cookie = "scope=PLF42";
	} 
	else if (locationHref.indexOf("PLF41") != -1) {
		loadSelectedDoc("/PLF41/toc.xml");
		document.getElementById("currentItem").innerHTML = "eXo Platform 4.1";
		document.cookie = "scope=PLF41";
	} 	
	else if (locationHref.indexOf("PLF40") != -1) {
		loadSelectedDoc("/PLF40/toc.xml");
		document.getElementById("currentItem").innerHTML = "eXo Platform 4.0";
		document.cookie = "scope=PLF40";
	}
	else if (locationHref.indexOf("PLF35") != -1) {
		loadSelectedDoc("/PLF35/toc.xml");
		document.getElementById("currentItem").innerHTML = "eXo Platform 3.5";
		document.cookie = "scope=PLF35";
	} 
    var slashAdvanced = locationHref.lastIndexOf('/tocView.jsp');
    if(slashAdvanced > 0) {
	    setAjaxPrefix(locationHref.substr(0, slashAdvanced));
	}
<%
    if (request.getParameter("topic") != null) {
        TocData data = new TocData(application,request, response);
	    if (data.getSelectedToc() != -1) {
%>
	var tocTopic = "<%=UrlUtil.JavaScriptEncode(data.getTocDescriptionTopic(data.getSelectedToc()))%>";
	var topicSelected=false;
	// select specified topic, or else the book
	var topic = "<%=UrlUtil.JavaScriptEncode(data.getSelectedTopic())%>";
	if (topic != "about:blank" && topic != tocTopic) {
		if (topic.indexOf(window.location.protocol) != 0 && topic.length > 2) {
			// remove the .. from topic
			topic = topic.substring(2);
			// remove advanced/tocView.jsp from path to obtain contextPath
			var contextPath = window.location.pathname;
			var slash = contextPath.lastIndexOf('/');
			if(slash > 0) {
				slash = contextPath.lastIndexOf('/', slash-1);
				if(slash >= 0) {
					contextPath = contextPath.substr(0, slash);
					topic = window.location.protocol + "//" +window.location.host + contextPath + topic;
				}
			}			
		}
		topicSelected = selectTopic(topic);
	} 
<%
	    }
	} else if (!"true".equalsIgnoreCase(request.getParameter("collapse"))) {
%>   
        if (isAutosynchEnabled()) {
	        selectTopic("<%=prefs.getHelpHome()%>", true);
	    }
<%
	} 
%>
}

function onunloadHandler() {
<%
// for large books, we want to avoid a long unload time
if (requestData.isIE()){
%>
	document.body.innerHTML = "";
<%
}
%>
}
</script>

</head>
<body dir="<%=direction%>" onload="onloadHandler()" onunload="onunloadHandler()">
<%
    if (searchData.isScopeActive()) {
%>
<p>
<%= UrlUtil.htmlEncode(searchData.getScopeActiveMessage()) %>
<a class="showall" onclick="showAll();" ><%=ServletResources.getString("showAllLink", request)%></a>
</p>
<%
    }
%>
<div id="selectedTopicTitle" style="display: none"></div>
<div style="width: 100%">
		<div class="leftBar">
			<div class="uiBox">
				<div id = "wai_application" class="uiContentBox">
					<div id="select_doc" class="btn-group uiDropdownWithIcon" onclick="openDropBox();">
							<div data-toggle="dropdown" class="btn dropdown-toggle">		
								<span id="currentItem"></span>		
								<i class="spiter"></i>
								<i class="caret"></i>
							</div>
							<ul id="listOfDocs" role="menu" class="dropdown-menu">	
								<li>							
									<a href="../topic/PLF43/home.html" target="_top" class="OptionItem" onclick="selectDoc(event,this);">eXo Platform 4.3</a>
								</li> 
								<li>							
									<a href="../topic/PLF42/home.html" target="_top" class="OptionItem" onclick="selectDoc(event,this);">eXo Platform 4.2</a>
								</li> 
								<li>							
									<a href="../topic/PLF41/home.html" target="_top" class="OptionItem" onclick="selectDoc(event,this);">eXo Platform 4.1</a>
								</li>    
								<li>							
									<a href="../topic/PLF40/home.html" target="_top" class="OptionItem" onclick="selectDoc(event,this);">eXo Platform 4.0</a>
								</li>
								<li>							
									<a href="../topic/PLF35/home.html" target="_top" class="OptionItem" onclick="selectDoc(event,this);">eXo Platform 3.5</a>
								</li>
							</ul>
					</div>
					<!--begin tree-->					
					<div id="tree_root" class="root" aria-expanded="true">
					</div>
				</div>
			</div>
		</div>
</div>
</body>
</html>

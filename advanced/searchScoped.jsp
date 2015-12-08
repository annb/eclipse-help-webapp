<%--
 Copyright (c) 2000, 2010 IBM Corporation and others.
 All rights reserved. This program and the accompanying materials 
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html
 
 Contributors:
     IBM Corporation - initial API and implementation    
     Pierre Candela  - fix for Bug 194911
--%>
<%@ include file="header.jsp"%>

<% 
	SearchData data = new SearchData(application, request, response);
	WebappPreferences prefs = data.getPrefs();
%>


<html lang="<%=ServletResources.getString("locale", request)%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title><%=ServletResources.getString("SearchLabel", request)%></title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/global.css" />
<script language="JavaScript" src="jquery.js"></script>
<script language="JavaScript">
$(function(){
	$("#settingButton").hover(function(){
		$("#settingButton").show();
	},
	function(){
		$("#settingButton").hide();
	});
});


function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
    }
    return "";
}

function printContent(button, param){
	try {
		parent.parent.parent.HelpFrame.ContentFrame.ContentViewFrame.focus();
		parent.parent.parent.HelpFrame.ContentFrame.ContentViewFrame.print();
	} catch(e) {}	
}

var isIE = navigator.userAgent.indexOf('MSIE') != -1;
var isMozilla = navigator.userAgent.toLowerCase().indexOf('mozilla') != -1 && parseInt(navigator.appVersion.substring(0,1)) >= 5;

var isTablet = false;
if($(window).width() < 1023){
	isTablet = true;
}


var advancedDialog;

function openAdvanced() 
{ 
    var workingSet = "All topics";
    var minSize = 300; 
    var maxHeight= 500;  
    var maxWidth = 600;       
    var w = minSize; 
    var h = minSize; 
      
    // If we have large fonts make the dialog larger, up to 500 pixels high, 600 wide
    try {         
        var letterHeight = document.getElementById("searchWord").offsetHeight; 
        var requiredSize = 16 * letterHeight; 
        if (requiredSize > minSize) { 
            if (requiredSize < maxWidth) { 
                w = requiredSize; 
            } else { 
                w =  maxWidth; 
            }
            if (requiredSize < maxHeight) { 
                h = requiredSize; 
            } else {               
                h = maxHeight;
            }
        } 
             
    } catch (e) {} 
    
<%
if (data.isIE()){
%>
	var l = parent.screenLeft + (parent.document.body.clientWidth - w) / 2;
	var t = parent.screenTop + (parent.document.body.clientHeight - h) / 2;
<%
} else {
%>
	var l = parent.screenX + (parent.innerWidth - w) / 2;
	var t = parent.screenY + (parent.innerHeight - h) / 2;
<%
}
%>
	// move the dialog just a bit higher than the middle
	if (t-50 > 0) t = t-50;
	
	window.location="javascript://needModal";
	advancedDialog = window.open("workingSetManager.jsp?workingSet="+encodeURIComponent(workingSet), "advancedDialog", "resizable=yes,height="+h+",width="+w+",left="+l+",top="+t );
	advancedDialog.focus(); 
}

function closeAdvanced()
{
	try {
		if (advancedDialog)
			advancedDialog.close();
	}
	catch(e) {}
}

/**
 * This function can be called from this page or from
 * the advanced search page. When called from the advanced
 * search page, a query is passed.
 * noRefocus is a boolean which if true suppresses
 * switch of focus to the search view
 */
function doSearch(query, noRefocus)
{
	var workingSet = "All topics";


	var form = document.forms["searchForm"];
	var searchWord = form.searchWord.value;
  var maxHits = form.maxHits.value;


	if (!searchWord || searchWord == "")
		return;
	query ="searchWord="+encodeURIComponent(searchWord)+"&maxHits="+maxHits;
	if (workingSet != '<%=UrlUtil.JavaScriptEncode(ServletResources.getString("All", request))%>')
		query = query +"&scope="+encodeURIComponent(workingSet);

		
  var isComeFromHomePage = getCookie("isComeFromHomePage") ;
  if (isComeFromHomePage == "ok"){
    form.submit();
		var searchView = parent.parent.HelpFrame.NavFrame.ViewsFrame.search.searchViewFrame;
		searchView.location.replace("searchView.jsp?"+query);
		//fix for Firefox
		document.cookie = "isComeFromHomePage=; expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/docs/";
		//fix for Chrome
    		document.cookie = "isComeFromHomePage=; expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/docs";
 //   document.cookie = "scope=; expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/public/advanced";
    }

	/******** HARD CODED VIEW NAME *********/
	// do some tests to ensure the results are available
	if (parent.parent.HelpFrame && 
		parent.parent.HelpFrame.NavFrame && 
		parent.parent.HelpFrame.NavFrame.showView &&
		parent.parent.HelpFrame.NavFrame.ViewsFrame && 
		parent.parent.HelpFrame.NavFrame.ViewsFrame.search && 
		parent.parent.HelpFrame.NavFrame.ViewsFrame.search.searchViewFrame) 
	{
	    if (!noRefocus) {
		    parent.parent.HelpFrame.NavFrame.showView("search");
		}
		var searchView = parent.parent.HelpFrame.NavFrame.ViewsFrame.search.searchViewFrame;
		searchView.location.replace("searchView.jsp?"+query);
	}


	if(isTablet){
		document.cookie = "valueSearchMobile="+searchWord+"; path=/";	
	}





}

function getSearchWord() {
    var form = document.forms["searchForm"];
    var searchWord = form.searchWord.value;
    if (searchWord ) {
        return searchWord;
    }
    return "";
}

function rescope() {
    if (parent.parent.HelpFrame && 
		parent.parent.HelpFrame.NavFrame && 
		parent.parent.HelpFrame.NavFrame.ViewsFrame) {
		var viewsFrame = parent.parent.HelpFrame.NavFrame.ViewsFrame;
		if (viewsFrame.toc && viewsFrame.toc.tocViewFrame) {
		    var tocView = viewsFrame.toc.tocViewFrame;
		    tocView.repaint();
		}
		if (viewsFrame.index && viewsFrame.index.indexViewFrame) {
		    var indexView = viewsFrame.index.indexViewFrame;
		    indexView.repaint();
		}
		doSearch(null, true);
	}
}

function fixHeights()
{
	if (!isIE) return;
	
	var h = document.getElementById("searchWord").offsetHeight;
	document.getElementById("go").style.height = h;
}

function openDropBox() {
  var docsList = document.getElementById("settingButton");
  docsList.style.display = "block";
}

function onloadHandler(e)
{
	      var form = document.forms["searchForm"];
        var isComeFromHomePage = getCookie("isComeFromHomePage") ;
        if (isComeFromHomePage == "ok"){
	        form.searchWord.value = getCookie("searchValue");    
          doSearch();
        }
        else{
	        form.searchWord.value = '<%=UrlUtil.JavaScriptEncode(data.getSearchWord())%>';
	        fixHeights();
        <%
            if (data.isScopeRequest() && RequestScope.filterBySearchScope(request)) {
        %>
            rescope();
        <%}
        %>
        }
}

</script>

</head>

<body dir="<%=direction%>" onload="onloadHandler()"  onunload="closeAdvanced()">

<div  class="uiGrayLightBox searchBar clearfix">
	<div class="pull-right actionBar">
		<!--div class="pull-right setting dropdown"  onclick="openDropBox();">
			 <a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="uiIconSetting"></i> 
				<span class="caret"></span>
			 </a>
			<ul id="settingButton" class="dropdown-menu">
				 <li><a href="http://community.exoplatform.com/portal/classic/documentation-public" target="_top" tabindex="-1">HTML Version</a></li>
				<li class="divider"></li>
				<li><a id="printButton" href="javascript:printContent('printButton','');" tabindex="-1">Print Page</a></li>
			</ul>
		</div-->
		<a class="btn btn-primary" target="_blank" href="http://community.exoplatform.com/portal/intranet/downloads"><i class="uiIconDownload uiIconWhite"></i> PDF</a>		
	</div>
	
	<div class="uiSearchForm uiSearchInput">
		<input id="searchScope" type="hidden" name="Scope" value="" >
		<form  name="searchForm"   onsubmit="doSearch();">
			<div>
				<input type="text" id="searchWord" name="searchWord" alt="<%=UrlUtil.htmlEncode(ServletResources.getString("expression_label", request))%>" 
					       title="<%=UrlUtil.htmlEncode(ServletResources.getString("expression_label", request))%>">
				<a href="javascript:void(0);" class="search-button" onclick="doSearch();">search</a>
				<input type="hidden" name="maxHits" value="500" >
			</div>
		</form>
	</div>
	<div id="newBreadcrumbs" class="breadcrumb"></div>

</div>
</body>
</html>


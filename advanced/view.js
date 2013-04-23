/*******************************************************************************
 * Copyright (c) 2010, 2011 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials 
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/

// Contains functions used by more than one view

function showAll() {
    var searchFrame = parent.parent.parent.parent.parent.HelpToolbarFrame.SearchFrame;
    if (searchFrame.getSearchWord) {
        searchFrame.location.replace("../scopeState.jsp?searchWord=" + searchFrame.getSearchWord() + "&workingSet=");
    }      
}

function rescope() {
    var searchFrame = parent.parent.parent.parent.parent.HelpToolbarFrame.SearchFrame;
    if (searchFrame.getSearchWord) {
        searchFrame.openAdvanced();
    }      
}

function backToContent(){
    parent.parent.parent.parent.parent.HelpFrame.NavFrame.showView("toc");
    var searchInput = parent.parent.parent.parent.parent.HelpToolbarFrame.SearchFrame.document.getElementById("searchWord");
    searchInput.value="";
}

function synchWithToc(){
	try {
		parent.parent.parent.parent.parent.HelpFrame.NavFrame.displayTocFor(getCurrentTopic(), false);
	} catch(e) {}
    	//var searchInput = parent.parent.parent.parent.parent.HelpToolbarFrame.SearchFrame.document.getElementById("searchWord");
    	//searchInput.value="";
}

function getCurrentTopic() {
    var topic = parent.parent.parent.parent.parent.HelpFrame.ContentFrame.ContentViewFrame.window.location.href;
	// remove the query, if any
	var i = topic.indexOf('?');
	if (i != -1) {
		topic = topic.substring(0, i);
	}
	return topic;
}

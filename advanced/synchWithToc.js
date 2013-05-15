/*******************************************************************************
 * Copyright (c) 2007 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials 
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
 
 /*if (parent.ContentToolbarFrame && parent.ContentToolbarFrame.autosynch) {
     parent.ContentToolbarFrame.autosynch();
 }*/

function synchWithToc(){
	try {
		parent.parent.HelpFrame.NavFrame.displayTocFor(getCurrentTopic(), false);
	} catch(e) {}
}

function getCurrentTopic() {
    var topic = parent.parent.HelpFrame.ContentFrame.ContentViewFrame.window.location.href;
	// remove the query, if any
	var i = topic.indexOf('?');
	if (i != -1) {
		topic = topic.substring(0, i);
	}
	return topic;
}

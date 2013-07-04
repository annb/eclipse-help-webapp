<%--
 Copyright (c) 2000, 2010 IBM Corporation and others.
 All rights reserved. This program and the accompanying materials 
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html
 
 Contributors:
     IBM Corporation - initial API and implementation
--%>
<%@ include file="header.jsp"%>

<jsp:include page="toolbar.jsp">
	<jsp:param name="script" value="navActions.js"/>
	<jsp:param name="view" value="toc"/>

	<jsp:param name="name"     value="toggle_highlight"/>
	<jsp:param name="tooltip"  value='highlight_tip'/>
	<jsp:param name="image"    value="highlight.gif"/>
	<jsp:param name="action"   value="toggleHighlight"/>
	<jsp:param name="param"    value=""/>
	<jsp:param name="state"    value='hidden'/>	

</jsp:include>
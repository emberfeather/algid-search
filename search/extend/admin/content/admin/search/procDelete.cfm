<!--- Redirect to the list page if no collection chosen --->
<cfif theUrl.search('collection') eq ''>
	<cfset theURL.setRedirect('_base', '/admin/search/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<cfset servCollection = services.get('search', 'collection') />

<!--- Retrieve the object --->
<cfset collection = servCollection.getCollection(theURL.search('collection')) />

<!--- Run the delete --->
<cfset servCollection.deleteCollection(collection) />

<!--- Redirect --->
<cfset theURL.setRedirect('_base', '/admin/search') />
<cfset theURL.redirectRedirect() />

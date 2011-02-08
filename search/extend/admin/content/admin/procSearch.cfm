<!--- Redirect to the list page if no collection chosen --->
<cfif theUrl.search('collection') eq ''>
	<cfset theURL.setRedirect('_base', '/admin/search/list') />
	<cfset theURL.redirectRedirect() />
</cfif>

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cfset theURL.redirect() />
</cfif>

<cfset servCollection = services.get('search', 'collection') />

<!--- Retrieve the object --->
<cfset collection = servCollection.getCollection(theURL.search('collection')) />

<!--- Add to the current levels --->
<cfset template.addLevel(collection.getName(), collection.getName(), theUrl.get(), 0, true) />

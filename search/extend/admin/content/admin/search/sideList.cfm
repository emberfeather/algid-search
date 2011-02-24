<cfset viewCollection = views.get('search', 'collection') />

<cfset filter = {
	'language' = theURL.search('language'),
	'search' = theURL.search('search')
} />

<!--- Check for no specified language --->
<cfif filter.language eq ''>
	<cfset filter.language = 'english' />
</cfif>

<cfoutput>
	#viewCollection.filter( filter )#
</cfoutput>

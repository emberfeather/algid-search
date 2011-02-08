<cfset viewCollection = views.get('search', 'collection') />

<cfset filter = {
	'search' = theURL.search('search')
} />

<cfoutput>
	#viewCollection.filterSearch( filter )#
</cfoutput>

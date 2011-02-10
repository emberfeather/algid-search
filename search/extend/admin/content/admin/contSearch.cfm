<cfif filter.search neq ''>
	<cfset results = servCollection.searchCollection(collection, filter) />
	
	<cfoutput>
		#viewCollection.displayResults( results )#
	</cfoutput>
<cfelse>
	<cfoutput>
		#viewCollection.overview( collection )#
	</cfoutput>
</cfif>

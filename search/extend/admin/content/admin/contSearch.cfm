<cfif filter.search neq ''>
	<cfdump var="#servCollection.searchCollection(collection, filter)#" />
</cfif>

<cfoutput>
	#viewCollection.overview( collection )#
</cfoutput>

<cfset collections = servCollection.getCollections(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(collections.recordcount, session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, collections, viewCollection, paginate, filter)#</cfoutput>

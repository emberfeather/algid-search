component extends="plugins.widget.inc.resource.base.widget" {
	public component function init(required struct transport) {
		super.init(arguments.transport);
		
		preventCaching();
		
		return this;
	}
	
	public string function process( required string content, required struct args ) {
		local.pathParts = explodePath(variables.path);
		local.servCollection = getService('search', 'collection');
		local.viewCollection = getView('search', 'collection');
		
		local.options = variables.extend({ term: 'term' }, arguments.args);
		
		theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		
		// Want to have a url to the search results
		if(variables.transport.theCgi.request_method == 'post') {
			theUrl.setRedirect('_base', getBasePath() & '/' & form[local.options.term]);
			theUrl.redirectRedirect();
		}
		
		if(arrayLen(local.pathParts)) {
			local.collection = servCollection.getCollection(local.options.collection);
			
			if(local.collection.getName() == '') {
				return 'Search collection not found.';
			}
			
			local.results = local.servCollection.searchCollection( local.collection, { search: local.pathParts[1] } );
			
			if(local.results.recordCount == 1) {
				// TODO Remove when RAILO-1180 is fixed
				local.base = right(local.results.url, len(local.results.url) - 3);
				
				theUrl.cleanRedirect();
				theUrl.setRedirect('_base', local.base);
				theUrl.redirectRedirect();
			}
			
			return local.viewCollection.displayResults( local.results );
		}
		
		return '';
	}
}

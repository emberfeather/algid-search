component extends="algid.inc.resource.base.service" {
	public component function getCollection(required string name) {
		local.collection = getModel('search', 'collection');
		
		collection name="local.results" action="list";
		
		query name="local.results" dbtype="query" {
			writeOutput('SELECT * FROM local.results WHERE name = ');
			queryparam value="#arguments.name#" cfsqltype="cf_sql_varchar";
		}
		
		if (local.results.recordCount) {
			local.modelSerial = variables.transport.theApplication.factories.transient.getModelSerial(variables.transport);
			local.collection = modelSerial.deserialize(local.results, local.collection, true, true)
		}
		
		return local.collection;
	}
	
	public query function getCollections(struct filter = {}) {
		collection name="local.results" action="list";
		
		query name="local.results" dbtype="query" {
			writeOutput('SELECT * FROM local.results WHERE 1 = 1 ');
			
			if( structKeyExists(arguments.filter, 'search') and arguments.filter.search neq '') {
				writeOutput('AND (');
				
				writeOutput('name LIKE ');
				queryparam value="%#arguments.filter.search#%" cfsqltype="cf_sql_varchar";
				
				writeOutput('OR path LIKE ');
				queryparam value="%#arguments.filter.search#%" cfsqltype="cf_sql_varchar";
				
				writeOutput(') ');
			}
			
			if( structKeyExists(arguments.filter, 'language') and arguments.filter.language neq '') {
				writeOutput('AND language = ');
				queryparam value="#arguments.filter.language#" cfsqltype="cf_sql_varchar";
				
				writeOutput(' ');
			}
		}
		
		return local.results;
	}
	
	public query function searchCollection(required component collection, struct filter = {}) {
		local.observer = getPluginObserver('search', 'collection');
		
		// Trigger the before search event
		local.observer.beforeSearch(variables.transport, arguments.collection, arguments.filter);
		
		search collection="#arguments.collection.getName()#" name="local.results" criteria="#arguments.filter.search#";
		
		// Trigger the after search event
		local.observer.afterSearch(variables.transport, arguments.collection, arguments.filter);
		
		return local.results;
	}
	
	public void function updateCollection(required component collection) {
		local.observer = getPluginObserver('search', 'collection');
		
		// Actual plugins in charge of what/how they want to index information
		local.observer.onUpdate(variables.transport, arguments.collection);
	}
}

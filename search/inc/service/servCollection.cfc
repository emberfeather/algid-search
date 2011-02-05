component extends="algid.inc.resource.base.service" {
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
}

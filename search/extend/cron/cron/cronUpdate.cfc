component extends="plugins.cron.inc.resource.base.cron" {
	public void function execute(struct options = {}) {
		local.servCollection = getService('search', 'collection');
		
		local.collections = local.servCollection.getCollections({});
		
		// Update each collection
		for(local.i = 1; local.i <= local.collections.recordCount; local.i++) {
			// Retrieve the object
			local.collection = servCollection.getCollection(local.collections.name[local.i]);
			
			// Run the indexing
			servCollection.updateCollection(collection);
		}
	}
}

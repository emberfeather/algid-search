component extends="algid.inc.resource.base.service" {
	public query function getCollections(struct filter = {}) {
		collection name="local.results" action="list";
		
		return local.results;
	}
}

component extends="algid.inc.resource.base.event" {
	public void function afterDelete( required struct transport, required component collection ) {
		// Log the event
		local.eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		local.eventLog.logEvent('search', 'deleteCollection', 'Deleted the ''' & arguments.collection.getName() & ''' collection.');
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('Deleted the ''' & arguments.collection.getName() & ''' collection.');
	}
	
	public void function afterOptimize( required struct transport, required component collection ) {
		// Log the event
		local.eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		local.eventLog.logEvent('search', 'optimizeCollection', 'Optimized the ''' & arguments.collection.getName() & ''' collection.');
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('Optimized the ''' & arguments.collection.getName() & ''' collection.');
	}
	
	public void function afterRepair( required struct transport, required component collection ) {
		// Log the event
		local.eventLog = arguments.transport.theApplication.managers.singleton.getEventLog();
		local.eventLog.logEvent('search', 'repairCollection', 'Repaired the ''' & arguments.collection.getName() & ''' collection.');
		
		// Add success message
		arguments.transport.theSession.managers.singleton.getSuccess().addMessages('Repaired the ''' & arguments.collection.getName() & ''' collection.');
	}
}

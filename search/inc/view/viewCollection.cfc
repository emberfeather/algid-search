<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="addCollection" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagrid = '' />
		<cfset var i18n = '' />
		
		<cfset arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL() />
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.theSession.managers.singleton.getSession().getLocale()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset datagrid.addBundle('plugins/search/i18n/inc/view', 'viewCollection') />
		
		<cfset datagrid.addColumn({
				key = 'collection',
				label = 'collection'
			}) />
		
		<cfset datagrid.addColumn({
				key = 'directory',
				label = 'directory'
			}) />
		
		<cfset datagrid.addColumn({
				class = 'phantom align-right',
				value = [ 'add' ],
				link = [
					{
						'plugin' = 'plugin',
						'collectionDirectory' = 'collectionDirectory',
						'_base' = '/admin/search/collection/add'
					}
				]
			}) />
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
	</cffunction>
	
	<cffunction name="filterActive" access="public" returntype="string" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var filterActive = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filterActive = variables.transport.theApplication.factories.transient.getFilterActive(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filterActive.addBundle('plugins/search/i18n/inc/view', 'viewCollection') />
		
		<cfreturn filterActive.toHTML(arguments.filter, variables.transport.theRequest.managers.singleton.getURL(), 'search') />
	</cffunction>
	
	<cffunction name="filter" access="public" returntype="string" output="false">
		<cfargument name="values" type="struct" default="#{}#" />
		
		<cfset var filter = '' />
		<cfset var i = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		<cfset var languages = [
			{
				label: 'Arabic',
				value: 'arabic'
			},
			{
				label: 'Norwegian (Bokmal)',
				value: 'bokmal'
			},
			{
				label: 'Czech',
				value: 'czech'
			},
			{
				label: 'Danish',
				value: 'danish'
			},
			{
				label: 'Dutch',
				value: 'dutch'
			},
			{
				label: 'English',
				value: 'english'
			},
			{
				label: 'Finnish',
				value: 'finnish'
			},
			{
				label: 'French',
				value: 'french'
			},
			{
				label: 'German',
				value: 'german'
			},
			{
				label: 'Greek',
				value: 'greek'
			},
			{
				label: 'Hebrew',
				value: 'hebrew'
			},
			{
				label: 'Hungarian',
				value: 'hungarian'
			},
			{
				label: 'Italian',
				value: 'italian'
			},
			{
				label: 'Japanese',
				value: 'japanese'
			},
			{
				label: 'Korean',
				value: 'korean'
			},
			{
				label: 'Korean',
				value: 'korean'
			},
			{
				label: 'Norwegian',
				value: 'norwegian'
			},
			{
				label: 'Norwegian (Nynorsk)',
				value: 'nynorsk'
			},
			{
				label: 'Polish',
				value: 'polish'
			},
			{
				label: 'Portuguese',
				value: 'portuguese'
			},
			{
				label: 'Russian',
				value: 'russian'
			},
			{
				label: 'Chinese (simplified)',
				value: 'simplified_chinese'
			},
			{
				label: 'Spanish',
				value: 'spanish'
			},
			{
				label: 'Swedish',
				value: 'swedish'
			},
			{
				label: 'Chinese (traditional)',
				value: 'traditional_chinese'
			},
			{
				label: 'Turkish',
				value: 'turkish'
			}
		] />
		
		<cfset filter = variables.transport.theApplication.factories.transient.getFilterVertical(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filter.addBundle('plugins/search/i18n/inc/view', 'viewCollection') />
		
		<!--- Search --->
		<cfset filter.addFilter('search') />
		
		<!--- Language --->
		<cfset options = variables.transport.theApplication.factories.transient.getOptions() />
		
		<cfloop array="#languages#" index="i">
			<cfset options.addOption(i.label, i.value) />
		</cfloop>
		
		<cfset filter.addFilter('language', options) />
		
		<cfreturn filter.toHTML(variables.transport.theRequest.managers.singleton.getURL(), arguments.values) />
	</cffunction>
	
	<cffunction name="datagrid" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagrid = '' />
		<cfset var i18n = '' />
		
		<cfset arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL() />
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.theSession.managers.singleton.getSession().getLocale()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset datagrid.addBundle('plugins/search/i18n/inc/view', 'viewCollection') />
		
		<cfset datagrid.addColumn({
			key = 'name',
			label = 'collection'
		}) />
		
		<cfset datagrid.addColumn({
			key = 'language',
			label = 'language'
		}) />
		
		<cfset datagrid.addColumn({
			class = 'phantom align-right',
			value = [ 'delete', 'edit' ],
			link = [
				{
					'collection' = 'collectionID',
					'_base' = '/admin/search/delete'
				},
				{
					'collection' = 'collectionID',
					'_base' = '/admin/search/edit'
				}
			],
			linkClass = [ 'delete', '' ],
			title = 'name'
		}) />
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
	</cffunction>
</cfcomponent>

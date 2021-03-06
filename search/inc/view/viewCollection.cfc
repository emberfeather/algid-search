<cfcomponent extends="algid.inc.resource.base.view" output="false">
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
			label = 'collection',
			link = {
				'collection' = 'name',
				'_base' = '/admin/search'
			}
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
					'collection' = 'name',
					'_base' = '/admin/search/delete'
				},
				{
					'collection' = 'name',
					'_base' = '/admin/search/edit'
				}
			],
			linkClass = [ 'delete', '' ],
			title = 'name'
		}) />
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
	</cffunction>
	
	<cffunction name="displayResults" access="public" returntype="string" output="false">
		<cfargument name="results" type="query" required="true" />
		
		<cfset local.theUrl = variables.transport.theRequest.managers.singleton.getURL() />
		
		<cfset local.theUrl.cleanResult() />
		
		<cfsavecontent variable="local.html">
			<cfoutput>
				<ul>
					<cfloop query="arguments.results">
						<!--- TODO Remove when RAILO-1180 is fixed --->
						<cfset local.base = right(arguments.results.url, len(arguments.results.url) - 3) />
						<cfset local.theUrl.setResult('_base', local.base) />
						
						<li><a href="#local.theUrl.getResult()#">#arguments.results.title#</a></li>
					</cfloop>
					
					<cfif not results.recordCount>
						<li><strong>No results found</strong></li>
					</cfif>
				</ul>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn local.html />
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
	
	<cffunction name="filterSearch" access="public" returntype="string" output="false">
		<cfargument name="values" type="struct" default="#{}#" />
		
		<cfset var filter = '' />
		<cfset var i = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filter = variables.transport.theApplication.factories.transient.getFilterVertical(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filter.addBundle('plugins/search/i18n/inc/view', 'viewCollection') />
		
		<!--- Search --->
		<cfset filter.addFilter('search') />
		
		<cfreturn filter.toHTML(variables.transport.theRequest.managers.singleton.getURL(), arguments.values) />
	</cffunction>
	<cfscript>
	public string function overview(required component collection) {
		var html = '';
		var theUrl = '';
		
		theUrl = variables.transport.theRequest.managers.singleton.getUrl();
		
		html = '<dl class="navigation">';
		
		theUrl.setSection('_base', '/admin/search/optimize');
		
		html &= '<dt><a href="' & theUrl.getSection() & '">Optimize</a></dt>';
		html &= '<dd>Optimize the search collection.</dd>';
		
		theUrl.setSection('_base', '/admin/search/purge');
		
		html &= '<dt><a href="' & theUrl.getSection() & '">Purge</a></dt>';
		html &= '<dd>Purge the search collection.</dd>';
		
		theUrl.setSection('_base', '/admin/search/repair');
		
		html &= '<dt><a href="' & theUrl.getSection() & '">Repair</a></dt>';
		html &= '<dd>Repair the search collection.</dd>';
		
		theUrl.setSection('_base', '/admin/search/update');
		
		html &= '<dt><a href="' & theUrl.getSection() & '">Update</a></dt>';
		html &= '<dd>Update the search collection.</dd>';
		
		html &= '</dl>';
		
		return html;
	}
	</cfscript>
</cfcomponent>

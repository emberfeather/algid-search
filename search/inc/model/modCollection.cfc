component extends="algid.inc.resource.base.model" {
	public component function init(required component i18n, string locale = 'en_US') {
		super.init(arguments.i18n, arguments.locale);
		
		// Categories
		add__attribute(
			attribute = 'categories'
		);
		
		// Charset
		add__attribute(
			attribute = 'charset'
		);
		
		// Created
		add__attribute(
			attribute = 'created'
		);
		
		// Document Count
		add__attribute(
			attribute = 'doccount'
		);
		
		// External
		add__attribute(
			attribute = 'external'
		);
		
		// Language
		add__attribute(
			attribute = 'language'
		);
		
		// Last Modified
		add__attribute(
			attribute = 'lastModified'
		);
		
		// Mapped
		add__attribute(
			attribute = 'mapped'
		);
		
		// Name
		add__attribute(
			attribute = 'name'
		);
		
		// Online
		add__attribute(
			attribute = 'online'
		);
		
		// Path
		add__attribute(
			attribute = 'path'
		);
		
		// Registered
		add__attribute(
			attribute = 'registered'
		);
		
		// Size
		add__attribute(
			attribute = 'size'
		);
		
		// Set the bundle information for translation
		add__bundle('plugins/search/i18n/inc/model', 'modCollection');
		
		return this;
	}
}

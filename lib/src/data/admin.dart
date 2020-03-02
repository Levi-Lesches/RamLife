import "package:flutter/foundation.dart";

import "times.dart";

/// Scopes for administrative privileges.
/// 
/// [Admin] users use these scopes ([Admin.scopes]) to determine what they can 
/// access and/or modify.
enum Scope {
	/// The admin can access and modify the calendar.
	calendar, 

	/// The admin can access and modify student schedules.
	schedule
}

/// Maps Strings to their respective [Scope]s.
const Map<String, Scope> stringToScope = {
	"calendar": Scope.calendar,
	"schedule": Scope.schedule,
};

/// Maps [Scope]s to Strings. 
const Map<Scope, String> scopeToString = {
	Scope.calendar: "calendar",
	Scope.schedule: "schedule",
};

/// A system administrator. 
/// 
/// Based on the scopes granted to them, they can 
/// access and/or modify data not normally visible/modifiable to all users.
@immutable
class Admin {
	/// A list of scopes available to this user. 
	final List<Scope> scopes;

	/// A list of custom-made [Special]s by this admin. 
	/// 
	/// These can be saved so the admin does not have to recreate them. 
	final List<Special> specials;

	/// Creates a user with administrative privileges. 
	const Admin ({
		this.scopes, 
		this.specials
	});

	/// Creates an admin from a JSON entry. 
	Admin.fromJson(Map<String, dynamic> json) :
		scopes = [
			for (dynamic scope in json ["scopes"])
				stringToScope [scope]
		],
		specials = [
			for (dynamic special in json ["specials"])
				Special.fromJson (Map<String, dynamic>.from(special))
		];

	/// Converts an admin to JSON form. 
	Map<String, dynamic> toJson() => {
		"scopes": [
			for (final Scope scope in scopes)
				scopeToString [scope]
		],
		"specials": [
			for (final Special special in specials)
				special.toJson(),
		]
	};
}
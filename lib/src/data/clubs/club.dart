import "package:meta/meta.dart";

import "../contact_info.dart";
import "message.dart";

/// Creates a T from a JSON. 
typedef JsonBuilder<T> = T Function(Map<String, dynamic>);

/// Returns a list of objects from a list of JSON. 
/// 
/// This function needs a constructor to work. Until 
/// [constructor tear-offs](https://github.com/dart-lang/language/issues/216) 
/// are supported, you can use a function that uses a constructor, or a static 
/// method as a tear-off. 
List<T> fromList<T>(List json, JsonBuilder<T> builder) => [
	for (final dynamic entryJson in json) 
		builder(Map<String, dynamic>.from(entryJson))
];

class Club {
	final String id;
	final String name;
	final String description;
	final String shortDescription;
	final String imageUrl;
	final bool isActive;
	final Set<String> tags;
	final String formUrl;
	final bool phoneNumberRequested;

	final ContactInfo facultyAdvisor;
	final List<ContactInfo> captains;
	final List<ContactInfo> members;
	final List<Message> messages;
	final Map<String, int> attendance;

	/// Creates a club. 
	/// 
	/// When creating a club, the faculty advisor is not needed -- it can be 
	/// assigned later by a club creator. [formUrl] can also be null.  
	Club({
		@required this.id,
		@required this.name,
		@required this.description,
		@required this.shortDescription,
		@required this.imageUrl,
		@required this.isActive,
		@required this.tags,
		@required this.phoneNumberRequested,
		@required this.captains,
		this.formUrl,
		this.facultyAdvisor,
	}) : 
		members = [],
		messages = [],
		attendance = {};

	/// Creates a club from a JSON object.
	Club.fromJson(Map<String, dynamic> json) : 
		id = json ["id"],
		name = json ["name"],
		description = json ["description"],
		shortDescription = json ["shortDescription"],
		imageUrl = json ["imageUrl"],
		isActive = json ["isActive"],
		tags = Set<String>.from(json ["tags"]),
		formUrl = json ["formUrl"],
		phoneNumberRequested = json ["phoneNumberRequested"],
		facultyAdvisor = ContactInfo.fromJson(
			Map<String, dynamic>.from(json ["faculty"])
		),
		captains = fromList<ContactInfo>(json ["captains"], ContactInfo.fromJson),
		members = fromList<ContactInfo>(json ["members"], ContactInfo.fromJson),
		messages = fromList<Message>(json ["messages"], Message.fromJson),
		attendance = Map<String, int>.from(json ["attendance"]);
}

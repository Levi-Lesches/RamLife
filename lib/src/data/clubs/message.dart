import "package:meta/meta.dart";

import "../contact_info.dart";

class Message {
	// ignore: prefer_constructors_over_static_methods
	static Message fromJson(Map<String, dynamic> json) => Message( 
		sender: ContactInfo.fromJson(
			Map<String, dynamic>.from(json ["sender"])
		),
		timestamp: DateTime.parse(json ["timestamp"]),
		body: json ["body"],
	);

	ContactInfo sender;
	DateTime timestamp;
	String body;

	Message({
		@required this.sender,
		@required this.timestamp,
		@required this.body,
	});

}

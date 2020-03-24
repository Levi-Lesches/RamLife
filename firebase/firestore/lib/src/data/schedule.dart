import "package:meta/meta.dart";

import "package:firestore/helpers.dart";

import "letters.dart";

@immutable
/// Tracks if a section meets in a semester.
class Semesters {
	/// Whether this section meets in the first semester.
	final bool semester1;

	/// Whether this section meets in the second semester.	
	final bool semester2;

	/// Creates a container for semester data.
	const Semesters({
		@required this.semester1, 
		@required this.semester2,
		String sectionID
	}) : assert (
		semester1 != null && semester2 != null, 
		"Could not read semester data for $sectionID"
	);
}

/// A class section.
/// 
/// Classes are split into courses, which hold descriptive data about the 
/// course itself. Courses are split into one or more sections, which hold
/// data specific to that section, such as the teacher or roster list. 
@immutable
class Section extends Serializable {
	/// The name of this section.
	final String name;

	/// The section ID for this class
	final String id;

	/// The teacher for this section.
	final String teacher;

	/// Creates a section. 
	const Section({
		@required this.name, 
		@required this.id, 
		@required this.teacher,
	}) : 
		assert(
			name != null && id != null && teacher != null,
			"Could not read section data for $id"
		);

	@override
	Map<String, dynamic> get json => {
		"name": name,
		"teacher": teacher,
	};
}

@immutable
/// A period in the day. 
class Period extends Serializable {
	/// THe room this period is located in.
	final String room;

	/// The section ID for this period.
	final String id;

	/// The day this period takes place.
	final Letter day;

	/// The period number.
	final int period;

	/// Creates a period.
	const Period({
		@required this.room, 
		@required this.id,
		@required this.day,
		@required this.period,
	}) : 
		assert(
			day != null && period != null,
			"Could not read period data for $id"
		),
		assert(
			(id == null) == (room == null), 
			"If ID is null, room must be (and vice versa). $day, $period, $id"
		);

	@override
	Map<String, dynamic> get json => {
		"room": room,
		"id": id,
	};
}

import "dart:io";
export "dart:io";

/// The project directory.
final Directory projectDir = Directory.current;

class DataFiles {
	/// The data directory.
	static final Directory dataDir = 
		Directory("${projectDir.parent.parent.path}\\data");

	/// The courses database. 
	/// 
	/// Contains the names of every course, but requires a course ID, not 
	/// a section ID. 
	static final String courses = "${dataDir.path}\\courses.csv";
	
	/// The faculty database.
	/// 
	/// Contains the names, emails, and IDs of every faculty member. 
	static final String faculty = "${dataDir.path}\\faculty.csv";

	/// The schedule database. 
	/// 
	/// Contains a list pairing each student ID to multiple section IDs. 
	static final String schedule = "${dataDir.path}\\schedule.csv";

	/// The sections database.
	/// 
	/// Contains the teachers of every section, along with other useful data.
	static final String section = "${dataDir.path}\\section.csv";

	/// The periods database.
	/// 
	/// Contains each period every section meets. 
	static final String sectionSchedule = "${dataDir.path}\\section_schedule.csv";

	/// The students database. 
	/// 
	/// Contains the names, emails, and IDs of every student.
	static final String students = "${dataDir.path}\\students.csv";
}
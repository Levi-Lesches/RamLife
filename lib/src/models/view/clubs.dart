import "package:ramaz/data.dart";
import "package:ramaz/models.dart";
import "package:ramaz/services.dart";

abstract class ClubsModel {
	User user;
	void registerForClub(Club club);
	void unregisterFromClub(Club club);
	void email(ContactInfo contact);

	void init() {
		user = Models.instance.user.data;
	}

	Future<List<Club>> getAllClubs() async {
		// Step 1. Get the raw JSON. 
		// Step 2. Turn them into a list of clubs
		final List<Map<String, dynamic>> rawJson = 
			await Services.instance.database.getAllClubs();

		final List<Club> result = [];
		for (final Map<String, dynamic> json in rawJson) {
			result.add(Club.fromJson(json));
		}
		return result;
	}	
}

abstract class ClubAdminsModel {
	Club club;

	void markMeetingAsSpecial(DateTime date);
	void rescheduleMeeting(DateTime from, DateTime to);
	void postMessage(String message);
	void createClub();
	void approveClub();
	void emailAll();
}
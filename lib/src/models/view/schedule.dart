import "package:flutter/foundation.dart" show ChangeNotifier;

import "package:ramaz/data.dart";
import "package:ramaz/models.dart";

/// A view model for the schedule page. 
// ignore: prefer_mixin
class ScheduleModel with ChangeNotifier {
	/// The default [Special] for the UI.
	static const Special defaultSpecial = Special.covid;

	/// The default [Day] for the UI.
	Day defaultDay;

	/// The schedule data model.
	/// 
	/// Used to retrieve the schedule for a given day.
	final Schedule schedule;

	/// The day whose schedule is being shown in the UI.
	Day day;

	/// The selected date from the calendar. 
	/// 
	/// The user can select a date from the calendar and, if there is school 
	/// that day, have their schedule be shown to them.
	DateTime _selectedDay = DateTime.now();

	/// Initializes the view model. 
	/// 
	/// Also initializes the default day shown to the user. 
	/// If today is a school day, then use that. Otherwise, use the 
	/// defaults (see [defaultSpecial]).
	ScheduleModel () : schedule = Models.instance.schedule {
		day = schedule.hasSchool
			? schedule.today
			: defaultDay;
		defaultDay = Day(
			name: schedule.user.schedule.keys.first, 
			special: defaultSpecial
		);
	}

	/// Attempts to set the UI to the schedule of the given day. 
	/// 
	/// If there is no school on that day, then [ArgumentError] is thrown.
	set date (DateTime date) {
		// Get rid of time
		final DateTime justDate = DateTime.utc (
			date.year, 
			date.month,
			date.day
		);
		final Day selected = Day.getDate(schedule.calendar, justDate);
		if (!selected.school) {
			throw Exception("No School");
		}
		day = selected;
		_selectedDay = justDate;
		update (newName: selected.name, newSpecial: selected.special);
	}

	/// Gets the date whose schedule the user is looking at
	DateTime get date => _selectedDay;

	/// Updates the UI to a new day given a new dayName or special.
	/// 
	/// If the dayName is non-null, the special defaults to [defaultSpecial].
	void update({String newName, Special newSpecial}) {
		String name  = day.name;
		if (newName != null) {
			name = newName;
			day = Day(name: name, special: defaultSpecial);
			notifyListeners();
		} 
		if (newSpecial != null) {
			day = Day (name: name, special: newSpecial);
			notifyListeners();
		}
	}
}

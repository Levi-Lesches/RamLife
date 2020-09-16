import "dart:async" show runZoned;

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/foundation.dart" show kDebugMode;

import "package:ramaz/constants.dart";  // for route keys
import "package:ramaz/models.dart";
import "package:ramaz/pages.dart";
import "package:ramaz/services.dart";
import "package:ramaz/widgets.dart" show ThemeChanger;

Future<void> main({bool restart = false}) async {
	// This shows a splash screen but secretly 
	// determines the desired `platformBrightness`
	Brightness brightness;
	runZoned(
		() => runApp (
			SplashScreen(
				setBrightness: 
					(Brightness platform) => brightness = platform
			)
		),
		onError: Crashlytics.recordError,
	);
	await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

	// This initializes services -- it is always safe. 
	await Services.init();
	bool isReady;
	try {
		isReady = await Services.instance.isReady;
		// Checks whther services are ready -- REALLY shouldn't error, but might
		if (isReady) {
			// This initializes data models -- it may error. 
			await Models.init();
		}
	// We want to at least try again on ANY error. 
	// ignore: avoid_catches_without_on_clauses
	} catch (_) {
		debugPrint("Error on main.");
		if (!restart && !kDebugMode) {
			debugPrint("Trying again...");
			await Services.instance.reset();
			return main(restart: true);
		} else {
			rethrow;
		}
	}

	// Determine the appropriate brightness. 
	final bool savedBrightness = Services.instance.prefs.brightness;
	if (savedBrightness != null) {
		brightness = savedBrightness
			? Brightness.light
			: Brightness.dark;
	}

	// Now we are ready to run the app (with error catching)
	FlutterError.onError = Crashlytics.recordFlutterError;
	runZoned(
		() => runApp (
			RamazApp (
				isReady: isReady,
				brightness: brightness,
			)
		),
		onError: Crashlytics.recordError,
	);
}

/// The main app widget. 
class RamazApp extends StatelessWidget {
	final bool isReady;

	/// The brightness to default to. 
	final Brightness brightness;

	/// Creates the main app widget.
	const RamazApp ({
		@required this.brightness,
		@required this.isReady,
	});

	@override 
	Widget build (BuildContext context) => ThemeChanger(
		defaultBrightness: brightness,
		light: ThemeData (
			brightness: Brightness.light,
			primarySwatch: Colors.blue,
			primaryColor: RamazColors.blue,
			primaryColorBrightness: Brightness.dark,
			primaryColorLight: RamazColors.blueLight,
			primaryColorDark: RamazColors.blueDark,
			accentColor: RamazColors.gold,
			accentColorBrightness: Brightness.light,
			cursorColor: RamazColors.blueLight,
			textSelectionHandleColor: RamazColors.blueLight,
			buttonColor: RamazColors.gold,
			buttonTheme: const ButtonThemeData (
				buttonColor: RamazColors.gold,
				textTheme: ButtonTextTheme.normal,
			),
		),
		dark: ThemeData(
			brightness: Brightness.dark,
			scaffoldBackgroundColor: Colors.grey[850],
			primarySwatch: Colors.blue,
			primaryColorBrightness: Brightness.dark,
			primaryColorLight: RamazColors.blueLight,
			primaryColorDark: RamazColors.blueDark,
			accentColor: RamazColors.goldDark,
			accentColorBrightness: Brightness.light,
			iconTheme: const IconThemeData (color: RamazColors.goldDark),
			primaryIconTheme: const IconThemeData (color: RamazColors.goldDark),
			accentIconTheme: const IconThemeData (color: RamazColors.goldDark),
			floatingActionButtonTheme: const FloatingActionButtonThemeData(
				backgroundColor: RamazColors.goldDark,
				foregroundColor: RamazColors.blue
			),
			cursorColor: RamazColors.blueLight,
			textSelectionHandleColor: RamazColors.blueLight,
			cardTheme: CardTheme (
				color: Colors.grey[820]
			),
			toggleableActiveColor: RamazColors.blueLight,
			buttonColor: RamazColors.blueDark,
			buttonTheme: const ButtonThemeData (
				buttonColor: RamazColors.blueDark, 
				textTheme: ButtonTextTheme.accent,
			),
		),
		builder: (BuildContext context, ThemeData theme) => MaterialApp (
			home: isReady ? HomePage() : Login(),
			title: "Ram Life",
			color: RamazColors.blue,
			theme: theme,
			routes: {
				Routes.login: (_) => Login(),
				Routes.home: (_) => HomePage(),
				Routes.schedule: (_) => SchedulePage(),
				Routes.reminders: (_) => RemindersPage(),
				Routes.feedback: (_) => FeedbackPage(),
				Routes.calendar: (_) => CalendarPage(),
				Routes.specials: (_) => SpecialPage(),
				Routes.admin: (_) => AdminHomePage(),
				Routes.sports: (_) => SportsPage(),
			}
		)
	);
}

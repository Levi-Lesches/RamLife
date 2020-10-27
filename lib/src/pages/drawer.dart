// ignore_for_file: prefer_const_constructors
import "package:flutter/material.dart";

import "package:ramaz/constants.dart";  // for route names
import "package:ramaz/models.dart";
import "package:ramaz/services.dart";
import "package:ramaz/widgets.dart";

/// A drawer to show throughout the app.
class NavigationDrawer extends StatelessWidget {
	/// Uses the navigator to launch a page by name.
	static Future<void> Function() pushRoute(BuildContext context, String name) => 
		() => Navigator.of(context).pushReplacementNamed(name);

	@override Widget build (BuildContext context) => Drawer (
		child: LayoutBuilder(
			builder: (
				BuildContext context, 
				BoxConstraints constraints
			) => SingleChildScrollView(
				child: ConstrainedBox(
					constraints: BoxConstraints(
						minHeight: constraints.maxHeight,
					),
					child: IntrinsicHeight(
						child: Column(
							children: [
								DrawerHeader (child: RamazLogos.ramSquare),
								ListTile (
									title: const Text ("Home"),
									leading: Icon (Icons.home),
									onTap: pushRoute(context, Routes.home),
								),
								ListTile (
									title: const Text ("Schedule"),
									leading: Icon (Icons.schedule),
									onTap: pushRoute(context, Routes.schedule),
								),
								ListTile (
									title: const Text ("Reminders"),
									leading: Icon (Icons.note),
									onTap: pushRoute(context, Routes.reminders),
								),
								// ListTile (
								// 	title: Text ("Sports"),
								// 	leading: Icon (Icons.directions_run),
								// 	onTap: pushRoute(context, Routes.sports),
								// ),
								if (Models.instance.user.isAdmin)
									ListTile(
										title: const Text("Admin console"),
										leading: Icon(Icons.verified_user),
										onTap: pushRoute(context, Routes.admin),
									),
								BrightnessChanger.dropdown(prefs: Services.instance.prefs),
								// ListTile (
								// 	title: Text ("Newspapers (coming soon)"),
								// 	leading: Icon (Icons.new_releases),
								// 	onTap: () => Navigator.of(context).pushReplacementNamed(NEWS),
								// ),
								// ListTile (
								// 	title: Text ("Lost and Found (coming soon)"),
								// 	leading: Icon (Icons.help),
								// 	onTap: pushRoute(context, LOST_AND_FOUND)
								// ),
								// Divider(),
								ListTile (
									title: const Text ("Logout"),
									leading: Icon (Icons.lock),
									onTap: pushRoute(context, Routes.login)
								),
								ListTile (
									title: const Text ("Send Feedback"),
									leading: Icon (Icons.feedback),
									onTap: () => Navigator.of(context)
										..pop()
										..pushNamed(Routes.feedback)
								),
								const AboutListTile (
									icon: Icon (Icons.info),
									// ignore: sort_child_properties_last
									child: Text ("About"),
									applicationName: "Ramaz Student Life",
									applicationVersion: "0.5",
									applicationIcon: Logos.ramazIcon,
									aboutBoxChildren: [
										Text (
											"Created by the Ramaz Coding Club (Levi Lesches and Sophia "
											"Kremer) with the support of the Ramaz administration. "
										),
										SizedBox (height: 20),
										Text (
											"A special thanks to Mr. Vovsha for helping us go from idea to "
											"reality."
										),
									]
								),
								const Spacer(),
								Align (
									alignment: Alignment.bottomCenter,
									child: Column (
										children: [
											const Divider(),
											SingleChildScrollView (
												scrollDirection: Axis.horizontal,
												child: Row (
													children: const [
														Logos.ramazIcon,
														Logos.outlook,
														Logos.schoology,
														Logos.drive,
														Logos.seniorSystems
													]
												)
											)
										]
									)
								)
							]
						)
					) 
				)
			)
		)
	);
}

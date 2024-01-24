import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Consumer<PreferencesProvider>(
    builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                value: provider.isDarkTheme,
                onChanged: (value) {
                  provider.enableDarkTheme(value);
                },
              ),
            ),
          ),
          // Material(
          //   child: ListTile(
          //     title: const Text('Scheduling News'),
          //     trailing: Consumer<SchedulingProvider>(
          //       builder: (context, scheduled, _) {
          //         return Switch.adaptive(
          //          value: provider.isDailyNewsActive,
          //           onChanged: (value) async {
          //             if (Platform.isIOS) {
          //               customDialog(context);
          //             } else {
          //               scheduled.scheduledNews(value);
          //               provider.enableDailyNews(value);
          //             }
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      );
    },
  );
}
}

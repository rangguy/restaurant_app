import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your profile',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () => Navigation.back(),
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>()),
                  // );
                },
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildProfileInfo(),
                  const SizedBox(height: 20.0),
                  _buildSettingSection(provider),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileInfo() {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(.2),
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: BorderRadius.circular(100.0),
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.green],
              ),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                'R',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'ranggadwi100@gmail.com',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingSection(PreferencesProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettingSectionTitle(),
              const SizedBox(height: 10.0),
              _buildDarkThemeSwitch(provider),
              _buildSchedulingSwitch(provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingSectionTitle() {
    return Container(
      margin: const EdgeInsets.all(4),
      child: const Text(
        'Setting',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  Widget _buildDarkThemeSwitch(PreferencesProvider provider) {
    return ListTile(
      title: const Text('Dark Theme'),
      trailing: Switch.adaptive(
        value: provider.isDarkTheme,
        onChanged: (value) {
          provider.enableDarkTheme(value);
        },
      ),
    );
  }

  Widget _buildSchedulingSwitch(PreferencesProvider provider) {
    return ListTile(
      title: const Text('Scheduling Restaurant'),
      trailing: Consumer<SchedulingProvider>(
        builder: (context, scheduled, _) {
          return Switch.adaptive(
            value: provider.isNotifRestaurantActive,
            onChanged: (value) async {
              final result = await Permission.notification.request();
              if (result == PermissionStatus.granted) {
                scheduled.scheduledNotif(value);
                provider.enableNotifRestaurant(value);
              }
            },
          );
        },
      ),
    );
  }
}

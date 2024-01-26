import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/login_page.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _auth = FirebaseAuth.instance;
  late User? _activeUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      _activeUser = _auth.currentUser;
    } catch (e) {
      print(e);
    }
  }

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
                onPressed: () async {
                  await _auth.signOut();
                  Navigation.logout(LoginPage.routeName);
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
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                _activeUser!.email![0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _activeUser!.email!,
            style: const TextStyle(
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

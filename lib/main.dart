import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/firebase_options.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/login_page.dart';
import 'package:restaurant_app/ui/register_page.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            apiService: ApiService(Client()),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            theme: provider.themeData,
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case SplashScreen.routeName:
                  return MaterialPageRoute(
                      builder: (_) => const SplashScreen());
                case LoginPage.routeName:
                  return MaterialPageRoute(builder: (_) => const LoginPage());
                case RegisterPage.routeName:
                  return MaterialPageRoute(
                      builder: (_) => const RegisterPage());
                case HomePage.routeName:
                  return MaterialPageRoute(builder: (_) => const HomePage());
                case RestaurantDetailPage.routeName:
                  return MaterialPageRoute(
                      builder: (_) => RestaurantDetailPage(
                            id: settings.arguments as String,
                          ));
                case SearchRestaurant.routeName:
                  return MaterialPageRoute(
                      builder: (_) => SearchRestaurant(
                            search: settings.arguments as String,
                          ));
                case SettingsPage.routeName:
                  if (FirebaseAuth.instance.currentUser != null) {
                    return MaterialPageRoute(
                        builder: (_) => const SettingsPage());
                  } else {
                    return MaterialPageRoute(builder: (_) => const LoginPage());
                  }
                default:
                  return MaterialPageRoute(
                      builder: (_) => const SplashScreen());
              }
            },
          );
        },
      ),
    );
  }
}

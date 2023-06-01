import 'package:appba/assets/apba_theme/apba_theme.dart';
import 'package:appba/screens/clock_in/create_clock_in/create_clock_in.dart';
import 'package:appba/screens/login/login.dart';
import 'package:appba/screens/main_screen/main_screen.dart';
import 'package:appba/screens/notifications/create_notification/create_notification.dart';
import 'package:appba/screens/notifications/notification_list/notification_list.dart';
import 'package:appba/screens/requests/create_request/create_request.dart';
import 'package:flutter/material.dart';

import 'commons/Models/employee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APPBA',
        theme: ApbaTheme.lightTheme,
        routes: {
          '/': (context) => const Login(),
          '/mainScreen': (context) => MainScreen(
              ModalRoute.of(context)!.settings.arguments as Employee),
          '/notifications': (context) => NotificationList(
              ModalRoute.of(context)!.settings.arguments as Employee),
          '/createNotification': (context) => CreateNotification(
              ModalRoute.of(context)!.settings.arguments as Employee),
          '/createClockIn': (context) => CreateClockIn(
              ModalRoute.of(context)!.settings.arguments as Employee),
          '/createRequest': (context) => CreateRequest(
              ModalRoute.of(context)!.settings.arguments as Employee),
          //'/createNotification': (context) => const CreateNotification()
        });
  }
}

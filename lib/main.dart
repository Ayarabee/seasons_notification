import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test_notification/constant.dart';

import 'firebase_options.dart';
import 'notification_center_view.dart';

Future onBackground(RemoteMessage message) async {
  print("on background:---------- ${message.notification!.body}");
}

getMessage() {
  FirebaseMessaging.onMessage.listen((event) {
    print("hereeeeeeeeeeeeeeeeeeeeeeee");
    print(event.notification!.body);
    print(event.notification!.title);
    print(event.data['name']);
    print(event.data['lastname']);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(onBackground);
  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
    token = value;
  });
  print("////////////****************///////////");
  getMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationCenterView(),
    );
  }
}

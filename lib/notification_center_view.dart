import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_notification/constant.dart';

import 'add_data_row.dart';
import 'choose_drop_down.dart';
import 'next_button.dart';

class NotificationCenterView extends StatefulWidget {
  const NotificationCenterView({Key? key}) : super(key: key);

  @override
  State<NotificationCenterView> createState() => _NotificationCenterViewState();
}

late TextEditingController notificationTitleController;
late TextEditingController notificationMessageController;
late TextEditingController dropDownController;

class _NotificationCenterViewState extends State<NotificationCenterView> {
  final List<String> items = [
    'All users',
    'All clients',
    'All agents',
  ];
  final String serverToken =
      "AAAA4MtJ2b0:APA91bFZwXDm575c_CRJY9HuKWnPLv41e9rtQMAKznSsjvEF-Y6-9s9aqm3MWLLeWKzSve0BQ4GJwLTo_vDuwEdHilOhMOwnUeqUYyImSAhkpQuql8ydbgYNka4YteRdTcW_5unkprXp";
  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> sendNotify(String title, String body, String? token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': token.toString(),
      'status': 'done',
      'message': body.toString(),
    };
    try {
      http.Response r = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body.toString(),
              'title': title.toString(),
            },
            'priority': 'high',
            'data': data,
            'to': selectedValue == items[0]
                ? '/topics/all'
                : selectedValue == items[1]
                    ? '/topics/client'
                    : '/topics/agent',
          },
        ),
      );
      if (r.statusCode == 200) {
        print("Done********************");
      } else {
        print(r.statusCode);
      }
    } catch (e) {
      print("exception*********************** ${e.toString()}");
    }
  }

  @override
  void initState() {
    notificationMessageController = TextEditingController();
    notificationTitleController = TextEditingController();
    dropDownController = TextEditingController();
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Center(
                child: Text(
                  "Send Notification",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Choose",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ChooseDropDown(
                        items: items,
                        textEditingController: dropDownController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AddDataRow(
                controller: notificationTitleController,
                name: "Notification Title",
                width: 60,
              ),
              const SizedBox(
                height: 30,
              ),
              AddDataRow(
                  controller: notificationMessageController,
                  name: "Notification Message",
                  width: 30),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  child: NextButton(
                    text: "Next",
                    onPressed: () async {
                      await sendNotify(
                        notificationTitleController.text,
                        notificationMessageController.text,
                        token,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:math';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:rafu_store_app/GenericHelpers/common_helpers.dart';
// import 'package:rafu_store_app/Home/features/notifications/notification_provider.dart';
// import 'package:rafu_store_app/Utils/print_debug.dart';

// import '../../../GenericHelpers/petite_storage.dart';
// import '../../../main.dart';

// final FirebaseMessaging messaging =
//     FirebaseMessaging.instance;
// @pragma('vm:entry-point')
// Future<void> backgroundMessageHandler(
//     RemoteMessage message) async {
//   print("Handling a background message: ${message.data}");
//   await Firebase.initializeApp();
//   LocalNotificationService.initialize();
//   await StorageUtil.getInstance();
//   await showNotification(message);
//   print(
//       "Handling a background message: ${message.messageId}");
// }

// void registerBackgroundMessageHandler() {
//   FirebaseMessaging.onBackgroundMessage(
//       backgroundMessageHandler);
// }

// Future<void> myBackgroundMessageHandler(
//     RemoteMessage message) async {
//   // Handle background message
//   await showNotification(message);
// }

// final FlutterLocalNotificationsPlugin
//     flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// const AndroidNotificationChannel channel =
//     AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   importance: Importance.high,
// );

// Future<void> showNotification(RemoteMessage message) async {
//   logg("Remote message ${message}");
//   // RemoteNotification? notification = message.notification;
//   // AndroidNotification? android =
//   //     message.notification != null ? message.notification!.android : null;

//   if (message.data != null) {
//     // Create a new AndroidNotificationDetails object
//     final AndroidNotificationDetails
//         androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(channel.id, channel.name,
//             channelDescription: channel.description,
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');

//     // Create a new NotificationDetails object
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(
//             android: androidPlatformChannelSpecifics);
//     Random random = new Random();
//     int id = random.nextInt(1000);
//     // Show the notification
//     await flutterLocalNotificationsPlugin.show(
//         id,
//         getStringFromMap(message.data, 'title'),
//         getStringFromMap(message.data, 'message')
//             .toString(),
//         platformChannelSpecifics,
//         payload: getStringFromMap(message.data, 'body'));
//   }
// }

// // click action
// Future selectNotification(String? payload) {
//   // Handle notification tap
//   if (payload != null) {
//     logg('notification payload: $payload');
//   }
//   return Future.value(true);
// }

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initialize() {
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings(
//                 "@mipmap/launcher_icon"));
//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse
//               notificationResponse) async {
//         logg("From Res");
//         if (notificationResponse.payload != null) {
//           StorageUtil.resetpreferencedata(
//               key: 'from_notification');
//           StorageUtil.resetpreferencedata(key: 'payload');
//           StorageUtil.putString(
//               key: 'from_notification', value: 'true');

//           StorageUtil.putString(
//               key: 'payload',
//               value:
//                   jsonEncode(notificationResponse.payload));
//         }
//         // final String? payload = notificationResponse.payload;
//         // if (notificationResponse.payload != null) {
//         //   debugPrint('notification payload: $payload');
//         // }
//         // await Navigator.push(
//         //   context,
//         //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//         // );
//       },
//       // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//   }

//   static void display(RemoteMessage message) async {
//     try {
//       print("In Notification method");
//       // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
//       Random random = new Random();
//       int id = random.nextInt(1000);
//       final NotificationDetails notificationDetails =
//           const NotificationDetails(
//               android: AndroidNotificationDetails(
//         "mychanel",
//         "my chanel",
//         importance: Importance.max,
//         enableVibration: true,
//         playSound: true,
//         priority: Priority.high,
//         styleInformation: BigTextStyleInformation(''),
//       ));
//       print("my id is ${id.toString()}");
//       await _flutterLocalNotificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//       );
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//   }
// }

// RemoteNotification getNoteFrom(String title, String body) {
//   return RemoteNotification(
//     title: title,
//     titleLocArgs: ['', ''],
//     titleLocKey: '',
//     body: body,
//     bodyLocArgs: ['', ''],
//     bodyLocKey: null,
//   );
// }

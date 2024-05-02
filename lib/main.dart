import 'package:flutter/material.dart';
import 'package:prime_template/features/navigation/views/navigation.dart';
import 'package:prime_template/state_management_class.dart';

import 'utils/petite_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // LocalNotificationService.initialize();
  await StorageUtil.getInstance();
  StorageUtil.putString(key: 'permission', value: '0');
  // try {
  //   await Permission.notification.isDenied.then((value) {
  //     if (value) {
  //       Permission.notification.request();
  //       StorageUtil.putString(
  //           key: 'permission', value: '1');
  //     }
  //   });
  // } catch (e) {
  //   log("Permission Error $e");
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StateManagementClass(
      child: MaterialApp(
          title: 'Luvit Test',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
          ),
          home: const Navigation()),
    );
  }
}



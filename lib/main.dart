import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/controller/providers/chatroom_provider.dart';
import 'package:taxverse/controller/providers/gst3Provider.dart';
import 'package:taxverse/controller/providers/verification_provider.dart';
import 'package:taxverse/view/gst_registraion/verification_faille.dart';
import 'package:taxverse/view/gst_registraion/verified_success.dart';
import 'package:taxverse/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For Showing Message Notifications',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
  );
  log('Notification Channel $result');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GstThirdScreenProvider>(
          create: (context) => GstThirdScreenProvider(),
        ),
        ChangeNotifierProvider<ChatRoomProvider>(
          create: (context) => ChatRoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerificationSuccessProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.watch<AuthProvider>().stream(), initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, splashFactory: InkRipple.splashFactory),
        home: const Splash(),
      ),
    );
  }
}

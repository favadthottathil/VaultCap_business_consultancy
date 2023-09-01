import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/view/authentication/provider/auth_provider.dart';
import 'package:taxverse/view/chat/chat_provider/chatroom_provider.dart';
import 'package:taxverse/view/gst_registraion/dashboard/provider/dashboard_provider.dart';
import 'package:taxverse/view/Appoinments/provider/datetimeprovider.dart';
import 'package:taxverse/view/gst_registraion/gst_screen_3/provider/gst_3_provider.dart';
import 'package:taxverse/view/mainscreens/homescreen/provider/homescreen_provider.dart';
import 'package:taxverse/view/authentication/otp_auth/provider/otpscreen_provider.dart';
import 'package:taxverse/view/authentication/otp_auth/provider/register_phone_provider.dart';
import 'package:taxverse/controller/providers/toggle_provider.dart';
import 'package:taxverse/view/mainscreens/useraccount/provider/useraccount_provider.dart';
import 'package:taxverse/view/Appoinments/provider/verification_provider.dart';
import 'package:taxverse/view/splash/splash.dart';

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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<GstThirdScreenProvider>(
              create: (context) => GstThirdScreenProvider(),
            ),
            ChangeNotifierProvider<DateTimeProvider>(
              create: (context) => DateTimeProvider(),
            ),
            ChangeNotifierProvider<UserAccountProvider>(
              create: (context) => UserAccountProvider(),
            ),
            ChangeNotifierProvider<HomeScreenProvider>(
              create: (context) => HomeScreenProvider(),
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
            StreamProvider(create: (context) => context.watch<AuthProvider>().stream(), initialData: null),
            ChangeNotifierProvider(
              create: (context) => DashBoardProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => OtpScreenProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ToggleProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterPhoneProvider(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              splashFactory: InkRipple.splashFactory,
            ),
            home: Splash(),
          ),
        );
      },
    );
  }
}

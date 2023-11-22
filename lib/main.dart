import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vaultcap/controller/providers/toggle_provider.dart';
import 'package:vaultcap/view/Appoinments/provider/datetimeprovider.dart';
import 'package:vaultcap/view/Appoinments/provider/verification_provider.dart';
import 'package:vaultcap/view/authentication/otp_auth/provider/otpscreen_provider.dart';
import 'package:vaultcap/view/authentication/otp_auth/provider/register_phone_provider.dart';
import 'package:vaultcap/view/authentication/provider/auth_provider.dart';
import 'package:vaultcap/view/chat/chat_provider/chatroom_provider.dart';
import 'package:vaultcap/view/gst_registraion/dashboard/provider/dashboard_provider.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_3/provider/gst_3_provider.dart';
import 'package:vaultcap/view/mainscreens/homescreen/provider/homescreen_provider.dart';
import 'package:vaultcap/view/mainscreens/useraccount/provider/useraccount_provider.dart';
import 'package:vaultcap/view/splash/splash.dart';
import 'view/authentication/otp_auth/provider/otp_time_provider.dart';

void main() async {
  // Initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Register a notification channel
  await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For Showing Message Notifications',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
  );

  // Run the Flutter app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            // Providers for various parts of the app
            ChangeNotifierProvider<GstThirdScreenProvider>(create: (_) => GstThirdScreenProvider()),
            ChangeNotifierProvider<DateTimeProvider>(create: (_) => DateTimeProvider()),
            ChangeNotifierProvider<UserAccountProvider>(create: (_) => UserAccountProvider()),
            ChangeNotifierProvider<HomeScreenProvider>(create: (_) => HomeScreenProvider()),
            ChangeNotifierProvider<ChatRoomProvider>(create: (_) => ChatRoomProvider()),
            ChangeNotifierProvider<VerificationSuccessProvider>(create: (_) => VerificationSuccessProvider()),
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(FirebaseAuth.instance),
            ),
            StreamProvider(
              // Stream provider for authentication
              create: (context) => context.watch<AuthProvider>().stream(),
              initialData: null,
            ),
            ChangeNotifierProvider<DashBoardProvider>(create: (_) => DashBoardProvider()),
            ChangeNotifierProvider<OtpScreenProvider>(create: (_) => OtpScreenProvider()),
            ChangeNotifierProvider<ToggleProvider>(create: (_) => ToggleProvider()),
            ChangeNotifierProvider<RegisterPhoneProvider>(create: (_) => RegisterPhoneProvider()),
            ChangeNotifierProvider<OtpTimeProvider>(create: (context) => OtpTimeProvider()),
          ],
          child: MaterialApp(
            // Main MaterialApp widget
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: Splash(), // Initial screen is Splash

            // home: EnterUsersEmail(),
          ),
        );
      },
    );
  }
}

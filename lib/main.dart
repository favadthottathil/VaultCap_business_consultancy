import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/gst_registraion/gst_1.dart';
import 'package:taxverse/view/sign_option.dart';
import 'package:taxverse/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.watch<AuthProvider>().stream(), initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, splashFactory: InkRipple.splashFactory),
        home: const GstFirstScreen(),
      ),
    );
  }
}

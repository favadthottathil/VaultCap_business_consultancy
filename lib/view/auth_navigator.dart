import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/mainscreens/home.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';

import 'package:taxverse/view/register_phone.dart';

class AuthNav extends StatelessWidget {
  const AuthNav({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      initialData: null,
      stream: context.watch<AuthProvider>().stream(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (user == null) {
          return const RegisterWithPhone();
        } else {
          return const BottomNav();
        }
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

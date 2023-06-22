import 'dart:developer';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/mainscreens/home_screen.dart';
import 'package:taxverse/view/mainscreens/news.dart';
import 'package:taxverse/view/mainscreens/user.dart';
import 'package:taxverse/view/sign_option.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with WidgetsBindingObserver {
  int index = 0;

  final screen = [
    const HomeScreen(),
    const News(),
    const User1(),
  ];

  @override
  void initState() {
    super.initState();

    APIs.getDocumetID().then((value) {
      WidgetsBinding.instance.addObserver(this);

      APIs.updateActiveStatus(true);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      log('resumed');
      APIs.updateActiveStatus(true);
    } else {
      log('paused');
      APIs.updateActiveStatus(false);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false).setLoading = false;
    });
    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SignOption();

          return SafeArea(
            top: false,
            child: Scaffold(
              body: screen[index],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: whiteColor,
                color: blackColor,
                buttonBackgroundColor: blackColor,
                onTap: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                items: const [
                  Icon(
                    Icons.home,
                    size: 35,
                    color: whiteColor,
                  ),
                  Icon(
                    Icons.newspaper_outlined,
                    size: 35,
                    color: whiteColor,
                  ),
                  Icon(
                    Icons.person_2,
                    size: 35,
                    color: whiteColor,
                  )
                ],
              ),
            ),
          );
        });
  }
}

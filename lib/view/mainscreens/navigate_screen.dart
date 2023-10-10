import 'dart:developer';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/authentication/provider/auth_provider.dart';
import 'package:taxverse/view/gst_registraion/dashboard/dashboard_list.dart';
import 'package:taxverse/view/mainscreens/homescreen/home_screen.dart';
import 'package:taxverse/view/mainscreens/news_screen/news.dart';
import 'package:taxverse/view/mainscreens/useraccount/user_account.dart';
import 'package:taxverse/view/authentication/sign_option.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key, required this.isGuest}) : super(key: key);

  final bool isGuest;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with WidgetsBindingObserver {
  int _currentIndex = 0; // Current tab index
  late List<Widget> _screens; // List of screens

  @override
  void initState() {
    super.initState();
    // Initialize screens
    _screens = [
      HomeScreen(),
      const DashBoardListTile(),
      const News(),
      UserProfile(),
    ];

    // Fetch document ID and update active status
  }

  //

  // Initialize APIs and handle app lifecycle state changes
  void _initializeAPIs() {
    APIs.getDocumetID().then((value) {
      WidgetsBinding.instance.addObserver(this);
      APIs.updateActiveStatus(true);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      APIs.updateActiveStatus(true);
    } else {
      APIs.updateActiveStatus(false);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    // addCurrentUserEmail(context);

    // Set loading to false after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).setLoading = false;
    });

    return StreamBuilder(
      stream: context.watch<AuthProvider>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData && !widget.isGuest) {
          // User not authenticated, show SignOption widget
          return const SignOption();
        }
        //  else if (firebaseAuth.currentUser!.email == "" || firebaseAuth.currentUser!.email == null) {
        //   return const EnterUsersEmail();
        // }
         else {
          // User authenticated or guest, show the bottom navigation bar
          log(' useremail  ${firebaseAuth.currentUser!.email}');
          // _initializeAPIs();

          return _buildBottomNav();
        }
      },
    );
  }

  // Build the bottom navigation bar
  Widget _buildBottomNav() {
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          _screens[_currentIndex], // Display the selected screen
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: blackColor,
              buttonBackgroundColor: blackColor,
              onTap: (index) {
                setState(() {
                  _currentIndex = index; // Change the selected tab
                });
              },
              items: const [
                Icon(
                  Icons.home,
                  size: 35,
                  color: whiteColor,
                ),
                Icon(
                  Icons.dashboard_outlined,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

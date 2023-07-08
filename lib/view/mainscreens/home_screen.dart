import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/api/messaging_api.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/controller/providers/homescreen_provider.dart';
import 'package:taxverse/view/widgets/homescreen_widget/homescreen_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();

  NotificationServices notificationServices = NotificationServices();

  // @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MessagingAPI.getFirebaseMessagingToken();

      

      notificationServices.firebaseInit();

      final authprovider = Provider.of<AuthProvider>(context, listen: false);

      final homeProvide = Provider.of<HomeScreenProvider>(context, listen: false);

      authprovider.setLoading = false;

      homeProvide.addDisplayName();

      homeProvide.tokenToDatabase(saveTokenToDatabase);
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  textAndLogout(context),
                  startingNewbusinessWidget(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, right: 100),
                    child: Text(
                      'Explore Our Services',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.poppinsBold24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  mainScreenGridView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/aboutus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/settingsWidgets/settings_widgets.dart';

class Settingss extends StatelessWidget {
  const Settingss({super.key});

  deleteUser(BuildContext context) async {
    FirebaseAuth.instance.currentUser!.delete();
    await APIs.updateActiveStatus(false);
    context.read<AuthProvider>().logOut(context);
  }

  feedback() async {
    const url = 'mailto:favadfavad2@gmail.com?subject=FeedBack';
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    
    final names = [
      'Notifications',
      'Feedback',
      'Delete Account',
      'About',
    ];

    final icons = [
      const Icon(Icons.notifications_active),
      const Icon(Icons.feedback_outlined),
      const Icon(Icons.delete_forever_outlined),
      const Icon(Icons.info_outline_rounded),
    ];

    final trailing = [
      toggleCustom(),
      const Icon(
        Icons.arrow_forward_ios_outlined,
      ),
      const Icon(
        Icons.arrow_forward_ios_outlined,
      ),
      const Icon(
        Icons.arrow_forward_ios_outlined,
      ),
      const Icon(
        Icons.arrow_forward_ios_outlined,
      )
    ];

    List<void Function()?> onpressed = [
      null,
      feedback,
      deleteUser(context),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutUs(),
          ),
        );
      },
    ];

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: MaterialButton(
          onPressed: () {},
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          'Settings',
          style: AppStyle.poppinsBold20,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: icons[index],
                title: Text(
                  names[index],
                  style: AppStyle.poppinsBold16,
                ),
                trailing: InkWell(
                  onTap: onpressed[index],
                  child: trailing[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/aboutUs.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingss extends StatefulWidget {
  const Settingss({super.key});

  @override
  State<Settingss> createState() => _SettingssState();
}

class _SettingssState extends State<Settingss> {
  bool toggleValue = false;

  deleteUser() async {
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
    final size = MediaQuery.of(context).size;

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
      deleteUser,
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

  contactUs(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: size.height * 0.2,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri(scheme: 'tel', path: '81296353553');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        child: SvgPicture.asset(
                          'Asset/phone-call-svgrepo-com.svg',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'Phone',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://www.google.com/search?q=google&sxsrf=APwXEdcEdAbszBacONR_Nmv2RKaVGvTNbw%3A1687863253617&ei=1b-aZO6YJf_cseMPjPCuMA&ved=0ahUKEwiu16TNpOP_AhV_bmwGHQy4CwYQ4dUDCA8&uact=5&oq=google&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCCMQigUQJzIHCCMQigUQJzIECCMQJzIWCC4QgAQQFBCHAhCxAxCDARDHARDRAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMgsIABCABBCxAxCDAToKCAAQRxDWBBCwAzoKCAAQigUQsAMQQzoICAAQgAQQsQNKBAhBGABQ8AZYvBRg9xZoAXABeACAAc0BiAGGCpIBBTAuOS4xmAEAoAEBwAEByAEJ&sclient=gws-wiz-serp');

                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        // color: Colors.amber,
                        child: SvgPicture.asset('Asset/whatsapp.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'WhattsApp',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://www.google.com/search?q=google&sxsrf=APwXEdcEdAbszBacONR_Nmv2RKaVGvTNbw%3A1687863253617&ei=1b-aZO6YJf_cseMPjPCuMA&ved=0ahUKEwiu16TNpOP_AhV_bmwGHQy4CwYQ4dUDCA8&uact=5&oq=google&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCCMQigUQJzIHCCMQigUQJzIECCMQJzIWCC4QgAQQFBCHAhCxAxCDARDHARDRAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMgsIABCABBCxAxCDAToKCAAQRxDWBBCwAzoKCAAQigUQsAMQQzoICAAQgAQQsQNKBAhBGABQ8AZYvBRg9xZoAXABeACAAc0BiAGGCpIBBTAuOS4xmAEAoAEBwAEByAEJ&sclient=gws-wiz-serp');

                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        // color: Colors.amber,
                        child: SvgPicture.asset('Asset/insta.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'Instagram',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final url = Uri.parse('https://www.google.com/search?q=google&sxsrf=APwXEdcEdAbszBacONR_Nmv2RKaVGvTNbw%3A1687863253617&ei=1b-aZO6YJf_cseMPjPCuMA&ved=0ahUKEwiu16TNpOP_AhV_bmwGHQy4CwYQ4dUDCA8&uact=5&oq=google&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCCMQigUQJzIHCCMQigUQJzIECCMQJzIWCC4QgAQQFBCHAhCxAxCDARDHARDRAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMgsIABCABBCxAxCDAToKCAAQRxDWBBCwAzoKCAAQigUQsAMQQzoICAAQgAQQsQNKBAhBGABQ8AZYvBRg9xZoAXABeACAAc0BiAGGCpIBBTAuOS4xmAEAoAEBwAEByAEJ&sclient=gws-wiz-serp');

                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        // color: Colors.amber,
                        child: SvgPicture.asset('Asset/facebook-logo-meta-2-svgrepo-com.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'Facebook',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedContainer toggleCustom() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: toggleValue ? Colors.greenAccent[100] : Colors.redAccent[100]!.withOpacity(0.5),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 3.0,
            left: toggleValue ? 20 : 0,
            right: toggleValue ? 0 : 20,
            child: InkWell(
              onTap: () {
                setState(() {
                  toggleValue = !toggleValue;
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: toggleValue
                    ? Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                          key: UniqueKey(),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          size: 30,
                          key: UniqueKey(),
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}

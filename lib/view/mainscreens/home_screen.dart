import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/controller/notificatin_services.dart';
import 'package:taxverse/view/gst_registraion/gst_1.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  NotificationServices notificationServices = NotificationServices();

  Future<void> sendPushNotification() async {
    try {
      String deviceToken = await notificationServices.getDeviceToken();

      var payload = {
        'to': deviceToken,
        'priority': 'high',
        'notification': {
          'title': 'Application Accepted',
          'body': 'Your Application for GST Registration Successfully verified'
        }
      };

      http.Response response = await http.post(
        Uri.parse('http://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(payload),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAA0P_GUt4:APA91bHcL44BeKK2BwLMu0L9JfzkA2uFWh4v0wGd8w2j9T8QqT8FQeLZQ2FiBEbj3PRTtWFPIjp2_pNOHThfG3vn11OUSl0n-HlMXyiYfhaI0zZ8fY-To4XyKGqDEv2HR34HMsAykrqn',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Push notification sent successfully.');
      } else {
        print('Failed to send push notification. Response: ${response.body}');
      }
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }

  List imgLIst1 = [
    'Asset/gst-returns.jpg',
    'Asset/tax.jpg',
  ];

  List imgLIst2 = [
    'Asset/audit.png',
    'Asset/companyIncorparatin.png',
  ];

  List name1 = [
    'GST REGISTRACTION',
    'INCOME TAX'
  ];

  List name2 = [
    'INTERNAL AUDIT',
    'COMPANY INCORPARATION',
  ];

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 28),
                          child: Text(
                            'Welcome...',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.poppinsBold27,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'Asset/notification.svg',
                            height: 40,
                            width: 40,
                            // ignore: deprecated_member_use
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     notificationServices.getDeviceToken().then(
                  //       (value) async {
                  //         try {
                  //           var data = {
                  //             'to': value.toString(),
                  //             'priority': 'high',
                  //             'notification': {
                  //               'title': 'Application Accepted',
                  //               'body': 'Your Application for GST Registration Successfully verified'
                  //             }
                  //           };

                  //           var response = await http.post(
                  //             Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  //             body: jsonEncode(data),
                  //             headers: {
                  //               'Content-Type': 'application/json; charset=UTF-8',
                  //               'Authorization': 'key=AAAA0P_GUt4:APA91bHcL44BeKK2BwLMu0L9JfzkA2uFWh4v0wGd8w2j9T8QqT8FQeLZQ2FiBEbj3PRTtWFPIjp2_pNOHThfG3vn11OUSl0n-HlMXyiYfhaI0zZ8fY-To4XyKGqDEv2HR34HMsAykrqn',
                  //             },
                  //           );

                  //           if (response.statusCode == 200) {
                  //             print('response success');
                  //           } else {
                  //             print('response failed');
                  //           }
                  //         } catch (e) {
                  //           print('error $e');
                  //         }
                  //       },
                  //     );
                  //     // sendPushNotification();
                  //   },
                  //   child: Text('data'),
                  // ),
                  Container(
                    height: 149,
                    width: 336,
                    margin: const EdgeInsets.only(top: 25, left: 25),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'Asset/home_1.png',
                            height: 149,
                            width: 336,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    'Starting New Business',
                                    textAlign: TextAlign.left,
                                    style: AppStyle.poppinsBold20,
                                  ),
                                ),
                                Text(
                                  'Connect with us >',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.poppinsBold16,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 38, left: 25, right: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: blackColor.withOpacity(0.1),
                          hintText: 'Search Service',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: const Color(0xa0000000),
                          ),
                          prefix: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              'Asset/img_search.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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

                  ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                    right: 7,
                                  ),
                                  padding: const EdgeInsets.only(left: 11, top: 7, bottom: 7, right: 11),
                                  decoration: BoxDecoration(
                                    color: blackColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: Image.asset(
                                          imgLIst1[index],
                                          fit: BoxFit.cover,
                                          height: 120,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 7),
                                          child: Text(
                                            name1[index],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.poppinsBold12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const GstFirstScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 65,
                                          margin: const EdgeInsets.only(left: 45),
                                          decoration: BoxDecoration(
                                            color: blackColor,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Get Now',
                                              style: AppStyle.poppinsBoldWhite12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                    right: 7,
                                  ),
                                  padding: const EdgeInsets.only(left: 11, top: 7, bottom: 7, right: 11),
                                  decoration: BoxDecoration(
                                    color: blackColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: Image.asset(
                                          imgLIst2[index],
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 7),
                                          child: Text(
                                            name2[index],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.poppinsBold12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const GstFirstScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 65,
                                          margin: const EdgeInsets.only(left: 45),
                                          decoration: BoxDecoration(
                                            color: blackColor,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Get Now',
                                              style: AppStyle.poppinsBoldWhite12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

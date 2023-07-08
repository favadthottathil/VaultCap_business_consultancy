import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/view/chat/chat_ui.dart';
import 'package:taxverse/view/gst_registraion/gst_1.dart';
import 'package:taxverse/view/mainscreens/checkapplication_status.dart';

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

// <<---------------------------------------------------------->>

//                       Next widget

ListView mainScreenGridView() {
  return ListView.separated(
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
                              builder: (context) => const CheckStatus(),
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
      itemCount: 2);
}

// <<---------------------------------------------------------->>

//                       Next widget

InkWell startingNewbusinessWidget(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(),
          ));
    },
    child: Container(
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
  );
}

// <<---------------------------------------------------------->>

//                       Next widget

Padding textAndLogout(BuildContext context) {
  return Padding(
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
          child: InkWell(
            onTap: () async {
              await APIs.updateActiveStatus(false);
              context.read<AuthProvider>().logOut(context);
            },
            child: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}

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

ListView mainScreenGridView(Size size) {
  return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
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
                          height: size.height * 0.15,
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
                      SizedBox(height: size.height * 0.02),
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
                          height: size.height * 0.03,
                          width: size.height * 0.09,
                          margin: EdgeInsets.only(left: size.width * 0.12),
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
                          height: size.height * 0.15,
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
                      SizedBox(height: size.height * 0.02),
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
                          height: size.height * 0.03,
                          width: size.height * 0.09,
                          margin: EdgeInsets.only(left: size.width * 0.12),
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
        return SizedBox(height: size.height * 0.01);
      },
      itemCount: 2);
}

// <<---------------------------------------------------------->>

//                       Next widget

InkWell startingNewbusinessWidget(BuildContext context, Size size) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(),
          ));
    },
    child: Container(
      height: size.height * 0.2,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * 0.01, left: size.width * 0.07),
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
              padding: EdgeInsets.only(left: size.width * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.amber,
                    width: size.width * 0.37,
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

Padding textAndLogout(BuildContext context, Size size) {
  return Padding(
    padding: EdgeInsets.only(left: size.width * 0.04),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.03,
            bottom: size.height * 0.03,
          ),
          child: Text(
            'Welcome...',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.poppinsBold27,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.03),
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

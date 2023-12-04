import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/view/gst_registraion/dashboard/provider/dashboard_provider.dart';
import 'widget/dashboard_widgets.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({super.key, required this.data});

  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  String? downloadError;

  // bool statusUpdated = false;
  // double? _progress;

  Widget controlsBuilder(context, details) {
    return Row(
      children: const [
        SizedBox(),
      ],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> clientData() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    return FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: userEmail,
        )
        .limit(1)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashBoardProvider>(context, listen: false).checkPermission();
    });

    var temp = Provider.of<DashBoardProvider>(context, listen: false).temp;

    var currentStep = Provider.of<DashBoardProvider>(context, listen: false).currentStep;

    final size = MediaQuery.of(context).size;

    final statusPercentage = data['statuspercentage'];

    temp = data['verifystatus'];
    if (temp > 2) {
      currentStep = 2;
    } else {
      currentStep = temp;
    }

    return StreamBuilder(
      stream: clientData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // final clientdata = snapshot.data?.docs ?? [];

          // final verified = clientdata[0]['Isverified'];
          var verified = data['application_status'];
          bool isRegistrationCompleted = data['isRegistrationCompleted'];
          bool showProgress = data['showprogress'];

          final gstNumber = data['gst_number'];
          final gstdoc = data['gstcertificate'];

          log('$isRegistrationCompleted');

          return Scaffold(
            body: SafeArea(
              child: Consumer<DashBoardProvider>(builder: (context, provider, child) {
                return Padding(
                  padding: EdgeInsets.only(left: size.width * 0.07),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DashBoard',
                          style: AppStyle.poppinsBold27,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Text(
                          'Application Status',
                          style: AppStyle.poppinsBold16,
                        ),
                        SizedBox(height: size.height * 0.04),
                        CircularPercentIndicator(
                          radius: 50,
                          backgroundColor: Colors.amber,
                          curve: Curves.slowMiddle,
                          animationDuration: 500,
                          lineWidth: 6,
                          percent: statusPercentage / 100,
                          animation: true,
                          center: Text(
                            '$statusPercentage%',
                            style: AppStyle.poppinsBold16,
                          ),
                          footer: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'Checking Application',
                              style: AppStyle.poppinsBold12,
                            ),
                          ),
                          progressColor: blackColor,
                        ),
                        Stepper(
                          physics: const BouncingScrollPhysics(),
                          currentStep: currentStep,
                          onStepTapped: provider.onStepTapped,
                          controlsBuilder: controlsBuilder,
                          steps: [
                            Step(
                              title: Text('Checking Information', style: AppStyle.poppinsBold12),
                              content: temp >= 0 && temp <= 2 ? Text('We are Checking Your Information', style: AppStyle.poppinsBoldGreen12) : const SizedBox(),
                              isActive: temp >= 0 && temp <= 2,
                              state: temp >= 0 && temp <= 2 ? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: Text('Checking Documents', style: AppStyle.poppinsBold12),
                              content: temp >= 1 && temp <= 2 ? Text('We are Checking Your Document ', style: AppStyle.poppinsBoldGreen12) : const SizedBox(),
                              isActive: temp >= 1 && temp <= 2,
                              state: temp >= 1 && temp <= 2 ? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: Text('Application Status', style: AppStyle.poppinsBold12),
                              content: temp >= 2 && temp <= 2
                                  ? verified == 'accepted'
                                      ? Text('Application Accepted', style: AppStyle.poppinsBoldGreen12)
                                      : verified == 'notAccepted'
                                          ? Text('Application Rejected', style: AppStyle.poppinsBoldGreen12)
                                          : Text('updating status....', style: AppStyle.poppinsBoldGreen12)
                                  : const SizedBox(),
                              isActive: temp >= 2 && temp <= 2,
                              state: temp >= 2 && temp <= 2 ? StepState.complete : StepState.indexed,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        if (showProgress == true)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Your Application Process Underway',
                                style: AppStyle.poppinsBold16,
                              ),
                              SizedBox(height: size.width * 0.02),
                              const SpinKitCircle(
                                color: blackColor,
                                size: 40,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        if (isRegistrationCompleted == true)
                          // provider.isPermission
                          //     ?
                          showgstInfoToClient(size, gstNumber, provider, gstdoc)
                        // : Center(
                        //     child: TextButton(
                        //       onPressed: () {
                        //         provider.checkPermission();
                        //       },
                        //       child: Text(
                        //         'Request Permission',
                        //         style: AppStyle.poppinsBold12,
                        //       ),
                        //     ),
                        //   )
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return const SpinKitCircle(color: blackColor);
        }
      },
    );
  }
}

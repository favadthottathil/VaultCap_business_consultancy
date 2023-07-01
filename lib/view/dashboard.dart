import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taxverse/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.data});

  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentStep = 1;

  int temp = 1;

  bool statusUpdated = false;

  bool isAdmin = true;

  countinueStep() {
    if (currentStep < temp) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    log('onstepTapped Temp  $temp');
    log('onStepTapped value $value');
    if (value <= temp) {
      setState(() {
        currentStep = value;
        log(currentStep.toString());
      });
    }
  }

  Widget controlsBuilder(context, details) {
    return Row(
      children: const [
        SizedBox(),
      ],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> clientData() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    return FirebaseFirestore.instance.collection('ClientDetails').where('Email', isEqualTo: userEmail).limit(1).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final statusPercentage = widget.data['statuspercentage'];

    currentStep = widget.data['verifystatus'];
    temp = currentStep;

    return StreamBuilder(
        stream: clientData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.docs ?? [];

            final verified = data[0]['Isverified'];
            bool isRegistrationCompleted = widget.data['isRegistrationCompleted'];
            bool showProgress = widget.data['showprogress'];

            log('$isRegistrationCompleted');

            return Scaffold(
              body: SafeArea(
                child: Padding(
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
                          onStepTapped: onStepTapped,
                          controlsBuilder: controlsBuilder,
                          steps: [
                            Step(
                              title: const Text('Checking Information'),
                              content: const Text('We are Checking Your Information'),
                              isActive: temp >= 0,
                              state: temp >= 0 ? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Checking Documents'),
                              content: const Text('We are Checking Your Document '),
                              isActive: temp >= 1,
                              state: temp >= 1 ? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Application Status'),
                              content: verified == 'verified' ? const Text('Application Accepted') : const Text('Application Rejected'),
                              isActive: temp >= 2,
                              state: temp >= 2 ? StepState.complete : StepState.indexed,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        if (showProgress == true)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.05),
                                child: Text(
                                  'Your Application Process Underway',
                                  style: AppStyle.poppinsBold16,
                                ),
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
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.08, bottom: size.height * 0.05),
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.025),
                                  Text(
                                    'Registration Completed!!!',
                                    style: AppStyle.poppinsBoldGreen20,
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Text(
                                    'GST NO :     879458854JHERRHJ',
                                    style: AppStyle.poppinsRegular15,
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  // MaterialButton(
                                  //   onPressed: () {},
                                  //   child: Text(
                                  //     'Download GST Certificate',
                                  //     style: AppStyle.poppinsRegular15,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SpinKitCircle(color: blackColor);
          }
        });
  }
}

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/gst_registraion/gst_screen_3/gst_3.dart';
import 'package:taxverse/view/gst_registraion/gst_screen_2/widgets/gst_second_widgets.dart';

class GstSecondScreen extends StatefulWidget {
  const GstSecondScreen({
    super.key,
    required this.businessName,
    required this.businessType,
    required this.businessStartDate,
  });

  final String businessName;

  final String businessType;

  final String businessStartDate;

  @override
  State<GstSecondScreen> createState() => _GstSecondScreenState();
}

class _GstSecondScreenState extends State<GstSecondScreen> {
  final CollectionReference gstClientInformaion = FirebaseFirestore.instance.collection('ClientGstInfo');

  final panCard = TextEditingController();

  final aadhaarCard = TextEditingController();

  final electricityBill = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    electricityBill.dispose();
    aadhaarCard.dispose();
    // electricityBill.dispose();
    super.dispose();
  }

  // addDetailsToDatabase(
  //   String businessName,
  //   String businessType,
  //   String businessStartDate,
  //   String panCardNumber,
  //   String aadhaarCardNumber,
  //   String electricityBill,
  // ) async {
  //   try {
  //     final userEmail = FirebaseAuth.instance.currentUser!.email;

  //     log(userEmail!);

  //     Query query = firestore.collection('ClientDetails').where(
  //           'Email',
  //           isEqualTo: userEmail,
  //         );

  //     Future<QuerySnapshot<Object?>> futureData = query.get();

  //     QuerySnapshot<Object?> data = await futureData;

  //     if (data.docs.isNotEmpty) {
  //       String fieldName = data.docs[0].get('Name');

  //       clientUserName = fieldName;
  //       // Use the value of the 'name' field
  //       log(clientUserName!);
  //     } else {
  //       // Handle the case when the snapshot is empty
  //       log('No documents found.');
  //     }

  //     final time = DateTime.now().millisecondsSinceEpoch.toString();

  //     final DocumentReference doc = await gstClientInformaion.add({
  //       'BusinessName': businessName,
  //       'BusinesssType': businessType,
  //       'BusinessStartDate': businessStartDate,
  //       'PanCardNumber': panCardNumber,
  //       'AadhaarCard': aadhaarCardNumber,
  //       'BusinessRegistrationNumber': electricityBill,
  //       'ServiceName': 'GST Registration',
  //       'time': time,
  //       'Email': userEmail,
  //       'name': clientUserName,
  //       'acceptbutton': false,
  //     });

  //     ClientInformation.gstId = doc.id;
  //     log('doc id in screen 2 === ${ClientInformation.gstId}');
  //   } catch (e) {
  //     log('Error saving gst information: $e');
  //   }
  // }

  _navigateToThirdScreen(
    String businessName,
    String businessType,
    String businessStartDate,
  ) {
    if (_formKey.currentState!.validate()) {
      // addDetailsToDatabase(
      //   businessName,
      //   businessType,
      //   businessStartDate,
      //   panCard.text.trim(),
      //   aadhaarCard.text.trim(),
      //   electricityBill.text.trim(),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GstThirdScreen(
            aadhaarCard: aadhaarCard.text.trim(),
            businessName: businessName,
            businessStartDate: businessStartDate,
            businessType: businessType,
            electricityBill: electricityBill.text.trim(),
            pancard: panCard.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: size.height * 0.06),
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gst2Heading(size: size, head: 'Please Upload Required Informations'),
                          SizedBox(height: size.height * 0.02),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Gst2textField(
                                size: size,
                                panCard: panCard,
                                labelText: 'Enter your PANCARD Number',
                                hintText: 'eg:HFYU3262H',
                              ),
                              Gst2textField(
                                size: size,
                                panCard: aadhaarCard,
                                labelText: 'Enter your AADHAAR Number',
                                hintText: 'eg: 8756 5435 7634',
                                keyBoardType: TextInputType.number,
                              ),
                              Gst2textField(
                                size: size,
                                panCard: electricityBill,
                                labelText: 'Enter Firm Eelectricity bill',
                                hintText: '',
                              ),
                              SizedBox(height: size.height * 0.06),
                              gst2NextAndPrevious(size)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row gst2NextAndPrevious(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Back',
          style: AppStyle.poppinsBold16,
        ),
        NeumorphicButton(
          onPressed: () => _navigateToThirdScreen(
            widget.businessName,
            widget.businessType,
            widget.businessStartDate,
          ),
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: const NeumorphicBoxShape.circle(),
            depth: 8,
            lightSource: LightSource.topLeft,
            color: blackColor.withOpacity(0.1),
          ),
          child: Container(
            height: size.height * 0.09,
            width: size.height * 0.09,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: blackColor),
            child: const Icon(
              Icons.arrow_forward_sharp,
              color: whiteColor,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}

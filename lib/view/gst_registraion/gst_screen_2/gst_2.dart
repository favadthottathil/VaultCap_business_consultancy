import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_2/widgets/gst_second_widgets.dart';
import 'package:vaultcap/view/gst_registraion/gst_screen_3/gst_3.dart';


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
  _navigateToThirdScreen(
    String businessName,
    String businessType,
    String businessStartDate,
  ) {
    if (_formKey.currentState!.validate()) {
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
                                labelText: 'give dummy data',
                                hintText: 'eg:HFYU3262H',
                              ),
                              Gst2textField(
                                size: size,
                                panCard: aadhaarCard,
                                labelText: 'give dummy data',
                                hintText: 'eg: 8756 5435 7634',
                                keyBoardType: TextInputType.number,
                              ),
                              Gst2textField(
                                size: size,
                                panCard: electricityBill,
                                labelText: 'give dummy data',
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

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/view/gst_registraion/gst_2.dart';
import 'package:taxverse/view/widgets/services/gst_1%20_widgets.dart';

class GstFirstScreen extends StatefulWidget {
  const GstFirstScreen({super.key});

  @override
  State<GstFirstScreen> createState() => _GstFirstScreenState();
}

class _GstFirstScreenState extends State<GstFirstScreen> {
  final businessTypeController = TextEditingController();

  final businessNameController = TextEditingController();

  final businessStartDate = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    businessNameController.dispose();

    businessTypeController.dispose();

    businessStartDate.dispose();

    super.dispose();
  }

  _navigateToGstSecondScreen() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GstSecondScreen(
            businessName: businessNameController.text.trim(),
            businessType: businessTypeController.text.trim(),
            businessStartDate: businessStartDate.text.trim(),
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              // height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gst1MainHead(size: size, heading: 'GST Registration'),
                  Gst1subHeading(size: size, subHeading: 'Add basic information'),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: size.width * 0.07,
                      top: size.height * 0.06,
                      right: size.width * 0.07,
                      bottom: size.height * 0.07,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gst1TextField(businessNameController: businessNameController, size: size, hintText: 'Business Name'),
                        SizedBox(height: size.height * 0.03),
                        customDrop(controller: businessTypeController),
                        Gst1TextField(
                          businessNameController: businessStartDate,
                          size: size,
                          hintText: 'Business StartDate',
                          marginTop: size.height * 0.025,
                          keybordType: TextInputType.datetime,
                        ),
                        SizedBox(height: size.height * 0.06),
                        NextAndPreviousButton(
                          size: size,
                          onpresssed: _navigateToGstSecondScreen,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

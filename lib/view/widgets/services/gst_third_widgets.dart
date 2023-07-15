import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/controller/providers/gst3Provider.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/gst_registraion/accept_application.dart';

class DocumentUploadData {
  bool showLoading = false;
  bool isImageUploaded = false;
}

// <<---------------------------------------------------------->>

//                       Next widget

gst3BackAndForward({required BuildContext context, required Future onpressed}) {
  final size = MediaQuery.of(context).size;
  final provider = context.watch<GstThirdScreenProvider>();
  return Padding(
    padding: EdgeInsets.only(right: size.width * 0.04),
    child: Align(
      alignment: Alignment.centerRight,
      child: NeumorphicButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.scale,
            showCloseIcon: true,
            title: 'Confirm',
            desc: 'Do you Do really want to confirm',
            btnOkColor: Colors.green,
            btnOkText: 'Yes',
            buttonsTextStyle: AppStyle.poppinsBold16,
            dismissOnBackKeyPress: true,
            titleTextStyle: AppStyle.poppinsBold18,
            descTextStyle: AppStyle.poppinsBold16,
            transitionAnimationDuration: const Duration(milliseconds: 500),
            btnOkOnPress: () {
              onpressed;

              provider.setAllboolToFalse('PassportSizePhoto');
              provider.setAllboolToFalse('PANCARD');
              provider.setAllboolToFalse('AADHAARCARD');
              provider.setAllboolToFalse('Electricity bill');
              provider.setAllboolToFalse('RENT AGREEMENT');
              provider.setAllboolToFalse('BUILDING TAX RECEIPT');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WaitingScreen(),
                ),
              );
            },
            buttonsBorderRadius: BorderRadius.circular(20),
          ).show();
        },
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
    ),
  );
}

// <<---------------------------------------------------------->>

//                       Next widget

class Gst3Head extends StatelessWidget {
  const Gst3Head({
    super.key,
    required this.size,
    required this.head,
  });

  final Size size;

  final String head;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: size.width * 0.1,
      ),
      child: Text(
        head,
        textAlign: TextAlign.left,
        style: AppStyle.poppinsBold27,
      ),
    );
  }
}

// <<---------------------------------------------------------->>

//                       Next widget

class DocumentUpload extends StatelessWidget {
  const DocumentUpload({
    super.key,
    required this.name,
    required this.ontap,
    required this.documentUploadData,
  });

  final String name;

  final VoidCallback ontap;

  final DocumentUploadData documentUploadData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          color: whiteColor,
          width: size.width * 0.6,
          child: Expanded(
            child: Text(
              name,
              style: AppStyle.poppinsBold18,
            ),
          ),
        ),
        Container(
          color: whiteColor,
          child: Expanded(
            child: TextButton(
                onPressed: ontap,
                child: const Icon(
                  Icons.upload,
                  color: blackColor,
                )),
          ),
        ),
        documentUploadData.showLoading
            ? const Padding(
                padding: EdgeInsets.only(left: 10),
                child: SpinKitCircle(
                  color: blackColor,
                  size: 30,
                ),
              )
            : documentUploadData.isImageUploaded
                ? const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.task_alt,
                      color: Colors.green,
                      size: 30,
                    ),
                  )
                : const SizedBox(),
      ],
    );
  }
}

// <<---------------------------------------------------------->>

//                       Next widget

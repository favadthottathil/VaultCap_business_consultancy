import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/gst3Provider.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/widgets/services/gst_third_widgets.dart';
import 'package:provider/provider.dart';

class GstThirdScreen extends StatelessWidget {
  const GstThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: size.height * 0.06),
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.09),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gst3Head(size: size, head: 'Please Uplaod Required Documents'),
                      SizedBox(height: size.height * 0.02),
                      Consumer<GstThirdScreenProvider>(builder: (context, provider, _) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DocumentUpload(
                              name: 'Add your Passport Size photo',
                              ontap: () {
                                provider.pickFile("$userDisplayName's PassportSizePhoto", 'PassportSizePhoto');
                              },
                              documentUploadData: provider.documentUploadDataMap['PassportSizePhoto']!,
                            ),
                            SizedBox(height: size.height * 0.02),
                            DocumentUpload(
                              name: 'Upload PANCARD',
                              ontap: () {
                                provider.pickFile("$userDisplayName's PANCARD", 'PANCARD');
                              },
                              documentUploadData: provider.documentUploadDataMap['PANCARD']!,
                            ),
                            SizedBox(height: size.height * 0.02),
                            DocumentUpload(
                              name: 'Upload AADHAARCARD',
                              ontap: () {
                                provider.pickFile("$userDisplayName's AADHAARCARD", 'AADHAARCARD');
                              },
                              documentUploadData: provider.documentUploadDataMap['AADHAARCARD']!,
                            ),
                            SizedBox(height: size.height * 0.02),
                            DocumentUpload(
                              name: 'Upload Electricity bill',
                              ontap: () {
                                provider.pickFile("$userDisplayName's Electricity bill", 'Electricity bill');
                              },
                              documentUploadData: provider.documentUploadDataMap['Electricity bill']!,
                            ),
                            SizedBox(height: size.height * 0.02),
                            DocumentUpload(
                              name: 'Upload RENT AGREEMENT',
                              ontap: () {
                                provider.pickFile("$userDisplayName's RENT AGREEMENT", 'RENT AGREEMENT');
                              },
                              documentUploadData: provider.documentUploadDataMap['RENT AGREEMENT']!,
                            ),
                            SizedBox(height: size.height * 0.02),
                            DocumentUpload(
                              name: 'Upload BUILDING TAX RECEIPT',
                              ontap: () {
                                provider.pickFile("$userDisplayName's BUILDING TAX RECEIPT", 'BUILDING TAX RECEIPT');
                              },
                              documentUploadData: provider.documentUploadDataMap['BUILDING TAX RECEIPT']!,
                            ),
                            SizedBox(height: mediaQuery.size.height * 0.03),
                            if (provider.gstDocumentCount == 6)
                              gst3BackAndForward(
                                context: context,
                                onpressed: provider.addUserVerified(),
                              )
                            else
                              Text(
                                'upload all documents to continue.....',
                                style: AppStyle.poppinsBoldRed12,
                              ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

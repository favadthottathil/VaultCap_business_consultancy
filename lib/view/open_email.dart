import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_mail_app/open_mail_app.dart';

import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/sign_in.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 160),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                // margin: const EdgeInsets.only(left: 40),
                color: blackColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 141,
                  width: 152,
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'Asset/img_send.svg',
                          height: 63,
                          width: 63,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 115, top: 40),
                  child: Text(
                    "Check your mail",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xa0000000),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 39,
                ),
                child: Text(
                  "We have sent a password recover",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: blackColor.withOpacity(0.4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "instructions to your email",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: blackColor.withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () async {
                    var result = await OpenMailApp.openMailApp();

                    if (!result.didOpen && !result.canOpen) {
                      // ignore: use_build_context_synchronously
                      showNoMailAppsDialog(context);
                    } else if (!result.didOpen && result.canOpen) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MailAppPickerDialog(mailApps: result.options);
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    color: blackColor.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        'Open email app',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ));
                  },
                  child: Text(
                    "Skip, i’ll confirm later",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, right: 42),
                  child: Text(
                    "Did not receive the email? check your spam filter, ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 11),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "or ",
                        style: GoogleFonts.poppins(
                          color: blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "try another email address",
                        style: GoogleFonts.poppins(
                          color: blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

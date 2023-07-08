import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/controller/providers/toggle_provider.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:url_launcher/url_launcher.dart';

toggleCustom() {
  return Consumer<ToggleProvider>(builder: (context, provider, child) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: provider.toggleValue ? Colors.greenAccent[100] : Colors.redAccent[100]!.withOpacity(0.5),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 3.0,
            left: provider.toggleValue ? 20 : 0,
            right: provider.toggleValue ? 0 : 20,
            child: InkWell(
              onTap: () {
                provider.setToggleState();
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: provider.toggleValue
                    ? Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                          key: UniqueKey(),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          size: 30,
                          key: UniqueKey(),
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  });
}


// <<---------------------------------------------------------->>

  //                       Next widget 


contactUs(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: size.height * 0.2,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri(scheme: 'tel', path: '81296353553');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        child: SvgPicture.asset(
                          'Asset/phone-call-svgrepo-com.svg',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'Phone',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://www.google.com/search?q=google&sxsrf=APwXEdcEdAbszBacONR_Nmv2RKaVGvTNbw%3A1687863253617&ei=1b-aZO6YJf_cseMPjPCuMA&ved=0ahUKEwiu16TNpOP_AhV_bmwGHQy4CwYQ4dUDCA8&uact=5&oq=google&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCCMQigUQJzIHCCMQigUQJzIECCMQJzIWCC4QgAQQFBCHAhCxAxCDARDHARDRAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMgsIABCABBCxAxCDAToKCAAQRxDWBBCwAzoKCAAQigUQsAMQQzoICAAQgAQQsQNKBAhBGABQ8AZYvBRg9xZoAXABeACAAc0BiAGGCpIBBTAuOS4xmAEAoAEBwAEByAEJ&sclient=gws-wiz-serp');

                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        // color: Colors.amber,
                        child: SvgPicture.asset('Asset/whatsapp.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'WhattsApp',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://www.google.com/search?q=google&sxsrf=APwXEdcEdAbszBacONR_Nmv2RKaVGvTNbw%3A1687863253617&ei=1b-aZO6YJf_cseMPjPCuMA&ved=0ahUKEwiu16TNpOP_AhV_bmwGHQy4CwYQ4dUDCA8&uact=5&oq=google&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCCMQigUQJzIHCCMQigUQJzIECCMQJzIWCC4QgAQQFBCHAhCxAxCDARDHARDRAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMgsIABCABBCxAxCDAToKCAAQRxDWBBCwAzoKCAAQigUQsAMQQzoICAAQgAQQsQNKBAhBGABQ8AZYvBRg9xZoAXABeACAAc0BiAGGCpIBBTAuOS4xmAEAoAEBwAEByAEJ&sclient=gws-wiz-serp');

                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        // color: Colors.amber,
                        child: SvgPicture.asset('Asset/insta.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'Instagram',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final url = Uri.parse('https://www.google.com/search?q=google&sxsrf=APwXEdcEdAbszBacONR_Nmv2RKaVGvTNbw%3A1687863253617&ei=1b-aZO6YJf_cseMPjPCuMA&ved=0ahUKEwiu16TNpOP_AhV_bmwGHQy4CwYQ4dUDCA8&uact=5&oq=google&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCCMQigUQJzIHCCMQigUQJzIECCMQJzIWCC4QgAQQFBCHAhCxAxCDARDHARDRAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMgsIABCABBCxAxCDAToKCAAQRxDWBBCwAzoKCAAQigUQsAMQQzoICAAQgAQQsQNKBAhBGABQ8AZYvBRg9xZoAXABeACAAc0BiAGGCpIBBTAuOS4xmAEAoAEBwAEByAEJ&sclient=gws-wiz-serp');

                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.height * 0.04,
                        // color: Colors.amber,
                        child: SvgPicture.asset('Asset/facebook-logo-meta-2-svgrepo-com.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          'Facebook',
                          style: AppStyle.poppinsBold12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // <<---------------------------------------------------------->>

  //                       Next widget 

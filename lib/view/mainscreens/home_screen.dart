import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxverse/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 28),
                        child: Text(
                          'Welcome...',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.poppinsBold27,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 149,
                  width: 336,
                  margin: const EdgeInsets.only(top: 25, left: 25),
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
                          padding: const EdgeInsets.only(left: 17),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 140,
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
                Container(
                  margin: const EdgeInsets.only(top: 38, left: 25, right: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: blackColor.withOpacity(0.1),
                        hintText: 'Search Service',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: const Color(0xa0000000),
                        ),
                        prefix: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'Asset/img_search.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 26),
                  child: Text(
                    'Explore Our Services',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.poppinsBold24,
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 17, left: 17),
                              padding: const EdgeInsets.only(
                                left: 11,
                                top: 7,
                                bottom: 7,
                              ),
                              decoration: BoxDecoration(
                                color: blackColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'Asset/home_2.png',
                                      height: 111,
                                      width: 136,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 7, left: 24),
                                      child: Text(
                                        'Gst Registraion',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.poppinsBold12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 17,
                                    width: 54,
                                    margin: const EdgeInsets.only(left: 36),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'GET NOW',
                                        style: AppStyle.poppinsBold12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 17, left: 17),
                              padding: const EdgeInsets.only(
                                left: 11,
                                top: 7,
                                bottom: 7,
                              ),
                              decoration: BoxDecoration(
                                color: blackColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'Asset/home_2.png',
                                      height: 111,
                                      width: 136,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 7, left: 24),
                                      child: Text(
                                        'Gst Registraion',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.poppinsBold12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 17,
                                    width: 54,
                                    margin: const EdgeInsets.only(left: 36),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text('GET NOW'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 14);
                    },
                    itemCount: 2)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

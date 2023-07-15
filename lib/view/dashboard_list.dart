import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/api/api.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/dashboard.dart';

class DashBoardListTile extends StatelessWidget {
  const DashBoardListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: APIs.getClientGstData(),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs ?? [];
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    children: [
                      Text(
                        'Your Application',
                        style: AppStyle.poppinsBold24,
                      ),
                      SizedBox(height: size.height * 0.05),
                      data.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Container(
                                    height: size.height * 0.1,
                                    width: size.height * 0.09,
                                    decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: size.width * 0.03),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Service:   ${data[index]['ServiceName']}',
                                                style: AppStyle.poppinsBold16,
                                              ),
                                              Text(
                                                'Business Name:   ${data[index]['BusinessName']}',
                                                style: AppStyle.poppinsBold16,
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            left: size.width * 0.67,
                                            top: size.height * 0.02,
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Dashboard(data: data[index]),
                                                  ),
                                                );
                                              },
                                              child: const Icon(Icons.arrow_forward_ios_outlined),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : SizedBox(
                              height: size.height * 0.6,
                              child: Center(
                                child: Text(
                                  'NO APPLICATION',
                                  style: AppStyle.poppinsBold18,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: SpinKitThreeBounce(color: blackColor));
          }
        });
  }
}

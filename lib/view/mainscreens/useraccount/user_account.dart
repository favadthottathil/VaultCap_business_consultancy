import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/useraccount/provider/useraccount_provider.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/mainscreens/useraccount/widget/useraccount_widget.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  final placeController = TextEditingController();

  // getUserData() async {
  String imageurl = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('ClientDetails').where('Email', isEqualTo: firebaseAuth.currentUser!.email).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userdata = snapshot.data!.docs[0];
          return Scaffold(
            backgroundColor: blackColor,
            body: SafeArea(
              child: SizedBox(
                height: size.height * 0.9,
                child: Material(
                  child: CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: MySliverAppBar(expandedHeight: size.height * 0.23, user: userdata),
                      ),
                      Consumer<UserAccountProvider>(builder: (context, provider, child) {
                        return SliverList(
                          // delegate: sliverChildListDelegate(size, userdata, provider),
                          delegate: sliverChildListDelegate(
                            size,
                            userdata,
                            provider,
                            nameController,
                            phoneController,
                            addressController,
                            placeController,
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              children: [
                Center(
                  child: Text(
                    'Error ',
                    style: AppStyle.poppinsBold27,
                  ),
                )
              ],
            ),
          );
        } else {
          return const SpinKitThreeBounce(color: blackColor);
        }
      },
    );
  }
}

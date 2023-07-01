
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/settings.dart';
import 'package:taxverse/view/user/user_details.dart';
import 'package:taxverse/view/user/user_edit.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final placeController = TextEditingController();

  // getUserData() async {
  @override
  void initState() {
    // ignore: unused_local_variable
    var userEmail = FirebaseAuth.instance.currentUser!.email;
    super.initState();
  }

  Map<String, UserEdit> userEdit = {
    'Name': UserEdit(),
    'phoneNumber': UserEdit(),
    'address': UserEdit(),
    'place': UserEdit(),
  };

  String imageurl = '';

  // updateName() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('ClientDetails')
  //       .where(
  //         'Email',
  //         isEqualTo: userEmail,
  //       )
  //       .get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     await querySnapshot.docs.first.reference.update({
  //       'profile': imageurl,
  //     });
  //     log('usser name updated');
  //   }
  // }

  // pickImage() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   log('jdlfka');

  //   if (user != null) {
  //     print('favad');
  //     String uid = user.uid;

  //     ImagePicker imagePicker = ImagePicker();

  //     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

  //     if (file == null) return;

  //     Reference reference = FirebaseStorage.instance.ref();
  //     Reference referenceDirImage = reference.child('news');
  //     Reference referenceImageToUpload = referenceDirImage.child(uid);

  //     try {
  //       await referenceImageToUpload.putFile(File(file.path));
  //       imageurl = await referenceImageToUpload.getDownloadURL();
  //     } catch (e) {
  //       log('$e');
  //     }
  //   }
  //   log('message');
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('ClientDetails').where('Email', isEqualTo: userEmail).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userdata = snapshot.data!.docs.first;
          return Scaffold(
            backgroundColor: blackColor,
            body: SafeArea(
              child: Material(
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: MySliverAppBar(expandedHeight: size.height * 0.27, user: userdata),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const SizedBox(
                            height: 120,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: UserDetialsHead(
                              name: 'Name',
                              fontsize: 15,
                              top: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                          ),
                          if (userEdit['Name']?.showEdit == false || userEdit['Name']?.showEdit == null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserData(text: userdata['Name']),
                                Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        userEdit['Name']?.showEdit = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                )
                              ],
                            ),
                          if (userEdit['Name']?.showEdit == true)
                            UserEditTextfield(
                              controller: nameController,
                              hintText: 'John Doe',
                              userEmail: userEmail!,
                              userEdit: userEdit,
                              userdata: userdata['Name'],
                              mapName: 'Name',
                              filedName: 'Name',
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: const CustomDivider(),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: UserDetialsHead(
                              name: 'Email Address',
                              fontsize: 15,
                              top: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                          ),
                          UserData(text: userdata['Email']),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: const CustomDivider(),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: UserDetialsHead(
                              name: 'phone number',
                              fontsize: 15,
                              top: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                          ),
                          if (userEdit['phoneNumber']?.showEdit == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserData(
                                  text: userdata['phone_number'] == '' ? 'Add phone Number' : userdata['phone_number'],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        userEdit['phoneNumber']?.showEdit = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                )
                              ],
                            ),
                          if (userEdit['phoneNumber']?.showEdit == true)
                            UserEditTextfield(
                              controller: phoneController,
                              hintText: '81297442',
                              userEmail: userEmail!,
                              userEdit: userEdit,
                              userdata: userdata['phone_number'],
                              filedName: 'phone_number',
                              mapName: 'phoneNumber',
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: const CustomDivider(),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: UserDetialsHead(
                              name: 'Address',
                              fontsize: 15,
                              top: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                          ),
                          if (userEdit['address']?.showEdit == false || userEdit['address']?.showEdit == null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserData(text: userdata['Address'] == '' ? 'Add Address' : userdata['Address']),
                                Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        userEdit['address']?.showEdit = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                )
                              ],
                            ),
                          if (userEdit['address']?.showEdit == true)
                            UserEditTextfield(
                              controller: addressController,
                              hintText: 'Address',
                              userEmail: userEmail!,
                              userEdit: userEdit,
                              userdata: userdata['Address'],
                              filedName: 'Address',
                              mapName: 'address',
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: const CustomDivider(),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: UserDetialsHead(
                              name: 'Place',
                              fontsize: 15,
                              top: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                          ),
                          if (userEdit['place']?.showEdit == false || userEdit['place']?.showEdit == null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserData(text: userdata['place'] == '' ? 'Add place' : userdata['place']),
                                Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        userEdit['place']?.showEdit = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                )
                              ],
                            ),
                          if (userEdit['place']?.showEdit == true)
                            UserEditTextfield(
                              controller: placeController,
                              hintText: 'place',
                              userEmail: userEmail!,
                              userEdit: userEdit,
                              userdata: userdata['place'],
                              filedName: 'place',
                              mapName: 'place',
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: const CustomDivider(),
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ),
                    )
                  ],
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

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  final QueryDocumentSnapshot user;

 

  MySliverAppBar({
    required this.expandedHeight,
    required this.user,
    
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: blackColor,
          ),
          child: const SizedBox(),
        ),
        Row(
          children: [
            SizedBox(width: size.width * 0.03),
            Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
              ),
            ),
            SizedBox(width: size.width * 0.04),
            Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Text(
                user['Name'],
                style: AppStyle.poppinsBoldWhite20,
              ),
            ),
          ],
        ),
        Positioned(
          top: expandedHeight / 4 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      'Hello ${user['Name']}',
                      style: AppStyle.poppinsBoldWhite18,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SizedBox(
                        height: expandedHeight,
                        width: MediaQuery.of(context).size.width / 2,
                        child: CircularProfileAvatar('',
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            borderColor: blackColor,
                            borderWidth: 4,
                            child: Image.asset(
                              'Asset/dp.png',
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: size.width * 0.91,
          top: size.width * 0.045,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settingss(),
                  ));
            },
            child: const Icon(Icons.settings, color: whiteColor),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class UserEdit {
  bool showEdit = false;
}

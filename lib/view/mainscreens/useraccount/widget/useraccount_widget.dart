import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/mainscreens/useraccount/provider/useraccount_provider.dart';
import 'package:taxverse/utils/client_id.dart';
import 'package:taxverse/view/settings/settings.dart';
import 'package:taxverse/view/mainscreens/useraccount/widget/user_details.dart';
import 'package:taxverse/view/mainscreens/useraccount/widget/user_edit.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  final QueryDocumentSnapshot user;

  MySliverAppBar({
    required this.expandedHeight,
    required this.user,
  });

  Future<void> pickFile() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final downloadLink = await uploadPdf(file);

      try {
        final userEmail = FirebaseAuth.instance.currentUser!.email;

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('ClientDetails')
            .where(
              'Email',
              isEqualTo: userEmail,
            )
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.update({
            'userProfileImage': downloadLink,
          });

          log('profile updated');
        }
      } catch (e) {
        log('message   $e');
      }
    }
  }

  Future<String> uploadPdf(File file) async {
    final reference = FirebaseStorage.instance.ref().child("usersProfiles");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      // fit: StackFit.expand,
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
                child: CircularProfileAvatar(
                  '',
                  radius: 30,
                  // backgroundColor: Colors.transparent,
                  // borderColor: blackColor,
                  borderWidth: 1,
                  child: user['userProfileImage'] == ''
                      ? Image.asset('Asset/profileAvather.png')
                      : CachedNetworkImage(
                          imageUrl: user['userProfileImage'],
                          placeholder: (context, url) => const Center(
                            child: SpinKitThreeBounce(
                              color: blackColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
                          fit: BoxFit.fill,
                        ),
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
              clipBehavior: Clip.hardEdge,
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
                        child: CircularProfileAvatar(
                          '',
                          radius: 100,
                          // backgroundColor: Colors.transparent,
                          // borderColor: blackColor,
                          borderWidth: 4,
                          child: user['userProfileImage'] == ''
                              ? Image.asset('Asset/profileAvather.png')
                              : CachedNetworkImage(
                                  imageUrl: user['userProfileImage'],
                                  placeholder: (context, url) => const Center(
                                    child: SpinKitThreeBounce(
                                      color: blackColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: size.height * 0.04,
                  left: size.width * 0.23,
                  child: InkWell(
                    onTap: () {
                      pickFile();
                    },
                    child: IgnorePointer(
                      child: SvgPicture.asset(
                        'Asset/add_dp.svg',
                        // ignore: deprecated_member_use
                        color: blackColor,
                      ),
                    ),
                  ),
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
              log('message');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settingss(),
                  ));
            },
            child: const Icon(Icons.settings, color: whiteColor),
          ),
        ),
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

// <<---------------------------------------------------------->>

//                       Next widget

SliverChildListDelegate sliverChildListDelegate(
  Size size,
  QueryDocumentSnapshot<Map<String, dynamic>> userdata,
  UserAccountProvider provider,
  TextEditingController nameController,
  TextEditingController phoneController,
  TextEditingController addressController,
  TextEditingController placeController,
) {
  return SliverChildListDelegate(
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
      if (provider.userEdit['Name']?.showEdit == false)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserData(text: userdata['Name']),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
              child: InkWell(
                onTap: () {
                  provider.setShowEditTrueName();
                },
                child: const Icon(Icons.edit),
              ),
            )
          ],
        ),
      if (provider.userEdit['Name']?.showEdit == true)
        UserEditTextfield(
          controller: nameController,
          hintText: 'John Doe',
          userEmail: userEmail!,
          userEdit: provider.userEdit,
          userdata: userdata['Name'],
          mapName: 'Name',
          filedName: 'Name',
          userExisitingData: userdata['Name'],
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
      if (provider.userEdit['phoneNumber']?.showEdit == false)
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
                  provider.setShowEditTruephone();
                },
                child: const Icon(Icons.edit),
              ),
            )
          ],
        ),
      if (provider.userEdit['phoneNumber']?.showEdit == true)
        UserEditTextfield(
          controller: phoneController,
          hintText: '81297442',
          userEmail: userEmail!,
          userEdit: provider.userEdit,
          userdata: userdata['phone_number'],
          filedName: 'phone_number',
          mapName: 'phoneNumber',
          userExisitingData: userdata['phone_number'] ?? '',
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
      if (provider.userEdit['address']?.showEdit == false)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserData(text: userdata['Address'] == '' ? 'Add Address' : userdata['Address']),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
              child: InkWell(
                onTap: () {
                  provider.setShowEditTrueAddress();
                },
                child: const Icon(Icons.edit),
              ),
            )
          ],
        ),
      if (provider.userEdit['address']?.showEdit == true)
        UserEditTextfield(
          controller: addressController,
          hintText: 'Address',
          userEmail: userEmail!,
          userEdit: provider.userEdit,
          userdata: userdata['Address'],
          filedName: 'Address',
          mapName: 'address',
          userExisitingData: userdata['Address'] ?? '',
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
      if (provider.userEdit['place']?.showEdit == false)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserData(text: userdata['place'] == '' ? 'Add place' : userdata['place']),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.08, top: size.height * 0.02),
              child: InkWell(
                onTap: () {
                  provider.setShowEditTruePlace();
                },
                child: const Icon(Icons.edit),
              ),
            )
          ],
        ),
      if (provider.userEdit['place']?.showEdit == true)
        UserEditTextfield(
          controller: placeController,
          hintText: 'place',
          userEmail: userEmail!,
          userEdit: provider.userEdit,
          userdata: userdata['place'],
          filedName: 'place',
          mapName: 'place',
          userExisitingData: userdata['place'] ?? '',
        ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: const CustomDivider(),
      ),
      SizedBox(height: size.height * 0.02),
    ],
  );
}

// <<---------------------------------------------------------->>

//                       Next widget

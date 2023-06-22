import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxverse/api/messaging_api.dart';
import 'package:taxverse/constants.dart';
import 'package:taxverse/utils/date_util.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    super.key,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String imageUrl = '';

  bool showEmoji = false;

  String adminMessageToken = '';

  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String currentUserId = '';

  getAdminId() async {
    User? user = auth.currentUser;

    if (user != null) {
      currentUserId = user.email!;
    }
  }

  void sendMessage(String message) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    firestore.collection('chats').add({
      'participants': [
        'admin',
        currentUserId
      ],
      'text': message,
      'time': time,
      'sender': 'admin',
      'read': '',
      'image': '',
    });
  }

  void sendImage() {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    firestore.collection('chats').add({
      'participants': [
        'admin',
        currentUserId
      ],
      'text': '',
      'time': time,
      'sender': 'admin',
      'read': '',
      'image': imageUrl,
    });
  }

  Future<void> pickFromCamera() async {
    ImagePicker imagePicker = ImagePicker();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

      if (file != null) {
        Uint8List imageFile = await file.readAsBytes();
        try {
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('chatImages').child(uid);
          UploadTask uploadTask = referenceDirImages.putData(imageFile);
          TaskSnapshot snap = await uploadTask;
          imageUrl = await snap.ref.getDownloadURL();
        } catch (error) {
          log('$error');
        }
      }
    }
  }

  Future<void> pickFromGallery() async {
    ImagePicker imagePicker = ImagePicker();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        Uint8List imageFile = await file.readAsBytes();
        try {
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('chatImages').child(uid);
          UploadTask uploadTask = referenceDirImages.putData(imageFile);
          TaskSnapshot snap = await uploadTask;
          imageUrl = await snap.ref.getDownloadURL();
        } catch (error) {
          log('$error');
        }
      }
    }
  }

  updateMessageReadStatus(String messageID) {
    firestore.collection('chats').doc(messageID).update({
      'read': 'read'
    });
  }

  @override
  void initState() {
    super.initState();
    getAdminId();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (showEmoji) {
            setState(() {
              showEmoji = !showEmoji;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: blackColor,
            title: StreamBuilder(
              stream: firestore.collection('admins').snapshots(),
              builder: (context, snapshot) {
                final admin = snapshot.data?.docs;
                if (snapshot.data != null) {
                  final checkOnline = admin![0]['is_online'] ? 'online' : 'employee is offline';

                  adminMessageToken = admin[0]['message_token'];

                  log('admin token $adminMessageToken');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin',
                        // 'jdjakdahsaah',
                        style: AppStyle.poppinsBoldWhite18,
                      ),
                      Text(
                        checkOnline,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                } else {
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin',
                        // 'jdjakdahsaah',
                        style: AppStyle.poppinsBoldWhite18,
                      ),
                      Text(
                        'failed to user status',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );;
                }
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: firestore
                      .collection('chats')
                      .where(
                        'participants',
                        arrayContains: currentUserId,
                      )
                      .orderBy(
                        'time',
                        descending: false,
                      )
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    final messages = snapshot.data?.docs ?? [];

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error : ${snapshot.error}',
                          style: AppStyle.poppinsBold24,
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SpinKitCircle(
                        color: Colors.black,
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index].data();
                        final docId = messages[index].id;
                        // updateMessageReadStatus(docId);
                        final isSendMessage = (message as Map<String, dynamic>)['sender'] == 'admin';
                        return MessageCard(
                          message: message,
                          isSender: isSendMessage,
                          updateRead: updateMessageReadStatus,
                          docId: docId,
                        );
                      },
                    );
                    //  else {
                    //   return const Center(
                    //     child: Text('error'),
                    //   );
                    // }
                  },
                ),
              ),
              _chatInput(),
              if (showEmoji)
                SizedBox(
                  height: size.height * .35,
                  child: EmojiPicker(
                    textEditingController: _message,
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isAndroid ? 1.30 : 1.0),
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      loadingIndicator: const SizedBox.shrink(),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() => showEmoji = !showEmoji);
                    },
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: blackColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _message,
                      onTap: () {
                        if (showEmoji) {
                          setState(() {
                            showEmoji = !showEmoji;
                          });
                        }
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Type Something....',
                        hintStyle: AppStyle.poppinsBold16,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await pickFromGallery();
                      sendImage();
                    },
                    icon: const Icon(
                      Icons.image,
                      color: blackColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      log('====befor ==== $imageUrl');
                      await pickFromCamera();

                      log('====after ==== $imageUrl');

                      sendImage();
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              final message = _message.text.trim();

              if (message.isNotEmpty) {
                sendMessage(message);
                _message.clear();

                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  log(user.displayName!);

                  log(' admin token $adminMessageToken');

                  MessagingAPI.sendPushNotification(adminMessageToken, message, user.displayName!);
                }
              }
            },
            shape: const CircleBorder(),
            minWidth: 0,
            padding: const EdgeInsets.all(10),
            color: Colors.green,
            child: const Icon(
              Icons.send,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.isSender,
    required this.updateRead,
    required this.docId,
  });

  final Object? message;

  final bool isSender;

  final void Function(String) updateRead;

  final String docId;

  @override
  Widget build(BuildContext context) {
    if (!isSender) {
      updateRead(docId);
    }

    return Align(
      // alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: isSender
          ? Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 10, top: 20, left: 40),
                        decoration: BoxDecoration(
                          // color: Colors.blue.shade100,
                          border: Border.all(color: blackColor),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Wrap(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                (message as Map<String, dynamic>)['image'] == ''
                                    ? Text(
                                        (message as Map<String, dynamic>)['text'],
                                        // 'jdjjdfs',
                                        style: AppStyle.poppinsBold16,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: (message as Map<String, dynamic>)['image'],
                                          errorWidget: (context, url, error) {
                                            return Center(
                                              child: Text(
                                                'Unable To Fetch Image',
                                                style: AppStyle.poppinsBold16,
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) => const SpinKitCircle(color: blackColor),
                                        ),
                                      ),
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5, top: 5),
                                    child: _buildTickIcon((message as Map<String, dynamic>)['read']),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(right: 17),
                        child: Text(
                          MyDateUtil.getFormattedTime(
                            context: context,
                            time: (message as Map<String, dynamic>)['time'],
                          ),
                          style: AppStyle.poppinsRegular12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                        margin: const EdgeInsets.only(left: 20, top: 20, right: 60),
                        decoration: BoxDecoration(
                          // color: Colors.cyan.shade100,
                          border: Border.all(color: blackColor),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            (message as Map<String, dynamic>)['image'] == ''
                                ? Text(
                                    (message as Map<String, dynamic>)['text'],
                                    style: AppStyle.poppinsBold16,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: (message as Map<String, dynamic>)['image'],
                                      errorWidget: (context, url, error) {
                                        return Center(
                                          child: Text(
                                            'Unable To Fetch Image',
                                            style: AppStyle.poppinsBold16,
                                          ),
                                        );
                                      },
                                      placeholder: (context, url) => const SpinKitCircle(color: blackColor),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          MyDateUtil.getFormattedTime(
                            context: context,
                            time: (message as Map<String, dynamic>)['time'],
                          ),
                          style: AppStyle.poppinsRegular12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

_buildTickIcon(String read) {
  if (read.isNotEmpty) {
    return const Icon(
      Icons.done_all_rounded,
      size: 20,
      color: Colors.blue,
    );
  } else {
    return const Icon(
      Icons.done_rounded,
      size: 20,
    );
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/controller/providers/chatroom_provider.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/widgets/chat_widgets.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({
    super.key,
  });

  String adminMessageToken = '';

  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  // getAdminId() async {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      curentUserEmail;
    });
    final size = MediaQuery.of(context).size;
    return Consumer<ChatRoomProvider>(builder: (context, provider, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () {
            if (provider.showEmoji) {
              provider.showEmojiState();

              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: blackColor,
              leading: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNav(guest: false),
                    ),
                    (route) => false),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin',
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
                    );
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
                          arrayContains: curentUserEmail,
                        )
                        .orderBy(
                          'time',
                          descending: true,
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
                        // shrinkWrap: true,
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = messages[index].data();
                          final docId = messages[index].id;
                          // updateMessageReadStatus(docId);
                          final isSendMessage = (message as Map<String, dynamic>)['sender'] == 'admin';
                          return MessageCard(
                            message: message,
                            isSender: isSendMessage,
                            updateRead: provider.updateMessageReadStatus,
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
                chatInput(message: _message, adminMessageToken: adminMessageToken),
                if (provider.showEmoji)
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
    });
  }
}

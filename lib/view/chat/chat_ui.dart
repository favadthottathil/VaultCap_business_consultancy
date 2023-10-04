import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/chat/chat_provider/chatroom_provider.dart';
import 'package:taxverse/view/mainscreens/navigate_screen.dart';
import 'package:taxverse/view/chat/chat_widget/chat_widgets.dart';

// ignore: must_be_immutable
class ChatRoom extends StatelessWidget {
  ChatRoom({Key? key}) : super(key: key);

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String adminMessageToken = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ChatRoomProvider>(
      builder: (context, provider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          curentUserEmail;
        });

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () async {
              if (provider.showEmoji) {
                provider.showEmojiState();
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
              appBar: buildAppBar(context),
              body: Column(
                children: [
                  Expanded(child: buildMessageList(context, provider)),
                  chatInput(message: _message, adminMessageToken: adminMessageToken),
                  if (provider.showEmoji) buildEmojiPicker(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build the app bar
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: blackColor,
      leading: GestureDetector(
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNav(isGuest: false),
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
          final checkOnline = admin?[0]['is_online'] ?? false ? 'online' : 'employee is offline';

          adminMessageToken = admin?[0]['message_token'] ?? '';

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
        },
      ),
    );
  }

  // Build the message list
  Widget buildMessageList(BuildContext context, ChatRoomProvider provider) {
    return StreamBuilder(
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
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildErrorWidget('Error : ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitCircle(
            color: Colors.black,
          );
        }

        final messages = snapshot.data?.docs ?? [];
        return StreamBuilder(
          stream: firestore
              .collection('ClientDetails')
              .where(
                'Email',
                isEqualTo: curentUserEmail,
              )
              .limit(1)
              .snapshots(),
          builder: (context, snapshot1) {
            if (snapshot1.hasError) {
              return buildErrorWidget('Error : ${snapshot1.error}');
            }

            if (snapshot1.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(
                color: Colors.black,
              );
            }

            final clients = snapshot1.data?.docs;
            final isMessage = clients?[0]['isMessage'] ?? false;

            return isMessage == false
                ? buildWelcomeMessage()
                : buildMessageListView(messages, context, provider);
          },
        );
      },
    );
  }

  // Build an error widget
  Widget buildErrorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: AppStyle.poppinsBold24,
      ),
    );
  }

  // Build a welcome message when there are no messages
  Widget buildWelcomeMessage() {
    return Center(
      child: SizedBox(
        width: 100.w,
        height: 23.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('Asset/chat-svgrepo-com.svg', height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Welcome to our chat! Feel free to ask any questions you have',
                style: AppStyle.poppinsBold18,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Build the list view of chat messages
  Widget buildMessageListView(List<DocumentSnapshot> messages, BuildContext context, ChatRoomProvider provider) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        final message = messages[index].data();
        final docId = messages[index].id;
        final isSendMessage = (message as Map<String, dynamic>)['sender'] == 'admin';

        return MessageCard(
          message: message,
          isSender: isSendMessage,
          updateRead: provider.updateMessageReadStatus,
          docId: docId,
        );
      },
    );
  }

  // Build the emoji picker widget
  Widget buildEmojiPicker(context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
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
    );
  }
}

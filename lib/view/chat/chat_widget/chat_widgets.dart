import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vaultcap/api/api_const.dart';
import 'package:vaultcap/api/messaging_api.dart';
import 'package:vaultcap/utils/constant/constants.dart';
import 'package:vaultcap/utils/date_util.dart';
import 'package:vaultcap/view/chat/chat_provider/chatroom_provider.dart';


class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.message,
    required this.isSender,
    required this.updateRead,
    required this.docId,
  }) : super(key: key);

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

Widget chatInput({
  required TextEditingController message,
  required String adminMessageToken,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 10,
    ),
    child: Consumer<ChatRoomProvider>(builder: (context, provider, child) {
      return Row(
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
                      provider.showEmojiState();
                    },
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: blackColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: message,
                      onTap: () {
                        if (provider.showEmoji) {
                          provider.showEmojiState();
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
                      await provider.pickFromGallery();
                      provider.sendImage();
                    },
                    icon: const Icon(
                      Icons.image,
                      color: blackColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await provider.pickFromCamera();
                      provider.sendImage();
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
              final messages = message.text.trim();

              if (messages.isNotEmpty) {
                provider.sendMessage(messages);
                provider.isMessageTrue();
                message.clear();

                MessagingAPI.sendPushNotification(adminMessageToken, messages, currentUserName);
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
      );
    }),
  );
}

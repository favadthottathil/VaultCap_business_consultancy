import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxverse/api/api_const.dart';

class ChatRoomProvider extends ChangeNotifier {
  String imageUrl = '';

  bool _showEmoji = false;

  bool get showEmoji => _showEmoji;

  showEmojiState() {
    _showEmoji = !_showEmoji;

    notifyListeners();
  }

  isMessageTrue() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ClientDetails')
        .where(
          'Email',
          isEqualTo: curentUserEmail,
        )
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({
        'isMessage': true,
      });

      log('profile updated');
    }
  }

  void sendMessage(String message) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    firestore.collection('chats').add({
      'participants': [
        'admin',
        curentUserEmail
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
        curentUserEmail
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
          Reference referenceRoot = firebaseStorage.ref();
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
}

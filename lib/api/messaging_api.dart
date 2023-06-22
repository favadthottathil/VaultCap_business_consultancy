import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class MessagingAPI {
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then(
      (t) {
        if (t != null) {
          messageTokenToDatabase(t);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log(
          'Message also contained a notification: ${message.notification}',
        );
      }
    });
  }

  static sendPushNotification(String messageToken, String message, String userName) async {
    try {
      final body = {
        "to": messageToken,
        "notification": {
          "title": userName,
          "body": message,
          "android_channel_id":"chats",
        },
        "data": {
          "some_data": "User ID: $userName",
        }
      };

      Response response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'key=AAAA0P_GUt4:APA91bHcL44BeKK2BwLMu0L9JfzkA2uFWh4v0wGd8w2j9T8QqT8FQeLZQ2FiBEbj3PRTtWFPIjp2_pNOHThfG3vn11OUSl0n-HlMXyiYfhaI0zZ8fY-To4XyKGqDEv2HR34HMsAykrqn'
        },
        body: jsonEncode(body),
      );
      log('Response Status: ${response.statusCode}');
      log('Response body : ${response.body}');
    } catch (e) {
      log('error in Message push notification======   $e');
    }
  }

  static messageTokenToDatabase(String token) async {
    try {
      CollectionReference collectionReference = FirebaseFirestore.instance.collection('ClientDetails');

      QuerySnapshot querySnapshot = await collectionReference.get();

      for (var doc in querySnapshot.docs) {
        // get the document ID

        String docId = doc.id;

        // update the document by adding a new field

        await collectionReference.doc(docId).update({
          'message_token': token,
        });
      }
      log('Message=====token added');
    } catch (e) {
      log('erro ===== $e');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

FirebaseStorage firebaseStorage = FirebaseStorage.instance;

var currentUserName = '';

final curentUserEmail = firebaseAuth.currentUser!.email;



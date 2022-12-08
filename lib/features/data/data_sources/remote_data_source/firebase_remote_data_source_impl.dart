import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../../const.dart';
import '../../../domain/entities/user/user_entity.dart';
import '../../models/users/user_model.dart';
import 'firebase_remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDatasource {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<void> createUser(UserEntity userEntity) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        username: userEntity.username,
        email: userEntity.email,
        profileUrl: userEntity.profileUrl,
        bio: userEntity.bio,
        name: userEntity.name,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Some error occur");
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where('uid', isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUser(UserEntity userEntity) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity userEntity) async {
    try {
      if (userEntity.email!.isNotEmpty || userEntity.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: userEntity.email!, password: userEntity.password!);
      } else {
        toast("Fields cannot be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("User not found");
      } else if (e.code == "wrong-passowrd") {
        toast("Invalid email or password");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity userEntity) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: userEntity.email!, password: userEntity.password!)
          .then((value) async {
        if (value.user?.uid != null) {
          await createUser(userEntity);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("E-Mail is already taken");
      } else {
        toast("Something wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity userEntity) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = {};

    if (userEntity.username != "" && userEntity.username != null) {
      userInformation["username"] = userEntity.username;
    }
    if (userEntity.profileUrl != "" && userEntity.profileUrl != null) {
      userInformation["profileUrl"] = userEntity.profileUrl;
    }
    if (userEntity.bio != "" && userEntity.bio != null) {
      userInformation["bio"] = userEntity.bio;
    }
    if (userEntity.name != "" && userEntity.name != null) {
      userInformation["name"] = userEntity.name;
    }

    userCollection.doc(userEntity.uid).update(userInformation);
  }

  @override
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }
}

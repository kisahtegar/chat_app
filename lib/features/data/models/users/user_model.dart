import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? uid,
    String? username,
    String? email,
  }) : super(
          uid: uid,
          username: username,
          email: email,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
      };
}

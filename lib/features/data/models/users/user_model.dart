import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? uid,
    String? username,
    String? email,
    String? profileUrl,
    String? bio,
    String? name,
  }) : super(
          uid: uid,
          username: username,
          email: email,
          profileUrl: profileUrl,
          bio: bio,
          name: name,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      profileUrl: snapshot['profileUrl'],
      bio: snapshot['bio'],
      name: snapshot['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "profileUrl": profileUrl,
        "bio": bio,
        "name": name,
      };
}

import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? email;
  final String? profileUrl;
  final String? bio;
  final String? name;

  // will not going to store in DB
  final String? password;
  final String? otherUid;
  final File? imageFile;

  const UserEntity({
    this.uid,
    this.username,
    this.email,
    this.password,
    this.otherUid,
    this.profileUrl,
    this.imageFile,
    this.bio,
    this.name,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        email,
        password,
        otherUid,
        profileUrl,
        imageFile,
        bio,
        name,
      ];
}

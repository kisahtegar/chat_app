import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? email;

  // will not going to store in DB
  final String? password;
  final String? otherUid;

  const UserEntity({
    this.uid,
    this.username,
    this.email,
    this.password,
    this.otherUid,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        email,
        password,
        otherUid,
      ];
}

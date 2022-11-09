import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/usecases/firebase_usecases/user/get_user_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUsecase updateUserUsecase;
  final GetUserUsecase getUserUsecase;

  UserCubit({
    required this.updateUserUsecase,
    required this.getUserUsecase,
  }) : super(UserInitial());

  Future<void> getUsers({required UserEntity userEntity}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUserUsecase.call(userEntity);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity userEntity}) async {
    emit(UserLoading());
    try {
      await updateUserUsecase.call(userEntity);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}

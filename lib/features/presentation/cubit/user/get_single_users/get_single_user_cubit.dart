import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/firebase_usecases/user/get_single_users_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUsersUsecase getSingleUsersUsecase;

  GetSingleUserCubit({
    required this.getSingleUsersUsecase,
  }) : super(GetSingleUserInitial());

  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUsersUsecase.call(uid);
      streamResponse.listen((users) {
        emit(GetSingleUserLoaded(userEntity: users.first));
      });
    } on SocketException catch (_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}

part of 'get_single_user_cubit.dart';

abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object> get props => [];
}

class GetSingleUserInitial extends GetSingleUserState {}

class GetSingleUserLoading extends GetSingleUserState {}

class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity userEntity;

  const GetSingleUserLoaded({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

class GetSingleUserFailure extends GetSingleUserState {}

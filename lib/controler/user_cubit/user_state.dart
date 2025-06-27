part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UploadProfilePic extends UserState {}

// sign in states
final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errorMessage;
  SignInFailure({required this.errorMessage});
}

// sign up states
final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}

final class SignUpSuccess extends UserState {
  final String message;
  SignUpSuccess({required this.message});
}

// get user data states
final class GetUserDataSuccess extends UserState {
  final User user;
  GetUserDataSuccess({required this.user});
}

final class GetUserDataLoading extends UserState {}

final class GetUserDataFailure extends UserState {
  final String errorMessage;
  GetUserDataFailure({required this.errorMessage});
}

// tank valve states
final class TankValveStateLoading extends UserState {}

final class TankValveStateSuccess extends UserState {}

final class TankValveStateFailure extends UserState {
  final String errorMessage;
  TankValveStateFailure({required this.errorMessage});
}

// main valve states
final class MainValveStateLoading extends UserState {}

final class MainValveStateSuccess extends UserState {}

final class MainValveStateFailure extends UserState {
  final String errorMessage;
  MainValveStateFailure({required this.errorMessage});
}

// cado valve states
final class CadoValveStateLoading extends UserState {}

final class CadoValveStateSuccess extends UserState {}

final class CadoValveStateFailure extends UserState {
  final String errorMessage;
  CadoValveStateFailure({required this.errorMessage});
}

// tank value states
final class TankValueLoading extends UserState {}

final class TankValueSuccess extends UserState {}

final class TankValueFailure extends UserState {
  final String errorMessage;
  TankValueFailure({required this.errorMessage});
}

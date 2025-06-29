import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/models/log_out_model.dart';
import 'package:smart_home/models/sign_in_model.dart';
import 'package:smart_home/models/user_model.dart';
import 'package:smart_home/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(UserInitial());

//profile pic
  XFile? profilePic;

  SignInModel? user;

  getUserProfile() async {
    emit(GetUserDataLoading());
    final response = await userRepository.getUserProfile();
    response.fold(
        (errorMessage) => emit(GetUserDataFailure(errorMessage: errorMessage)),
        (userModel) => emit(GetUserDataSuccess(userModel: userModel)));
  }

  logOut() async {
    emit(LogoutLoading());
    final response = await userRepository.logOut();
    response.fold(
        (errorMessage) => emit(LogoutFailure(errorMessage: errorMessage)),
        (logOutModel) => emit(LogoutSuccess(logOutModel: logOutModel)));
  }

  signUp(
      {required String fullName,
      required String email,
      required String password,
      required String confirmPassword,
      required String username,
      required String phoneNumber}) async {
    emit(SignUpLoading());
    final response = await userRepository.signUp(
      fullName: fullName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      username: username,
      phoneNumber: phoneNumber,
      // profilePic: profilePic!
    );
    response.fold(
        (errorMessage) => emit(SignUpFailure(errorMessage: errorMessage)),
        (signInModel) => emit(SignInSuccess()));
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  signIn({required String usernameOrPhone, required String password}) async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
        usernameOrPhone: usernameOrPhone, password: password);
    response.fold(
        (errorMessage) => emit(SignInFailure(errorMessage: errorMessage)),
        (signInModel) => emit(SignInSuccess()));
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ApiKey.token);
  }
}

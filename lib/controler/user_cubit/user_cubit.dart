import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
        (userModel) => emit(GetUserDataSuccess(user: userModel)));
  }

  signUp(
      {required String fullName,
        required String email,
      required String password,
      required String confirmPassword,
      required String name,
      required String phoneNumber}) async {
    emit(SignUpLoading());
    final response = await userRepository.signUp(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        name: name,
        phoneNumber: phoneNumber,
        // profilePic: profilePic!
        );
    response.fold(
        (errorMessage) => emit(SignUpFailure(errorMessage: errorMessage)),
        (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)));
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  signIn({required String email, required String password}) async {
    emit(SignInLoading());
    final response =
        await userRepository.signIn(email: email, password: password);
    response.fold(
        (errorMessage) => emit(SignInFailure(errorMessage: errorMessage)),
        (signInModel) => emit(SignInSuccess()));
  }

}

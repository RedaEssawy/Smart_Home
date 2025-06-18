
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/core/functions/upload_image_to_api.dart';
import 'package:smart_home/models/sign_in_model.dart';
import 'package:smart_home/models/sign_up_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;
  UserCubit(this.api) : super(UserInitial());

// Sing in form key
GlobalKey<FormState> signInFormKey  = GlobalKey();

//sign in email
TextEditingController  signInEmail  = TextEditingController();

//sign in password
TextEditingController  signInPassword  = TextEditingController();

// Sing up form key
GlobalKey<FormState> signUpFormKey  = GlobalKey();

//profile pic
XFile? profilePic;

//sign up name
TextEditingController  signUpName  = TextEditingController();

//sign up phone number
TextEditingController  signUpPhoneNumber  = TextEditingController();

//sign up email
TextEditingController  signUpEmail  = TextEditingController();

//sign up password
TextEditingController  signUpPassword  = TextEditingController();

//sign up confirm password
TextEditingController  signUpConfirmPassword  = TextEditingController();

SignInModel? user;

signUp()async{
  try {
    emit(SignUpLoading());
  final response = await api.post(EndPoints.singUp,isFormData:true,data: {
    ApiKey.name:signUpName.text,
    ApiKey.phone:signUpPhoneNumber.text,
    ApiKey.email:signUpEmail.text,
    ApiKey.password:signUpPassword.text,
    ApiKey.confirmPassword:signUpConfirmPassword.text,
    ApiKey.location:'{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
    ApiKey.profilePic:await uploadImageToApi(profilePic!)
  
    
  
  }
  );
  final signUpModel = SignUpModel.fromJson(response);
  emit(SignUpSuccess(message: signUpModel.message));


  
} on ServerException catch (e) {
  emit(SignUpFailure(errorMessage: e.errorModel.errorMessage));
  
}
}


uploadProfilePic(XFile image){
  profilePic = image;
  emit(UploadProfilePic());
  
}


signIn()async{
  try {
    emit(SignInLoading());
final response = await api.post(EndPoints.singIn,data: {
    ApiKey.email:signInEmail.text,
    ApiKey.password:signInPassword.text

  
  });
  user = SignInModel.ofJson(response.data);
  final decodedToken = JwtDecoder.decode(user!.token);
  CacheHelper().saveData(key: ApiKey.token, value: user!.token);
  CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
  emit(SignInSuccess());
}on  ServerException catch (e){ 
  emit(SignInFailure(errorMessage:(e.errorModel.errorMessage)));

  }}
}




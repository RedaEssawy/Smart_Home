
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/sign_in_model.dart';

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
// XFile? profilePic;

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


signIn()async{
  try {
    emit(SignInLoading());
final response = await api.post(EndPoints.singIn,data: {
    ApiKey.email:signInEmail.text,
    ApiKey.password:signInPassword.text

  
  });
  user = SignInModel.ofJson(response.data);
  final decodedToken = JwtDecoder.decode(user!.token);
  print(decodedToken['id']);
  emit(SignInSuccess());
}on  ServerException catch (e){ 
  emit(SignInFailure(errorMessage:(e.errorModel.errorMessage)));

  }}
}




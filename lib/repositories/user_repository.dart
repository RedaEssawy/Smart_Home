import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
// import 'package:smart_home/core/functions/upload_image_to_api.dart';
import 'package:smart_home/models/sign_in_model.dart';
import 'package:smart_home/models/user_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, SignInModel>> signIn(
      {required String usernameOrPhone, required String password}) async {
    try {
      final response = await api.post(EndPoints.singIn,
          data: {ApiKey.name: usernameOrPhone, ApiKey.password: password});
      // print(response.data[ApiKey.token]);
      final user = SignInModel.fromJson(response);
      // final decodedToken = JwtDecoder.decode(user.token);

      CacheHelper().saveData(
          key: ApiKey.token, value: response[ApiKey.token]); //user.token);
      // CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignInModel>> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    required String phoneNumber,
    // required XFile profilePic
  }) async {
    try {
      final response =
          await api.post(EndPoints.singUp, isFormData: false, data: {
        ApiKey.fullName: fullName,
        ApiKey.username: username,
        ApiKey.phone: phoneNumber,
        ApiKey.email: email,
        ApiKey.password: password,
        ApiKey.confirmPassword: confirmPassword,
        ApiKey.location: '123 Street',
        // ApiKey.profilePic: await uploadImageToApi(profilePic)
      });
      final signInModel = SignInModel.fromJson(response);
      return Right(signInModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    final dio = Dio();
    try {
      dio.options.baseUrl = EndPoints.baseUrl;
      dio.options.headers = {
        'Accept': 'application/json',

        'Content-Type': 'application/json',
        'Authorization':
            'Token ${CacheHelper().getData(key: ApiKey.token)}'
      };
      final response = await api.get('/api/profile/',data: 
      {
        ApiKey.name: CacheHelper().getData(key: ApiKey.name),
        ApiKey.password: CacheHelper().getData(key: ApiKey.password),
      }
       
      
          );

      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

// uploadProfilePic(XFile image){
//   profilePic = image;
//   emit(UploadProfilePic());

// }
}

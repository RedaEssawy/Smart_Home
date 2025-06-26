import 'package:dartz/dartz.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smart_home/cache/cache_helper.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
// import 'package:smart_home/core/functions/upload_image_to_api.dart';
import 'package:smart_home/models/sign_in_model.dart';
import 'package:smart_home/models/sign_up_model.dart';
import 'package:smart_home/models/user_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, SignInModel>> signIn(
      {required String email, required String password}) async {
    try {
      final response = await api.post(EndPoints.singIn,
          data: {ApiKey.email: email, ApiKey.password: password});
      // print(response.data[ApiKey.token]);
      final user = SignInModel.ofJson(response);
      final decodedToken = JwtDecoder.decode(user.token);

      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> signUp(

      {
      required String fullName,  
      required String email,
      required String password,
      required String confirmPassword,
      required String name,
      required String phoneNumber,
      // required XFile profilePic
      }) async {
    try {
      final response =
          await api.post(EndPoints.singUp, isFormData: true, data: {
        ApiKey.fullName: fullName,
        ApiKey.name: name,
        ApiKey.phone: phoneNumber,
        ApiKey.email: email,
        ApiKey.password: password,
        ApiKey.confirmPassword: confirmPassword,
        ApiKey.location:
            '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
        // ApiKey.profilePic: await uploadImageToApi(profilePic)
      });
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(EndPoints.getUserDataEndPoint(
          CacheHelper().getData(key: ApiKey.token)));

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

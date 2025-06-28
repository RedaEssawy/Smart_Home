import 'package:dartz/dartz.dart';
import 'package:smart_home/core/api/api_consumer.dart';
import 'package:smart_home/core/api/end_points.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/models/tank_and_flow_model.dart';

class TankAndFlowRepo {
  final ApiConsumer api;
  TankAndFlowRepo(this.api); 
Future<Either<String,List<TankAndFlowModel>>> getTankAndFlow()async{
  try {
   final response = await api.get(EndPoints.getTankAndFlowEndPoint);
   final list = List<TankAndFlowModel>.from(response.map((x) => TankAndFlowModel.fromJson(x)));

   return Right(list);
     }    on ServerException catch (e) {
   return Left(e.errorModel.errorMessage);
}

}
}


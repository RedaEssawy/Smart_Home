import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/models/tank_and_flow_model.dart';
import 'package:smart_home/repositories/tank_and_flow_repo.dart';

part 'tank_and_flow_state.dart';

class TankAndFlowCubit extends Cubit<TankAndFlowState> {
  final TankAndFlowRepo tankAndFlowRepo; 
  List <TankAndFlowModel> tankAndFlowModels = [];
  TankAndFlowCubit({required this.tankAndFlowRepo}) : super(TankAndFlowInitial());

  getTankAndFlow()async {
    emit(TankAndFlowLoading());
    final response = await tankAndFlowRepo.getTankAndFlow();
    response.fold(
      (errorMessage) => emit(TankAndFlowError(errorMessage: errorMessage)),
     (tankAndFlowModel) {
       emit(TankAndFlowSuccess(tankAndFlowModels: tankAndFlowModel));
     tankAndFlowModels = tankAndFlowModel;

     },);
  }



}
class TankAndFlowValue {
  double flowRate1 ;
  double flowRate2;
  double tankLevel;

  TankAndFlowValue({required this.flowRate1,required this.flowRate2,required this.tankLevel});


}

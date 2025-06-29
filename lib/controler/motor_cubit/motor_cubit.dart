import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/models/motor_model.dart';
import 'package:smart_home/repositories/motor_repo.dart';

part 'motor_state.dart';

class MotorCubit extends Cubit<MotorState> {
  final MotorRepo motorRepo;
  MotorCubit({required this.motorRepo}) : super(MotorInitial());
  setMotorState({required bool motorStatus})async{
    emit(MotorLoading());
    final result = await motorRepo.getMotorStatus(motorStatus: motorStatus);
    result.fold(
      (errorMessage) => emit(MotorError(errorMessage: errorMessage)),
     (motorModel) => emit(MotorSuccess(motorModel: motorModel)),);
  }
}

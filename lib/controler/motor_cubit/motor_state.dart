part of 'motor_cubit.dart';


sealed class MotorState {}

final class MotorInitial extends MotorState {}

final class MotorLoading extends MotorState {}

final class MotorSuccess extends MotorState {
  final MotorModel motorModel;
  MotorSuccess({required this.motorModel});
}

final class MotorError extends MotorState {
  final String errorMessage;
  MotorError({required this.errorMessage});
}

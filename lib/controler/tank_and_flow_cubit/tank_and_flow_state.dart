part of 'tank_and_flow_cubit.dart';


sealed class TankAndFlowState {}

final class TankAndFlowInitial extends TankAndFlowState {}

final class TankAndFlowLoading extends TankAndFlowState {}

final class TankAndFlowError extends TankAndFlowState {
  final String errorMessage;
  TankAndFlowError({required this.errorMessage});
}

final class TankAndFlowSuccess extends TankAndFlowState {
  final List<TankAndFlowModel> tankAndFlowModels;
  TankAndFlowSuccess({required this.tankAndFlowModels});
}

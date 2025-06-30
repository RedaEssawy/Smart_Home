part of 'update_consumption_rate_cubit.dart';


sealed class UpdateConsumptionRateState {}

final class UpdateConsumptionRateInitial extends UpdateConsumptionRateState {}

final class UpdateConsumptionRateLoading extends UpdateConsumptionRateState {}

final class UpdateConsumptionRateSuccess extends UpdateConsumptionRateState {
  final UpdateConsumptionRateModel message;
  UpdateConsumptionRateSuccess({required this.message});
}

final class UpdateConsumptionRateError extends UpdateConsumptionRateState {
  final String errorMessage ;
  UpdateConsumptionRateError({required this.errorMessage});
}

final class SetConsumptionRateSuccess extends UpdateConsumptionRateState {
  final UpdateConsumptionRateModel message;
  SetConsumptionRateSuccess({required this.message});
}

final class SetConsumptionRateError extends UpdateConsumptionRateState {
  final String errorMessage ;
  SetConsumptionRateError({required this.errorMessage});
}

final class SetConsumptionRateLoading extends UpdateConsumptionRateState {}
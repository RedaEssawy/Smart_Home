part of 'consumption_cubit.dart';


sealed class ConsumptionState {}

final class ConsumptionInitial extends ConsumptionState {}

final class GetConsumptionRateSccess  extends ConsumptionState {
  final ConsumptionModel consumptionModel;
  GetConsumptionRateSccess({required this.consumptionModel});
}

final class GetConsumptionRateLoading  extends ConsumptionState {}

final class GetConsumptionRateFailure  extends ConsumptionState {
  final String errorMessage;
  GetConsumptionRateFailure({required this.errorMessage});
}

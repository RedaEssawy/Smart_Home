import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/models/update_consumption_rate_model.dart';
import 'package:smart_home/repositories/%20update_consumption_rate_repo.dart';

part 'update_consumption_rate_state.dart';

class UpdateConsumptionRateCubit extends Cubit<UpdateConsumptionRateState> {
  final UpdateConsumptionRateRepo updateConsumptionRateRepo;

  UpdateConsumptionRateCubit(this.updateConsumptionRateRepo)
      : super(UpdateConsumptionRateInitial());

  updateConsumptionRate({required String tankLevel, required String period}) async {
    emit(UpdateConsumptionRateLoading());
    final result = await updateConsumptionRateRepo.updateConsumptionRate(
        tankLevel: tankLevel, period: period);
    result.fold(
        (errorMessage) =>
            emit(UpdateConsumptionRateError(errorMessage: errorMessage)),
        (updateConsumptionRateModel) => emit(
            UpdateConsumptionRateSuccess(message: updateConsumptionRateModel)));
  }

  setConsumptionRate({required String tankLevel, required String period}) async {
    emit(UpdateConsumptionRateLoading());
    final result = await updateConsumptionRateRepo.setConsumptionRate(
        tankLevel: tankLevel, period: period);
    result.fold(
        (errorMessage) =>
            emit(UpdateConsumptionRateError(errorMessage: errorMessage)),
        (updateConsumptionRateModel) => emit(
            UpdateConsumptionRateSuccess(message: updateConsumptionRateModel)));
  }




}

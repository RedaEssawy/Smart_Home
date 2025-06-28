import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/models/consuption_model.dart';
import 'package:smart_home/repositories/consumption_repository.dart';

part 'consumption_state.dart';

class ConsumptionCubit extends Cubit<ConsumptionState> {
  final ConsumptionRepository consumptionRepository;
  List<ConsumptionModel> consumptionModels=[];
  ConsumptionCubit(this.consumptionRepository) : super(ConsumptionInitial());
  getConsumptionRate() async {
    emit(GetConsumptionRateLoading());
    final result = await consumptionRepository.getConsumptionRate();
    result.fold(
      (errorMessage) =>
          emit(GetConsumptionRateFailure(errorMessage: errorMessage)),
      (consumptionModel) {
        emit(GetConsumptionRateSccess(consumptionModel: consumptionModel));
        consumptionModels=consumptionModel;
        // print('consumptionModels $consumptionModels');
        

      },
    );
  }

  List<ConsumptionData> consumptionData = [
    ConsumptionData(x: 1, y: 10),
    ConsumptionData(x: 2, y: 5),
    ConsumptionData(x: 3, y: 4),
    ConsumptionData(x: 4, y: 9),
    ConsumptionData(x: 5, y: 6),
    ConsumptionData(x: 6, y: 7),
    ConsumptionData(x: 7, y: 20),
    ConsumptionData(x: 8, y: 15),
    ConsumptionData(x: 9, y: 10),
    ConsumptionData(x: 10, y: 11),
  ];

  

  void routeData(ConsumptionModel consumptionModel) {
    if (consumptionData.length <= 10) {
      consumptionData.add(ConsumptionData(
          x: consumptionData.length + 1,
          y: double.parse(consumptionModel.consumption.toString())));
    } else {
      consumptionData.removeAt(0);
      consumptionData.add(ConsumptionData(
          x: consumptionData.length + 1,
          y: double.parse(consumptionModels[3].toString())));
    }
  }
}


class ConsumptionData {
  final double x;
  final double y;
  ConsumptionData({required this.x, required this.y});
}

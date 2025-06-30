import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/models/bulk_model.dart';
import 'package:smart_home/repositories/bulk_repo.dart';

part 'bulk_state.dart';

class BulkCubit extends Cubit<BulkState> {
  final BulkRepo bulkRepo ;

  BulkCubit(this.bulkRepo) : super(BulkInitial());
  setMotor({required String value})async{
    emit(BulkLoading());
    final result = await bulkRepo.setMotor(value: value);
    result.fold(
      (errorMessage) => emit(BulkError( errorMessage)),
     (bulkModel) => emit(BulkSuccess( bulkModel)));
  }

  setAutomode({required String value})async{
    emit(BulkLoading());
    final result = await bulkRepo.setAutomode(value: value);
    result.fold(
        (errorMessage) => emit(BulkError( errorMessage)),
        (bulkModel) => emit(BulkSuccess( bulkModel)));
  }

  setCadoValve({required String value})async{
    emit(BulkLoading());
    final result = await bulkRepo.setCadoValve(value: value);
    result.fold(
        (errorMessage) => emit(BulkError( errorMessage)),
        (bulkModel) => emit(BulkSuccess( bulkModel)));
  }

  setMainValve({required String value})async{
    emit(BulkLoading());
    final result = await bulkRepo.setMainValve(value: value);
    result.fold(
        (errorMessage) => emit(BulkError( errorMessage)),
        (bulkModel) => emit(BulkSuccess( bulkModel)));
  }

  setTankValve({required String value})async{
    emit(BulkLoading());
    final result = await bulkRepo.setTankValve(value: value);
    result.fold(
        (errorMessage) => emit(BulkError( errorMessage)),
        (bulkModel) => emit(BulkSuccess( bulkModel)));
  }


}

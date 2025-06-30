part of 'bulk_cubit.dart';
sealed class BulkState {}

final class BulkInitial extends BulkState {}

final class BulkLoading extends BulkState {}

final class BulkSuccess extends BulkState {
  final BulkModel bulkModel;
  BulkSuccess(this.bulkModel);
}

final class BulkError extends BulkState {
  final String errorMessage;
  BulkError(this.errorMessage);
}

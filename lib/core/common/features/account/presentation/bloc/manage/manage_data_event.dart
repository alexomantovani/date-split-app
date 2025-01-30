part of 'manage_data_bloc.dart';

abstract class ManageDataEvent extends Equatable {
  const ManageDataEvent();

  @override
  List<Object?> get props => [];
}

class SelectData<T> extends ManageDataEvent {
  final T data;

  const SelectData({required this.data});

  @override
  List<Object?> get props => [data];
}

class ClearData extends ManageDataEvent {
  const ClearData();
}

part of 'manage_data_bloc.dart';

abstract class ManageDataState extends Equatable {
  const ManageDataState();

  @override
  List<Object?> get props => [];
}

class ManageDataInitial extends ManageDataState {}

class ManageDataLoading extends ManageDataState {}

class PushData<T> extends ManageDataState {
  final List<T> dataList;

  const PushData({required this.dataList});

  @override
  List<Object?> get props => [dataList];
}

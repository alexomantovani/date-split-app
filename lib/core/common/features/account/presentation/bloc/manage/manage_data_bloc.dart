import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manage_data_event.dart';
part 'manage_data_state.dart';

class ManageDataBloc extends Bloc<ManageDataEvent, ManageDataState> {
  ManageDataBloc({required List<String> dataList})
      : _dataList = dataList,
        super(ManageDataInitial()) {
    on<SelectData>(_onSelectData);
    on<ClearData>(_onClearData);
  }

  final List<String> _dataList;

  Future<void> _onSelectData(
    SelectData event,
    Emitter<ManageDataState> emit,
  ) async {
    emit(ManageDataLoading());

    if (_dataList.contains(event.data)) {
      _dataList.remove(event.data);
    } else {
      _dataList.add(event.data);
    }

    if (_dataList.isNotEmpty) {
      emit(PushData(dataList: _dataList));
    }
  }

  Future<void> _onClearData(
    ClearData event,
    Emitter<ManageDataState> emit,
  ) async {
    if (_dataList.isNotEmpty) {
      _dataList.clear();
      emit(ManageDataInitial());
    }
  }
}

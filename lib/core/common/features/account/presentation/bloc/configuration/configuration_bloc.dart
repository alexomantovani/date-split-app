import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc({
    required String? avatar,
    required String? nickName,
  })  : _avatar = avatar,
        super(ConfigurationInitial()) {
    on<SelectConfigurationDataEvent>(_onSelectAvatar);
  }

  String? _avatar;
  String? _nickName;

  Future<void> _onSelectAvatar(SelectConfigurationDataEvent event,
      Emitter<ConfigurationState> emit) async {
    emit(ConfigurationLoading());
    _avatar = event.avatar;
    _nickName = event.nickName;
    emit(SelectConfigurationDataSuccess(avatar: _avatar, nickName: _nickName));
  }
}

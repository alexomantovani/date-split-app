part of 'configuration_bloc.dart';

abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent();

  @override
  List<Object?> get props => [];
}

class SelectConfigurationDataEvent extends ConfigurationEvent {
  const SelectConfigurationDataEvent({
    required this.avatar,
    required this.nickName,
  });

  final String? avatar;
  final String? nickName;

  @override
  List<Object?> get props => [avatar, nickName];
}

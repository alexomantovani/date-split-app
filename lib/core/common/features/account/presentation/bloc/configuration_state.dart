part of 'configuration_bloc.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object?> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoading extends ConfigurationState {}

class SelectConfigurationDataSuccess extends ConfigurationState {
  const SelectConfigurationDataSuccess({
    required this.avatar,
    required this.nickName,
  });

  final String? avatar;
  final String? nickName;

  @override
  List<Object?> get props => [avatar, nickName];
}

part of 'transfer_bloc.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferError extends TransferState {
  final String message;

  const TransferError(this.message);

  @override
  List<Object> get props => [message];
}

class TransferCreatedSuccess extends TransferState {}

class TransferLoadedSuccess extends TransferState {
  final Transfer transfer;

  const TransferLoadedSuccess(this.transfer);

  @override
  List<Object> get props => [transfer];
}

class TransferListLoadedSuccess extends TransferState {
  final List<Transfer> transfers;

  const TransferListLoadedSuccess(this.transfers);

  @override
  List<Object> get props => [transfers];
}

class TransferUpdatedSuccess extends TransferState {}

class TransferDeletedSuccess extends TransferState {}

part of 'transfer_bloc.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class CreateTransferEvent extends TransferEvent {
  final Transfer transfer;

  const CreateTransferEvent(this.transfer);

  @override
  List<Object> get props => [transfer];
}

class GetTransferByIdEvent extends TransferEvent {
  final String id;

  const GetTransferByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetAllTransfersEvent extends TransferEvent {
  final String userId;

  const GetAllTransfersEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateTransferEvent extends TransferEvent {
  final String id;
  final Transfer transfer;

  const UpdateTransferEvent(this.id, this.transfer);

  @override
  List<Object> get props => [id, transfer];
}

class DeleteTransferEvent extends TransferEvent {
  final String id;

  const DeleteTransferEvent(this.id);

  @override
  List<Object> get props => [id];
}

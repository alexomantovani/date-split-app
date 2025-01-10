import 'package:bloc/bloc.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';
import 'package:date_split_app/features/transfers/domain/repositories/transfer_repository.dart';
import 'package:equatable/equatable.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository transferRepository;

  TransferBloc({required this.transferRepository}) : super(TransferInitial()) {
    on<CreateTransferEvent>(_onCreateTransfer);
    on<GetTransferByIdEvent>(_onGetTransferById);
    on<GetAllTransfersEvent>(_onGetAllTransfers);
    on<UpdateTransferEvent>(_onUpdateTransfer);
    on<DeleteTransferEvent>(_onDeleteTransfer);
  }

  Future<void> _onCreateTransfer(
      CreateTransferEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    final result = await transferRepository.createTransfer(event.transfer);
    result.fold(
      (failure) => emit(TransferError(failure.message)),
      (_) => emit(TransferCreatedSuccess()),
    );
  }

  Future<void> _onGetTransferById(
      GetTransferByIdEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    final result = await transferRepository.getTransferById(event.id);
    result.fold(
      (failure) => emit(TransferError(failure.message)),
      (transfer) => emit(TransferLoadedSuccess(transfer)),
    );
  }

  Future<void> _onGetAllTransfers(
      GetAllTransfersEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    final result = await transferRepository.getAllTransfers(event.userId);
    result.fold(
      (failure) => emit(TransferError(failure.message)),
      (transfers) => emit(TransferListLoadedSuccess(transfers)),
    );
  }

  Future<void> _onUpdateTransfer(
      UpdateTransferEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    final result =
        await transferRepository.updateTransfer(event.id, event.transfer);
    result.fold(
      (failure) => emit(TransferError(failure.message)),
      (_) => emit(TransferUpdatedSuccess()),
    );
  }

  Future<void> _onDeleteTransfer(
      DeleteTransferEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    final result = await transferRepository.deleteTransfer(event.id);
    result.fold(
      (failure) => emit(TransferError(failure.message)),
      (_) => emit(TransferDeletedSuccess()),
    );
  }
}

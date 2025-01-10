import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';
import 'package:date_split_app/features/transfers/domain/repositories/transfer_repository.dart';
import 'package:date_split_app/features/transfers/presentation/bloc/transfer_bloc.dart';

import 'transfer_bloc_test.mocks.dart';

@GenerateMocks([TransferRepository])
void main() {
  late MockTransferRepository mockTransferRepository;
  late TransferBloc transferBloc;

  setUp(() {
    mockTransferRepository = MockTransferRepository();
    transferBloc = TransferBloc(transferRepository: mockTransferRepository);
  });

  tearDown(() {
    transferBloc.close();
  });

  const testUserId = 'user123';
  const testTransferId = 'transfer123';
  final testTransfer = Transfer(
    id: testTransferId,
    value: 100.0,
    transferredBy: 'user123',
    transferredTo: 'user456',
    date: DateTime(2023, 12, 25),
  );
  final testTransfersList = [testTransfer];

  group('CreateTransferEvent', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferCreatedSuccess] on successful creation',
      build: () {
        when(mockTransferRepository.createTransfer(testTransfer))
            .thenAnswer((_) async => const Right(null));
        return transferBloc;
      },
      act: (bloc) => bloc.add(CreateTransferEvent(testTransfer)),
      expect: () => [
        TransferLoading(),
        TransferCreatedSuccess(),
      ],
      verify: (_) {
        verify(mockTransferRepository.createTransfer(testTransfer)).called(1);
      },
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferError] on failure',
      build: () {
        when(mockTransferRepository.createTransfer(testTransfer))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Creation failed',
                    statusCode: 500,
                  ),
                ));
        return transferBloc;
      },
      act: (bloc) => bloc.add(CreateTransferEvent(testTransfer)),
      expect: () => [
        TransferLoading(),
        const TransferError('Creation failed'),
      ],
      verify: (_) {
        verify(mockTransferRepository.createTransfer(testTransfer)).called(1);
      },
    );
  });

  group('GetTransferByIdEvent', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferLoadedSuccess] on successful retrieval',
      build: () {
        when(mockTransferRepository.getTransferById(testTransferId))
            .thenAnswer((_) async => Right(testTransfer));
        return transferBloc;
      },
      act: (bloc) => bloc.add(const GetTransferByIdEvent(testTransferId)),
      expect: () => [
        TransferLoading(),
        TransferLoadedSuccess(testTransfer),
      ],
      verify: (_) {
        verify(mockTransferRepository.getTransferById(testTransferId))
            .called(1);
      },
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferError] on failure',
      build: () {
        when(mockTransferRepository.getTransferById(testTransferId))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Transfer not found',
                    statusCode: 404,
                  ),
                ));
        return transferBloc;
      },
      act: (bloc) => bloc.add(const GetTransferByIdEvent(testTransferId)),
      expect: () => [
        TransferLoading(),
        const TransferError('Transfer not found'),
      ],
      verify: (_) {
        verify(mockTransferRepository.getTransferById(testTransferId))
            .called(1);
      },
    );
  });

  group('GetAllTransfersEvent', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferListLoadedSuccess] on successful retrieval',
      build: () {
        when(mockTransferRepository.getAllTransfers(testUserId))
            .thenAnswer((_) async => Right(testTransfersList));
        return transferBloc;
      },
      act: (bloc) => bloc.add(const GetAllTransfersEvent(testUserId)),
      expect: () => [
        TransferLoading(),
        TransferListLoadedSuccess(testTransfersList),
      ],
      verify: (_) {
        verify(mockTransferRepository.getAllTransfers(testUserId)).called(1);
      },
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferError] on failure',
      build: () {
        when(mockTransferRepository.getAllTransfers(testUserId))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Failed to load transfers',
                    statusCode: 500,
                  ),
                ));
        return transferBloc;
      },
      act: (bloc) => bloc.add(const GetAllTransfersEvent(testUserId)),
      expect: () => [
        TransferLoading(),
        const TransferError('Failed to load transfers'),
      ],
      verify: (_) {
        verify(mockTransferRepository.getAllTransfers(testUserId)).called(1);
      },
    );
  });

  group('UpdateTransferEvent', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferUpdatedSuccess] on successful update',
      build: () {
        when(mockTransferRepository.updateTransfer(
                testTransferId, testTransfer))
            .thenAnswer((_) async => const Right(null));
        return transferBloc;
      },
      act: (bloc) =>
          bloc.add(UpdateTransferEvent(testTransferId, testTransfer)),
      expect: () => [
        TransferLoading(),
        TransferUpdatedSuccess(),
      ],
      verify: (_) {
        verify(mockTransferRepository.updateTransfer(
                testTransferId, testTransfer))
            .called(1);
      },
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferError] on failure',
      build: () {
        when(mockTransferRepository.updateTransfer(
                testTransferId, testTransfer))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Update failed',
                    statusCode: 500,
                  ),
                ));
        return transferBloc;
      },
      act: (bloc) =>
          bloc.add(UpdateTransferEvent(testTransferId, testTransfer)),
      expect: () => [
        TransferLoading(),
        const TransferError('Update failed'),
      ],
      verify: (_) {
        verify(mockTransferRepository.updateTransfer(
                testTransferId, testTransfer))
            .called(1);
      },
    );
  });

  group('DeleteTransferEvent', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferDeletedSuccess] on successful deletion',
      build: () {
        when(mockTransferRepository.deleteTransfer(testTransferId))
            .thenAnswer((_) async => const Right(null));
        return transferBloc;
      },
      act: (bloc) => bloc.add(const DeleteTransferEvent(testTransferId)),
      expect: () => [
        TransferLoading(),
        TransferDeletedSuccess(),
      ],
      verify: (_) {
        verify(mockTransferRepository.deleteTransfer(testTransferId)).called(1);
      },
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferError] on failure',
      build: () {
        when(mockTransferRepository.deleteTransfer(testTransferId))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Deletion failed',
                    statusCode: 500,
                  ),
                ));
        return transferBloc;
      },
      act: (bloc) => bloc.add(const DeleteTransferEvent(testTransferId)),
      expect: () => [
        TransferLoading(),
        const TransferError('Deletion failed'),
      ],
      verify: (_) {
        verify(mockTransferRepository.deleteTransfer(testTransferId)).called(1);
      },
    );
  });
}

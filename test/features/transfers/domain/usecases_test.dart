import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';
import 'package:date_split_app/features/transfers/domain/repositories/transfer_repository.dart';

import 'usecases_test.mocks.dart';

@GenerateMocks([TransferRepository])
void main() {
  late MockTransferRepository mockTransferRepository;

  final transfer = Transfer(
    id: '1',
    value: 200.0,
    date: DateTime.now(),
    transferredBy: 'User1',
    transferredTo: 'User2',
  );

  const String id = '';

  setUp(() {
    mockTransferRepository = MockTransferRepository();
  });

  group('Create Transfer', () {
    test('should save transfer successfully', () async {
      // Simulação de sucesso
      when(mockTransferRepository.createTransfer(transfer))
          .thenAnswer((_) async => const Right(null));

      final result = await mockTransferRepository.createTransfer(transfer);

      // Verificações
      expect(result, const Right(null));
      verify(mockTransferRepository.createTransfer(transfer)).called(1);
    });

    test('should return failure when saving transfer fails', () async {
      // Simulação de falha
      when(mockTransferRepository.createTransfer(transfer)).thenAnswer(
        (_) async => const Left(
            ServerFailure(message: 'Failed to save transfer', statusCode: 500)),
      );

      final result = await mockTransferRepository.createTransfer(transfer);

      // Verificações
      expect(result, isA<Left>());
      verify(mockTransferRepository.createTransfer(transfer)).called(1);
    });
  });

  group('Read Transfer', () {
    test('should fetch transfer by ID successfully', () async {
      when(mockTransferRepository.getTransferById('1'))
          .thenAnswer((_) async => Right(transfer));

      final result = await mockTransferRepository.getTransferById('1');

      expect(result, Right(transfer));
      verify(mockTransferRepository.getTransferById('1')).called(1);
    });

    test('should return failure when transfer is not found', () async {
      when(mockTransferRepository.getTransferById('1')).thenAnswer((_) async =>
          const Left(
              ServerFailure(message: 'Transfer not found', statusCode: 404)));

      final result = await mockTransferRepository.getTransferById('1');

      expect(result, isA<Left>());
      verify(mockTransferRepository.getTransferById('1')).called(1);
    });
  });

  group('Get All Transfers', () {
    test('should fetch all transfers successfully', () async {
      final transfersList = [transfer];
      when(mockTransferRepository.getAllTransfers(id))
          .thenAnswer((_) async => Right(transfersList));

      final result = await mockTransferRepository.getAllTransfers(id);

      expect(result, Right(transfersList));
      verify(mockTransferRepository.getAllTransfers(id)).called(1);
    });

    test('should return failure when fetching transfers fails', () async {
      when(mockTransferRepository.getAllTransfers(id)).thenAnswer((_) async =>
          const Left(ServerFailure(
              message: 'Failed to fetch transfers', statusCode: 500)));

      final result = await mockTransferRepository.getAllTransfers(id);

      expect(result, isA<Left>());
      verify(mockTransferRepository.getAllTransfers(id)).called(1);
    });
  });

  group('Update Transfer', () {
    final updatedTransfer = Transfer(
      id: '1',
      value: 300.0,
      date: DateTime.now(),
      transferredBy: 'User1',
      transferredTo: 'User3',
    );

    test('should update transfer successfully', () async {
      // Simulação de sucesso
      when(mockTransferRepository.updateTransfer(id, updatedTransfer))
          .thenAnswer((_) async => const Right(null));

      final result =
          await mockTransferRepository.updateTransfer(id, updatedTransfer);

      // Verificações
      expect(result, const Right(null));
      verify(mockTransferRepository.updateTransfer(id, updatedTransfer))
          .called(1);
    });

    test('should return failure when updating transfer fails', () async {
      // Simulação de falha
      when(mockTransferRepository.updateTransfer(id, updatedTransfer))
          .thenAnswer(
        (_) async => const Left(ServerFailure(
            message: 'Failed to update transfer', statusCode: 500)),
      );

      final result =
          await mockTransferRepository.updateTransfer(id, updatedTransfer);

      // Verificações
      expect(result, isA<Left>());
      verify(mockTransferRepository.updateTransfer(id, updatedTransfer))
          .called(1);
    });
  });

  group('Delete Transfer', () {
    test('should delete transfer successfully', () async {
      // Simulação de sucesso
      when(mockTransferRepository.deleteTransfer('1'))
          .thenAnswer((_) async => const Right(null));

      final result = await mockTransferRepository.deleteTransfer('1');

      // Verificações
      expect(result, const Right(null));
      verify(mockTransferRepository.deleteTransfer('1')).called(1);
    });

    test('should return failure when deleting transfer fails', () async {
      // Simulação de falha
      when(mockTransferRepository.deleteTransfer('1')).thenAnswer(
        (_) async => const Left(ServerFailure(
            message: 'Failed to delete transfer', statusCode: 500)),
      );

      final result = await mockTransferRepository.deleteTransfer('1');

      // Verificações
      expect(result, isA<Left>());
      verify(mockTransferRepository.deleteTransfer('1')).called(1);
    });
  });
}

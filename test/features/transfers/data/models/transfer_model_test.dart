import 'package:date_split_app/features/transfers/data/models/transfer_model.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final date = DateTime.now();
  final transferModel = TransferModel(
    id: 'testTransferId123',
    value: 250.75,
    date: date,
    transferredBy: 'User1',
    transferredTo: 'User2',
  );

  group('TransferModel', () {
    test('should convert from Transfer entity correctly', () {
      // Arrange
      final transferEntity = Transfer(
        id: 'testTransferId123',
        value: 250.75,
        date: date,
        transferredBy: 'User1',
        transferredTo: 'User2',
      );

      // Act
      final model = TransferModel.fromEntity(transferEntity);

      // Assert
      expect(model.id, transferEntity.id);
      expect(model.value, transferEntity.value);
      expect(model.date, transferEntity.date);
      expect(model.transferredBy, transferEntity.transferredBy);
      expect(model.transferredTo, transferEntity.transferredTo);
    });

    test('should convert to Transfer entity correctly', () {
      // Act
      final entity = transferModel.toEntity();

      // Assert
      expect(entity.id, transferModel.id);
      expect(entity.value, transferModel.value);
      expect(entity.date, transferModel.date);
      expect(entity.transferredBy, transferModel.transferredBy);
      expect(entity.transferredTo, transferModel.transferredTo);
    });

    test('should convert from JSON correctly', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 'testTransferId123',
        'value': 250.75,
        'date': date.toIso8601String(),
        'transferredBy': 'User1',
        'transferredTo': 'User2',
      };

      // Act
      final model = TransferModel.fromJson(json);

      // Assert
      expect(model.id, json['id']);
      expect(model.value, json['value']);
      expect(model.date, DateTime.parse(json['date']));
      expect(model.transferredBy, json['transferredBy']);
      expect(model.transferredTo, json['transferredTo']);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = transferModel.toJson();

      // Assert
      expect(json['id'], transferModel.id);
      expect(json['value'], transferModel.value);
      expect(json['date'], transferModel.date.toIso8601String());
      expect(json['transferredBy'], transferModel.transferredBy);
      expect(json['transferredTo'], transferModel.transferredTo);
    });

    test('should return an empty TransferModel correctly', () {
      // Act
      final emptyModel = TransferModel.empty();

      // Assert
      expect(emptyModel.id, '');
      expect(emptyModel.value, 0.0);
      expect(emptyModel.date, DateTime(2012, 12, 16, 10));
      expect(emptyModel.transferredBy, '');
      expect(emptyModel.transferredTo, '');
    });

    test('should support value comparison with Equatable', () {
      // Arrange
      final anotherTransferModel = TransferModel(
        id: 'testTransferId123',
        value: 250.75,
        date: date,
        transferredBy: 'User1',
        transferredTo: 'User2',
      );

      // Assert
      expect(transferModel, equals(anotherTransferModel));
    });

    test('should have correct toString implementation', () {
      // Assert
      expect(
        transferModel.toString(),
        'TransferModel{id: testTransferId123, value: 250.75, date: $date, transferredBy: User1, transferredTo: User2}',
      );
    });
  });
}

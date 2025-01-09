import 'package:date_split_app/features/expenses/data/models/expese_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';

void main() {
  final date = DateTime.now();
  final expenseModel = ExpenseModel(
    id: 'testId123',
    name: 'Test Expense',
    value: 100.5,
    date: date,
    paidBy: 'Test Payer',
    sharedWith: const ['User1', 'User2'],
  );

  group('ExpenseModel', () {
    test('should convert from Expense entity correctly', () {
      // Arrange
      final expenseEntity = Expense(
        id: 'testId123',
        name: 'Test Expense',
        value: 100.5,
        date: date,
        paidBy: 'Test Payer',
        sharedWith: const ['User1', 'User2'],
      );

      // Act
      final model = ExpenseModel.fromEntity(expenseEntity);

      // Assert
      expect(model.id, expenseEntity.id);
      expect(model.name, expenseEntity.name);
      expect(model.value, expenseEntity.value);
      expect(model.date, expenseEntity.date);
      expect(model.paidBy, expenseEntity.paidBy);
      expect(model.sharedWith, expenseEntity.sharedWith);
    });

    test('should convert to Expense entity correctly', () {
      // Act
      final entity = expenseModel.toEntity();

      // Assert
      expect(entity.id, expenseModel.id);
      expect(entity.name, expenseModel.name);
      expect(entity.value, expenseModel.value);
      expect(entity.date, expenseModel.date);
      expect(entity.paidBy, expenseModel.paidBy);
      expect(entity.sharedWith, expenseModel.sharedWith);
    });

    test('should convert from JSON correctly', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 'testId123',
        'name': 'Test Expense',
        'value': 100.5,
        'date': date.toString(),
        'paidBy': 'Test Payer',
        'sharedWith': ['User1', 'User2'],
      };

      // Act
      final model = ExpenseModel.fromJson(json);

      // Assert
      expect(model.id, json['id']);
      expect(model.name, json['name']);
      expect(model.value, json['value']);
      expect(model.date, DateTime.parse(json['date']));
      expect(model.paidBy, json['paidBy']);
      expect(model.sharedWith, json['sharedWith']);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = expenseModel.toJson();

      // Assert
      expect(json['id'], expenseModel.id);
      expect(json['name'], expenseModel.name);
      expect(json['value'], expenseModel.value);
      expect(json['date'], expenseModel.date.toIso8601String());
      expect(json['paidBy'], expenseModel.paidBy);
      expect(json['sharedWith'], expenseModel.sharedWith);
    });

    test('should return an empty ExpenseModel correctly', () {
      // Act
      final emptyModel = ExpenseModel.empty();

      // Assert
      expect(emptyModel.id, '');
      expect(emptyModel.name, '');
      expect(emptyModel.value, 0.0);
      expect(emptyModel.date, DateTime(2012, 12, 16, 10));
      expect(emptyModel.paidBy, '');
      expect(emptyModel.sharedWith, isEmpty);
    });

    test('should support value comparison with Equatable', () {
      // Arrange
      final anotherExpenseModel = ExpenseModel(
        id: 'testId123',
        name: 'Test Expense',
        value: 100.5,
        date: date,
        paidBy: 'Test Payer',
        sharedWith: const ['User1', 'User2'],
      );

      // Assert
      expect(expenseModel, equals(anotherExpenseModel));
    });

    test('should have correct toString implementation', () {
      // Assert
      expect(
        expenseModel.toString(),
        'ExpenseModel{id: testId123, name: Test Expense, value: 100.5, date: $date, paidBy: Test Payer, sharedWith: [User1, User2]}',
      );
    });
  });
}

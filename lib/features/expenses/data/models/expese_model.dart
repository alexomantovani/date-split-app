import 'package:date_split_app/features/expenses/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.id,
    required super.name,
    required super.value,
    required super.date,
    required super.paidBy,
    required super.sharedWith,
  });

  ExpenseModel.empty()
      : this(
          id: '',
          name: '',
          value: 0.0,
          date: DateTime(2012, 12, 16, 10),
          paidBy: '',
          sharedWith: const [],
        );

  @override
  List<Object?> get props => [id, name, value, date, paidBy, sharedWith];

  @override
  String toString() {
    return 'ExpenseModel{id: $id, name: $name, value: $value, date: $date, paidBy: $paidBy, sharedWith: $sharedWith}';
  }

  // Métodos para conversão da camada de dados:
  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      name: expense.name,
      value: expense.value,
      date: expense.date,
      paidBy: expense.paidBy,
      sharedWith: expense.sharedWith,
    );
  }

  Expense toEntity() {
    return Expense(
      id: id,
      name: name,
      value: value,
      date: date,
      paidBy: paidBy,
      sharedWith: sharedWith,
    );
  }

  // Métodos de serialização para JSON
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      paidBy: json['paidBy'] as String,
      sharedWith: List<String>.from(json['sharedWith'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'date': date.toIso8601String(),
      'paidBy': paidBy,
      'sharedWith': sharedWith,
    };
  }
}

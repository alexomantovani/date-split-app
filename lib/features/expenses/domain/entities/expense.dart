import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String id;
  final String name;
  final double value;
  final DateTime date;
  final String paidBy;
  final List<String> sharedWith;

  const Expense({
    required this.id,
    required this.name,
    required this.value,
    required this.date,
    required this.paidBy,
    required this.sharedWith,
  });

  @override
  List<Object?> get props => [id, name, value, date, paidBy, sharedWith];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, value: $value, date: $date, paidBy: $paidBy, sharedWith: $sharedWith)';
  }
}

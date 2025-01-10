import 'package:equatable/equatable.dart';

class Transfer extends Equatable {
  final String id;
  final double value;
  final DateTime date;
  final String transferredBy;
  final String transferredTo;

  const Transfer({
    required this.id,
    required this.value,
    required this.date,
    required this.transferredBy,
    required this.transferredTo,
  });

  @override
  List<Object?> get props => [id, value, date, transferredBy, transferredTo];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return 'Transfer(id: $id, value: $value, date: $date, transferredBy: $transferredBy, transferredTo: $transferredTo)';
  }
}

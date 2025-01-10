import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';

class TransferModel extends Transfer {
  const TransferModel({
    required super.id,
    required super.value,
    required super.date,
    required super.transferredBy,
    required super.transferredTo,
  });

  TransferModel.empty()
      : this(
          id: '',
          value: 0.0,
          date: DateTime(2012, 12, 16, 10),
          transferredBy: '',
          transferredTo: '',
        );

  @override
  List<Object?> get props => [id, value, date, transferredBy, transferredTo];

  @override
  String toString() {
    return 'TransferModel{id: $id, value: $value, date: $date, transferredBy: $transferredBy, transferredTo: $transferredTo}';
  }

  // Métodos para conversão da camada de dados:
  factory TransferModel.fromEntity(Transfer transfer) {
    return TransferModel(
      id: transfer.id,
      value: transfer.value,
      date: transfer.date,
      transferredBy: transfer.transferredBy,
      transferredTo: transfer.transferredTo,
    );
  }

  Transfer toEntity() {
    return Transfer(
      id: id,
      value: value,
      date: date,
      transferredBy: transferredBy,
      transferredTo: transferredTo,
    );
  }

  // Métodos de serialização para JSON
  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      id: json['id'] as String,
      value: (json['value'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      transferredBy: json['transferredBy'] as String,
      transferredTo: json['transferredTo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'date': date.toIso8601String(),
      'transferredBy': transferredBy,
      'transferredTo': transferredTo,
    };
  }
}

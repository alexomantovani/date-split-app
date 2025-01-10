part of 'expenses_bloc.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class CreateExpenseEvent extends ExpensesEvent {
  final Expense expense;

  const CreateExpenseEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}

class GetExpenseByIdEvent extends ExpensesEvent {
  final String id;

  const GetExpenseByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetAllExpensesEvent extends ExpensesEvent {
  final String userId;

  const GetAllExpensesEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateExpenseEvent extends ExpensesEvent {
  final String id;
  final Expense expense;

  const UpdateExpenseEvent(this.id, this.expense);

  @override
  List<Object?> get props => [id, expense];
}

class DeleteExpenseEvent extends ExpensesEvent {
  final String id;

  const DeleteExpenseEvent(this.id);

  @override
  List<Object?> get props => [id];
}

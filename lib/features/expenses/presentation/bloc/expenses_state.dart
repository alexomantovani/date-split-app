part of 'expenses_bloc.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExpenseCreatedSuccess extends ExpensesState {}

class ExpenseLoadedSuccess extends ExpensesState {
  final Expense expense;

  const ExpenseLoadedSuccess(this.expense);

  @override
  List<Object?> get props => [expense];
}

class ExpensesListLoadedSuccess extends ExpensesState {
  final List<Expense> expenses;

  const ExpensesListLoadedSuccess(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

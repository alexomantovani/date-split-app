import 'package:bloc/bloc.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';
import 'package:date_split_app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:equatable/equatable.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpensesRepository expensesRepository;

  ExpensesBloc({required this.expensesRepository}) : super(ExpensesInitial()) {
    on<CreateExpenseEvent>(_onCreateExpense);
    on<GetExpenseByIdEvent>(_onGetExpenseById);
    on<GetAllExpensesEvent>(_onGetAllExpenses);
  }

  Future<void> _onCreateExpense(
      CreateExpenseEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    final result = await expensesRepository.createExpense(event.expense);
    result.fold(
      (failure) => emit(ExpensesError(failure.message)),
      (_) => emit(ExpenseCreatedSuccess()),
    );
  }

  Future<void> _onGetExpenseById(
      GetExpenseByIdEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    final result = await expensesRepository.getExpenseById(event.id);
    result.fold(
      (failure) => emit(ExpensesError(failure.message)),
      (expense) => emit(ExpenseLoadedSuccess(expense)),
    );
  }

  Future<void> _onGetAllExpenses(
      GetAllExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    final result = await expensesRepository.getAllExpenses(event.userId);
    result.fold(
      (failure) => emit(ExpensesError(failure.message)),
      (expenses) => emit(ExpensesListLoadedSuccess(expenses)),
    );
  }
}

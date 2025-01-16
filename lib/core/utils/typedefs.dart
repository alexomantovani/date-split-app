import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/failure.dart';

typedef EitherFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

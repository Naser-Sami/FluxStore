import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/_core.dart' show Failure;

abstract class BaseUseCase<T, P> {
  // p => parameters
  Future<Either<Failure, T>> call(P p);
}

// without any parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}


import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/token.dart';
import 'package:front/domain/repositories/user_repository.dart';

class AutoLoginUsecase {
  final UserRepository repository;

  const AutoLoginUsecase(this.repository);
  Future<Either<Failure, Token?>> call() async => await repository.autoLogin();
}


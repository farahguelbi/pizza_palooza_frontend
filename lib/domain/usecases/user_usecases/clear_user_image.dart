
import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/user_repository.dart';

class ClearUserImageUsecase {
  final UserRepository repository;

  ClearUserImageUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String userId) async =>
      await repository.clearUserImage(userId);
}
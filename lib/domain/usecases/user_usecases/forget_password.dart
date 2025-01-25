import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/user_repository.dart';

class ForgetPasswordUsecase {
  final UserRepository repository;

  const ForgetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required String destination}) async =>
      await repository.forgetPassword(email: email, destination: destination);
}
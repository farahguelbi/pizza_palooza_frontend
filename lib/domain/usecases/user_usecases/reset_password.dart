import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/user_repository.dart';

class ResetPasswordUsecase {
  final UserRepository repository;

  ResetPasswordUsecase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
  }) async {
    return await repository.resetPassword(
      email: email,
      password: password,
    );
  }
}

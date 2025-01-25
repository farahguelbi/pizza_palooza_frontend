import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/user_repository.dart';

class UpdatePassword {
  final UserRepository repository;

  UpdatePassword(this.repository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    return await repository.updatePassword(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}

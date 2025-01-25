import '../../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';

class UpdateUserUsecase {
  final UserRepository repository;

  UpdateUserUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
          {required address,
          required firstName,
          required lastName,
          required phone,
          required id,
          required birthDate,
          required gender}) async =>
      await repository.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        address: address,
        phone: phone,
        gender: gender,
        birthDate: birthDate,
      );
}

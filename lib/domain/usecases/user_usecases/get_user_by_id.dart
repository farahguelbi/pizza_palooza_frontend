import '../../repositories/user_repository.dart';
import '../../entities/user.dart';
import 'package:dartz/dartz.dart';
import'../../../core/errors/failures/failures.dart';
class GetUserByIdUsecase {
  final UserRepository repository;

  GetUserByIdUsecase(this.repository);

   Future<Either<Failure, User>> call({required String userId}) async =>
      await repository.getUserById( userId:userId);
  }


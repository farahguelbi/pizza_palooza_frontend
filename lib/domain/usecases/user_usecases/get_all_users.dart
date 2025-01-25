import '../../repositories/user_repository.dart';
import '../../entities/user.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
class GetAllUsers {
  final UserRepository repository;

  GetAllUsers(this.repository);

    Future<Either<Failure, List<User>>> call() async {
    return await repository.getAllUsers();
  }
}

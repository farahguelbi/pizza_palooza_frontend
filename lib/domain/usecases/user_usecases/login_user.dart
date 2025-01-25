import '../../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../entities/token.dart';
class LoginUsecase {
  final UserRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, Token>> call({required String email,required String password}) async => 
  await repository.loginUser(email: email,password: password);

  }


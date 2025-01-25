import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/user_repository.dart';

class OTPVerificationUsecase {
  final UserRepository repository;

  const OTPVerificationUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required int otp}) async =>
      await repository.verifyOTP(email: email, otp: otp);
}
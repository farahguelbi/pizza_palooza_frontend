import 'dart:io';

import 'package:dartz/dartz.dart';
import '../entities/token.dart';
import '../entities/user.dart';
import '../../core/errors/failures/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> registerUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      String? address,
      String? phone,
      String? image,
      DateTime? birthDate,
      String? gender});

  Future<Either<Failure, Token>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getUserById( {required String userId});
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, Unit>> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String gender,
    required DateTime birthDate,
  });
  Future<Either<Failure, Unit>> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });
  Future<Either<Failure, Unit>> updateImage({
    required String userId,
    required File image,
  });
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> resetPassword(
      {required String email, required String password});
  Future<Either<Failure, Unit>> deleteUser(String id);
  Future<Either<Failure, Unit>> verifyOTP(
      {required String email, required int otp});
  Future<Either<Failure, Unit>> forgetPassword(
      {required String email, required String destination});
  Future<Either<Failure, Token?>> autoLogin();
   Future<Either<Failure, Unit>> clearUserImage(String userId);
 
}

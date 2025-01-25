import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/models/token_model.dart';
import 'package:front/domain/usecases/user_usecases/register_user.dart';

import '../../core/errors/failures/failures.dart';
import '../../domain/entities/token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/datasources/remote_data_source/user_remote_datasource.dart';

 class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource LocalDataSource;

  UserRepositoryImpl(this.LocalDataSource,this.remoteDataSource,);


 @override
Future<Either<Failure, String>> registerUser({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  String? address,
  String? phone,
  String? image,
  DateTime? birthDate,
  String? gender,
}) async {
  try {
    final userId = await remoteDataSource.registerUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      address: address??'',
      phone: phone??'',
      image: image??'',
      birthDate: birthDate,
      gender: gender,
    );
    return Right(userId); // Return user ID on success.
  } catch (e) {
    return Left(ServerFailure()); // Handle failure.
  }
}


  @override
  Future<Either<Failure, Token>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      TokenModel tm = await remoteDataSource.loginUser(
        email: email,
        password: password,
      );
      await LocalDataSource.saveUserInformations(tm);
      Token t=Token(
        token: tm.token,
        expiryDate: tm.expiryDate,
        userId: tm.userId
       );
      return Right(t);
    }on LoginException catch(e){
      return left(LoginFailure(e.message));
    
    }on LocalStorageException  {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) async {
    try {
      final result = await remoteDataSource.getUserById(userId);
      print(result);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final result = await remoteDataSource.getAllUsers();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String gender,
    required DateTime birthDate,
  }) async {
    try {
      await remoteDataSource.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        address: address,
        phone: phone,
        gender: gender,
        birthDate: birthDate,
      );
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.updatePassword(
        userId: userId,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return Right(unit);
    }on DataNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateImage({
    required String userId,
    required File image,
  }) async {
    try {
      await remoteDataSource.updateImage(
        userId: userId,
        image:image,
      );
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await LocalDataSource.logout();
      return Right(unit);
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        email: email,
        password: password,
      );
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(String id) async {
    try {
      await remoteDataSource.deleteUser(id);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

    @override
  Future<Either<Failure, Unit>> verifyOTP(
      {required String email, required int otp}) async {
    try {
      await remoteDataSource.verifyOTP(email, otp);
      return const Right(unit);
    } on BadOTPException catch (e) {
      return Left(BadOTPFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword({
    required String email,
    required String destination,
  }) async {
    try {
      await remoteDataSource.forgetPassword(
        email: email,
        destination: destination,
      );
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
   @override
  Future<Either<Failure, Token?>> autoLogin() async {
    try {
      final tk = await remoteDataSource.autoLogin();
      return right(tk);
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> clearUserImage(String userId)async {
    
  try {
      await remoteDataSource.clearUserImage(userId);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
 
 
  
  
  }
  



  



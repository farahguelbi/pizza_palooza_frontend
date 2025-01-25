import 'dart:io';

import 'package:flutter/material.dart';

import '../../repositories/user_repository.dart';
import '../../../core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, String>> call(
          {String? address,
          required email,
          required firstName,
          required lastName,
          required password,
          String? phone,
          String? imageUrl,
          String? gender,
          DateTime? birthDate,
}) async {
         return  await repository.registerUser( 
          email: email,
          address: address,
          firstName: firstName,
          lastName: lastName,
          password: password,
          phone: phone,
          image: imageUrl,
          birthDate: birthDate,
          gender: gender);
}
}
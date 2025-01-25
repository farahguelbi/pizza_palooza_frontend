import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/user_repository.dart';

class UpdateImageUsecase {
  final UserRepository repository;

  UpdateImageUsecase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required File image,
  }) async {
    return await repository.updateImage(
      userId: userId,
      image:image,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/command_repository.dart';

class ChangePaymentMethod {
  final CommandRepository repository;

  ChangePaymentMethod(this.repository);

  Future<Either<Failure, Unit>> call(String commandId, String newPaymentMethod) async {
    return await repository.changePaymentMethod(commandId, newPaymentMethod);
  }
}

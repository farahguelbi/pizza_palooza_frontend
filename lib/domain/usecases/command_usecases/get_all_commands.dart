import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/command.dart';
import 'package:front/domain/repositories/command_repository.dart';

class GetAllCommands {
  final CommandRepository repository;

  GetAllCommands(this.repository);

  Future<Either<Failure, List<Command>>> call(String userId) async {
    return repository.getAllCommands(userId);
  }
}

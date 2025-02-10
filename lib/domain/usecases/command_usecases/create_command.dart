import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/command.dart';
import 'package:front/domain/repositories/command_repository.dart';

class CreateCommand {
  final CommandRepository repository;

  CreateCommand(this.repository);

  // Future<Either<Failure, Unit>> call(Command command) async {
  //   return await repository.createCommand(command);
    Future<Either<String, Command>> call(Map<String, dynamic> commandData) async {
    return await repository.createCommand(commandData);
  }
}
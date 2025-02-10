import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/command.dart';
import 'package:front/domain/repositories/command_repository.dart';

class GetCommandById {
  final CommandRepository repository;

  GetCommandById(this.repository);

  // Future<Either<Failure, Command>> call(String commandId) async {
  //   return await repository.getCommandById(commandId);
   Future<Either<String, Command>> call(String id) async {
    return await repository.getCommandById(id);
  }
}
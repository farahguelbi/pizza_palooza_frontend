import 'package:dartz/dartz.dart';
import 'package:front/domain/entities/command.dart';
import 'package:front/domain/repositories/command_repository.dart';

class UpdateCommand {
  final CommandRepository repository;
  UpdateCommand(this.repository);

  Future<Either<String, Command>> call(String id, Map<String, dynamic> commandData) async {
    return await repository.updateCommand(id, commandData);
  }
}


import 'package:dartz/dartz.dart';
import 'package:front/domain/repositories/command_repository.dart';

class DeleteCommand {
  final CommandRepository repository;
  DeleteCommand(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deleteCommand(id);
  }}
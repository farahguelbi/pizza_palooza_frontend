import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../entities/command.dart';

abstract class CommandRepository {
  Future<Either<Failure, Unit>> createCommand(Command command);
  Future<Either<Failure, List<Command>>> getAllCommands(String userId);
  Future<Either<Failure, Command>> getCommandById(String commandId);
  Future<Either<Failure, Unit>> cancelCommand(String commandId);
  Future<Either<Failure, Unit>> completeCommand(String commandId);
  Future<Either<Failure, Unit>> changePaymentStatus(String commandId, String paymentStatus);
  Future<Either<Failure, Unit>> changePaymentMethod(String commandId, String newPaymentMethod);
}

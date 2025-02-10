// lib/data/repositories/command_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/command.dart';
import '../../domain/repositories/command_repository.dart';
import '../datasources/remote_data_source/command_remote_datasource.dart';
import '../models/command_model.dart';

class CommandRepositoryImpl implements CommandRepository {
  final CommandRemoteDataSource commandRemoteDataSource;

  CommandRepositoryImpl({required this.commandRemoteDataSource});




@override
  Future<Either<String, Command>> createCommand(Map<String, dynamic> commandData) async {
    try {
      final result = await commandRemoteDataSource.createCommand(commandData);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Command>>> getAllCommands() async {
    try {
      final result = await commandRemoteDataSource.getAllCommands();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }



  @override
  Future<Either<String, Command>> getCommandById(String id) async {
    try {
      final result = await commandRemoteDataSource.getCommandById(id);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Command>> updateCommand(String id, Map<String, dynamic> commandData) async {
    try {
      final result = await commandRemoteDataSource.updateCommand(id, commandData);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteCommand(String id) async {
    try {
      await commandRemoteDataSource.deleteCommand(id);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }












//  @override
// Future<Either<Failure, List<Command>>> getAllCommands(String userId) async {
//   try {
//     final commandModels = await remoteDataSource.getAllCommands(userId);
//     // Convert CommandModel to Command
//     final commands = commandModels.map((model) => model.toEntity()).toList();
//     return Right(commands);
//   } catch (e) {
//     return Left(ServerFailure());
//   }
// }


//   @override
//   Future<Either<Failure, Command>> getCommandById(String commandId) async {
//     try {
//       final commandModel = await remoteDataSource.getCommandById(commandId);
//       return Right(commandModel);
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }

// @override
// Future<Either<Failure, Unit>> createCommand(Command command) async {
//   try {
//     final commandModel = CommandModel.fromEntity(command);
//     await remoteDataSource.createCommand(commandModel.toJson());
//     return const Right(unit); // Indicate success without returning a Command
//   } on ServerException {
//     return Left(ServerFailure());
//   } catch (e) {
//     return Left(ServerFailure());
//   }
// }
// @override
//   Future<Either<Failure, Unit>> cancelCommand(String commandId) async {
//     try {
//       await remoteDataSource.cancelCommand(commandId);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerFailure());
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }
//   @override
//   Future<Either<Failure, Unit>> changePaymentMethod(String commandId, String newPaymentMethod) async {
//     try {
//       await remoteDataSource.changePaymentMethod(commandId, newPaymentMethod);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerFailure());
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> changePaymentStatus(String commandId, String paymentStatus) async {
//     try {
//       await remoteDataSource.changePaymentStatus(commandId, paymentStatus);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerFailure());
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }

  
//   @override
//   Future<Either<Failure, Unit>> completeCommand(String commandId) async {
//     try {
//       await remoteDataSource.completeCommand(commandId);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerFailure());
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }



 
}

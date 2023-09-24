import 'package:dartz/dartz.dart';
import '../entities/app_errors.dart';

abstract class UseCase<Type,Params>{
  Future<Either<AppError,Type>> call(Params params);
}
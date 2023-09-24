import 'package:dartz/dartz.dart';
import 'package:my_task_app/domain/entities/app_errors.dart';

abstract class GetAllCategoriesRepository{
  Future<Either<AppError,List<String>>> getCategories();
}
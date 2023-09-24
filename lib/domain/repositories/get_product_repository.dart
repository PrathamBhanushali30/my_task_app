import 'package:dartz/dartz.dart';
import 'package:my_task_app/data/models/get_product_model.dart';
import 'package:my_task_app/domain/entities/app_errors.dart';

abstract class GetProductRepository{
  Future<Either<AppError,List<GetProductModel>>> getProducts(String category, Map<String, dynamic>? params);
}
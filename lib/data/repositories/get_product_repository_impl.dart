import 'package:dartz/dartz.dart';
import 'package:my_task_app/data/data_sources/get_product_remote_data_source.dart';
import 'package:my_task_app/data/models/get_product_model.dart';
import 'package:my_task_app/domain/entities/app_errors.dart';
import 'package:my_task_app/shared/utils/logger.dart';
import '../../domain/repositories/get_product_repository.dart';

class GetProductRepositoryImpl extends GetProductRepository {

  final GetProductRemoteDataSource _getProductRemoteDataSource;

  GetProductRepositoryImpl(this._getProductRemoteDataSource);

  @override
  Future<Either<AppError, List<GetProductModel>>> getProducts(String category, Map<String, dynamic>? params) async {
    try{
      final response = await _getProductRemoteDataSource.getProducts(category, params);
      return Right(response);
    }catch(e){
      Logger.prints(e);
      return const Left(AppError(AppErrorType.api));
    }
  }
}

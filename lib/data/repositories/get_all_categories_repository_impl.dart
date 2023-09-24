import 'package:dartz/dartz.dart';
import 'package:my_task_app/data/data_sources/get_all_categories_remote_data_source.dart';
import 'package:my_task_app/domain/entities/app_errors.dart';
import 'package:my_task_app/domain/repositories/get_all_categories_repository.dart';
import 'package:my_task_app/shared/utils/logger.dart';

class GetAllCategoriesRepositoryImpl extends GetAllCategoriesRepository{

  final GetAllCategoriesRemoteDataSource _allCategoriesRemoteDataSource;

  GetAllCategoriesRepositoryImpl(this._allCategoriesRemoteDataSource);
  @override
  Future<Either<AppError,List<String>>> getCategories() async {
    try{
      final response = await _allCategoriesRemoteDataSource.getCategories();
      return Right(response);
    }catch(e){
      Logger.prints(e);
      return const Left(AppError(AppErrorType.api));
    }
  }
}
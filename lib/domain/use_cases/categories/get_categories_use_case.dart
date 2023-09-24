import 'package:dartz/dartz.dart';
import 'package:my_task_app/domain/entities/app_errors.dart';
import 'package:my_task_app/domain/repositories/get_all_categories_repository.dart';
import 'package:my_task_app/domain/use_cases/use_case.dart';

class GetCategoriesUseCase extends UseCase<List<String>,String?>{

  final GetAllCategoriesRepository _getAllCategoriesRepository;

  GetCategoriesUseCase(this._getAllCategoriesRepository);
  @override
  Future<Either<AppError, List<String>>> call(String? params) async {
    return await _getAllCategoriesRepository.getCategories();
  }

}
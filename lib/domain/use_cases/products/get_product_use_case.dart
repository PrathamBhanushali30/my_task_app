import 'package:dartz/dartz.dart';
import 'package:my_task_app/data/models/get_product_model.dart';
import 'package:my_task_app/domain/entities/app_errors.dart';
import 'package:my_task_app/domain/repositories/get_product_repository.dart';
import 'package:my_task_app/domain/use_cases/use_case.dart';
import 'package:my_task_app/shared/utils/logger.dart';
import '../../../shared/constants/app_strings.dart';

class GetProductUseCase extends UseCase<List<GetProductModel>, Map<String, dynamic>> {
  final GetProductRepository _getProductRepository;

  GetProductUseCase(this._getProductRepository);

  @override
  Future<Either<AppError, List<GetProductModel>>> call(Map<String, dynamic> params) async {
    String category = params[Strings.strCategories];
    params.remove(Strings.strCategories);
    Logger.prints(category);
    Logger.prints(params);
    /*Map<String,dynamic> finalParams;
    finalParams = params;
    finalParams.remove(Strings.strCategories);
    Logger.prints(params[Strings.strCategories]);
    Logger.prints(finalParams);*/
    return await _getProductRepository.getProducts(category, params);
  }
}

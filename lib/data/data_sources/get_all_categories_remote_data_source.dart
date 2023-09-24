import 'package:my_task_app/data/core/api_constants.dart';
import 'package:my_task_app/shared/utils/logger.dart';

import '../core/api_client.dart';
import '../models/get_all_categories_model.dart';

abstract class GetAllCategoriesRemoteDataSource{
  Future<List<String>> getCategories();
}

class GetAllCategoriesRemoteDataSourceImpl extends GetAllCategoriesRemoteDataSource{

  final ApiClient _apiClient;

  GetAllCategoriesRemoteDataSourceImpl(this._apiClient);
  @override
  Future<List<String>> getCategories() async {
    final response = await _apiClient.get(ApiConstants.allCategories);
    final categoryModel = getAllCategoriesModelFromJson(response);
    return categoryModel;
  }
}
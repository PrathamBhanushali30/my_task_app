import 'package:my_task_app/data/core/api_client.dart';
import 'package:my_task_app/data/core/api_constants.dart';
import 'package:my_task_app/shared/utils/logger.dart';

import '../models/get_product_model.dart';

abstract class GetProductRemoteDataSource{
  Future<List<GetProductModel>> getProducts(String category, Map<String,dynamic>? params);
}

class GetProductRemoteDataSourceImpl extends GetProductRemoteDataSource{

  final ApiClient _apiClient;

  GetProductRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<GetProductModel>> getProducts(String category, Map<String, dynamic>? params) async {
    final response = await _apiClient.get('${ApiConstants.getProduct}$category',params: params);
    print(response.runtimeType);
    final getProductModel = getProductModelFromJson(response);
    Logger.prints(getProductModel);
    return getProductModel;
  }
}
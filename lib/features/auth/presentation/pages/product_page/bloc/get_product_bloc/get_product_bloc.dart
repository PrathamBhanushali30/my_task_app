import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_task_app/data/data_sources/get_product_remote_data_source.dart';
import 'package:my_task_app/data/repositories/get_product_repository_impl.dart';
import 'package:my_task_app/domain/use_cases/products/get_product_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:my_task_app/shared/utils/logger.dart';
import '../../../../../../../data/core/api_client.dart';
import '../../../../../../../data/models/get_product_model.dart';
import '../../../../../../../shared/constants/app_strings.dart';

part 'get_product_event.dart';

part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  GetProductBloc() : super(GetProductInitial()) {
    on<GetProducts>((event, emit) async {
      final response = await GetProductUseCase(GetProductRepositoryImpl(GetProductRemoteDataSourceImpl(ApiClient(http.Client()))))
          .call({Strings.strCategories: event.category, 'limit': event.limit});
      response.fold((l) => Logger.prints(l), (r) => emit(GetProductLoaded(productList: r)));
    });
  }
}

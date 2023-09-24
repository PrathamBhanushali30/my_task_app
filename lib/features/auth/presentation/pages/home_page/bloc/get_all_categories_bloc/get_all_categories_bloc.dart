import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_task_app/data/data_sources/get_all_categories_remote_data_source.dart';
import 'package:my_task_app/data/repositories/get_all_categories_repository_impl.dart';
import 'package:my_task_app/shared/utils/logger.dart';
import '../../../../../../../data/core/api_client.dart';
import '../../../../../../../domain/use_cases/categories/get_categories_use_case.dart';
import 'package:http/http.dart' as http;

part 'get_all_categories_event.dart';

part 'get_all_categories_state.dart';

class GetAllCategoriesBloc extends Bloc<GetAllCategoriesEvent, GetAllCategoriesState> {
  GetAllCategoriesBloc() : super(GetAllCategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      final response =
          await GetCategoriesUseCase(GetAllCategoriesRepositoryImpl(GetAllCategoriesRemoteDataSourceImpl(ApiClient(http.Client())))).call('');
      response.fold((l) => Logger.prints(l), (r) {
        List<String> tempList = [];
        if(event.searchedKeyword != null){
          for (var element in r) {
            if(element.contains(event.searchedKeyword!)){
              tempList.add(element);
            }
          }
        }else{
          tempList = r;
        }
        emit(GetAllCategoriesLoaded(categoryList: tempList));
      });
    });
  }
}

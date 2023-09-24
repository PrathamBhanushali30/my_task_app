import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/constants/route_constants.dart';
import '../../../../shared/imports.dart';
import '../../../../shared/widgets/common_text_view.dart';
import 'cart_page/bloc/cart_bloc/cart_bloc.dart';
import 'home_page/bloc/get_all_categories_bloc/get_all_categories_bloc.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final GetAllCategoriesBloc getAllCategoriesBloc = GetAllCategoriesBloc()..add(GetCategories());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getAllCategoriesBloc,
        child: BlocBuilder<GetAllCategoriesBloc, GetAllCategoriesState>(
          bloc: getAllCategoriesBloc,
          builder: (context, apiState) {
            if (apiState is GetAllCategoriesLoaded) {
              return Wrap(
                children: [
                  for (var i = 0; i < apiState.categoryList.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 30,left: 15,right: 15),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(color: AppColors.colorPrimary, borderRadius: BorderRadius.circular(20), boxShadow: [
                          BoxShadow(color: AppColors.blackColor.withOpacity(0.26), blurRadius: 1, spreadRadius: 1, offset: const Offset(3, 2))
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.category,
                              color: AppColors.whiteColor,
                            ),
                            TextView(
                              text: apiState.categoryList[i].toString(),
                              textColor: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

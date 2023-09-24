import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_task_app/shared/constants/app_colors.dart';
import 'package:my_task_app/shared/constants/constants.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import 'package:my_task_app/shared/widgets/app_logo.dart';
import 'package:my_task_app/shared/widgets/common_drawer.dart';
import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/imports.dart';
import '../../../../../shared/utils/local_storage.dart';
import '../../../../../shared/widgets/common_text_view.dart';
import '../cart_page/bloc/cart_bloc/cart_bloc.dart';
import 'bloc/get_all_categories_bloc/get_all_categories_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GetAllCategoriesBloc getAllCategoriesBloc = GetAllCategoriesBloc()..add(GetCategories());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getAllCategoriesBloc,
        ),
        BlocProvider(
          create: (context2) => CartBloc()..add(ProductLoading()),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(Icons.menu),
                      ),
                      const AppLogo(
                        height: 40,
                        fontSize: 40,
                        width: 40,
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        size: 35,
                        color: AppColors.colorPrimary,
                      ),
                      Positioned(
                        right: 1,
                        top: 0,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: BlocBuilder<CartBloc, CartState>(
                            builder: (context2, cartState) {
                              if (cartState is CartLoaded) {
                                int? totalItem = 0;
                                for (var i = 0; i < cartState.cartList.length; i++) {
                                  totalItem = (totalItem! +
                                      LocalStorage.instance.read(cartState.cartList[i].title.toString() + cartState.cartList[i].id.toString()))
                                  as int?;
                                }
                                return Center(
                                    child: TextView(
                                      text: totalItem.toString(),
                                      textColor: AppColors.whiteColor,
                                    ));
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(10), boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.26),
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: const Offset(3, 2),
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: Strings.strSearch,
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: AppColors.blackColor,
                              )),
                          cursorColor: AppColors.colorPrimary,
                          onChanged: (value) {
                            getAllCategoriesBloc.add(GetCategories(searchedKeyword: value.toString()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ImageSlideshow(
                width: double.infinity,
                height: 195,
                initialPage: 0,
                indicatorColor: AppColors.colorPrimary,
                indicatorBackgroundColor: AppColors.whiteColor,
                autoPlayInterval: 3000,
                isLoop: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: Constants.bannerList[0],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: LoadingAnimationWidget.bouncingBall(color: AppColors.colorPrimary, size: 30)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: Constants.bannerList[1],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: LoadingAnimationWidget.bouncingBall(color: AppColors.colorPrimary, size: 30)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: Constants.bannerList[2],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: LoadingAnimationWidget.bouncingBall(color: AppColors.colorPrimary, size: 30)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextView(
                  text: Strings.strCategories,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              BlocBuilder<GetAllCategoriesBloc, GetAllCategoriesState>(
                bloc: getAllCategoriesBloc,
                builder: (context, apiState) {
                  if (apiState is GetAllCategoriesLoaded) {
                    return Wrap(
                      children: [
                        for (var i = 0; i < apiState.categoryList.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RouteList.productPage, arguments: apiState.categoryList[i].toString())
                                    .then((value) => BlocProvider.of<CartBloc>(context).add(ProductLoading()));
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(color: AppColors.colorPrimary, borderRadius: BorderRadius.circular(20), boxShadow: [
                                  BoxShadow(
                                      color: AppColors.blackColor.withOpacity(0.26), blurRadius: 1, spreadRadius: 1, offset: const Offset(3, 2))
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
                            ),
                          )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextView(text: Strings.strCopyWrite, textColor: AppColors.greyColor, fontSize: 10, fontWeight: FontWeight.w300),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      if (cartState is CartLoaded) {
                        var price = 0.0;
                        int? totalItem = 0;
                        for (var i = 0; i < cartState.cartList.length; i++) {
                          price = price +
                              double.parse(cartState.cartList[i].price!.toString()) *
                                  LocalStorage.instance.read(cartState.cartList[i].title.toString() + cartState.cartList[i].id.toString());
                          totalItem = (totalItem! +
                              LocalStorage.instance.read(cartState.cartList[i].title.toString() + cartState.cartList[i].id.toString())) as int?;
                        }
                        return TextView(text: '$totalItem ${Strings.strItems} : ${Strings.strRupee} ${price.toStringAsFixed(2)}');
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

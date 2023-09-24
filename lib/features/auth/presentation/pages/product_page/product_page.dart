import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_task_app/features/auth/presentation/common_blocs/quantity_bloc/quantity_bloc.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';
import 'package:my_task_app/shared/utils/logger.dart';
import 'package:my_task_app/shared/widgets/add_to_cart_button.dart';
import '../../../../../shared/constants/app_colors.dart';
import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/constants/constants.dart';
import '../../../../../shared/imports.dart';
import '../../../../../shared/widgets/app_logo.dart';
import '../../../../../shared/widgets/common_text_view.dart';
import '../cart_page/bloc/cart_bloc/cart_bloc.dart';
import 'bloc/get_product_bloc/get_product_bloc.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  late final GetProductBloc getProductBloc /* = GetProductBloc()*/;

  final CartBloc cartBloc = CartBloc()..add(ProductLoading());

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments.toString();
    getProductBloc = GetProductBloc()..add(GetProducts(category: args, limit: '8'));
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getProductBloc,
          ),
          BlocProvider(
            create: (context) => cartBloc,
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
                    const AppLogo(
                      height: 40,
                      fontSize: 40,
                      width: 40,
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
                              bloc: cartBloc,
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
                BlocBuilder<GetProductBloc, GetProductState>(
                  bloc: getProductBloc,
                  builder: (context, apiState) {
                    if (apiState is GetProductLoaded) {
                      return Wrap(
                        children: [
                          for (var i = 0; i < apiState.productList!.length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RouteList.productDetailsPage, arguments: {
                                    Constants.productName: apiState.productList![i].title.toString(),
                                    Constants.productImage: apiState.productList![i].image.toString(),
                                    Constants.productDetails: apiState.productList![i].description.toString(),
                                    Constants.productPrice: apiState.productList![i].price.toString(),
                                    Constants.productRatings: apiState.productList![i].rating!.rate.toString(),
                                  });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.27,
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20), boxShadow: [
                                    BoxShadow(
                                        color: AppColors.blackColor.withOpacity(0.26), blurRadius: 1, spreadRadius: 1, offset: const Offset(3, 2))
                                  ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: apiState.productList![i].image.toString(),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Center(child: LoadingAnimationWidget.dotsTriangle(color: AppColors.colorPrimary, size: 30)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: TextView(
                                            text: apiState.productList![i].title.toString(),
                                            fontSize: 12,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextView(
                                              text: '${Strings.strRupee}${apiState.productList![i].price.toString()}',
                                              fontSize: 12,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColors.yellowColor,
                                                ),
                                                TextView(
                                                  text: apiState.productList![i].rating!.rate.toString(),
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              QuantityBloc(apiState.productList![i].title.toString() + apiState.productList![i].id.toString()),
                                          child: BlocBuilder<QuantityBloc, QuantityInitial>(
                                            builder: (context, state) {
                                              return AddToCartButton(
                                                addPressed: () {
                                                  LocalStorage.instance.write(
                                                      apiState.productList![i].title.toString() + apiState.productList![i].id.toString(),
                                                      state.qty + 1);
                                                  BlocProvider.of<QuantityBloc>(context).add(QuantityAdd());
                                                  cartBloc.add(ProductLoading());
                                                },
                                                removePressed: () {
                                                  LocalStorage.instance.write(
                                                      apiState.productList![i].title.toString() + apiState.productList![i].id.toString(),
                                                      state.qty - 1);
                                                  BlocProvider.of<QuantityBloc>(context).add(QuantityRemove());
                                                  if ((state.qty - 1) < 1) {
                                                    CartBloc().add(ProductRemove(apiState.productList![i]));
                                                  }
                                                  cartBloc.add(ProductLoading());
                                                },
                                                elevatedPressed: () {
                                                  LocalStorage.instance.write(
                                                      apiState.productList![i].title.toString() + apiState.productList![i].id.toString(),
                                                      state.qty + 1);
                                                  BlocProvider.of<QuantityBloc>(context).add(QuantityAdd());
                                                  CartBloc().add(ProductAdd(apiState.productList![i]));
                                                  cartBloc.add(ProductLoading());
                                                  cartBloc.add(ProductLoading());
                                                },
                                                qty: state.qty,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
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
                      bloc: cartBloc,
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
      ),
    );
  }
}

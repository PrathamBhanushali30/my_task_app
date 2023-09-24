import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/features/auth/presentation/common_blocs/quantity_bloc/quantity_bloc.dart';
import 'package:my_task_app/shared/constants/dbkeys.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';
import 'package:my_task_app/shared/widgets/add_to_cart_button.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';

import '../../../../../shared/constants/app_colors.dart';
import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/imports.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../shared/widgets/app_logo.dart';
import '../../../../../shared/widgets/cart_products.dart';
import 'bloc/cart_bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Logger.prints('here is the list ${LocalStorage.instance.read(DBKeys.cart)}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            Strings.strCart,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          BlocProvider(
            create: (context2) => CartBloc()..add(ProductLoading()),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context2, cartstate) {
                if (cartstate is CartLoaded) {
                  var price = 0.0;
                  int? totalItem = 0;
                  for (var i = 0; i < cartstate.cartList.length; i++) {
                    price = price +
                        double.parse(cartstate.cartList[i].price!.toString()) *
                            LocalStorage.instance.read(cartstate.cartList[i].title.toString() + cartstate.cartList[i].id.toString());
                    totalItem = (totalItem! +
                        LocalStorage.instance.read(cartstate.cartList[i].title.toString() + cartstate.cartList[i].id.toString())) as int?;
                  }
                  return cartstate.cartList.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextView(
                              text: Strings.strYourCartIsEmpty,
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
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
                                        child: Center(child: TextView(text: totalItem.toString(), textColor: AppColors.whiteColor,)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.67,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  key: UniqueKey(),
                                  itemCount: cartstate.cartList.length,
                                  itemBuilder: (context, index) {
                                    final id = cartstate.cartList[index].id.toString();
                                    final name = cartstate.cartList[index].title.toString();
                                    final product = cartstate.cartList[index];
                                    return CartProducts(
                                        image: cartstate.cartList[index].image.toString(),
                                        name: cartstate.cartList[index].title.toString(),
                                        numberOfUnits: cartstate.cartList[index].price.toString(),
                                        unit: Strings
                                            .strRupee /*cartstate.cartList[index].price!
                                      .first.units!.title
                                      .toString()*/
                                        ,
                                        salePrice: cartstate.cartList[index].price.toString(),
                                        id: cartstate.cartList[index].id.toString(),
                                        product: cartstate.cartList[index],
                                        button: BlocProvider<QuantityBloc>(
                                            create: (context) =>
                                                QuantityBloc(cartstate.cartList[index].title.toString() + cartstate.cartList[index].id.toString()),
                                            child: BlocBuilder<QuantityBloc, QuantityInitial>(
                                              builder: (context, state) {
                                                return AddToCartButton(
                                                    addPressed: () {
                                                      LocalStorage.instance.write(name + id, state.qty + 1);
                                                      BlocProvider.of<QuantityBloc>(context).add(QuantityAdd());
                                                      // GetStorage().read(name + id);
                                                      BlocProvider.of<CartBloc>(context2).add(ProductLoading());
                                                    },
                                                    removePressed: () {
                                                      LocalStorage.instance.write(name + id, state.qty - 1);
                                                      BlocProvider.of<QuantityBloc>(context).add(QuantityRemove());
                                                      BlocProvider.of<CartBloc>(context2).add(ProductLoading());
                                                      // GetStorage().read(name + id);
                                                      if ((state.qty - 1) < 1) {
                                                        BlocProvider.of<CartBloc>(context2).add(ProductRemove(product));
                                                      }
                                                    },
                                                    elevatedPressed: () {
                                                      LocalStorage.instance.write(name + id, state.qty + 1);
                                                      BlocProvider.of<QuantityBloc>(context).add(QuantityAdd());
                                                    },
                                                    qty: state.qty);
                                              },
                                            )));
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              margin: const EdgeInsets.symmetric(horizontal: 23),
                              height: 70,
                              width: MediaQuery.of(context).size.width - 50,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.whiteColor, boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor.withOpacity(.3),
                                  offset: const Offset(0, 5),
                                  blurRadius: 5,
                                ),
                              ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const TextView(
                                        text: Strings.strTotal,
                                        fontSize: 15,
                                        textColor: AppColors.greyColor,
                                      ),
                                      TextView(
                                        text: '${Strings.strRupee}${price.toStringAsFixed(2)}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppColors.greenColor,
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppColors.greenColor,
                                    ),
                                    child: Center(
                                      child: TextView(
                                        text: '${Strings.strTotalQty} ${totalItem.toString()}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppColors.whiteColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_task_app/data/models/get_product_model.dart';
import 'package:my_task_app/features/auth/presentation/common_blocs/quantity_bloc/quantity_bloc.dart';
import 'package:my_task_app/shared/constants/dbkeys.dart';
import 'package:my_task_app/shared/utils/app_component.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';

import '../../../../../../../shared/methods/cart_loader.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<ProductLoading>((event, emit) async {
      AppComponentBase.instance.showProgressDialog();
      final cartList = await CartDataLoader.getCartData();
      AppComponentBase.instance.hideProgressDialog();
      emit(CartLoaded(cartList));
    });

    on<ProductAdd>((event, emit) async {
      AppComponentBase.instance.showProgressDialog();
      var cartList = await CartDataLoader.getCartData();
      cartList.add(event.product);
      await LocalStorage.instance.write(DBKeys.cart, cartList);
      AppComponentBase.instance.hideProgressDialog();
    });

    on<ProductRemove>((event, emit) async {
      AppComponentBase.instance.showProgressDialog();
      var cartList = await CartDataLoader.getCartData();
      cartList.removeWhere((element) => element.id == event.product.id);

      QuantityBloc(event.product.id.toString() + event.product.id.toString()).add(QuantityRemove());

      LocalStorage.instance.write(DBKeys.cart, cartList);
      AppComponentBase.instance.hideProgressDialog();
      emit(CartLoaded(cartList));
    });
  }
}

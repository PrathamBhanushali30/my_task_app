import 'package:my_task_app/data/models/get_product_model.dart';
import 'package:my_task_app/shared/constants/dbkeys.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';


class CartDataLoader {
  static Future<List<GetProductModel>> getCartData() async {
    List<GetProductModel> templist = [];
    List<dynamic>? localdata = LocalStorage.instance.read(DBKeys.cart);
    if (localdata != null) {
      for (var element in localdata) {
        GetProductModel cartProduct = GetProductModel.fromJson(
            element is GetProductModel ? element.toJson() : element);
        templist.add(cartProduct);
      }
    } else {
      templist.clear();
    }
    return templist;
  }
}
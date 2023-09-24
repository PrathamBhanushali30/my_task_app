import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_task_app/data/models/get_product_model.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';

import '../../features/auth/presentation/pages/cart_page/bloc/cart_bloc/cart_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../imports.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key, required this.image, required this.name, required this.numberOfUnits, required this.unit, required this.salePrice, required this.id, required this.product, required this.button});

  final String image;
  final String name;
  final String numberOfUnits;
  final String unit;
  final String salePrice;
  final String id;
  final GetProductModel product;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.3),
                offset: const Offset(5, 5),
                blurRadius: 5)
          ]),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              height: 70,
              width: 70,
              imageUrl: image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: LoadingAnimationWidget.fallingDot(
                        color: AppColors.colorPrimary, size: 15),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 5),
              child: SizedBox(
                width: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: TextView(
                        text: name,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*TextView(
                      text: numberOfUnits + unit,
                      fontSize: 15,
                      textColor: Colors.grey,
                    ),*/
                    TextView(
                      text: '${Strings.strRupee} $salePrice',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                        textColor: AppColors.redColor,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<CartBloc>(context).add(ProductRemove(product));
                    LocalStorage.instance.write(name + id, 0);
                  },
                  child: const TextView(
                    text: Strings.strRemove,
                    textColor: AppColors.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                button,
              ],
            )
          ],
        ),
      ),
    );
  }
}

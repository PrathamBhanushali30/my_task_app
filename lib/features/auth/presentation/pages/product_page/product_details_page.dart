import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_task_app/shared/constants/constants.dart';
import 'package:my_task_app/shared/utils/logger.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';
import '../../../../../shared/constants/app_colors.dart';
import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/imports.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Logger.prints(args);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: CachedNetworkImage(
                  imageUrl: args[Constants.productImage],
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: LoadingAnimationWidget.fourRotatingDots(color: AppColors.colorPrimary, size: 30)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextView(
                        text: args[Constants.productName],
                      fontSize: 18,
                    ),
                  ),
                  TextView(
                    text: '${Strings.strRupee}${args[Constants.productPrice]}',
                    fontSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                  ),
                  TextView(
                    text: args[Constants.productRatings],
                    fontSize: 12,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              TextView(
                text: args[Constants.productDetails],
                fontSize: 18,
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

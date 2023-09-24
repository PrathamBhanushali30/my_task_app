import 'package:my_task_app/shared/widgets/common_text_view.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../imports.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.addPressed,
    required this.removePressed,
    required this.elevatedPressed,
    required this.qty,
  });

  final VoidCallback addPressed;
  final VoidCallback removePressed;
  final VoidCallback elevatedPressed;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.colorPrimary, borderRadius: BorderRadius.circular(5)),
      height: 45,
      width: 140,
      child: qty > 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.lightOrangeColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: removePressed,
                      icon: const Icon(
                        Icons.remove,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TextView(
                  text: qty.toString(),
                  fontSize: 20,
                  textColor: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.lightOrangeColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: addPressed,
                      icon: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(AppColors.colorPrimary),
              ),
              onPressed: elevatedPressed,
              child: const TextView(
                text: Strings.strAdd,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textColor: AppColors.whiteColor,
              ),
            ),
    );
  }
}

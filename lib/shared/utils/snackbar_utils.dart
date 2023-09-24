import 'package:my_task_app/shared/constants/app_colors.dart';

import '../imports.dart';

class SnackBarUtil {
  static void showInSnackBar(BuildContext context, String value, {Color bgColors = AppColors.colorPrimary}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
      content: Text(
        value,
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: bgColors,
    ));
  }
}

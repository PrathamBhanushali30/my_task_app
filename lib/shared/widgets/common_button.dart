import 'package:my_task_app/shared/constants/app_colors.dart';

import '../imports.dart';
import 'common_text_view.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key, required this.title, required this.onTap, this.width, this.buttonColor, this.textColor});

  final String title;
  final VoidCallback onTap;
  final double? width;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: TextView(
            text: title,
            fontSize: 16,
            textColor: textColor ?? AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

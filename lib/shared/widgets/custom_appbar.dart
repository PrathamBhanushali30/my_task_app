import 'package:my_task_app/shared/constants/app_colors.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';

import '../imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    required this.text,
    this.fontSize,
    this.fontWidth,
    this.textColor,
  });

  final double? height;
  final String text;
  final double? fontSize;
  final FontWeight? fontWidth;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.colorPrimary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Center(
        child: TextView(text: text, fontWeight: fontWidth, fontSize: fontSize, textColor: textColor),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, height ?? 50);
}

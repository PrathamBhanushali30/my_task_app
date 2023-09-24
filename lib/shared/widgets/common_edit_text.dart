import 'package:my_task_app/shared/constants/app_colors.dart';

import '../imports.dart';

class CommonEditText extends StatelessWidget {
  const CommonEditText(
      {super.key,
      this.hintText,
      this.keyBoardType,
      this.textInputAction,
      this.controller,
      this.isPassword,
      this.readOnly,
      this.maxLines,
      this.isCorrect,
      this.suffix,
      this.onTap,
      this.onChange,
      this.textColor,
      this.fontFamily,
      this.fontWeight,
      this.color});

  final String? hintText;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? readOnly;
  final int? maxLines;
  final bool? isCorrect;
  final Widget? suffix;
  final VoidCallback? onTap;
  final void Function(String)? onChange;
  final Color? textColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blackColor, width: 1),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14),
          suffixIcon: suffix,
          focusColor: AppColors.blackColor,
        ),
        cursorColor: AppColors.colorPrimary,
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        controller: controller,
        obscureText: isPassword ?? false,
        readOnly: readOnly ?? false,
        onTap: onTap,
        maxLines: maxLines ?? 1,
        onChanged: onChange,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }
}

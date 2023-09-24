import '../constants/app_colors.dart';
import '../constants/constants.dart';
import '../imports.dart';
import 'common_text_view.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height, this.width, this.fontSize});

  final double? height;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      width: width ?? 100,
      decoration: const BoxDecoration(
        color: AppColors.colorPrimary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: TextView(
          text: Constants.appLogoName,
          textColor: AppColors.whiteColor,
          fontSize: fontSize ?? 100,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

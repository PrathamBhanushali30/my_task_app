import 'package:my_task_app/shared/constants/app_colors.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';

import '../constants/app_strings.dart';
import '../imports.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key, required this.onUserTap, required this.onLogOutTap});

  final VoidCallback onUserTap;
  final VoidCallback onLogOutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: const BoxDecoration(color: AppColors.colorPrimary),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RouteList.categoriesPage);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.category,
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: 5,),
                  TextView(
                    text: Strings.strCategories,
                    textColor: AppColors.whiteColor,
                    fontSize: 18,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: onUserTap,
              child: const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: 5,),
                  TextView(
                    text: Strings.strUserDetails,
                    textColor: AppColors.whiteColor,
                    fontSize: 18,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: onLogOutTap,
              child: const Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: 5,),
                  TextView(
                    text: Strings.strLogout,
                    textColor: AppColors.whiteColor,
                    fontSize: 18,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/shared/constants/app_colors.dart';
import 'package:my_task_app/shared/utils/logger.dart';
import 'package:my_task_app/shared/widgets/app_logo.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';

import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/imports.dart';
import 'bloc/get_user_details_bloc/get_user_details_bloc.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final GetUserDetailsBloc userDetailsBloc = GetUserDetailsBloc()..add(GetUserDetails());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => userDetailsBloc,
        child: SingleChildScrollView(
          child: BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
            bloc: userDetailsBloc,
            builder: (context, apiState) {
              if (apiState is GetUserDetailsLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      const AppLogo(),
                      const SizedBox(height: 30,),
                      const Center(
                        child: TextView(
                          text: Strings.strUserDetails,
                          fontSize: 20,
                          textColor: AppColors.colorPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextView(
                            text: '${Strings.strName}: ',
                            textColor: AppColors.greyColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(width: 5,),
                          TextView(
                            text: apiState.user!.name,
                            textColor: AppColors.colorPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextView(
                            text: '${Strings.strEmail}: ',
                            textColor: AppColors.greyColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(width: 5,),
                          TextView(
                            text: apiState.user!.email,
                            textColor: AppColors.colorPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      const SizedBox(height: 70,),
                      const TextView(
                        text: Strings.strThankYou,
                        textColor: AppColors.colorPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 10,),
                      const TextView(
                        text: Strings.strForUsingOurApp,
                        textColor: AppColors.colorPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 10,),
                      const TextView(
                        text: Strings.strCopyWrite,
                        textColor: AppColors.greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

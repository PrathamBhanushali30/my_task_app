// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/shared/constants/dbkeys.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import 'package:my_task_app/shared/methods/authentication_methods.dart';
import 'package:my_task_app/shared/utils/app_component.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';
import 'package:my_task_app/shared/utils/snackbar_utils.dart';
import 'package:my_task_app/shared/widgets/common_button.dart';
import 'package:my_task_app/shared/widgets/common_edit_text.dart';
import 'package:my_task_app/shared/widgets/common_text_view.dart';
import 'package:my_task_app/shared/widgets/custom_appbar.dart';
import '../../../../../shared/constants/app_colors.dart';
import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/constants/constants.dart';
import '../../../../../shared/imports.dart';
import '../../../../../shared/widgets/app_logo.dart';
import 'bloc/password_eye_bloc/password_view_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final PasswordViewBloc passwordViewBloc = PasswordViewBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: Strings.loginPage,
        textColor: AppColors.whiteColor,
        fontSize: 20,
        fontWidth: FontWeight.w500,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const Center(
                child: AppLogo(),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextView(
                text: Strings.strLogin,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 20,
              ),
              CommonEditText(
                hintText: Strings.strEmail,
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyBoardType: TextInputType.emailAddress,
                suffix: const Icon(
                  Icons.email,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => passwordViewBloc,
                child: BlocBuilder<PasswordViewBloc, PasswordViewInitial>(
                  bloc: passwordViewBloc,
                  builder: (context, state) {
                    return CommonEditText(
                      hintText: Strings.strPassword,
                      controller: passwordController,
                      isPassword: !(state.isView ?? false),
                      keyBoardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffix: GestureDetector(
                        onTap: () {
                          passwordViewBloc.add(ViewPassword(isView: !(state.isView ?? true)));
                        },
                        child: const Icon(
                          Icons.remove_red_eye,
                          color: AppColors.blackColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: CommonButton(
                  title: Strings.strLogin,
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (emailController.text.isEmpty) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPleaseEnterEmail);
                    } else if (passwordController.text.isEmpty) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPleaseEnterPassword);
                    } else {
                      AppComponentBase.instance.showProgressDialog();
                      String result = await Authentication().logInUser(email: emailController.text, password: passwordController.text);
                      if (result == 'success') {
                        await LocalStorage.instance.write(DBKeys.isLogin, true);
                        Navigator.pushNamedAndRemoveUntil(context, RouteList.mainPage, (route) => false);
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.lightOrangeColor,
                              title: const Text(
                                'Error',
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                              content: Text(result.split('] ').last, style: const TextStyle(color: AppColors.whiteColor)),
                              actions: [
                                CommonButton(
                                  title: Strings.strOk,
                                  buttonColor: AppColors.whiteColor,
                                  textColor: AppColors.colorPrimary,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      AppComponentBase.instance.hideProgressDialog();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const TextView(
                    text: Strings.strDontHaveAccount,
                    fontSize: 12,
                    textColor: AppColors.greyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteList.registrationPage);
                    },
                    child: const TextView(
                      text: Strings.strRegister,
                      fontSize: 12,
                      textColor: AppColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

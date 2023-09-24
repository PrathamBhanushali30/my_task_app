// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import 'package:my_task_app/shared/utils/app_component.dart';
import 'package:my_task_app/shared/widgets/custom_appbar.dart';

import '../../../../../shared/constants/app_colors.dart';
import '../../../../../shared/constants/app_strings.dart';
import '../../../../../shared/constants/constants.dart';
import '../../../../../shared/imports.dart';
import '../../../../../shared/methods/authentication_methods.dart';
import '../../../../../shared/utils/snackbar_utils.dart';
import '../../../../../shared/widgets/app_logo.dart';
import '../../../../../shared/widgets/common_button.dart';
import '../../../../../shared/widgets/common_edit_text.dart';
import '../../../../../shared/widgets/common_text_view.dart';
import '../login/bloc/password_eye_bloc/password_view_bloc.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final PasswordViewBloc passwordViewBloc = PasswordViewBloc();
  final PasswordViewBloc confirmPasswordViewBloc = PasswordViewBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: Strings.strRegister,
        textColor: AppColors.whiteColor,
        fontSize: 20,
        fontWidth: FontWeight.w700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
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
                hintText: Strings.strName,
                controller: nameController,
                keyBoardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                suffix: const Icon(
                  Icons.person,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CommonEditText(
                hintText: Strings.strEmail,
                controller: emailController,
                keyBoardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.next,
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
                height: 20,
              ),
              BlocProvider(
                create: (context) => confirmPasswordViewBloc,
                child: BlocBuilder<PasswordViewBloc, PasswordViewInitial>(
                  bloc: confirmPasswordViewBloc,
                  builder: (context, state) {
                    return CommonEditText(
                      hintText: Strings.strConfirmPassword,
                      controller: confirmPasswordController,
                      isPassword: !(state.isView ?? false),
                      keyBoardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffix: GestureDetector(
                        onTap: () {
                          confirmPasswordViewBloc.add(ViewPassword(isView: !(state.isView ?? true)));
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
                  title: Strings.strRegister,
                  onTap: () async {
                    if (nameController.text.isEmpty) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPleaseEnterName);
                    } else if (emailController.text.isEmpty) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPleaseEnterEmail);
                    } else if (passwordController.text.isEmpty) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPleaseEnterPassword);
                    } else if (confirmPasswordController.text.isEmpty) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPleaseEnterConfirmPassword);
                    } else if (confirmPasswordController.text != passwordController.text) {
                      SnackBarUtil.showInSnackBar(context, Strings.strPasswordDoesNotMatch);
                    } else {
                      AppComponentBase.instance.showProgressDialog();
                      String result = await Authentication().signUpUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (result == 'success') {
                        AppComponentBase.instance.hideProgressDialog();
                        SnackBarUtil.showInSnackBar(context, Strings.strAccountCreatedSuccessfully);
                        Navigator.pop(context);
                      } else if (result == 'email-already-in-use') {
                        SnackBarUtil.showInSnackBar(context, Strings.strEmailAlreadyExists);
                      } else if (result == 'weak-password') {
                        SnackBarUtil.showInSnackBar(context, Strings.strWeekPassword);
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
                                    title: 'OK',
                                    textColor: AppColors.colorPrimary,
                                    buttonColor: AppColors.whiteColor,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    width: 50)
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
                    text: Strings.strAlreadyHaveAnAccount,
                    fontSize: 12,
                    textColor: AppColors.greyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const TextView(
                      text: Strings.strLogin,
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

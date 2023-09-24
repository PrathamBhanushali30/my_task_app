import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/shared/constants/constants.dart';
import 'package:my_task_app/shared/constants/dbkeys.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import 'package:my_task_app/shared/methods/authentication_methods.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';
import 'package:my_task_app/shared/widgets/common_drawer.dart';

import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/imports.dart';
import '../common_blocs/navbar_bloc/navbar_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int selected = 0;

  final NavbarBloc navbarBloc = NavbarBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: Constants.screenList(),
          ),
        ],
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => navbarBloc,
        child: BlocBuilder<NavbarBloc, NavbarInitial>(
          bloc: navbarBloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (state.selectedIndex != 0) {
                        navbarBloc.add(ChangeNavbarIndex(selectedIndex: 0));
                        controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.decelerate);
                      }
                    },
                    child: Icon(
                      Icons.home,
                      color: state.selectedIndex == 0 ? AppColors.colorPrimary : AppColors.blackColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state.selectedIndex != 1) {
                        navbarBloc.add(ChangeNavbarIndex(selectedIndex: 1));
                        controller.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.decelerate);
                      }
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: state.selectedIndex == 1 ? AppColors.colorPrimary : AppColors.blackColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state.selectedIndex != 2) {
                        navbarBloc.add(ChangeNavbarIndex(selectedIndex: 2));
                        controller.animateToPage(2, duration: const Duration(milliseconds: 200), curve: Curves.decelerate);
                      }
                    },
                    child: Icon(
                      Icons.person,
                      color: state.selectedIndex == 2 ? AppColors.colorPrimary : AppColors.blackColor,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      drawer: CommonDrawer(
          onLogOutTap: () async {
        final result = await Authentication().logOutUser();
        if(result == 'success'){
          LocalStorage.instance.write(DBKeys.isLogin, false);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(context, RouteList.loginPage, (route) => false);
        }
      }, onUserTap: () {
            Navigator.pop(context);
        controller.animateToPage(2, duration: const Duration(milliseconds: 200), curve: Curves.decelerate);
        navbarBloc.add(ChangeNavbarIndex(selectedIndex: 2));
      }),
    );
  }
}

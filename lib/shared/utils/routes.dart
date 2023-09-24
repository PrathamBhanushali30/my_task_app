import 'package:flutter/cupertino.dart';
import 'package:my_task_app/features/auth/presentation/pages/login/login_page.dart';
import 'package:my_task_app/features/auth/presentation/pages/main_page.dart';
import 'package:my_task_app/shared/constants/route_constants.dart';
import '../../features/auth/presentation/pages/categories_page.dart';
import '../../features/auth/presentation/pages/product_page/product_details_page.dart';
import '../../features/auth/presentation/pages/product_page/product_page.dart';
import '../../features/auth/presentation/pages/registration/registration_page.dart';

class Routes{
  static Map<String, WidgetBuilder> getRoutes() => {

    RouteList.registrationPage : (context) => RegistrationPage(),
    RouteList.mainPage : (context) => const MainPage(),
    RouteList.productPage : (context) => ProductPage(),
    RouteList.productDetailsPage : (context) => const ProductDetailsPage(),
    RouteList.categoriesPage : (context) => CategoriesPage(),
    RouteList.loginPage : (context) => LoginPage(),
  };
}
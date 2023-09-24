import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_task_app/features/auth/presentation/pages/main_page.dart';
import 'package:my_task_app/features/auth/presentation/pages/registration/registration_page.dart';
import 'package:my_task_app/shared/constants/app_colors.dart';
import 'package:my_task_app/shared/constants/app_strings.dart';
import 'package:my_task_app/shared/constants/constants.dart';
import 'package:my_task_app/shared/constants/dbkeys.dart';
import 'package:my_task_app/shared/utils/app_component.dart';
import 'package:my_task_app/shared/utils/fade_page_route_builder.dart';
import 'package:my_task_app/shared/utils/local_storage.dart';
import 'package:my_task_app/shared/utils/routes.dart';
import 'package:my_task_app/shared/widgets/custom_progress_dialog.dart';
import 'features/auth/presentation/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(const MyTaskApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.colorPrimary,
  ));
}

class MyTaskApp extends StatefulWidget {
  const MyTaskApp({super.key});

  @override
  State<MyTaskApp> createState() => _MyTaskAppState();
}

class _MyTaskAppState extends State<MyTaskApp> {
  @override
  void initState() {
    AppComponentBase.instance.init();
    super.initState();
  }

  @override
  void dispose() {
    AppComponentBase.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (LocalStorage.instance.read(DBKeys.isLogin) ?? false) ? const MainPage() : LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes();
        final WidgetBuilder? builder = routes[settings.name];
        return FadePageRouteBuilder(
          builder: builder!,
          settings: settings,
        );
      },
      builder: (context, widget) {
        return Stack(
          children: <Widget>[
            StreamBuilder<bool>(
                initialData: false,
                stream: AppComponentBase.instance.progressDialogStream,
                builder: (context, snapshot) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: IgnorePointer(ignoring: snapshot.data ?? false, child: widget),
                  );
                }),
            StreamBuilder<bool?>(
                initialData: true,
                stream: AppComponentBase.instance.networkManage.internetConnectionStream,
                builder: (context, snapshot) {
                  return SafeArea(
                    child: AnimatedContainer(
                        height: snapshot.data ?? false ? 0 : 100,
                        duration: Constants.animationDuration,
                        color: AppColors.colorPrimary,
                        child: const Material(
                          type: MaterialType.transparency,
                          child: Center(
                              child: Text(
                            Strings.noInternetConnection,
                          )),
                        )),
                  );
                }),
            StreamBuilder<bool?>(
                initialData: false,
                stream: AppComponentBase.instance.progressDialogStream,
                builder: (context, snapshot) {
                  if (snapshot.data ?? false) {
                    return const Center(child: CustomProgressDialog());
                  } else {
                    return const Offstage();
                  }
                })
          ],
        );
      },
    );
  }
}

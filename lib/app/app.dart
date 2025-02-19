import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:design_module/old_design/resources/font_manager.dart';
import 'package:design_module/old_design/resources/size_utils.dart';
import 'package:design_module/old_design/resources/styles_manager.dart';
import 'package:design_module/old_design/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/app/navigator_service.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/core/application/application_states.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late ApplicationBloc _applicationBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
        create: (context) => _applicationBloc,
        child: Sizer(builder: (context, orientation, deviceType) {
          return BlocListener<ApplicationBloc, ApplicationState>(
              listener: (context, state) {
                if (mounted) {
                  if (state is UserLoggedOut) {
                    GoRouter.of(NavigatorService.navigatorKey.currentContext!)
                        .goNamed(CommonRoutes.phoneLoginRoute);
                  } else if (state is HandleDeeplinkRoute) {
                    NavigatorService.navigatorKey.currentContext?.pushNamed(
                        state.route,
                        pathParameters: state.args ?? {});
                  }
                }
              },
              bloc: _applicationBloc,
              child: MaterialApp.router(
                routerConfig: NavigatorService.router,
                theme: getApplicationTheme(),
              ));
        }));
  }

  @override
  void initState() {
    super.initState();
    _applicationBloc = ApplicationBloc();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        _onDetached();
      case AppLifecycleState.resumed:
        _applicationBloc.onResumed();
      case AppLifecycleState.inactive:
        _onInactive();
      case AppLifecycleState.hidden:
        _onHidden();
      case AppLifecycleState.paused:
        _applicationBloc.onPaused();
    }
  }

  void _onDetached() => logMessage('detached');

  void _onInactive() => logMessage('inactive');

  void _onHidden() => logMessage('hidden');
}

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme: ColorScheme.light(
        surface: Colors.white
      ),
      // ripple color
      cardTheme: const CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: ColorManager.greyText),
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),
      // Button theme
      buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // Text theme
      textTheme: TextTheme(
          headlineLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          headlineMedium: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
          headlineSmall:
              getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
          titleSmall: getRegularStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          displayMedium: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          displaySmall: getMediumStyle(color: ColorManager.lightGrey),
          labelSmall: getRegularStyle(color: ColorManager.grey1),
          bodyLarge: getRegularStyle(color: ColorManager.grey)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.grey1),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}

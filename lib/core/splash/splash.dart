import 'package:common_module/base/base_screen.dart';
import 'package:utility_module/logger/logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:design_module/constants.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/core/splash/bloc/splash_bloc.dart';
import 'package:zinc/core/splash/bloc/splash_states.dart';
import 'package:design_module/old_design/resources/color_manager.dart';

class SplashView extends StatefulWidget {
  static const String pageName = "splash_screen";

  const SplashView({Key? key}) : super(key: const ValueKey(pageName));

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseScreenState<SplashView>
    with SingleTickerProviderStateMixin {
  bool isDeviceRooted = false;
  late final AnimationController _animationController;
  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _animationController = AnimationController(vsync: this);
    logMessage("Step------------------------> 0");
    _bloc.loadSplash(context.read<ApplicationBloc>());
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bloc.animationComplete();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(
        context,
        SplashView.pageName,
        BlocListener<SplashBloc, SplashState>(
            listener: (BuildContext ctx, SplashState state) {
              if (state is RootedDeviceDetected) {
                isDeviceRooted = state.isRooted;
              } else if (state is ModulesInitialized) {
                Analytics.getInstance
                    .trackEvent(PageLoadEvent(SplashView.pageName));
              } else if (state is NavigateFromSplash) {
                context.go("/${state.route}");
              }
            },
            bloc: _bloc,
            child: Container(
              color: ColorManager.color262626,
              child: Center(
                child: Lottie.asset(
                    "${AssetPaths.lottieAsset}lottie_splash.json",
                    animate: true,
                    repeat: false, onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the Lottie composition
                  _animationController.duration = composition.duration;
                  // Start the animation
                  _animationController.forward();
                }, controller: _animationController, height: 82, width: 95),
              ),
            )),
        backgroundColor: ColorManager.greySurface,
        showAppBar: false);
  }

  @override
  String get pageName => SplashView.pageName;
}

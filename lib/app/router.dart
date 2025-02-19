import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/app/constant.dart';
import 'package:zinc/core/coming_soon/coming_soon_screen.dart';
import 'package:zinc/core/contact_us/contact_us.dart';
import 'package:zinc/core/delete_account/delete_account.dart';
import 'package:zinc/core/help_and_support/repo/tickets_model.dart';
import 'package:zinc/core/help_and_support/view/support_faq.dart';
import 'package:zinc/core/help_and_support/view/tickets_widgets.dart';
import 'package:zinc/core/settings/settings_screen.dart';
import 'package:zinc/core/splash/bloc/splash_bloc.dart';
import 'package:zinc/core/splash/repository/splash_repository.dart';
import 'package:zinc/core/splash/splash.dart';
import 'package:zinc/core/webview/bloc/webview_bloc.dart';
import 'package:zinc/core/webview/webview_screen.dart';

abstract class CommonRoutes {
  static const String awxHome = "awxHome";
  static const String rmtHome = "rmtHome";
  static const String profile = "profile";
  static const String youtubeVideo = "youtubeVideo";
  static const String webView = "webview";
  static const String settings = "settings";
  static const String security = "security";
  static const String contactUs = "contactUs";
  static const String transactionDetail = "transactionDetail";
  static const String deleteAccount = "deleteAccount";
  static const String inAppWebView = "inAppWebView";
  static const String splashRoute = "splash";
  static const String phoneLoginRoute = "phoneLogin";
  static const String verifyPhoneRoute = "verifyPhone";
  static const String createProfile = "createProfile";
  static const String featureChooser = "featureChooser";
  static const String offersScreenView = "offersScreenView";
  static const String supportFaqScreenView = "supportFaqScreenView";
  static const String jailBrokenScreenView = "jailBrokenView";
  static const String appUpdateScreenView = "appUpdateView";
  static const String comingSoonView = "comingSoonView";
  static const String ticketDetailsView = "ticketDetailsView";
}

List<String> defaultRoutes = [
  "/",
  "/${CommonRoutes.phoneLoginRoute}",
  "/${CommonRoutes.verifyPhoneRoute}",
];

class CommonRouter {
  static Map<String, dynamic>? _getDecodedArgs(String? data) {
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  static Future<dynamic> routeWithArgs(BuildContext context, String route,
      {dynamic args, dynamic path}) {
    if (args != null) {
      return context
          .pushNamed(route, pathParameters: {"data": jsonEncode(args)});
    }
    if (path != null) {
      return context.pushNamed(route, pathParameters: path);
    } else {
      return context.pushNamed(route);
    }
  }

  static final List<GoRoute> routes = [
    GoRoute(
      path: '/',
      name: CommonRoutes.splashRoute,
      builder: (context, state) => BlocProvider(
        create: (context) => SplashBloc(SplashRepository()),
        child: const SplashView(),
      ),
    ),
    GoRoute(
      path: "/${CommonRoutes.supportFaqScreenView}",
      name: CommonRoutes.supportFaqScreenView,
      builder: (context, state) {
        return const SupportPage();
      },
    ),
    GoRoute(
      path: "/${CommonRoutes.contactUs}",
      name: CommonRoutes.contactUs,
      builder: (context, state) {
        return const ContactUsScreen();
      },
    ),
    GoRoute(
      path: "/${CommonRoutes.settings}",
      name: CommonRoutes.settings,
      builder: (context, state) {
        return const SettingsScreen();
      },
    ),
    GoRoute(
      path: "/${CommonRoutes.deleteAccount}",
      name: CommonRoutes.deleteAccount,
      builder: (context, state) {
        return const DeleteAccountScreen();
      },
    ),
    /*    GoRoute(
        path: "/${CommonRoutes.youtubeVideo}/:data",
        name: CommonRoutes.youtubeVideo,
        builder: (context, state) {
          //TODO: check how data is going
          final data = state.pathParameters['data'];
          final args = ZincAppRouter._getDecodedArgs(data);
          final videoId = args?['youtube_video_id'];
          return YoutubeEmbeddingScreen(youtubeVideoId: videoId);
        },
      ),*/
    GoRoute(
      path: "/${CommonRoutes.webView}/:data",
      name: CommonRoutes.webView,
      builder: (context, state) {
        final data = state.pathParameters['data'];
        final x = _getDecodedArgs(data);
        final url = x?['url'];
        final title = x?['title'];
        final showAppBar = x?['show_app_bar'];
        final successUrl = x?['success_url'];
        final windowId = x?['window_id'];

        return BlocProvider(
            create: (context) => WebViewBloc.create(url, successUrl: successUrl, windowId: windowId),
            child: ZincWebView(title: title, showAppBar: showAppBar));
      },
    ),
    GoRoute(
      path: "/${CommonRoutes.comingSoonView}",
      name: CommonRoutes.comingSoonView,
      builder: (context, state) {
        return const ComingSoonScreen();
      },
    ),
    GoRoute(
      path: "/${CommonRoutes.ticketDetailsView}/:data",
      name: CommonRoutes.ticketDetailsView,
      builder: (context, state) {
        final data = state.pathParameters['data'];
        final List decodedTickets = jsonDecode(data!);
        List<Ticket> tickets =
            decodedTickets.map((json) => Ticket.fromJson(json)).toList();

        return TicketDetailsScreen(tickets: tickets);
      },
    ),
  ];
}

class NoRouteScreen extends StatelessWidget {
  final Uri uri;

  const NoRouteScreen(this.uri, {super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.go("/");
    });
    return const Scaffold(body: SizedBox.shrink());
  }
}

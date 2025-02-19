import 'package:common_module/base/base_component_state.dart';
import 'package:design_module/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinc/core/commons/email_verify/bloc/email_verify_bloc.dart';
import 'package:zinc/core/commons/email_verify/email_verify.dart';
import 'package:zinc/core/commons/form/config_form_page.dart';
import 'package:zinc/domain/bff/ui_configuration/onboarding_config_models.dart';

extension ConfiguratedHomeUiWidgets on PageConfig? {
  Widget getWidget(
      {BaseComponentState? state,
      dynamic metaData,
      bool launchForResult = false}) {
    switch (this?.type) {
      case PageType.emailVerification:
        return BlocProvider(
          create: (context) => EmailVerificationBloc.create(),
          child: EmailVerificationScreen(
            pageConfig: this,
            launchForResult: launchForResult,
            onEmailVerified: (email) {
              state?.onComponentClicked(this?.successAction?.action,
                  metaData: {this?.fieldKey: email});
            },
          ),
        );
      case PageType.form:
        return PageConfigForm(
            pageConfig: this, launchForResult: launchForResult);


      case PageType.none:
      default:
        return const SizedBox.shrink();
    }
  }
}

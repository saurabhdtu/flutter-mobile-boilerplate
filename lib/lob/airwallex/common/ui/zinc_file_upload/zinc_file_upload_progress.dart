import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/lob/airwallex/common/ui/zinc_file_upload/zinc_file_upload_bloc.dart';
import 'package:zinc/lob/airwallex/common/ui/zinc_file_upload/zinc_file_upload_states.dart';

class FileUploadProgress {
  static Future<void> showProgress(
      BuildContext context, String message, ZincFileUploadBloc uploadBloc) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.black54,
            elevation: 5,
            insetPadding:
                const EdgeInsets.all(AppDimens.screenHorizontalPadding),
            child: PopScope(
              canPop: false,
                child: BlocConsumer<ZincFileUploadBloc, ZincFileUploadStates>(
                    builder: (context, state) {
                      double progress = 0;
                      String? stageMsg;
                      if (state is UploadProgressState) {
                        progress = state.progress;
                        stageMsg = state.message;
                      }
                      return Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(
                              AppDimens.screenHorizontalPadding),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(stageMsg ?? message,
                                    style: ZincTextStyle.moderateSemiBold()),
                                const SizedBox(height: 20.0),
                                LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: GreyscaleSurface().subtle,
                                    color: SuccessSurface().defaultC,
                                    minHeight: 6.0)
                              ]));
                    },
                    listener: (context, state) {
                      if (state is UploadProgressState) {
                        if (state.isComplete) context.pop();
                      }
                    },
                    bloc: uploadBloc)),
          );
        },
        barrierDismissible: false,
        useSafeArea: true);
  }
}

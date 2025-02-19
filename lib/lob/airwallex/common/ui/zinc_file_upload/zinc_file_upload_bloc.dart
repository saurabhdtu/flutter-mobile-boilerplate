import 'package:common_module/base/base_bloc.dart';
import 'package:design_module/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zinc/lob/airwallex/common/ui/zinc_file_upload/zinc_file_upload_states.dart';

class ZincFileUploadBloc extends BaseCubit<ZincFileUploadStates> {
  final ImagePicker _picker = ImagePicker();

  ZincFileUploadBloc._() : super(UploadStartedState());

  factory ZincFileUploadBloc.create() {
    return ZincFileUploadBloc._();
  }

  ZincFileUploadBloc() : super(UploadStartedState());

  void updateProgress(double progress, bool isCompleted) {
    emitState(UploadProgressState(progress, isCompleted));
  }

  Future<XFile?> pickFile(FilePickerLaunchMode launchMode) async {
    final XFile? pickedFile;
    switch (launchMode) {
      case FilePickerLaunchMode.localStorage:
        pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 1920,
            maxHeight: 1920,
            imageQuality: 80);
      case FilePickerLaunchMode.cameraImageFront:
        pickedFile = await _picker.pickImage(
            source: ImageSource.camera,
            maxWidth: 1920,
            maxHeight: 1920,
            imageQuality: 80,
            preferredCameraDevice: CameraDevice.front);
      case FilePickerLaunchMode.cameraImageBack:
        pickedFile = await _picker.pickImage(
            source: ImageSource.camera,
            maxWidth: 1920,
            maxHeight: 1920,
            imageQuality: 80,
            preferredCameraDevice: CameraDevice.rear);
      case FilePickerLaunchMode.unknown:
        pickedFile = null;
    }
    return pickedFile;
  }
}

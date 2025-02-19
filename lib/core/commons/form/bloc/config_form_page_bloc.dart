import 'package:common_module/base/base_bloc.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/core/commons/form/bloc/config_form_page_states.dart';

class ConfigFormPageBloc extends BaseCubit<ConfigFormPageStates> {
  ConfigFormPageBloc._() : super(ConfigFormPageLoading());

  factory ConfigFormPageBloc.create() {
    return ConfigFormPageBloc._();
  }

  @override
  void handleError(error) {
    if (error is ZincAPIError) {
      emitState(ConfigFormPageLoader(false));
    }
    super.handleError(error);
  }

  void loadData() {}
}

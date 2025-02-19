import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:utility_module/logger/logger.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  void emitState(State state) {
    if (!isClosed) emit(state);
  }
  void handleError(err){

    if(err is ZincAPIError) {
      logError(err.message);
    } else {
      logError(err);
    }
  }
}

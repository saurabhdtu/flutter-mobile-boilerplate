import 'package:common_module/base/base_screen.dart';
import 'package:common_module/loader_mixin.dart';
import 'package:design_module/old_design/common_ui/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';
#set( $CamelCaseName = "" )
#set( $part = "" )
#foreach($part in $NAME.split("_"))
    #set( $CamelCaseName = "${CamelCaseName}$part.substring(0,1).toUpperCase()$part.substring(1).toLowerCase()" )
#end
#parse("File Header.java")
class ${CamerCaseName}Screen extends StatefulWidget {
  static const pageName = "${NAME}_screen";
  const ${CamerCaseName}Screen() : super(key: const ValueKey(pageName));

  @override
  State<StatefulWidget> createState() => _${CamerCaseName}State();
}

class _${CamerCaseName}State extends BaseScreenState<${CamerCaseName}Screen>
    with ScreenHelperMixin {
  late ${CamerCaseName}Bloc _bloc;

  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(context, pageName, _getContent());
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _bloc.loadData();
  }

  @override
  String get pageName => ${CamerCaseName}Screen.pageName;

  Widget _getContent() {
    return BlocConsumer<${CamerCaseName}Bloc, ${CamerCaseName}States>(
      builder: (context, state) {
        if (state is ${CamerCaseName}Loading) {
        } else {}
        return const SizedBox.shrink();
      },
      listener: (context, state) async{
        if (state is ${CamerCaseName}Loader) {
          handleLoader(context, state.showLoader);
        } else if (state is ${CamerCaseName}Error) {
          showZincToast(state.message);
        } else if(state is NavigateFrom${CamerCaseName}){
            context.pushNamed(state.route);
        }
      },
      buildWhen: (previous, current) =>
          current is ${CamerCaseName}Loading || current is ${CamerCaseName}Loaded,
      bloc: _bloc,
    );
  }
}

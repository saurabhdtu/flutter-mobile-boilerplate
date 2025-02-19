import 'package:common_module/base/base_bloc.dart';
#set( $CamelCaseName = "" )
#set( $part = "" )
#foreach($part in $NAME.split("_"))
    #set( $CamelCaseName = "${CamelCaseName}$part.substring(0,1).toUpperCase()$part.substring(1).toLowerCase()" )
#end
#parse("File Header.java")
class ${CamelCaseName}Bloc extends BaseCubit<${CamelCaseName}States> {
  final ${CamelCaseName}Repository _repository;

  ${CamelCaseName}Bloc._(this._repository) : super(${CamelCaseName}Loading());
  
  factory ${CamelCaseName}.create(){
    return ${CamelCaseName}Bloc._(${CamelCaseName}RepositoryImpl());
  }
  
  @override
  void handleError(error){
      if(error is ZincAPIError){
      emitState(${CamelCaseName}Loader(false));
    }
    super.handleError(error);
  }
  
  void loadData() {}
}
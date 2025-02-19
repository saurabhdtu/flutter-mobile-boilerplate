import 'package:common_module/base/base_repository.dart';
#set( $CamelCaseName = "" )
#set( $part = "" )
#foreach($part in $NAME.split("_"))
    #set( $CamelCaseName = "${CamelCaseName}$part.substring(0,1).toUpperCase()$part.substring(1).toLowerCase()" )
#end
#parse("File Header.java")
abstract class ${CamelCaseName}Repository extends BaseRepository{
}

class ${CamelCaseName}RepositoryImpl extends ${CamelCaseName}Repository{
  @override
  void reset() {
    
  }
}
#set( $CamelCaseName = "" )
#set( $part = "" )
#foreach($part in $NAME.split("_"))
    #set( $CamelCaseName = "${CamelCaseName}$part.substring(0,1).toUpperCase()$part.substring(1).toLowerCase()" )
#end
#parse("File Header.java")
abstract class ${CamelCaseName}States{}
class ${CamelCaseName}Error extends ${CamelCaseName}States{
    final String message;
    ${CamelCaseName}Error(this.message);
} 
class ${CamelCaseName}Loader extends ${CamelCaseName}States{
    final bool showLoader;
    final String? message;
    ${CamelCaseName}Loader(this.showLoader, {this.message});
} 
class ${CamelCaseName}Loading extends ${CamelCaseName}States{
} 
class ${CamelCaseName}Loaded extends ${CamelCaseName}States{
} 
class NavigateFrom${CamelCaseName} extends ${CamelCaseName}States{
    final String route;
    final Map<String, dynamic>? args;
  NavigateFrom${CamelCaseName}(this.route, {this.args});
 }
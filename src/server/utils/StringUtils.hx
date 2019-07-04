package server.utils;
class StringUtils {
    private function new() {}

    public static function SlashTrim(s:String):String{
        var result = s;
        if(result.charAt(0) == '/'){
            result = result.substr(1);
        }
        if(result.charAt(result.length-1) == '/'){
            result = result.substr(0,result.length-1);
        }
        return result;
    }

}

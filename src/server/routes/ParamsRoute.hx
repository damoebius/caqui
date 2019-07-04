package server.routes;

import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.io.Mime;
import haxe.Json;
import model.Params;
import php.Lib;
import php.Web;
import server.bll.ParamsBLL;
import server.config.IDatabaseConfig;


class ParamsRoute extends BaseRoute{

    public static final NAME:String = 'params';

    private var _paramsBLL:ParamsBLL;

    public function ParamsRoute(config:IDatabaseConfig) {
        super(config);
        _paramsBLL = new ParamsBLL(config);
    }

    override public function process():Void {
        try {
            if (Web.getMethod() == HttpMethod.Get) {
                var params:Params = _paramsBLL.getParams(requestData.username, requestData.password);
                if(params != null){
                    Web.setReturnCode(HttpStatus.OK);
                    Web.setHeader('Content-type',Mime.ApplicationJson);
                    Lib.print(Json.stringify(params);
                } else {
                    Web.setReturnCode(HttpStatus.Unauthorized);
                }
            } else if (Web.getMethod() != HttpMethod.Options) {
                Web.setReturnCode(HttpStatus.Forbidden);
            }
        } catch (error:Dynamic) {
            Lib.print(error);
            Web.setReturnCode(HttpStatus.BadRequest);
        }
    }

}

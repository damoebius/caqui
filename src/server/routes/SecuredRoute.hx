package server.routes;

import haxe.http.HttpStatus;
import php.Lib;
import php.Web;
import server.config.IDatabaseConfig;

class SecuredRoute extends BaseRoute{

    public function new(config:IDatabaseConfig) {
        super(config);
    }

    override public function process():Void {
        try {
            if(!_sessionBLL.isValidToken(Web.getClientHeader("Authorization"))){
                Web.setReturnCode(HttpStatus.Forbidden);
                php.Global.exit(0);
            }
        } catch (error:Dynamic) {
            Lib.print(error);
            Web.setReturnCode(HttpStatus.BadRequest);
            php.Global.exit(0);
        }
    }
}

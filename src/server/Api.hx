package server;

import model.RoutesDefinitions;
import server.routes.GameRoute;
import server.config.ServerConfigFactory;
import server.routes.BaseRoute;
import haxe.ds.StringMap;
import haxe.http.HttpStatus;
import server.utils.StringUtils;
import php.Web;


class Api {

    private static var _instance:Api;

    private var _routes:StringMap<BaseRoute>;

    private function new() {
        registerRoutes();
        var routeRequest:String = StringUtils.SlashTrim(Web.getParams().get('request'));
        var routeList = routeRequest.split('/');
        var route = _routes.get(routeList.shift());
        if(route != null){
            route.process();
        } else {
            Web.setReturnCode(HttpStatus.BadRequest);
        }

    }

    private function registerRoutes():Void{
        var config = ServerConfigFactory.getDatabaseConfig();

        _routes = new StringMap();
        _routes.set(RoutesDefinitions.GAME,new GameRoute(config));
    }


    static public function main() {
        _instance = new Api();
    }
}
